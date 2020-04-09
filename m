Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B804C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1F20692
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0UvEZK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDIPAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:00:48 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46690 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIPAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 11:00:48 -0400
Received: by mail-ua1-f68.google.com with SMTP id o14so561645uat.13
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K/1bBpw8W4OKP2dL4Avc1cWDxVw51d94XPJu+H5J4BA=;
        b=Y0UvEZK1fCe+8Q3n2PtRXTmMq9ATjhdOUkpm8xc7fbzdjwt1YqAdMdgipNBeNfz+5+
         puw9zRSLozS2p9Rqddp/5TWAv2XKX5gCLYSbCMZOGyBRHAb5RT445POVWYC+CQWTwoo9
         1h9CGHbyDHjRsm1/8xYyP4NtIs0LQROqgga+Qc5VPawICxWe96CwGmg3nrZTQwt2ILdv
         n5RsPwaflwa2oUINWhLCJiOcpN/8ZM46dihxtP/8sxrsAjvEF7a+6vQHb+og1/2GQijg
         GnVVbzII4NetXa6+Gk//abNXz0JuPpqnra47hNVV3f+z+uKZA+v36F45hKGzma0Kq6t5
         UTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K/1bBpw8W4OKP2dL4Avc1cWDxVw51d94XPJu+H5J4BA=;
        b=QokDIDThhXPwNutyLRHG6EtoFxnjYkhuMyNLjlCzc1f65ccxHC4sGaARd+QLoJxZ7R
         7ixKJ6eDJ9Pkfq5JM96x0fjdR6AJTAYbBrDeTOXFVcdP0LLujS/gtqDVTDPo7X4hfSun
         377gEmPDkj/GEeFBsikeCTBp8MsJcP0LS/Eo/jIxP6/E1UG7MDmPR19GKslfK4UW55w2
         1+RnFcm1XmZHZ6zWaYmYFul3HqU2IO6zC4UqiGWfdc4ABp7I9m6L1hTzdr6ZezM6bDjz
         PMDN9KWMdLmcDIlbzZFkzL23iLJ+Mjn7fRA4agAviR6i/buHFfVTtXb14Ql/bxIK3zup
         TvyA==
X-Gm-Message-State: AGi0PuafIDZndApTuQuPaBkvgMDiQWQG5CgBd0t3CZwNASFemqnSTvkc
        5ZMzbp6gS7MdBBrWwC0x/6hjSXJcTReJkCR57OqSWRZY
X-Google-Smtp-Source: APiQypLKBv6Yku5M/GvxCc7HDDy6tSPyZ0h/5bGrdIyY5JaMVW6KZNK9X76V3usvccFyhY1yWnuFtTOCXa0JXvofTzw=
X-Received: by 2002:ab0:5550:: with SMTP id u16mr4567385uaa.62.1586444447721;
 Thu, 09 Apr 2020 08:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200409103541.23743-1-martin.agren@gmail.com> <20200409141452.GC3494212@coredump.intra.peff.net>
In-Reply-To: <20200409141452.GC3494212@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 9 Apr 2020 17:00:34 +0200
Message-ID: <CAN0heSp3=8fTGb5Ciuvr8+EevNSrAfskvrrS_PN=VPhKJyB5jA@mail.gmail.com>
Subject: Re: [PATCH] config.txt: move closing "----" to cover entire listing
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 9 Apr 2020 at 16:14, Jeff King <peff@peff.net> wrote:
>
> On Thu, Apr 09, 2020 at 12:35:41PM +0200, Martin =C3=85gren wrote:
>
> >  Not sure how I managed to botch this in 1925fe0c8a.
>
> I managed to botch the review, as well. :)

:)

> I checked it with doc-diff, but was surprised to find no change. That's
> because the manpage shows it the same either way (the indented chunk is
> just a different example, but two examples back to back render the same
> as a single one). But you can see the difference in the HTML version,
> where the final example isn't in the grey box.

Ah, you're using AsciiDoc. With Asciidoctor, there is a change in
indentation of the "path =3D foo.inc" line with this new, proposed patch.
The original commit reduced the number of occurrences of such
AsciiDoc/tor differences around this spot, but failed to bring the
number all the way down to zero. Now, finally, that discrepancy will be
fixed.

> That explains why I didn't see the issue when running doc-diff on the
> original bug. I wonder if we could teach doc-diff to look at the HTML,
> too. I'm not sure how, though. Certainly html2text or similar would get
> us something diff-able, but without the visual elements (like the grey
> box), I don't know that it's much more valuable than the manpages.

At one point I considered trying out diffoscope for this. It should
allegedly be good at comparing "everything". But being good at
everything, it wanted to pull in a discouragingly large number of
dependencies, so I never actually tried it out. It doesn't explicitly
claim to know html or manpages (but does mention xml and pdf), so I
dunno.

Martin
