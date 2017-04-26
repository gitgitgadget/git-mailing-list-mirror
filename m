Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08E9207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 01:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434557AbdDZB4q (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 21:56:46 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35685 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1434528AbdDZB4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 21:56:44 -0400
Received: by mail-pg0-f43.google.com with SMTP id 72so36426098pge.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 18:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=C2H7ZPlEQLWgmc2H0gkk/CXtls95i4Iq+3SHMyhZawI=;
        b=uhl4fIfFW1fw9mNLXuB748rdYjJbk6wsIEEtanKxt7RVnrBjLuhqiezVMZGn7P/BND
         N8Ar+83SnoeukAWYeZO73yv2ABMCwhZf7jm8p6Odn6ljPX6fBnvgPc/1wFMCUZLOrpX8
         5GbUuR/6XWtUKa4OcBoqhVchqoFGs1z+IbJaWCDA0uH2tPvAYdEv24hjCCdwBfHGu0z9
         NpWNHHpAnSmfcyEZXreCSJ0iNiRChLkql09undqy38baYrO9BoRMUd4NEGyEycozqtzh
         ufmIYF2rFCKD8mAlORRhwouS1VbDbn4xuDnbLEWvaZqieyHciNfSUu2gC/2sz7tFmhMW
         9eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=C2H7ZPlEQLWgmc2H0gkk/CXtls95i4Iq+3SHMyhZawI=;
        b=crRTs/bx66R9Qrao7yARlD6Y7UGOVbQdy3DO+yt8TT7W45kkVL8Va2y7kFlZ+X/h53
         deR5l5qHGoYOGuJwj35hi76iorRIHJCjiXucsYXnGvgjw0xafNo8z8nvt48nXCf7zGz7
         I4vGSxKIhFwaJc01Xata7CGH7nLPjQDwDRtTR9gzAEefNSTofc4l/y9rsKMDeufutYXj
         Do0/kLcL2VkMGssCtnshI0Le08auwpDLyJ2gNYY+i/R+wfaTnJHMJrf0k8laKHm7nSiW
         NLQEiaPmVthJa2KqyNXeXyvHw7CQOns8TqJykhyklE5BWHIG6POcruvXZrAG0WAc9qZy
         tGXQ==
X-Gm-Message-State: AN3rC/5S/JrJ0QzBEGcdGLwHdu47yHDzIvda02dACun45Eu5q+hcZFdN
        PwoFKYmG3tDjWQ==
X-Received: by 10.98.37.198 with SMTP id l189mr30262568pfl.38.1493171804040;
        Tue, 25 Apr 2017 18:56:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id t69sm38559590pfa.81.2017.04.25.18.56.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 18:56:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 0/8] Introduce timestamp_t for timestamps
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
        <cover.1493042239.git.johannes.schindelin@gmx.de>
        <7a2271ff-1386-18a6-5f6d-7eb13dc92509@web.de>
Date:   Tue, 25 Apr 2017 18:56:42 -0700
In-Reply-To: <7a2271ff-1386-18a6-5f6d-7eb13dc92509@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 25 Apr 2017 23:54:46 +0200")
Message-ID: <xmqqr30gszhh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> I can't think of many ways to get future time stamps (broken clock,
> broken CMOS battery, bit rot, time travel), so I wouldn't expect a
> change towards better error reporting to affect a lot of users.  (Not
> necessarily as part of this series, of course.)

Better error reporting is one thing, but we do not want to kill "git
log" in the middle by calling die().  

Dropping the patch v4 9/9 that caused us to call die() was a good
thing to do within the scope of this series, I would think.

