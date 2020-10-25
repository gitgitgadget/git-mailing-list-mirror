Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447CC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB60520897
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRdBb8Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766932AbgJYDfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762952AbgJYDfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:35:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C8C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:35:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so8668506wmi.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ks5j1mkThhuW7U1cYdmov1PI67ivJ4eCFoPBv5DT1mQ=;
        b=mRdBb8Ff3NoHUEQHtKqHcJnyK79upVhha5UBE/bT5BMVKdcyliJbeIqKbU35CMNR0o
         sVF4z+CEM9qAusxMDB01JtKOlP2iIiEMAlbdTsBnqgKi7xbdAqkXKIM5SIPUh95eGFJY
         6cipdAnzz0CzB9NAB4Eg7ZJqVkXsDYXQ4nQhXb8LsLeskYMVTRV982UChHxT+2hmikif
         hjoQ7JAEnWix3geaY8cjBhIyCCpc7GUbH3sb05cDx167Vdnw2uFk247Z7H50umfKFmSo
         mjRGNGZDz3ZA2LaCWmd/vanXIfSkgQ0NdvU5P8npc1zqfwU9TFEm2rpA3rXJN8hyrDwI
         qwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ks5j1mkThhuW7U1cYdmov1PI67ivJ4eCFoPBv5DT1mQ=;
        b=neBo3FNGMp2nPSyfctAk78iaiFJ50xEY+F4MUsrr1Db1+mtR59O7mM41YWV+mVisr1
         sDLZ2li0qKtwLywlfOyiokSVDetbIfFYgDuZ/YTGxnNgVNwsg+l7T7+f9rOWAsCCj2NL
         1KiP8tFFwOmwNu7cp5UpFvVGcWItj3LEAxAP8gS/DPtFFvzDN0KZonuXj+oKnMIVMKsA
         p5EeEVT1vcDLQZeR7MbJAKeX6XrlE/r4H/EBivDl0om4xjp7VqscxHQVvzj16sAWfkwF
         ORuGBoa9r4cHhSq5OEk7RZkFopF00aZGZ7vnVKMEwvnye2WNIOy2Wy5vOgwcwZC/b84z
         Rdlw==
X-Gm-Message-State: AOAM531TDOkCJO81U9IN7DYXCG5DeLIwP+U1OdXxKmjNfRZ2ptRGAo54
        ZGs1m7aG4St1klxnpxmmvmY4A7tkcHETb/C5Q8I=
X-Google-Smtp-Source: ABdhPJwNIXdqVUZn/oBaVDNMBHjxU9zvB6ckN1+cEeNDOc/6zUmzofdgZIQTbH6J1NaB7IoiWpsyXZ/frrMFiFVRjuE=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr9928433wma.100.1603596943762;
 Sat, 24 Oct 2020 20:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.613.git.1587107464322.gitgitgadget@gmail.com> <xmqqsgh2ug1q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgh2ug1q.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 24 Oct 2020 22:35:33 -0500
Message-ID: <CAMP44s0gy5JbB6+NuxPEzV5hOo1dXNB-J5hhZNViM9o+NweeuA@mail.gmail.com>
Subject: Re: [PATCH] complete: zsh: add missing sub cmd completion candidates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Terry via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Terry <tmoschou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 1:26 PM Junio C Hamano <gitster@pobox.com> wrote:

> This is not a new issue, but it makes me wonder if we can initialize
> this list just once by running "git help" and picking up pieces from
> it.  That way, we won't have to maintain this hardcoded list at all,
> no?

Yes, that would be nice, but what if the user has an older version of
git without --list-cmds? No solution has been proposed for those cases
in the bash script.

Most users of the zsh script are decoupled from the corresponding git
version, and since you refused to graduate the scripts out of contrib,
that gives distro maintainers the excuse not to automatically package
the zsh script.

So no, given the current situation, I would rather keep updating them manually.

-- 
Felipe Contreras
