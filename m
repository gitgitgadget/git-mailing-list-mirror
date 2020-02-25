Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9777C35E01
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C51218AC
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbKex+hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgBYN4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:56:41 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:43068 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgBYN4l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 08:56:41 -0500
Received: by mail-ua1-f45.google.com with SMTP id o42so4509023uad.10
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D0+hqI/y5yTZoTqVDD1rJUFBYIymcauxB9jiO43HAY4=;
        b=GbKex+hsSiYjcCyEhpQKz+wzjIKy3pj0BWP+NSElLkc0zz+L8OZ87QX4jMvzAnRmMn
         9s0qRkbzAmIncemeS+FJkxac8JgkmLgK2bAZwaB3EPxGc0/fZmxat0jRFRjZl+aOKXPK
         jEBNBSdtgPYIelYcCdMidDIA1Z6BuhoB/GUaC4Z+ZKnoNXzGP10r2xwYK1jQpkF12elj
         ox1WF9SiqG33zLZatlQDQSThO69rh/A9TvWesolNOYXHZBqIgC/MIbr4W+mXiCp5HL1m
         UHNJ3xudNnae4xLeqpF0QcA1mRysByy5MpbM3ZGPDTuAU1a2+p8CZDh38MbcQVtDAKX2
         2S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D0+hqI/y5yTZoTqVDD1rJUFBYIymcauxB9jiO43HAY4=;
        b=SQadf0+VsY6j6GBQ47JoWooAfRu1M/OO/BjFXK4e3t7cptiYGjTYB/9/LMPVJSaHY9
         W7Cifd8L4dT4DaXGY7/YXaft1qebwCT2IlnYdOYpP/c0wOflAhsWhqCO0yIA5z0byFPw
         fWoo/MP7MV7WhS/evNQmljviTOeF+cRUKeX3bu8JNXUeK2h2PIaGg/CnNCFKARb5/kHI
         abGVKjHJvd823qt+FUV+fOVEhNIuGOf887apc6LNvvyZPAX7LnFddM3CbT25UPjqifJO
         YMA0cj+o0cZ88C+H6OrsOLDLWBM80GS3lWFt6KgNrMpfWKaiywJHk1Bd7wN0vq6vWPgP
         TbUQ==
X-Gm-Message-State: APjAAAUWoiRISeYVao1ZUpcOpfC1heS9gH7Ik/dtsEThxpO5mV/mzTzA
        Prs/a0a4W3Ly+oOa/m/G22W0wZJwN9B/ZLCwtBORCrHH7qs=
X-Google-Smtp-Source: APXvYqxK7be3sA/lEi0yxIvTO+iBprJFnlNkFcnmsYIt0FN8Cg6aVVtz1S9x+eRxrjuVERcovRQaEiV3x+3kgZ16xEA=
X-Received: by 2002:a9f:2275:: with SMTP id 108mr26776054uad.82.1582638998608;
 Tue, 25 Feb 2020 05:56:38 -0800 (PST)
MIME-Version: 1.0
From:   Sebastian Gniazdowski <sgniazdowski@gmail.com>
Date:   Tue, 25 Feb 2020 14:56:49 +0100
Message-ID: <CAKc7PVAWwJSAMbqyn-EOiTn7nc_dXHrqD68JtwdrK8-WN2mkUA@mail.gmail.com>
Subject: [almost-patch] Add diff regular expressions for Markdown and Zshell
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
Git comes with a few of the diff-regexes built-in. They are listed
here: https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_header

I'm a Zsh plugin creator and I've found the following regexes to be useful:

- Zshell function-matching:
    xfuncname =3D
"^((function[[:blank:]]+[^[:blank:]]+[[:blank:]]*(\\(\\)|))|([^[:blank:]]+[=
[:blank:]]*\\(\\)))[[:blank:]]*(\\{|)[[:blank:]]*$"

- Markdown hading-matching:
    xfuncname =3D "^#+[[:blank:]].*$"

Could those regexes be added to the built-in set? I think that they're
extremely useful and shipping them with Git would lift the requirement
of having them in each .gitconfig on each machine =E2=80=93 particularly
useful for e.g.: receiving bug-reports from Zsh-plugin users, that may
have the patterns not set up.

--=20
Sebastian Gniazdowski
News: https://twitter.com/ZdharmaI
IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zinit
Blog: http://zdharma.org
