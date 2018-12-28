Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F981F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 18:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbeL1SOZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 13:14:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34873 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbeL1SOY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 13:14:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so8312616wmt.0
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mCeFRgl6Ipdk3APsL1Y6M7SavOUPF+47CjKTgduXm5k=;
        b=sBJ46wtkHSM5LpA5FuMpoVoNrfH7b85a4G20g11kaGGCmLgz2HJtCXSZlT0p5J8xTd
         NPPLwnKCa7lzS83IRZ+34eV50mWzaFvIRD2t7gJX9VZ38N1MALKtHaQ3hiOGqrIm7fGW
         qeLywmVnRjyBu+f2S3sH9phVUDoukIOjWfVf261y9gq1mm3PEHtfoXBACE4Mxh4S74C6
         H4dguSAbQ7cAxCSAGtRcCzA0rKhY5YA1AHP8fTUmVmU+3InDDWm7VS0NhefU2lehUkcN
         BLwlrLAoZxeMDutjgSLJ3FZGWCXKa8rNe9cHPO4zwW0bAP7aLtPjymJ03DoPDuiI7b6D
         KabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mCeFRgl6Ipdk3APsL1Y6M7SavOUPF+47CjKTgduXm5k=;
        b=TzgeBklamtoaiM3UZqKQZJuoBqjadYbVqUDOcIiTarTK8UQ68K3ua7ZjClTO59OCdV
         Qjp7LDCBDWkyiYoyPJFJDlknX+H11GIsoaMJnbbYloblYjJkrTnG9VqiGtx1rFIAa44Z
         2iCQG/gi9g87YKQWI2r8skEwWZs8U3rwkh774W0olYOiOdTDNAd4MtKrIPO4yvUH2lb6
         peEFv8NeVxKcrGnsfOx27hkyyr4QfgVh05/DdWptbcFH4ZY2oKBYiap9mHrK0mprqiD5
         EvEPCZdhNluheGC3LWw4UIQ0NjIaiCBCs+2fDhLhX1e+gvghuhuH2yZ06Ywd8uTtove+
         oTCQ==
X-Gm-Message-State: AJcUukc6/vDTv6ysy9AIHYn2g3Eiz0rw9xlySo/kvTcu0RXzTcT6Yw0e
        D44tWrysfVOud4AUSYD1aNE=
X-Google-Smtp-Source: ALg8bN6ZHQR1zquIUub2+823ZNCFAaak4Yo5m6B+rY69gYP7Izc4ZltC7UYPViBgT9cqne5vk3de7g==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr23692288wmg.100.1546020862711;
        Fri, 28 Dec 2018 10:14:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j14sm26167020wrv.96.2018.12.28.10.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 10:14:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     issac.trotts@gmail.com, git@vger.kernel.org, noemi@sourcegraph.com,
        Issac Trotts <issactrotts@google.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
References: <20181219083305.2500-1-issac.trotts@gmail.com>
        <5dfd92d1-2e87-3006-1630-a33794b6066b@gmail.com>
Date:   Fri, 28 Dec 2018 10:14:21 -0800
In-Reply-To: <5dfd92d1-2e87-3006-1630-a33794b6066b@gmail.com> (Derrick
        Stolee's message of "Thu, 27 Dec 2018 08:20:32 -0500")
Message-ID: <xmqqd0plplhe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +++ b/Documentation/pretty-formats.txt
>> @@ -134,6 +134,8 @@ The placeholders are:
>>   - '%cI': committer date, strict ISO 8601 format
>>   - '%d': ref names, like the --decorate option of linkgit:git-log[1]
>>   - '%D': ref names without the " (", ")" wrapping.
>> +- '%S': ref name given on the command line by which the commit was reached
>> +  (like `git log --source`), only works with `git log`
>
> This "only works with `git log`" made me think about what would happen
> with `git rev-list --pretty=format:"%h %S"` and the answer (on my
> machine) was a segfault.

That's a bad one X-<.

>> +		slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
>> +		if (slot && *slot) {
> I'm not sure this check for 'slot' being non-null is necessary, as we
> would already get a failure in the commit-slab code (for
> revision_sources_at()) if the slab is not initialized.
>> +			strbuf_addstr(sb, *slot);
>> +			return 1;
>> +		} else {
>> +			die(_("failed to get info for %%S"));
>
> Here, you die() when you fail to get a slot but above you return 0
> when the sources are not initialized.
>
> I don't see another use of die() in this method. Is that the right way
> to handle failure here? (I'm legitimately asking because I have
> over-used 'die()' in the past and am still unclear on when it is
> appropriate.)

This is definitely a bad one, too.  If '%d' cannot find decoration,
it would not "die".

Thanks.
