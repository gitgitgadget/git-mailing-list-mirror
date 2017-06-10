Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2891FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 11:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdFJLbq (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 07:31:46 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:32812 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFJLbo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 07:31:44 -0400
Received: by mail-wr0-f177.google.com with SMTP id v104so54717727wrb.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GdP15zhurIIHbMBMsDoFZZKkJQZjLpCtUyGM+4y+Bk4=;
        b=eohPuZBj398KMowzMPBGbd3WBzV+rry84Jbk62Zei78lkq1nwj7Iu7w9b2PjCVwRVI
         dRKmXQpKnfEGrAzZ2vKgtrPoOI6qmOE10vb92B3X/XErW/WSblWQ3LyuprE2LEbCuP4A
         6sVu90R5Cm8HUkVtWcyQrSkPX9UPywD5Hv1hJ+nDXtFofXBup/zu94EQ/ERwcLmIwQpP
         7fmK7qn+aBPzv53jEro/txL0cxf/c8NrjVMYPqmk7pnmv/yJ6gOhhjl3+oYicBXa6JV1
         SVAd/viynApGNNwmvlvBwqEefMc4zP9q1+vS5wvhTx352m920eXtqf9V8sJAruq8PwKa
         /6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GdP15zhurIIHbMBMsDoFZZKkJQZjLpCtUyGM+4y+Bk4=;
        b=nae+uWLcTXIcHV7mjjLNfEby1GpsFxic/XARFc9XjbFivHLDftsgMiz/eRitrHZ6zq
         XjChg2qkeewztq5q4L8Q58ICI+9qBvpX0z+BaeKfLtT4PGn4BCJmNJn5vVdAP/iAgxcU
         kY+MulY9iztacObMjqYn5w7nvrZOM0mB8gvqvTLCsQcE3MS4UyYoBGAggt9gk9T5xFBw
         KKtiZoG5gUnQfDCwyGULkC57IC+XnnQ4vZ553oaRWRvP3MAEuji0lQ1xuVVvI2fzh++c
         KSjfdq36sQK22Fbel6egBosNySIQFb/+m5vS9hgsB/nNikb0AaLfqA4AOrenXiyfQG9X
         JTSg==
X-Gm-Message-State: AODbwcCGijQ2CEnKttjSEHt7HI/AeofiYpmj1kRwc1QFiYJS1Xq4xB57
        E8I0ExH7Vuk9EQ==
X-Received: by 10.80.134.248 with SMTP id 53mr30153785edu.73.1497094303593;
        Sat, 10 Jun 2017 04:31:43 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id l25sm3186153eda.38.2017.06.10.04.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jun 2017 04:31:42 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dJecH-0006dH-QQ; Sat, 10 Jun 2017 13:31:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] wildmatch test: cover a blind spot in "/" matching
References: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com> <xmqqlgp04ne3.fsf@gitster.mtv.corp.google.com> <xmqqh8zo4na3.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqh8zo4na3.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 10 Jun 2017 13:31:41 +0200
Message-ID: <87wp8krsde.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 10 2017, Junio C. Hamano jotted:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> Add a test which covers a blindspot in how these tests should assert
>>> that negated character classes are allowed or not allowed to match "/"
>>> in certain circumstances.
>>
>> Please make this a bit more explicit, something like
>>
>> 	A negated character class that does not include '/',
>> 	e.g. [^a-z],
>
> oops.  I think the class includes '/'; please excuse loose logic in
> a "something like" meant as an illustration to show the level of
> details expected ;-)

Thanks for the feedback. Sorry I'm slightly confused still (after
reading this over a couple of times), are you OK with this patch/commit
message as-is or would you still like some clarification there?
