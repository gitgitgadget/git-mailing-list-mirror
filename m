Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D426BC35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993BE214D8
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKpwaSOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgA3WUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:20:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgA3WUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:20:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so2227658pfc.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjhWq8D7OG9KU6ElJBCA7ts6jzUmHJLYbV6qBWJ3Avo=;
        b=cKpwaSOMZgeQcZ5W66aSpInesfw9dtUvtpLP4TKlAENg5gmio9erC8kHXFP06FXhTV
         /Qh5Qy0XHKEcNo8uAb83OmARfWuTOSM1QYGlublztypFnQhqaZo5l4zVjhe4B5hYycVt
         Zedm3vQ/35X/Elc97mDh429UVW9X1ARS5xcsY3oGvADF+bOeroi/7wVb6ec2lge1evuA
         qGIXH/EYvlhviQf+6jmmDuDrq9sOwg0sy8bND9jnOxas8DyV7raQ+wX+ovU+wDJO5GYl
         CG6oDpZXSTidBXg+80Fsayp0p/b0kjtr/2go67G02oQdClJYEhlX4RkPGYxzsUkturae
         rjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjhWq8D7OG9KU6ElJBCA7ts6jzUmHJLYbV6qBWJ3Avo=;
        b=tM+xZFbt4i1dPAVt+t113wNhoxZpKi6w96pGbtu7WwLw5femZRomGETZh2iRCFsfAb
         ZobqZCEKgh6NeMM8Hs3G6LUIWX6r0YGCpzDCyN5ioMe4lLjgqu/IlW2MFiwvYs6m/6h+
         fmkUOant8fEmPKzTssWIr/PxOTmhg8fg/yTE98OT3BeKIUroFzbS36FHKn4u793IeI4v
         jt2PQgYt5U6/NpqprhmWoPgHZ2khjRr1385pzpMs9y2vKQXo+Sv31x0jI6eorFUxyXa1
         cKQ1jBVSKxHdWW+fbp9FFb2+0czp6u3847o1uyl+ikaXjcmFfww0b99zKlXsmcD9m+jQ
         Strg==
X-Gm-Message-State: APjAAAXsNtajBk3X8LNfvLcnIuaisYxXSK7IhzCXJO9vKCL62p3nXxxb
        Po1gEZ8FIYmsFns1fOOrn+2SW4ZIGJ9Ll1FPMII=
X-Google-Smtp-Source: APXvYqzq+//ndS6PBpD23myQMmzvBpwYTAgTpwvYtfb/3mmVtqVIs0psqtJAzQ0pRzNNhFugdZico5KLWO38f2bb3qw=
X-Received: by 2002:a62:b607:: with SMTP id j7mr7146099pff.45.1580422806880;
 Thu, 30 Jan 2020 14:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-4-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-4-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:19:55 +0100
Message-ID: <CAN0heSqaeaBTCmiY=f0eD8=hsPV7BL9OCFL=Oq7je+t_o4frqA@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] bugreport: gather git version and build info
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> +static void get_system_info(struct strbuf *sys_info)
> +{
> +       struct strbuf version_info = STRBUF_INIT;
> +
> +       /* get git version from native cmd */
> +       strbuf_addstr(sys_info, "git version:\n");
> +       get_version_info(&version_info, 1);
> +       strbuf_addbuf(sys_info, &version_info);
> +       strbuf_complete_line(sys_info);

This leaks version_info.

> +}


Martin
