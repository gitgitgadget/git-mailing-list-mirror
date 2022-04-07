Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE8C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiDGWMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiDGWME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:12:04 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43C1A5D7E
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 15:10:02 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1B0A05A0EC;
        Thu,  7 Apr 2022 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649369402;
        bh=eHZOwkXDR2mCY9J4EGVb+7b4fv7wdEkS54nM2+fQOig=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uGWwEYqK9XaG4NeaoOU8JWMV5KuxOMkcMul3AceZRe0tKV8TCkdg/I6jwGaGh0oU8
         yGUMDkteXsvRYC+kQV4bDQttfdulh/KDdk3HIjuEKq7xY6pKhysgyM8UGy7sX6R2y7
         o06CsLuujRemlp/0wsjM2SIFHDTkIdFJbKPynaa0AZjzga48h7K2+hhm2PHXa0Zm3v
         6m757HmgmJsuqIuAVmHdFCColqctPVcZUtDIM47d9B5yYIZ0l9la/X7dU7uxmWu79P
         I8sRBYCG8F2NJSc0rJLE/5L3euZqoKuGCm2bCivHwldK/mMI6cMN4vdpWRkJRWwIS3
         PBpPcW7c3dgtyKVfE4wf4TDhB0Wl/kVYRbXShJXAjXj05uJ9GO7mbkwml72qkNWGlW
         MvYmS6pGXlR01Wxs/wn/0WqSHTA/6ktyZu6oN/T1yPW3j2l/5C7IfYGFDqTpR1KgNx
         ugQjZ63tyxnrP08eKXqwnqajhuxSZIqFOr/z16b95H9gNsheTQR
Date:   Thu, 7 Apr 2022 22:10:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Justin Steven <justin@justinsteven.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Bare repositories in the working tree are a security risk
Message-ID: <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Justin Steven <justin@justinsteven.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net>
 <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwfDxA37JOqLuzJM"
Content-Disposition: inline
In-Reply-To: <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wwfDxA37JOqLuzJM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-07 at 21:53:26, Justin Steven wrote:
> Hi all,
>=20
> I'm the author of one of the articles linked in Glen's mail. Thank you
> Glen for summarising the problem beautifully and pushing this forward.
>=20
> Brian said:
> > As mentioned elsewhere, git status doesn't work without a working tree.
>=20
> This is correct. However, it is possible to embed a bare repo that has
> its own core.worktree which points to a directory within the
> containing repo, satisfying the requirement of having a working tree.
> This is covered in the article [1] and looks to be accounted for in
> Taylor's reproducer script which admittedly I haven't run.
>=20
> > Instead, I'd rather see us avoid executing any program from the config
> > or any hooks in a bare repository without a working tree (except for
> > pushes).  I think that would avoid breaking things while still improving
> > security.
>=20
> Due to the fact that the embedded bare repo can be made to have a
> working tree, this won't be an effective fix.

Then we'd probably be better off just walking up the entire hierarchy
and excluding worktrees from embedded bare repositories, or otherwise
restricting the config we read.  That will probably mean we'll need to
walk the entire directory hierarchy to see if it's embedded (or at least
to the root of the device) in such a case, but that should be relatively
uncommon.

I'd definitely like to see us make a security improvement here, but I
also would like to avoid us breaking a lot of repositories, especially
since we lack alternatives.

If git fast-import could 100% correctly round-trip all commits and
repositories, I would be much more open to blocking this in fsck after a
deprecation period, but as it stands that's not possible.  Perhaps
improving that would be a suitable way forward.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wwfDxA37JOqLuzJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYk9hNgAKCRB8DEliiIei
gdmyAQCNBgoEroPIisEI7vv/a2RXQNIcfP20YYrFleVlTw6ZkQD9EXTs6bffXzvC
Y7DY5vPA/G+tCirH/d3rJfZ9H9kdagw=
=kaK1
-----END PGP SIGNATURE-----

--wwfDxA37JOqLuzJM--
