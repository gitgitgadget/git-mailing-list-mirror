Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB5C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 21:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382522AbiDTVbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382508AbiDTVbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 17:31:12 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C159D427CD
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 14:28:23 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F126B5A410;
        Wed, 20 Apr 2022 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1650490103;
        bh=mKEcP1ipJUpgSJHjHEDZ7dXQb3Eyv+JwvSL2NDpj2H0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0nYfehh7M+k57s5Np3JZYDEL3Lf27DsXW90BNuHw8HOHM++LtWapLjtU0j7Tiib04
         54tPNPHTy8iSpE2kFU4M8EaCkTgsXA6h+CGADZ5qP0nY/I9Ykc4hx1xizImx6RmoK5
         ALVfQ8lMr4wVKGczHDWBTBauKIGVWZBMM4s595Bz8ZKQzWukYr4+xEwvJqtWTEqRhg
         MIfMq14zNCeoLQkhzAOYnES1bsN+BWCNaFjHRiD+qxrlmVgWU0ouAQ6ZloQX9FKFmb
         48FLJLtuc/DklQUcAc++3Y46BvQPvj7hU+vnFkkE2xPx5LM9A6RAEbs+xHhNuIDDo9
         xpeluYKkByv0o5NILH044aWI3p6baThwfdRZMENE3AiAmJVLad+jqhECtliLtmZvRV
         UuXlFGBYDbTHltY+0vDjprQbY811+f3oB5nyAVoWEa+jzWpAxLlh7EC7x+w5DS1ExW
         V720//l6fJXJSYyZiISbg+97HmuXPRIU8ujpXPLMwSaYaGZbtQB
Date:   Wed, 20 Apr 2022 21:28:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Attila Csosz <csosza@designsoftware.com>
Cc:     git@vger.kernel.org
Subject: Re: Git bug report - disk errors on Windows after push
Message-ID: <YmB686xgnjF86F+H@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Attila Csosz <csosza@designsoftware.com>, git@vger.kernel.org
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
 <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n3MCpmO+9Dz7pJFl"
Content-Disposition: inline
In-Reply-To: <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--n3MCpmO+9Dz7pJFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please avoid top-posting on this list.]

On 2022-04-19 at 03:52:23, Attila Csosz wrote:
> I've experienced the problem at least 3 different external disk.
> I'm not using cloud syncing service (e.g., Dropbox or OneDrive) for git.

I don't doubt that's the case.  However, it's not possible for Git to
corrupt a disk just by writing to it.  Git, as a normal unprivileged
program, can only open files and perform normal read and write
operations on them.  Management of the file system, including integrity,
is the responsibility of the operating system.  If running Git on
Windows causes files outside of the repository to be corrupted, that's
either a hardware problem or a bug in Windows.

If you're seeing this problem, it could be that you have a series of bad
disks (say, if you bought a set of cheap flash drives), that the drive
isn't being removed properly, that you have some sort of broken driver
or malware, that there's some other hardware problem (e.g., a bad dock,
USB device, CPU, or memory), or just that there's a previously unknown
bug in Windows.

None of this is Git's fault, and it's really up to you to figure out
which of these it is.  You might try isolating it by using a different
computer to write to the repository first, to see if something about
your current machine is the problem, and then try isolating other
causes.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--n3MCpmO+9Dz7pJFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmB68gAKCRB8DEliiIei
gUpBAPsHPCGT/AStEVPEPkTf73ImMFY5zM+dO9fmKM3oNlgXOQEAqtIXYdGJvUyk
RFY9NvbyHJXRKMxAVzx5IDZWb4WrkAs=
=47vX
-----END PGP SIGNATURE-----

--n3MCpmO+9Dz7pJFl--
