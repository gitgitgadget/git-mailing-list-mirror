Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681E41F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeFZWUg (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:20:36 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:37779 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeFZWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:20:35 -0400
Received: by mail-wr0-f172.google.com with SMTP id k6-v6so17253wrp.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zzZKT9l+ogZdSOsBf27t2xmEdKPEutq4GtnaI5I+Epk=;
        b=CJXJJ/P7ZbXv4tiQPCNUMnmIQ9sTG91YOAXGCjBYnlyrTfVNZ9s5IpKo1mf65fvQvT
         bhLY2/YLpqrYGXoCWwfHSKdkrmkOMC1cku4KiF5FBj2FOMPZUzJf8C9YsmsYibzao/+f
         g/XPINvVWVepSoPnLJmbmcrYssREle6NKrQ3FYHlFVF510caq1UQqcTlBNfReZg8Piy8
         adP9wI2wa9erUZEgYglwL1yOiqe0taJbCQlOcVGvsydmThRQ9gmx8CVujAxRFE/Ms76e
         6xTRQVZGQMeLBMtS2Y73gImFMU/tB8jUiyU5SOjkucS+jSIPDhaaad5sTb8luFgoqUb/
         zPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zzZKT9l+ogZdSOsBf27t2xmEdKPEutq4GtnaI5I+Epk=;
        b=lAoXTH3EJU4ApgLhGmDhMc4+8NTupJ6f0WdtgRYynHALaqle7vcQVypd90qXsF3o5/
         741w6xnij2TaamsL44ZckuYjeEQtrMAA6mgbt4OIOGUnNDbvNbZpm/EeDGV8SNe/X3A8
         XQBCn8SdmCkVoH2jdtqMo5O/CtEtgVpXv7k54Vx0pKvCDoi5JvW/S7hNnA81kn+oEa1i
         gvgtLXJg0nXYqdnb5lXPlyl0vkNx3mtE2tvXQ+hvnVwlC5cQLZB6U1tKSmxaEy+iBr2K
         0tGXt+m464GiqPLPrEqzghpPjyx1MkTdyS25oDLoCk0Ve1Qfhd73ji8bbxUivxWCua0J
         x9kQ==
X-Gm-Message-State: APt69E1i+GbqQx9NtPQfAC7z7DDtEn0sNx+5lHsyf1wWtw8nxd8N1Clc
        Qhm1CrWGTz6rhnk6mepVEfI=
X-Google-Smtp-Source: AAOMgpetNDSriNvowzhF65C0dj0+ouyYOl1ILQz1TWMjHzphuhR2gjUSW5gV5usm97je7JLqkLQKLQ==
X-Received: by 2002:adf:c3cd:: with SMTP id d13-v6mr2941119wrg.68.1530051634006;
        Tue, 26 Jun 2018 15:20:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q17-v6sm3112714wrs.5.2018.06.26.15.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 15:20:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
        <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
        <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
Date:   Tue, 26 Jun 2018 15:20:32 -0700
In-Reply-To: <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
        (Christian Couder's message of "Tue, 26 Jun 2018 17:41:44 +0200")
Message-ID: <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Obviousness is often not the same for everybody.

... which you just learned---what you thought obvious turns out to
be not so obvious after all, so you adjust to help your readers.

>> In this particular case it even feels as if this test is not even testing
>> what it should test at all:
>>
>> - it should verify that all of the commits in the first parent lineage are
>>   part of the list
>
> It does that.
>
>> - it should verify that none of the other commits are in the list
>
> It does that too.

But the point is it does a lot more by insisting exact output.  For
example, the version I reviewed had a two "expected output", and
said that the actual output must match either one of them.  I guess
it was because there were two entries with the same distance and we
cannot rely on which order they appear in the result?  If a test
history gained another entry with the same distance, then would we
need 6 possible expected output because we cannot rely on the order
in which these three come out?

That was the only thing I was complaining about.  Dscho gave me too
much credit and read a lot more good things than what I actually
meant to say ;-).

>> And that is really all there is to test.

Another is that "rev-list --bisect-all" promises that the entries
are ordered by the distance value.  So taking the above three
points, perhaps

	cat >expect <<EOF &&
	... as written in one of the expect list in Tiago's patch
	EOF

	# Make sure we have the same entries, nothing more, nothing less
	git rev-list --bisect-all $other_args >actual &&
	sort actual >actual.sorted &&
	sort expect >expect.sorted &&
	test_cmp expect.sorted actual.sorted

	# Make sure the entries are sorted in the dist order
	sed -e 's/.*(dist=\([1-9]*[0-9]\)).*/\1/' actual >actual.dists &&
	sort actual.dists >actual.dists.sorted &&
	test_cmp actual.dists.sorted actual.dists

is what I would have expected.
