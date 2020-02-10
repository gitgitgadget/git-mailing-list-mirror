Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC05C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8A20838
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 18:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6H06ifN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJStj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:49:39 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36252 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJStj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 13:49:39 -0500
Received: by mail-lj1-f176.google.com with SMTP id r19so8525738ljg.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RZzC1mXph5A8p3rIOKg215mFoGiAw2rt1gOJTprbO4s=;
        b=a6H06ifNl2VrJRFty7dDqJ8ZszI2BfLktcp+2y2AZUib+E7YIkddhjFYQr6ZzGJfNI
         EhA5CmPL+k49cBaoEgsVuvG+fwfXEcWIgLt7PeZbxFmkOF5JBYOgKnD70+WPSszhNoLb
         z8mk4/NVhUMDTaJD4cugFi3CX8DkX02GJnND9+o+oeiEsG3ld42OyXfyC9uhSrmStJ26
         aeR61zQOYWdbjJshA+yX8f0SxuCKs1ArFh0EPqPjLUPj+0UQuv4J3B7320ea3p14mgDD
         L4i1J/EsvJ+lxNMF0sjKn4TXkKJHpYa94Q2a4fuHvI0HN9AhGZwuZNmXjAIEv/V96V2I
         rmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RZzC1mXph5A8p3rIOKg215mFoGiAw2rt1gOJTprbO4s=;
        b=BDEDiRN8diV2ZRsQjVKZiDaXkOcyiyKF2BduzCPtnr+sceAZ+A9jt3smJos+gtFmFO
         zmI2QPHsdX6vxbwgxxZt0fiYH/ObYDIaw31YcxQx/1EzZ2SXstO39sgaaoaDg3vLXxEv
         FXZYlIYG+GKOHl5WQoak4OKhumXCblWfk6K0kCCgpNtmHx5UTRkyIJi+ng8VuN3+Kxgb
         PMvzfM46d6rpd1uP6ymChMxAXH41wmvYrG4O3Jsgwu/M4vATHayZLRWM2O4CbuALOA20
         Kc6SHdjxe1gcl5BKOpvNw+G156mJ/nQOfQkF70yFDnWo2jbez7muA4b1p96ECauXqktB
         GiZQ==
X-Gm-Message-State: APjAAAXMILUACszVaa69lmOVFpBnzxZnn7gN/HeTpydYIAakvkzrlkz6
        PO+yhatsbE2S+pZq4pmrjmBQ/Zed1XHo6Z9zt+Uo6g==
X-Google-Smtp-Source: APXvYqzaNKsBtS4c66YJiVrGffWl35/cqAA38NkVC8wRO7o90bhvMnJdxVOi9rYO+T9g+EqdaV+n/keXVeZeYi64PqE=
X-Received: by 2002:a2e:9110:: with SMTP id m16mr1729035ljg.140.1581360576003;
 Mon, 10 Feb 2020 10:49:36 -0800 (PST)
MIME-Version: 1.0
References: <CAF8BazCScMN1sBspcCycOJBcepbkKfJUvh_hL9MSgNVvs4jKGQ@mail.gmail.com>
In-Reply-To: <CAF8BazCScMN1sBspcCycOJBcepbkKfJUvh_hL9MSgNVvs4jKGQ@mail.gmail.com>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Mon, 10 Feb 2020 21:49:23 +0300
Message-ID: <CAF8BazA_Nd82keE6XG5XV5+bq0FekZYuq_ifUMAvgvd0-iGetQ@mail.gmail.com>
Subject: Git tedious verbosity
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can you please disable all these meaningless messages which become
more and more plentiful with each new version, like:

Updated 1 path from the index

And all these repeated tips with lots of text on git push/pull which
are only first-time useful but nag people for years.

--
All the best,

Aleksey Midenkov
@midenok
