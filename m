Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120FAC433E9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D639A65014
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCEIZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEIZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 03:25:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711DC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 00:25:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h10so1393330edl.6
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lmnl7rJWhlJyQywkzXl8gNpJ5aVhmhGe9dGixEfUfTE=;
        b=F/YGwx4P/ZGLt2G07i3yLhBIq5JEqV2D8ihGRkvmU3tQN67MFxTbYbwsCQfVemn8UR
         GirHv8s0nfpZRfEeeUSXMMh7fAY28ikP/QYNIG0axYs23XI5NmYRaN4rZoSF6xfCrVSZ
         /1hHv7+Szy06vVNpMUs/q7sYKbYKAIuoRkkJ6T5aXFV/44wIjXBPxtvywMGpn0wEKpJI
         SdfW7edGiQi9/gn17qUpDVyBuyvgwZqLp0XT/63RHHHWBNSZr3TcQ/KZddJSxcpb3N75
         1kanBZEOO7suCzf4Uyw/dUpBQk+arV+sf6pl0JI8krScCOgBb3VCBLEUfsFVGvXsNjqu
         m2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lmnl7rJWhlJyQywkzXl8gNpJ5aVhmhGe9dGixEfUfTE=;
        b=A8fKPfVdfzR9xaIr0Ogiedcc+Nha0dEbjW6hYu9QCiXN/yorIqNgDAwdMGEejgV3cl
         lrk2o9JSj2jxYRowlEEvn/ogAmKthwEJCKXyx9MD8mFMKlPiKSUEOw9VnAAPaxHEcrEs
         0whJSVtOUdojnktSrX1ecAtQNY4eN9pda0nANG6UOqJLyjdZY7nZzyKbgX8wPlZ6AgUk
         e5YZUnbRCZWk+wzXzPefo3J4vyZdmCe+EO+aSNQtejFQi3glpF4ZcOH3+SqO5D4k31gV
         2HjCVtGoKdqfv+IhK4s21pKfR7i61uHiNjghIkf4mY/7VRlG5JgAEvPnUu7AWx07Gngu
         rw9Q==
X-Gm-Message-State: AOAM533LpsoEHYDejSV2XoQWKq2j+z5ZlfDO7wl1iAI7saY9QsThFV5/
        3wB1HZ9DUpYVI0tKpbGxk3HRj2Wezrnp1gHSoK3/fATFUrjIcg==
X-Google-Smtp-Source: ABdhPJwx1tCAmQhOELHoQ+a8aaENjZ4Xf+DyzQ3XmQACb4qjYUTXMOeuNVvqg8I5GkPe611wo4fPdyt/qRTygCsVhLk=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr1616020eds.151.1614932709174;
 Fri, 05 Mar 2021 00:25:09 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-EXQJ2rWFqvt++Gi2=ZSCBonNtS1JSBkW4k+ORrQiyizQ@mail.gmail.com>
