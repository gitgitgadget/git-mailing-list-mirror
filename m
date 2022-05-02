Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB2CC433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386542AbiEBRNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386558AbiEBRNL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B85FFA
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:09:40 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a23-20020a17090a6d9700b001d60327d73aso11568568pjk.7
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wXtwhh2Z7WUsupCmAe6SnX2OG4aZ8WjvMeJ+60d6K3w=;
        b=eFcjs7PGHYCIn4eQ0Z0vpHlGMAwJRy7j+RJHoHxd1JQgj5SC74JhHjNoqWpVjTHZ5M
         zcYqEmPGNTfM8g80mOhEGST2T0EtogsCUXhLK5YQb6SSRJOPB94cM4AE4LXwFPCd/YD9
         sz/3f/I827Q9OSspww1ZXrLnyzeayIR3POCVZNKPme9ZjfOqm8VZwnAcBIMbsO3Xwein
         isDutsMAAATZwhDV8s2hTZdXDWJj6Huk9BXRrRmdQD++WWrTTbGeBRUdP8nqa4nCEFte
         uzxsCt7Dr1Z7XeSCX7j4nQdn1hxjSuxo91xlvqkoTlssdpxlfNcZMlMRI5uqZ+TgiePP
         W4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wXtwhh2Z7WUsupCmAe6SnX2OG4aZ8WjvMeJ+60d6K3w=;
        b=EFrlunm7ZkHA8PkkFB5CROkR8xt4YOvLyc5MRD5xN24t/LyK3HSEeR5TCnMcWm6yVt
         xi03ZD9rMeFlMwTP13lkl1o6SMmVjN+f+g8NJIEoeW7Tq23C0p8DJE+STN3ATRaXfZe/
         oxge6e58LMBzk76g16SiRzmDXlZ4mqw5FK2igLF8MbeNYPriyPscRHiKAZDQjUF8zLUP
         9h24eMRFH9SSrI+pJCPoLRglD6bMGG4ISablQCC70Hi8bKsIy34fR2BrdL4tRoH8nZD0
         bMZFBOEgv5QGAqFtdp0EswRQfnIvs4dFN0P/N5xrqZZaI72WVfqguXP8IV9tZsWcMIkk
         Twkg==
X-Gm-Message-State: AOAM530Atb4s+OVG8kTs+hNUHRRi76vVjnxbXQovc5dWbCj2OPSjq6K5
        iva+ext3gjO4FGmZOKdnmBNO61UoqBsDH+ZeynaF33Bonvoc7bpEh9rBGN8PC2aBPqufn7HAAA2
        LSecJQQyf5UZw74nfzgnsU8hYZRJhJ/WJLTFWIATeYlh8X/k4WvZwU6CHEve5x57xLg==
X-Google-Smtp-Source: ABdhPJyZNeu/4XfbciNgEsoOqPPNnR84IwFRd+2W6G+ns3M0J2ZmqwPdnk0YKsjO1sw1GK2gkzveRQiBoz5Z79Q=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:e5cd:b0:15d:57c7:b9fb with SMTP
 id u13-20020a170902e5cd00b0015d57c7b9fbmr12353063plf.101.1651511379958; Mon,
 02 May 2022 10:09:39 -0700 (PDT)
Date:   Mon,  2 May 2022 17:08:56 +0000
In-Reply-To: <20220328191112.3092139-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 0/8] cat-file: add --batch-command remote-object-info command
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to get information about an object without having
to download it completely. The server logic has already been implemented
as =E2=80=9Ca2ba162cda (object-info: support for retrieving object info,
2021-04-20)=E2=80=9D. This patch implements the client option for it.

Add `--object-info` option to `cat-file --batch-command`. This option
allows the client to make an object-info command request to a server
that supports protocol v2. If the server is v2, but does not allow for
the object-info command request, the entire object is fetched and the
relevant object info is returned.

Summary of changes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Patches 1, 2, 3, and 7 are small changes that setup the main
implementation. Patch 4 sets up object-info to be backwards compatible
for future patch series that adds additional attributes.  Patch 5 adds
internal trasnport functions to send and receive object-info command
request packets. Patch 6 adds the fallback if object-info is not
supported or fails.  Patch 8 adds the cat-file implementation.

Changes since V3 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 * Object-info is now implemented in cat-file --batch-command rather
   than fetch (new base commit)
 * Removed config option to advertise object-info
 * Added forwards and backwards compability for object-info
 * Split up some patches to better describe and visualize changes

Signed-off-by: Calvin Wan <calvinwan@google.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>

Calvin Wan (8):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch default settings
  object-store: add function to free object_info contents
  object-info: send attribute packet regardless of object ids
  transport: add client side capability to request object-info
  transport: add object-info fallback to fetch
  cat-file: move parse_cmd and DEFAULT_FORMAT up
  cat-file: add --batch-command remote-object-info command

 Documentation/git-cat-file.txt |  16 +-
 builtin/cat-file.c             | 225 ++++++++++++++++-----
 fetch-pack.c                   |  61 ++++--
 fetch-pack.h                   |  10 +
 object-file.c                  |  16 ++
 object-store.h                 |   3 +
 protocol-caps.c                |  14 +-
 t/t1006-cat-file.sh            | 347 +++++++++++++++++++++++++++++++++
 transport-helper.c             |   7 +-
 transport.c                    |  97 ++++++++-
 transport.h                    |  11 ++
 11 files changed, 728 insertions(+), 79 deletions(-)

--=20
2.36.0.rc2.10170.gb555eefa6f

