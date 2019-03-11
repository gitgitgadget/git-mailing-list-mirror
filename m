Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139D020248
	for <e@80x24.org>; Mon, 11 Mar 2019 14:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfCKO1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 10:27:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39019 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfCKO1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 10:27:45 -0400
Received: by mail-it1-f194.google.com with SMTP id l15so7554648iti.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LAYr/QGO54QZJzdVrljw6Phh5GgFZ4ZDhUBVX2L3EiU=;
        b=MzWFmBOj6gyC6rtblYN7j3d7EYyflq2YGTcIFTb/bWF4gaN1fIY4MG0JBemLj5QTHf
         EPCEf/okng6YkjkulW0JfzT81+znsntJsuzak1YIPWAfZIjIdOBiw2PVPwBq9G2AfIsu
         1fNN0JhuSVdQsb8Km7y4DihBdhmkGOKccCscZM7PNJn49tLuqN5uLxnz7UvF9EYLGttw
         /cELnM2ah/XP9IoRxz8uqvFheAXYBsn0YqTe0zWK5KqxYkCNoru0HXSDO7s1ne/EYMC2
         oqDPb3nvd4GjNsbfBDQK6YqnNZ1yKxtyGK57ymR64qxy13p60WMh+guK1/jM12INsV6H
         +3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LAYr/QGO54QZJzdVrljw6Phh5GgFZ4ZDhUBVX2L3EiU=;
        b=e29Ph/ONYCsV7VUWp1dG1NEf6T+gqHNGBDThm4sG1vNGqUev4pfJgfITlFQ4jP2fve
         Mui3p476XM8Qd5m5cIKKGWVOiDRYTGGopfqAuUmLupZZEoZ0Me52BwYZHboHh+ld2WcV
         vBlY23OEhqb8DzsHKvSxLYorV1FKMt6XuPbcsKZqOuctW8br+YreQ/MGxNC1MSPwPHyf
         iBnJH1IKIi0whhG6ZQSZuffBod3QdJmLth6emuUnFb1lHkCF9uGu4FL9ambFNY+hdTvY
         u/8MLBDA096fgaWbbSQ/NqRcuuF22tGqd6A5LatF7jIRlV+rqcE1dzLwukqdMC9NDjH1
         4Q1Q==
X-Gm-Message-State: APjAAAX6sEwWslK3Ik+jXZ/yxPbmyOvvdG0OLWapflmillWxH2hpeHET
        9wrLWbUKWW1o3uop87ZbVVk4Dx472mirqdiL54M=
X-Google-Smtp-Source: APXvYqydTCVcz07C2r9HqABNU6qKmHLiRV7c50Ovq4r81RHuQTBNs1jSkS6sQ8TbkJLUUtSh84l/4n93S0euOgNfMdQ=
X-Received: by 2002:a02:241d:: with SMTP id f29mr16968009jaa.30.1552314464509;
 Mon, 11 Mar 2019 07:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-12-pclouds@gmail.com> <20190310193211.GA444@esm>
In-Reply-To: <20190310193211.GA444@esm>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 21:27:18 +0700
Message-ID: <CACsJy8BeEHv8uhgi-2J++-t2mktQprGNTPK9kF+7af1tmhZ29w@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] switch-branch: only allow explicit detached HEAD
To:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 2:32 AM Eckhard Maa=C3=9F
<eckhard.s.maass@googlemail.com> wrote:
>
> On Thu, Nov 29, 2018 at 10:58:46PM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > +     if (!opts->implicit_detach &&
> > +         !opts->new_branch &&
> > +         !opts->new_branch_force &&
> > +         new_branch_info->name &&
> > +         !new_branch_info->path)
> > +             die(_("a branch is expected, got %s"), new_branch_info->n=
ame);
>
> Wouldn't it be nice to give more context here, for example the symbolic
> reference that the name actually points to? When expereimenting with the
> feature and trying to switch to a tag, it refuses with
> "a branch is expected, got v1.2.0". I personally would prefer something
> more like "a branch is expected, got v1.2.0 that resolved to
> refs/tags/v1.2.0", so I get "oh, yeah, that is actually a tag ...". Does
> this seem worthwhile to dig deeper into? A quick glance left me a bit
> puzzled, I admit.

Good suggestion. I'll try to report one of the following

a branch is expected, got tag 'v1.2.0'
a branch is expected, got remote branch 'origin/master'
a branch is expected, got 'refs/foo/bar'
a branch is expected, got commit 'HEAD^'

It's a bit more code, but I think it definitely helps.
--=20
Duy
