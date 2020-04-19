Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D45C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 04:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0488B21D82
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 04:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5Vz2cDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgDSEoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 00:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725763AbgDSEoU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 00:44:20 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14532C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 21:44:19 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q200so1469645vka.13
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 21:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UnrsQIPMNBlm8Pp/RhDZ89qo906IL1ExYi/m+yLF+Vc=;
        b=u5Vz2cDFuwQxGfp89OqdFcqTeyHZTsNFeRCOFdNXkbRafQOv+4bsCgAFPhIrUsktS3
         xNmMiX4PbKimht44oa/DVj6e9xX5T+D85PqDTnd+9i9/GnE7IfKaHTvm+/LFM/CTPvY/
         2+krIIKHI8D+OQQd6qNYattBeSckZYaXYORkKpxctnoztCeugLSQlPG7sfDczG6xIJIY
         smR/JK1838EIt4JjqSU1R51Ope5ut9MLXzEdoyOo4uBLeBr+nl88Om+DNSF3Vbp4EhXT
         X/dib0vHHwHqh8E+vn07cDZ5RJqtmy9ITAH61f7pFbvn5AoiksuIrAMjTW0qp1wBlOHg
         1J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UnrsQIPMNBlm8Pp/RhDZ89qo906IL1ExYi/m+yLF+Vc=;
        b=um75rH0JX08CGrNp9dEEhTwg2YavM3VRD7dLDlknKyMrZko0tCx2unBETP4gQP3Kad
         VRdIr4jloU1EHgW638JISwHY/VdCXU7eyxn2KJDZzsGpHUpltfZyjfAkbbTKp089JoKz
         xvhFlyhpoAzXRy1D5XFJ7T3+OxfWZgDSavJjWc8n4U2J1GFgA+JE0kGOZtRZuXmhgGvQ
         ZZQm0hMLSD2uabTBX1wYmU2jIkz2pF2Ur5y+hku3bQ4kLHr7VvMhuf4yjJo3RRblu9eR
         HY7Do8ttZyBfUptEC3xYU4W54SAGHXWFeqvIrGFDsd7JA3bV0IKOoaYPJ6vTBvu+sciD
         SYAg==
X-Gm-Message-State: AGi0PubguCcJTV7GHiAEUC2p4w1CWqtpUCxKhuxYzPuunxJfP2TTp/Fz
        hd3GZFHWhSW0R6BiJutpsV6kYzln0QHhbcsYuza3RZQq
X-Google-Smtp-Source: APiQypJ7w1UREcbJtzJB8UScFC4G4NyGSxJlvCeAfARGmtNz+qOQbO4iOn5rGEHxAWVA3mUTnjC0xpAiaECBy8KN5CI=
X-Received: by 2002:a1f:2414:: with SMTP id k20mr7230837vkk.57.1587271457916;
 Sat, 18 Apr 2020 21:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
 <cover.1587240635.git.martin.agren@gmail.com>
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 19 Apr 2020 06:44:06 +0200
Message-ID: <CAN0heSrzVfb1=xUReZidBVhE427r7MRPtZ_RDOorXESq4r-wwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] strbuf: simplify `strbuf_attach()` usage
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Apr 2020 at 22:18, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:
>
> On Sat, 18 Apr 2020 at 21:56, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> > > -       strbuf_attach(line, out, strlen(out), strlen(out));
> > > +       strbuf_attach(line, out, out_len, out_len);
> >
> > This conversion is ok as such. I wondered why we pass in the same
> > value twice (before and after this patch). Turns out this usage is wron=
g
> > (as per the documentation in strbuf.h) but safe (as per my understandin=
g
> > of the implementation in strbuf.c). I'll follow up with a series that
> > fell out of that investigation.
>
> Here's that series. It could go in parallel to Danh's, or one could go
> on top of the other. Any of those would be ok with me.

I realize now that some of the reasoning in this series is incorrect.
`strbuf_grow()` will use `ALLOC_GROW` meaning we might reallocate
cheaply rather than doing an entire allocate+copy+free cycle.

Still, there is some buggyness in the usage because we might reallocate
(with a 50% overhead) even when we shouldn't really need to.

I'll resubmit this after tackling it from a different angle: I'll
introduce `strbuf_attachstr()`, simplifying and robustifyng most users.
Then I'll switch a few incorrect users of `strbuf_attach()` to
`strbuf_attachstr()`. Then a small number of users will continue using
`strbuf_attach()` with `alloc =3D=3D len` for $reasons.

> The summary is that this function takes `len` and `alloc`, where the
> latter must be greater than the former, yet several callers use the same
> value for both. I first thought this could cause quite hairy problems
> such as writing outside of allocated memory, but it doesn't look that
> way. See the patches for more information.
>
> An alternative to the approach taken here would be to introduce
> `strbuf_attachstr()` and convert most existing users, then convert the
> few remaining ones to use the new function or to move in another
> direction. But the new name is a downer -- what else would you attach to
> a strbuf if not a string?

So this is what I'll do instead. The reasoning is, you can attach a
string (a NUL-terminated buffer) or a non-string (non-NUL-terminated
buffer).

Martin
