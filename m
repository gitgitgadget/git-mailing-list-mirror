Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE4C7EE2F
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 08:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCCIzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCCIzp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 03:55:45 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A71554C
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 00:55:43 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bl39so524104qkb.10
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff09F0t5+flsBPQiBs4nTtzDLCCJfUNdQvLtMwfo+vo=;
        b=Sv+mge5o3gzET+cssuWvRfxD6Z+uGpPpvhC2QB38ZGvRNp4KC53X9Owb3DxfTFouFL
         U6WIiHcSyYd83enB50XmiHKicgCRyeZx1qZWzIkSTNW0ipVNYgckWdRcS6lgForFboky
         21zf39zomf0Ah1Cxx7mUg4iDyZ0ibgwgP82pfbeqI98NYNna4khaUKK965bYNOd2Ivui
         epAtjvrwxluf4RqWoOazq4SwI9ut9WbLhW2+Pc9AqyLj08zjugGlUagZFmH+UceOOZiB
         Ogo4l1/XPBFBBxJt/BW7SdiSuS99kLbyQS8U9RWR2/lQcBqb3EcFj1YXmn+9YD/GdOwF
         qWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff09F0t5+flsBPQiBs4nTtzDLCCJfUNdQvLtMwfo+vo=;
        b=0ucsmMxA9RXXLhm7xwO6TeFbmx/YoIfHYffpaG4/AT+xI/E4Esd9MFwosZab2jDjF/
         E5hsvbRttU1wkSDUMSGfVP57RtmKLFZGEQrBpZ9GG2mARzd/Cj0e+ZFDhRSmRJjciYkf
         6ifGRAETzqAJnkptwkwbPRse3/Q3pGj3SawinXkzA2rXvCy7Z9pu33R+OKw7dRmsIEc4
         Eyhv/MOjrLfSJV84LA460gM3ZlGaGCpWHpniSfbrHc0J314zuCQqCE5E84tvpEBbe7h4
         jld4dL5VI5wi9glk0k3/bgsLsXDmW/11u6dEIARFYx8uisSM8x2cgEnMhEqjFqex/atH
         l7yg==
X-Gm-Message-State: AO0yUKVXz2DmjOPPAqI6+86/EHhQYHYGKEARnPRp6IetfBBK3mH6Q3A2
        5FGB6KVWTUzSfhhoONKRAeaiUOAMVTkUgMmj5gvaNErj
X-Google-Smtp-Source: AK7set8h0fiF170O1If0r7RnEnsjVr465J2Ub3fvPKplI4rM+QioqCDw3Y3Uon4dBX2NnofB9SwgxLOVFI3+Ad/e8RA=
X-Received: by 2002:a05:620a:2154:b0:73b:aa08:79ea with SMTP id
 m20-20020a05620a215400b0073baa0879eamr152258qkm.5.1677833742602; Fri, 03 Mar
 2023 00:55:42 -0800 (PST)
MIME-Version: 1.0
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <ZAEgRDelTlNZRJ5J@tapette.crustytoothpaste.net> <xmqqfsamiul2.fsf@gitster.g> <003201d94d64$1e732030$5b596090$@nexbridge.com>
In-Reply-To: <003201d94d64$1e732030$5b596090$@nexbridge.com>
From:   demerphq <demerphq@gmail.com>
Date:   Fri, 3 Mar 2023 09:55:31 +0100
Message-ID: <CANgJU+Vhh091E+n8B6WaMKh6K2kAG29a2M8Oqm-Zvrr8kRrTRw@mail.gmail.com>
Subject: Re: Let us not call it git blame
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Dinesh Dharmawardena <dinesh_dh@outlook.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 3 Mar 2023 at 02:24, <rsbecker@nexbridge.com> wrote:
> the core.user and core.email are associated with a nameless single sign o=
n (SSO), or tokenized user, in order to be compliant from a regulatory stan=
dpoint. This includes GDPR in Europe and the Privacy Act in Canada. In thes=
e cases, there is no identifying information in the commit itself, but exte=
rnally in the organization's HR and IT departments where identifying inform=
ation is tightly controlled.

I wish git would make this a core feature.  I think it is one of the
few oversights in the core design of git that there isn't a built
indirection on author and committer data.  It should be possible to
"forget" an author or committer without having to rewrite the repo.
IMO, one day in the future this design deficiency will cause some very
expensive remedial work in the git space, and IMO it is only a
question of when, but sods law says it will be at some very
inconvenient time.

It really should be technically simple to remedy as well, replacing
author and committer data with a hash or ID which is used to indirect
into a file of author information that is *not* version controlled
would essentially solve it.  If someone wanted to change their name
they would update the file, if they wanted to be forgotten they could
simply delete that line from the file and push it.  While not a 100%
complete solution it would go a LONG way to address most people's
privacy concerns and other practical identity management concerns (eg,
"my email changed"). The .mailmap support is just a bandaid, it
doesn't actually address the core problem and in fact in some ways it
makes it worse. If git provided support for hooking the id lookups
then queries to resolve the ID or names could be made to a third party
software or service, like an open source service for the public, or an
internal service owned by HR in the corporate context. It isn't rocket
science, it just requires recognition that names are not static
identifiers.

cheers,
Yves
