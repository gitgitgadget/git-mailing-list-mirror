Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E3A202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 17:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdGDR0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 13:26:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35248 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdGDR0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 13:26:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so2060109pfq.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cY5FNWVN+s4Mk//jukQycghPozgPAShfl5XDdA4NlOE=;
        b=jA9p0oTLLo5L1qu15QQEcuUz4nQEqeoi2PF4pGVvaTX0fpD3YGgyTbTlu9pMszcdEs
         jhV/3OKvV+thSQLC3AlrwgIHS2sKlUrO7fuvgmJuBNDoNozpG7vT80M50w/fXegSzZuo
         hf+dAPxojZ+lu7QZq540T2jRMNaV+1b1uGE6/6ig85bcXR5/fQR6ikjBCYXCXMaOCn7f
         bp4uw4R8/37ZC6cbOc5mj3JrdF4kZLuUnurDY9L6QxJg0C5+letTHUuWvP1vC/51Vdmn
         OrrWoZkmdRdp6q7AeNMidso69pQqccvDLBFTaaVKhH22+lylAABMmJArfZOlfqIcAdPU
         5now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cY5FNWVN+s4Mk//jukQycghPozgPAShfl5XDdA4NlOE=;
        b=C9Qs1lzoG01zmrMLuJRLm5JwLo0Yuh19kAGDpi3lIXH37/M1HHa2Y70ikhUnHWbgFn
         aljrCAgi2FJ19r6/SOd8Z79l6qKIExoTI8wp8yT3ePJWXKvnYysgkTIUZqVV18pKKqJ4
         nKtbkSZLJ/PWmNMJ0NC/7J84HLE9jkbs7/17NALYYF8I1ARzsrP28qf1XVjPodcvaubK
         4XKe05px6+XathmgrJ7lL/pFZ3kFMpU09mnoVSIAYwz2GspxHd+fus/RdKQf/KfYx6x9
         Ux7wtUtoilnYl7mpaVM/7Pe//IBFbbeHBo7LkEaZPi7bi7Qk5wE7D8+NGu8I8nUj8U1c
         NKHQ==
X-Gm-Message-State: AIVw111cEA637YSA0+61dP2CURXqPmQxX8JcAsRYWxqff1NidJXn344+
        N8OfDw+BvrtvUQ==
X-Received: by 10.84.128.39 with SMTP id 36mr17358801pla.226.1499189208469;
        Tue, 04 Jul 2017 10:26:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id g10sm45790663pfc.38.2017.07.04.10.26.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 10:26:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170701220547.10464-1-avarab@gmail.com>
        <20170627121718.12078-1-avarab@gmail.com>
        <20170701220547.10464-3-avarab@gmail.com>
        <xmqqa84lmonj.fsf@gitster.mtv.corp.google.com>
        <874lutclie.fsf@gmail.com>
Date:   Tue, 04 Jul 2017 10:26:46 -0700
In-Reply-To: <874lutclie.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Mon, 03 Jul 2017 22:29:13 +0200")
Message-ID: <xmqq4luskt9l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> diff --git a/.gitmodules b/.gitmodules
>>> new file mode 100644
>>> index 0000000000..cbeebdab7a
>>> --- /dev/null
>>> +++ b/.gitmodules
>>> @@ -0,0 +1,4 @@
>>> +[submodule "sha1collisiondetection"]
>>> +	path = sha1collisiondetection
>>> +	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
>>> +	branch = master
>>
>> Do we need to say this "branch" bit?
>
> Yes, it's to make future updates easier, see b928922727 ("submodule add:
> If --branch is given, record it in .gitmodules", 2012-12-19).

Why?  It's not like we want to _follow_ the 'master' branch of that
sha1collisiondetection repository.  We declare that a specific
commit from the (sub)module is suited for our project, and do not
really care to automatically update from whatever happens to be at
the tip of 'master' there.

>
>> Other than that looks good to me.
>>
>> Thanks.