In-Reply-To: <CAGyf7-EXQJ2rWFqvt++Gi2=ZSCBonNtS1JSBkW4k+ORrQiyizQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 5 Mar 2021 00:24:58 -0800
Message-ID: <CAGyf7-FsrTUzrEwgzSXotmEV1VZHAgOA18i_E2D3P7cbuCUQ=A@mail.gmail.com>
Subject: Re: rev-list --use-bitmap-index
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 12:18 AM Bryan Turner <bturner@atlassian.com> wrote:
>
> The documentation for --use-bitmap-index notes that if used with
> --objects trees and blobs they won't have their paths printed, but it
> appears to change a whole lot more than that. In my testing, it
> appears to mean --date-order, --format. --parents, and maybe more are
> effectively ignored.
>
> It appears this changed in 2.26.0. The release notes for that version
> include this blurb, which seems like it might be relevant, but I'm not
> sure:
> * The object reachability bitmap machinery and the partial cloning
>   machinery were not prepared to work well together, because some
>   object-filtering criteria that partial clones use inherently rely
>   on object traversal, but the bitmap machinery is an optimization
>   to bypass that object traversal. There however are some cases
>   where they can work together, and they were taught about them.
>
> I have a repository with a bitmap:
> $ git repack -abdfln --keep-unreachable
> Marked 2 islands, done.
> Enumerating objects: 3603142, done.
> Propagating island marks: 100% (2576295/2576295), done.
> Counting objects: 100% (3603142/3603142), done.
> Delta compression using up to 20 threads
> Compressing objects: 100% (2898179/2898179), done.
> Writing objects: 100% (3603142/3603142), done.
> Reusing bitmaps: 291, done.
> Selecting bitmap commits: 293052, done.
> Building bitmaps: 100% (363/363), done.
>
> Here's some output from Git 2.25.1:
> $ /opt/git/2.25.1/bin/git rev-list --boundary --ignore-missing
> --date-order --parents --use-bitmap-index
> c6abb83d2798415fa9fe0ebd683623620076b412
> 1c55e675a66cb98955232e1bd230119fd97a5467
> 634396036782682e7cd8c955070dfb30546ed58c -- | head
> c6abb83d2798415fa9fe0ebd683623620076b412
> 2c7281b151d0079acc3f9b2c67d4667e1c9bf6d9
> 634396036782682e7cd8c955070dfb30546ed58c
> 1c55e675a66cb98955232e1bd230119fd97a5467
> 2c7281b151d0079acc3f9b2c67d4667e1c9bf6d9
> d672894d3b2413b62034cb3cdb3470e5dee0001c
> 76250ec85aadff2ff451ec13efdadb8ccfd6b239
> d672894d3b2413b62034cb3cdb3470e5dee0001c
> 013343e1900330429bcd1e31bb2ae7261fc1e3af
> 3e1e27621aa5f1d49286e23d77199004a835699e
> 3e1e27621aa5f1d49286e23d77199004a835699e
> b944291d204cb7f3d5eb7678360b16435c53b2f3
> b745a7b9bd9434eefb411d5f2a80a7187e3e8b93
> 1c55e675a66cb98955232e1bd230119fd97a5467
> 7f2c871e0d239e87bef7a1505ae928ae3a09a402
> 76250ec85aadff2ff451ec13efdadb8ccfd6b239
> 04f561866a9c015c14c69a0294b753ced5e084f2
> 013343e1900330429bcd1e31bb2ae7261fc1e3af
> d907528818d010a360113790e227ebbcd8a61395
> b745a7b9bd9434eefb411d5f2a80a7187e3e8b93
> b944291d204cb7f3d5eb7678360b16435c53b2f3
> 7f2c871e0d239e87bef7a1505ae928ae3a09a402
> c2ec4d3d76d865a9b701eb8be822d31252278a76

Apologies, it looks like Gmail helpfully jumped in and ruined my
output for me. Let me try this with shorter hashes:
c6abb83 2c7281b
6343960 1c55e67
2c7281b d672894 76250ec
d672894 013343e 3e1e276
3e1e276 b944291 b745a7b
1c55e67 7f2c871
76250ec 04f5618
013343e d907528
b745a7b b944291
7f2c871 c2ec4d3d

>
> Changing to Git 2.26.0, I see this:
> $ /opt/git/2.26.0/bin/git rev-list --boundary --ignore-missing
> --date-order --parents --use-bitmap-index
> c6abb83d2798415fa9fe0ebd683623620076b412
> 1c55e675a66cb98955232e1bd230119fd97a5467
> 634396036782682e7cd8c955070dfb30546ed58c -- | head
> 634396036782682e7cd8c955070dfb30546ed58c
> 1c55e675a66cb98955232e1bd230119fd97a5467
> 7f2c871e0d239e87bef7a1505ae928ae3a09a402
> c2ec4d3d76d865a9b701eb8be822d31252278a76
> 899053a9043045fcfeb7f9254f2700d286c60a63
> f1adcf64a8c06cb12f4e3e876040ee596fb3c0ca
> 16792db59ffdbbefe4a27a11a9831eac39be69a0
> b844c3d11d09c2aec3428ce61bef02fdd097b9f9
> 802918fb139ef96cae5259822d22a36478c5e7b1
> 3a6105686ab302093648733dbf5fada3b44db72b

All of these are on their own lines, as shown.

>
> No parents now, and the commits aren't in the same order. I've tested
> with 2.30.1 and it produces the same output as 2.26.0. If I remove the
> bitmap, all versions produce the same output as 2.25.1 does, with
> parents and in the expected order. (I should note, the bitmap is
> perfectly up-to-date; I did the repack right before running these
> rev-list commands. I've also tried the rev-list without several of the
> options in place, like --boundary, and it behaves the same. This
> command line is assembled automatically, so I'm just including it here
> how the system produced it.)
>
> Is this expected? If so, perhaps the --use-bitmap-index documentation
> should be updated to indicate that it has unexpected interactions with
> a whole lot more than just --objects? Or perhaps I'm doing something
> wrong/unexpected here? What sorts of traversals are --use-bitmap-index
> expected to be used for?
>
> Best regards,
> Bryan Turner
