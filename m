Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78046C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA032063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju3VhsIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgA3WVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:21:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41355 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgA3WVR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:21:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so1880217plr.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xphL+ii+8syPALzXjnSbVwKXpDg8Ogt3chA3JGMIGQ=;
        b=Ju3VhsIwB1LHrnEnXpXGMxFT1M/lW8YdSV9eqZTZF3/btddmLBvjrCPQPQ1nVptHvf
         0gPyDruZcWCN68Un5EIKINWBQNlhJ2TF01JwsGbV2DlNSkc23QrP3DdT6bp/akOmmosp
         5aZ+62+j/ljvGuBGfL05nXomUH/Z3smb55/ob10gQJArC6Z4uYurrAPbaumQHhFwINPC
         7iAPlPNmYKOI3s6jyilOFNFn1i/b83ybHQiwcQTTGpWQB3TWTgD32fucbSmiCSaFhIva
         Gw96R+dLPCrCzkEaKjXkC06vkGcUeZ5HniLa3zZ0qHv4n3TcHW1iDjCbuTHMfiyfPly2
         6iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xphL+ii+8syPALzXjnSbVwKXpDg8Ogt3chA3JGMIGQ=;
        b=fQZXjogrLVtONcXuzLrS28Hy+zWxwzOZc2YzEl2NshkXe2y5aswAHYVpKgll0t93hg
         XtNuA8Qulstvz2AiIDMCiV9a7/vecLaFRtPbGI3nSaxzDGejwoPwDKIzB8k2Ng5+Hac0
         +yC8TtPpeZOnzqMtDGD/ECEzqhWFRjixmqoDaVJ6d2+nC6y7mNhshpvubceDVUjLC/Cm
         asXTI8r2r5bS7kh2XdukaOknraBnRWEOhnAienAK+Oxx5+vJ8Hy3HQ88zO7k7/YavXC2
         OZ+QCUCaFBUK999DKebSjCtutQdZXJjWeF159cJWOfIaPmRj9WwFwasjdAtvxwzT28ZA
         g8Jw==
X-Gm-Message-State: APjAAAU97BrL1LVpqIx84u/AcV6mtCY2A79DXEq/VmdBjJbXToL5+QIL
        EBfpDqEc1Pm9HYhiAWsHkfE1AoiafQgjnlXkZ8g=
X-Google-Smtp-Source: APXvYqy/BiDs4gJL4MYNODOGOv383tbujlpYY8kb0xT+rJeoRVqhxbW2es4Qxzdf+Vk//VxqhQbjAMv5Ld33OYdAwzQ=
X-Received: by 2002:a17:902:ba93:: with SMTP id k19mr2632647pls.197.1580422876639;
 Thu, 30 Jan 2020 14:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-5-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-5-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:21:05 +0100
Message-ID: <CAN0heSqKXAxOGBayEx+29EKFKqBWhrCymUF5X++OVj78=zhdmw@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] help: add shell-path to --build-options
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> It may be useful to know which shell Git was built to try to point to,
> in the event that shell-based Git commands are failing. $SHELL_PATH is
> set during the build and used to launch the manpage viewer, as well as
> by git-compat-util.h, and it's used during tests. 'git version
> --build-options' is encouraged for use in bug reports, so it makes sense
> to include this information there.

Hmm, similar nit as for patch 02/15: This could go in as, e.g., 02/15 and
your 01/15 would be 03/15: This patch would be useful even without `git
bugreport`.


Martin
