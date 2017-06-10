Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558E11F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbdFJB57 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:57:59 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35675 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdFJB56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:57:58 -0400
Received: by mail-pf0-f178.google.com with SMTP id l89so33765302pfi.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=C82h4bNXB9xqU4+/9oUu9V0vhMh+FTiXcwKRrSSxuCE=;
        b=Z4UsuVwWM1z1kMHgiYaheuuJ8mVrTxcE2jswgvOMFn2sPp4gFYGwiHzBXdPR/3NEiC
         0JMIiOY+NmHs3nae9V6bQIp0YjOpAtM94mQOOFJuZZOarU8Jdz+3mItn0GyZJMfW2Y3E
         KZGHeJusUQ9i2f+4c32S6oltkit+cIqAp2HK0QbThwKGwlLsyzlqEOYv486NpMB4Gail
         ce+jLJKLf2nHHiSHgH8BpGU41gCfIPJ6kYDY0/BgxEqvGl1k61B7VVW5ZxrZCpLtQyqC
         rtCv7AWbbmzwg9aexWchKe6+Ra9Da3XWnswyW1J1ILKvDnMQrrb3h3xOGgnpwYnFpXJn
         o4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=C82h4bNXB9xqU4+/9oUu9V0vhMh+FTiXcwKRrSSxuCE=;
        b=VC9OfWJOcFmPpTDmq2WzLFfh8+5Cg9BOfE46urD61tHA7cbcuO31UeoYe3autB9V/Q
         4ccSbdp73na7fW8FDw4ZEa4jmc/VI5S4ydTR/P4FV98IfP/6+kvHiyON9Vx1Jpu+yH88
         Wu6h52dCTTVgJzxAACw+fdMFpraJd5dzYB54P+pYpTfG8Md/plKEwI/0sCi2Fd8LKLlV
         is0roYtF7cnEHPdVPv38VZVvHYvToXleP7J/WHUS1lmFc2RrmcYRMWqcxKE2r/iO18mY
         +W7HJ2/sbCaXuL193ZxX5fChKv9xG5M+f6b/YIO6h785duASu5FMoO8NjHlDaDL5omWm
         sI2w==
X-Gm-Message-State: AODbwcCR9odz4z5PuKyfyURGs2UKdWbn4ApjGdJK5knk48IYqFksp3XR
        Iz9k6DdEmCISTg==
X-Received: by 10.98.105.137 with SMTP id e131mr32355635pfc.56.1497059877869;
        Fri, 09 Jun 2017 18:57:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id v8sm4993612pfa.10.2017.06.09.18.57.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:57:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] wildmatch test: cover a blind spot in "/" matching
References: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com>
        <xmqqlgp04ne3.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 10 Jun 2017 10:57:56 +0900
In-Reply-To: <xmqqlgp04ne3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 10 Jun 2017 10:55:32 +0900")
Message-ID: <xmqqh8zo4na3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Add a test which covers a blindspot in how these tests should assert
>> that negated character classes are allowed or not allowed to match "/"
>> in certain circumstances.
>
> Please make this a bit more explicit, something like
>
> 	A negated character class that does not include '/',
> 	e.g. [^a-z],

oops.  I think the class includes '/'; please excuse loose logic in
a "something like" meant as an illustration to show the level of
details expected ;-)
