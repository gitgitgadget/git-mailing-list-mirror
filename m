Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A23C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2772073A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600708019;
	bh=AbhwfCIb9bIs6pNgif8rZPv9lt5aJLE0P/1yQbIydvE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=az34fsOHiUFvcyImKOD235BkbSm7LpJNOsX3hqLuIbcqPU1cPLi+t37yVH2XDcox1
	 6M3/x1EohMHdk6N7OuTDCfVtaRYclOc6WTO9RnoIyem22y3uGaDy/NPRvO7d/k6EjA
	 kNhHJeukifi+oq8RfcABvUBzqH603gLg3uZMfKJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgIURG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgIURG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 13:06:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C26C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 10:06:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n133so15860342qkn.11
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=mQheBbl/Envxc4mlK6rqmLVa1VigNOe54/9h0gT4kcY=;
        b=StnFiTy0RCRivBJcaZa7KEdIF9in6BDgFzoYNi07XP6YRcUL19NTgUITB1TBEhFcXg
         Ru2yVf2z+6Hsi7Ut5BQ1fCOO7RyqK1HWq8axp4UBlPnql+rIpSrYGXwBuHXOD9tMIoK7
         VcgWCCG/9UYSWUfsNzFhBmhXBC23FEIh7/1uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=mQheBbl/Envxc4mlK6rqmLVa1VigNOe54/9h0gT4kcY=;
        b=ucxRs71oUvge8HyCw5eV7TvXwcniAMKdNkbDNs1Wl+F43vv0bKpxeORQvfmP896cDx
         oyVnh32UNT2bzkukXQ6+wr7eKHWmAgheSNbFUczOPZrk51sCIf3D+aDDGd9g/UfFoZPJ
         PNecmrMCuV774fazimf/6FzSTfMLnxZ4ZFQw7eauGcSc1IdMK2l9FugH6y4qNDfwBJUF
         sqQlH7bdyQe3qGjBLWzLPC5rKYjOGkeRM2/FvwT1tpRtnSorrW1jB90DI9mzuLFJFmAc
         XyZNG+DrccfsytxBVzlM5VjOG055zBA87Z3VDw+2wlXbQEWVSDdAGxYCDkcEhzgmF3L8
         eEzA==
X-Gm-Message-State: AOAM533Navl/Y8K0pd3AT00MpxLoVRHDCog0eFL2TFkc8pemeMK49OJV
        iDOYG6alNfuCccFTzxoOfufUR6sLoThniN52
X-Google-Smtp-Source: ABdhPJwNBPjWlIPRT4omUFip35s62/Vn8gKXKMZB15novcCArBYZg64QSG2WYnrz5Ih7raqifK2AxA==
X-Received: by 2002:a37:a84a:: with SMTP id r71mr663302qke.481.1600708014069;
        Mon, 21 Sep 2020 10:06:54 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id u18sm10671259qtk.61.2020.09.21.10.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:06:53 -0700 (PDT)
Date:   Mon, 21 Sep 2020 13:06:51 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     tools@linux.kernel.org
Subject: grokmirror-2.0 is available
Message-ID: <20200921170651.aszbydzvnj7l4y2w@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org, tools@linux.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x4ff6avmflavdcyx"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x4ff6avmflavdcyx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello:

I am pleased to announce version 2.0 of kernel.org's git mirroring=20
software, grokmirror. This is a major rewrite that intentionally breaks=20
the upgrade path from grokmirror-1.x due to significant backend changes=20
requiring replica administrator's thoughtful consideration -- please see=20
the UPGRADING.rst document provided with this release.

## New in grokmirror-2.0

- Drop support for python < 3.6
- Introduce "object storage" repositories that benefit from git-pack
  delta islands and improve overall disk storage footprint (results will=20
  directly depend on the number of forks).
- Drop dependency on GitPython: use git calls directly for all operations
- Remove progress bars to slim down dependencies (drops enlighten)
- Make grok-pull operate in daemon mode (with -o) (see contrib for
  systemd unit files). This is more efficient than the cron mode when
  run very frequently.
- Provide a socket listener for pubsub push updates (see contrib for
  Google pubsubv1.py).
- Merge fsck.conf and repos.conf into a single config file. This
  requires creating a new configuration file after the upgrade. See
  UPGRADING.rst for details.
- Record and propagate HEAD position using the manifest file.
- Add grok-bundle command to create clone.bundle files for CDN-offloaded
  cloning (mostly used by Android's repo command).
- Add SELinux policy for EL7 (see contrib).

## Object Storage Repositories

Grokmirror 2.0 introduces the concept of "object storage repositories", whi=
ch
aims to optimize how repository forks are stored on disk and served to the
cloning clients.

When grok-fsck runs, it will automatically recognize related repositories by
analyzing their root commits. If it finds two or more related repositories,=
 it
will set up a unified "object storage" repo and fetch all refs from each
related repository into it.

For example, you can have two forks of linux.git:
  torvalds/linux.git:
    refs/heads/master
    refs/tags/v5.0-rc3
    ...

and its fork:

  maintainer/linux.git:
    refs/heads/master
    refs/heads/devbranch
    refs/tags/v5.0-rc3
    ...

Grok-fsck will set up an object storage repository and fetch all refs from =
both
repositories:

  objstore/[random-guid-name].git
     refs/virtual/[sha1-of-torvalds/linux.git:12]/heads/master
     refs/virtual/[sha1-of-torvalds/linux.git:12]/tags/v5.0-rc3
     ...
     refs/virtual/[sha1-of-maintainer/linux.git:12]/heads/master
     refs/virtual/[sha1-of-maintainer/linux.git:12]/heads/devbranch
     refs/virtual/[sha1-of-maintainer/linux.git:12]/tags/v5.0-rc3
     ...

Then both torvalds/linux.git and maintainer/linux.git with be configured to=
 use
objstore/[random-guid-name].git via objects/info/alternates and repacked to
just contain metadata and no objects.

The alternates repository will be repacked with "delta islands" enabled,
which should help optimize clone operations for each "sibling"
repository.

Please see the example grokmirror.conf for more details about configuring
objstore repositories.

## Space savings using object storage repositories

Any disk space savings will depend on how many repositories are forks of=20
each other. For git.kernel.org, which already aggressively used=20
alternates for all linux.git forks, we saw reduction from 60GB to 20GB=20
for the entirety of git.kernel.org content. On some of the=20
codeaurora.org systems, especially those containing a lot of pre-release=20
forks of entire AOSP repo collections, we saw space usage go from 3TB to=20
under 1TB.

## Stability

This release has proven pretty stable and has been operating on=20
git.kernel.org and a subset of codeaurora.org systems for over the past=20
month. However, since the trickiest part is initial repository=20
conversion towards the use of object storage repos, we urge proceeding=20
with caution. Please study the UPGRADING.rst document before making any=20
changes to your infrastructure.

With all support questions, please email tools@linux.kernel.org.

Best regards,
Konstantin

--x4ff6avmflavdcyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCX2jdnwAKCRC2xBzjVmSZ
bGF9AP0TDwe9jUmlWZGW9LEjHjSXXKnOAVB4C+0UupoTD0/4/AEAxXW2pfirzX84
vW6hMB+fhIDuHdqL8mEGfCLvWatSdwA=
=Ieyd
-----END PGP SIGNATURE-----

--x4ff6avmflavdcyx--
