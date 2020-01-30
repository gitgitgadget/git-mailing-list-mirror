Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033CC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD120707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liY8wKdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgA3WPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:15:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38746 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgA3WPi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:15:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so2369668pgm.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9cAj34fLQayrPw8oRteLKFt7G3dQohvPm5HOckr84NI=;
        b=liY8wKdFHimW3aYBtOa+oVk7O21RXfHDxu3e32y0S8vR0p40z4+d/achHPGcP2WkxD
         Yhe0TkE2HNkhSgBL35v5vL0J2lIKq0+S5hLvf6rM08G/afj62xvVkG7pO3T4SpHJoALj
         k45nNfOT6ifMBo6/MhghKhaTVqPOutqVIQbWmaWhv/bkmWma731nsRJlxnxbbV6IcoSS
         I1Kr5FoGerMjG841HaXTEvhZ9DYGEGDaNaD90k3loe+nM+yd4KgBUxUaRMBNf7cPCJty
         rOnIw/5r9bvdmvwx7yJsvufhW3/1YzMsp8M8xAqZmwyDfsqmITnUQ4XUxjYBkpCqB+sV
         TkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9cAj34fLQayrPw8oRteLKFt7G3dQohvPm5HOckr84NI=;
        b=M5t49n1i6fRx958u+Q1S1h+h7Rawe5+hYpMfEVYOFKJLctUJmR8KbN4QdnWDYl3axY
         mksgsUgbo/3smlPcvRWZ5u6Noi0QtO+43v16uuDzZIkXflganT8+nLc0uMo1/SUSGh+f
         fKO9pqe9hZ0Hy7pJ/NbOP7LyNMmhXZX1kfbvc9NoHDCwDm8W59sRSxbrQecwaPlhmJri
         C8OD1S2PR/vfCMK7dnVAAfG3CI+B7B9XXxAW2dJh5IgUXImgTL7UBo5AZ6946ueJYqwS
         oej2BweTQnL9x61SdPUAUW3F7DTbcQXd5XNsEtm3kzDwzltBU6i/o/dt7QOLjAkbZwhd
         0nUA==
X-Gm-Message-State: APjAAAXOOWlmUnpSZei1VELrB0cPCdLbic0wyrGHCPEsiX+pYpo5im1i
        dvYcXGSNtNtVi8bhU7c32qtAoZgeapzM2OyNorM=
X-Google-Smtp-Source: APXvYqy+v0VwYW/JdOYY7GS4kaxrwTk7Agos45SjL+iZkSt8Vc7JHxMQfCXnDOpPJ01bZdeaXE61yniSHabkrZoPaL8=
X-Received: by 2002:aa7:8654:: with SMTP id a20mr7114820pfo.88.1580422537757;
 Thu, 30 Jan 2020 14:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com> <20200124033436.81097-1-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:15:25 +0100
Message-ID: <CAN0heSrwxnHGR0JP9EHgAHYysFO+E2qqV2JGO2qLaMM=MrA=LQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] add git-bugreport tool
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Aaron Schrab <aaron@schrab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:35, <emilyshaffer@google.com> wrote:
> This topic branch depends on the patch mailed in
> lore.kernel.org/git/20191211233820.185153-1-emilyshaffer@google.com in order to
> display scopes for configs gathered during "bugreport: add config values from
> safelist".

Should this use `config_scope_name()` which looks like it's about
to graduate [1]? Disclaimer: I haven't followed that patch set too closely.

[1] https://lore.kernel.org/git/xmqqzhe66dav.fsf@gitster-ct.c.googlers.com/



Martin
