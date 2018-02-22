Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C731F576
	for <e@80x24.org>; Thu, 22 Feb 2018 09:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeBVJ0o (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 04:26:44 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:41085 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeBVJ0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 04:26:43 -0500
Received: by mail-ot0-f169.google.com with SMTP id w38so4035905ota.8
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 01:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Ot2PgavcpE/HL+ksCkzgeNlFupGGpfhwuASw4gpcs4=;
        b=rXnWZO/BKHBIjLbGKM0JTt+5BY4QBvouPHvnl2hJ2SonlHRAKqq0SYxV/Khwl+oT7D
         87RRyfrxpIRKr2djzic/WnPXml/ap0sBop/VZBeZOovyZl6PvTyftMzDG1InjaQSqMdG
         ZUGELD2zPVUHaL6MxDGqrm03Jvzyl8V/7YkGDign/mgRoRmvIb+pC1frw3E9y/kdI4RE
         YljE4+jtEOcYajysmXTtTzBVY+KLlm+q/HOSwQebXFwDhcXsagMWV0VO7S2OdlEpYzVz
         8aRr1XlTX64QCBUoKs4hEX7lhiJhIqYsaQGY54Vo6FOuZpZr6C+qUZev0ggjqmu4lHbC
         E0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Ot2PgavcpE/HL+ksCkzgeNlFupGGpfhwuASw4gpcs4=;
        b=jInbEK9t9QAJBHVM3BqSi2t5kQDCWA6b5y5xPwqz27ENfUHaql9yOEObGIRKFGB1kr
         LzYdGOBbu5P80geb/6EJJFDl2VGAyZDan3xGxji5Fob20a5q5NDGR0wRM4pzwq4RYP3P
         mzXpixvzWQ0n2qRMz2zg9CmPoT+hR/ZoW5xt/BZz2IEZy95kraHuIvPylTbEv36X7XRU
         EwUqMJ9SYKgbPBez2IwpbPzwlQsYVqKV+/16/QQqClYREKHSdW7oIamcEttQMpSlnI2y
         YORdIpFznCKLZVwJWjRxaemrYGfUzaTu8XD9Nsnst7Ch+/okrnFk9qR0xFSiN6yuxuEx
         1jSA==
X-Gm-Message-State: APf1xPDvCnlE89NiFukuhtyMHAFHFFS7TvsqBP440IIh/j5gjvFh1Gh2
        icwu3l/XCsYJH5ZBymuQBqHJhQ5BdMsOGOTfVeA=
X-Google-Smtp-Source: AG47ELtmiYlAGYlcmYytZ2gPUS/KfTu5JOxduxYfU8vh7j9X94uxQ3YLto/R/XwG9mbI856SffNMgmdpWYstmMgy0xg=
X-Received: by 10.157.81.92 with SMTP id u28mr4788613oti.152.1519291602308;
 Thu, 22 Feb 2018 01:26:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Thu, 22 Feb 2018 01:26:11 -0800 (PST)
In-Reply-To: <87wozffavp.fsf@evledraar.gmail.com>
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
 <20180214105149.28896-1-pclouds@gmail.com> <87wozffavp.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Feb 2018 16:26:11 +0700
Message-ID: <CACsJy8BsUsT6iO9_68+rHnZG5B-tcaXZAXR88nh8DgR65zvVKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, doron.behar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 5:46 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> In general I'm mildly negative on adding this, for every user like Doron
> who'll be less confused by a hack like this, you'll have other users
> who'll be confused about git inexplicably working with ~ in the middle
> of strings, even though;
>
>     $ echo git init --template ~/path
>     git init --template /home/avar/path
>     $ echo git init --template=3D~/path
>     git init --template=3D~/path

If you have a directory named '~', I expect you are already used to
prefixing it with './' because '~' will be expanded in many places
where you might want to avoid.

> I think it makes more sense to just leave such expansion to the shell,
> and not try to magically expand it after the fact, since it's both
> confusing (user: why does this work with git and not this other
> program?), and as shown above changes existing semantics.
>
> We'll also be setting ourselves up for more disappointed users who'll
> notice that e.g. `git clone file://~/path` doesn't work, but `git clone
> file://$HOME/path` does, requiring more hacks to expand ~ in more
> codepaths. Will they also expact `git log -G~` to find references to
> their homedir in their dotfiles.git?
>
> I think this way lies madness, and it's better to just avoid it.

Well. That's a bit extreme, I think if we add this then we handle case
by case in future when it makes sense, not blindly expanding '~'
everywhere.

The problem I have with this --template=3D~/path is tab-completion
actually completes the path, which (mis)leads me to think the command
will accept '~/' too. But this looks like a bug in git-completion.bash
though, it's a bit eager in completing stuff (or maybe it completes
"--template ~/path" and "--template=3D~/path" the same way).

I don't feel strongly about this. I'm OK with dropping these patches
if people think it's not a good idea (then I will try to fix
git-completion.bash not to complete '~' in this case).

> But I think that if we're going to keep it it needs some tests & docs to
> point confused users to.
--=20
Duy
