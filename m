Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9181A1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdBNWjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:39:14 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35180 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbdBNWjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:39:12 -0500
Received: by mail-it0-f66.google.com with SMTP id 203so7725113ith.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ifQsZtTY4vQit8HfSC6w5nYEDVdwMgK9ufrrgEyewtw=;
        b=RMjrs7pT/Ma4SYolK4HXZ3EZ3WIAs+B/GSvt2vMY+WLGBm+VU1hoHQYmV/I0Po1U1U
         JZNZ5J7yEq3CT/a3afllBweVrjSrmtbC5CpOr5/0Gcy8LvIorHJDi8a7/WKiE54Tvor8
         R/X4FmgJ3iWUWccN2eV2qfongDD+WhAyLLp2DbTw++2du44Y0gG7nUaCSZy0BnexBUOf
         qVv9BgSrk8Rxlw+j30gnLOwILkjFTDSEUV/LKS0CQ9wkPE0lVbVj33aYCVb+N4iFquYp
         /ceSs4AUhrcKadej6mlnrZ4s8235cWpruKufujqZVycDovy883ltfTZDAcsaXFivNHf1
         pi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ifQsZtTY4vQit8HfSC6w5nYEDVdwMgK9ufrrgEyewtw=;
        b=ZTPJ4tzJHFPmMkyfuczlQKFHvql411EFCPokKKv6peiUpbgwd5+l1+uZ521/4cgzWL
         vBJl6nkCs863a4OXbpOwD506i7Fdn4zsXkaAmRETw8fj4nit8MiGII5OaFjD3CProf5q
         vzXknsF7mdaGsUPTsO4xvG9GqOXgKNLXiPMFnCTt8skqvfvmBG+Ey6VwSWWJRKzUUbc4
         vqW68tRezN4HyopmV3BlNweR/SBDEmUWRjTHfNJAtORomgUpEPWZNjtpTtaZFQKQOomz
         ewhEvVvldauvMrn0rrBuQ5nVIMvWKnCpP/ghHll0G7mR4tPvjcGpBj3/7NNxuBr4XlrB
         rvlg==
X-Gm-Message-State: AMke39mo/CnSfRkE2qAtNc1bfdjvbeyLFe3GYDy1DJ0s++rb+0/0+gorjeTBJkm5vYG5zA==
X-Received: by 10.84.211.7 with SMTP id b7mr38945709pli.82.1487111946522;
        Tue, 14 Feb 2017 14:39:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id c11sm3168324pfk.14.2017.02.14.14.39.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 14:39:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
References: <20170209020855.23486-1-sbeller@google.com>
        <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
        <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbjSLaUsJH_KuT6EiC+Kt-87+GjONt08hCytXULecMijA@mail.gmail.com>
        <xmqqmvdo76yw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaeVrW3_kUWWxBMztOPuWY_V6XP2SUDyw8mmQ6peFZwdw@mail.gmail.com>
Date:   Tue, 14 Feb 2017 14:39:04 -0800
In-Reply-To: <CAGZ79kaeVrW3_kUWWxBMztOPuWY_V6XP2SUDyw8mmQ6peFZwdw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Feb 2017 14:24:48 -0800")
Message-ID: <xmqqinoc75yv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> And then after doing the "git mv" you have pushed the result, which
>> I pulled.  Now, how will your "internal mapping" propagate to me?
>
> The "name" inside your superprojects git dir may be different from mine,
> after all the name only serves the purpose to not have duplicate
> git repositories when renaming a submodule.

That is true, but you still need to convey "what I used to have at
'path' is now at 'htap'".  It is clear how to do so if we use "name"
in .gitmodules (you say "what we collectively call module A is now
at 'htap'").  I do not know how you do so without having a name.
