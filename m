Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325EC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7DF22464
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy9oM8xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAWSE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:04:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWSE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id u131so1742356pgc.10
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 10:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOvOicxt1KSwAhAL9V+Pyfbq/CCSBNAoo0dZRAS4/mE=;
        b=Cy9oM8xSaoAbd9zx8ULi3y4ImhqmHKGQWDKQsB1BFNYQoDmOn+HGdAIFRlHVFAIcVK
         8SYTWksjdL/APzmNAYQjAuJQjGQowNbnu8vJ7DNBYrziyf2Divn/uf4mPOyOIK9+/F0n
         56gxG+55fnk8OmF4xpM4aFgI+Odl+dkg9ip+LTlfO1Ejaq2IV5/SHme/rbVDvZbz0IVC
         iKbb5QJkpLswY41gyX/3Wufv7ewyjgDclYFykMZfeDQf8VShjgLB60A1eJj/b4UJmd1Y
         Zpkke+jDcV7SmjV7Dbtd4HRxV1m42js7G3xoINVrY81OXl1LO3PQnX7L7nraVjitboYd
         CsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOvOicxt1KSwAhAL9V+Pyfbq/CCSBNAoo0dZRAS4/mE=;
        b=Fndxid0IduYur4HAChxph1EsKMfe62k1AHCpIvnrYy6RBJ5Jkb3s4Rb5HBZfqjGajt
         5GufZvwneY0WwpJ2Uu+nF9m0XOtbIJwqmqejH+Sdu5svy25K+hfBGEqIgEyIvBj/HYwF
         n9qK9rMwn1AOypxEHxs9N6KSAolq7biVQIllie22TRqoN9pZxOxQ/ntqVeqF9FB0Bt4h
         VXzTznXaQ6DE3Di3RiBi2M5uMwsF/ABON8zU61JNaS5mL1wIq0/vrbAevlsDAA7WZsC2
         SCH9uXeX6DEvNRfXeOVFQ3L3Xjm3URGlqARvxVN0+PLP0CKr3tAaEqWDIlaSdPo1Vlai
         2b7A==
X-Gm-Message-State: APjAAAVpYTvXYxXNIHFbHzU5Ii2J05/k8tJsfoWnJeG8VeFSGjCZFUVa
        V3EZxqcE0tJFCfNsnwV1Jl8=
X-Google-Smtp-Source: APXvYqxv0Sx7LItZq9XAmmd+7pahcMYrNboQOQLWKPHPmrG9wPuYw96SLJnvsn8NP4BDC9kA45pGSg==
X-Received: by 2002:a63:5056:: with SMTP id q22mr30044pgl.20.1579802668955;
        Thu, 23 Jan 2020 10:04:28 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id i17sm3470303pfr.67.2020.01.23.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 10:04:28 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC] Introduction
Date:   Thu, 23 Jan 2020 23:34:21 +0530
Message-Id: <20200123180421.16720-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAP8UFD2Fo=2suQDLwzLM-Wg3ZzXpqHw-x0brPtPV0d4dRsgs9A@mail.gmail.com>
References: <CAP8UFD2Fo=2suQDLwzLM-Wg3ZzXpqHw-x0brPtPV0d4dRsgs9A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Christian,

Thank you for your advice! Apologies for not tagging my patch with [GSoC],
I didn't realise it before. Is it okay if I try solving a couple of issues
and then focus on the GSoC project(following from what you advised)? 

Also, I wanted to ask whether or not one can try attempting the projects mentioned
last year[1] this year as well? I observed that only one idea[2] was picked out of
the aforementioned project list.

Merci,
Shourya

[1]: https://git.github.io/SoC-2019-Ideas/
[2]: https://summerofcode.withgoogle.com/archive/2019/projects/5390155215536128/

