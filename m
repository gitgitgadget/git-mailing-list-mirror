Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E5C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiGWOio (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiGWOim (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 10:38:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534B8BA8
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 07:38:41 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7AB4F5A14E;
        Sat, 23 Jul 2022 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1658587120;
        bh=KW0ljYMYbs6iz6UL/iYtfWHK3sAknCCp7euivgB/Prw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G1sAUTzDj1kokQJlrGZyX3CgUPwszoXQMamcid9l84rfdfj/7kG1fCJbICWUCeG5V
         mZBhy1YHgvRN/RaEmviQc/7qoN+4GwkI/5JiiMY9nCx8J7VAOun0PYRRNznBPmHpOt
         W52F/tMIplPEIXG3D/kAB4G86gY2hsqRz04kEbFy83kM8aZw4OMJgFaxWAPFYPFCQ7
         ZgEtxdEFh72oj3Vr/9d+kBADjjCGchZPYm4x4pZ75oZ/5GATb9tyFwBmhOTbqIF/5t
         tiJc4UeYsxCxUnSMnaTjbD3R18ZZic6fD4PZffDqN/H5RkuVuk53jw1zUHlGrbWgi9
         6ycYyQwkAeYtB3+oukoc9/lPg/dDxK1RAMiPkaFsKRU8QXS7jcEnO3ftLsgGUFQ24z
         /x/7V2DBdgj9PSiD5QMXP/uTy6eGfPnI+L068rnHGAlPavsDrdnb2/F/8D5uTNu//D
         439gr5jDBh0EXeWrglU5vMWf4lPJOXNKK4XkI8kwroJbSlZtMN2
Date:   Sat, 23 Jul 2022 14:38:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Dropbox and "Your local changes to the following files would be
 overwritten by merge"
Message-ID: <YtwH7pOnDgv+MYmh@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Yuri Kanivetsky <yuri.kanivetsky@gmail.com>, git@vger.kernel.org
References: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WlPEYAKxbs7RE6+G"
Content-Disposition: inline
In-Reply-To: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WlPEYAKxbs7RE6+G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-23 at 12:40:20, Yuri Kanivetsky wrote:
> Hi,

Hey,

> First I thought it's an issue with vim-fugitive, but I can reproduce
> it with git alone. The other culprits I can think of are magit (I
> believe I used it with this repository), vim, and now that I think
> about it... Dropbox? The repository is in a dropbox directory. I
> understand that this is uncommon, but a couple of my repositories are
> in a dropbox directory and I'd like to put the reasons aside. Can you
> suggest what I can do to find the reason it fails? Do you know what
> exactly triggers this message (the content changed, modification time,
> ctime)?

It's known that Dropbox and other cloud syncing services can corrupt
repositories.  They can cause files to be removed, renamed, or reappear
after being deleted, and I suspect that's what's happening here.

I'd definitely suggest moving your repository out of the Dropbox folder
and seeing if you can reproduce the problem.  That will tell you if
that's the problem you're having.

I'd recommend moving the data out of the Dropbox repository regardless,
since, as I mentioned, it is known to cause corruption, and you won't
know it until it's too late.  You may want to additionally run "git
fsck" to see if that finds any problems other than dangling objects.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--WlPEYAKxbs7RE6+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYtwH7gAKCRB8DEliiIei
gdaGAP9vK6DPYXsm2pa/JviDYsyEffvFmWkezdD99vkM2rMxIgD/YsthA89+5hB5
tVJ9UpDYNh+ivvhtZ+anK5wayDbH3QA=
=CY5d
-----END PGP SIGNATURE-----

--WlPEYAKxbs7RE6+G--
