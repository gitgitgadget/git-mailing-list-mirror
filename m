From: Joey Hess <id@joeyh.name>
Subject: Re: GIT_INDEX_FILE relative path breaks in subdir
Date: Mon, 23 May 2016 14:52:58 -0400
Message-ID: <20160523185258.GA10389@kitenet.net>
References: <20160517171836.GA12183@kitenet.net>
 <xmqqy478wptr.fsf@gitster.mtv.corp.google.com>
 <20160517182645.GA27396@kitenet.net>
 <20160522190404.GA20998@kitenet.net>
 <xmqqwpmkafmb.fsf@gitster.mtv.corp.google.com>
 <20160523172951.GA1184@kitenet.net>
 <xmqqiny4aaq9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 20:53:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4uyY-00041L-U4
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbcEWSxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:53:10 -0400
Received: from kitenet.net ([66.228.36.95]:56882 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbcEWSxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:53:09 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=ilgT2Mgo;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1464029579; bh=8MDfntb6PlsCvWGAstz3m0BMUN5+mNiMafT2RPr0kEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilgT2Mgow62IE1FYPi4MkUiJUKQ3BUZTtcO5Yvsde5lfVWv+t5k0/TPgsM9NShUcV
	 0wuBI/CtZhzfQ2BJ9B4mtxyiR5kZ/2qk7nnk6pbZj83w78GFDP0GlafMjJ92DjarPi
	 22aePH2WkR+6A44fpKxyiaRK+BFLdYVQlTddbCBw=
Content-Disposition: inline
In-Reply-To: <xmqqiny4aaq9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-98.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RDNS_DYNAMIC,SPF_SOFTFAIL,
	USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295350>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I personally think that it would be OK as long as we do not change
> behaviours for those who do not use core.worktree, $GIT_DIR and/or
> $GIT_WORK_TREE and change behaviour for others to match that
> behaviour, simply because the plain vanilla no-configuration would
> be used by the largest number of people.  But depending on the size
> of the "minority", you may get pushback from them.

The minority affected would I think be limited to:

1. People who have a configuration that *always* sets core.worktree etc,
   and used GIT_INDEX_FILE with a cwd-relative path and it just happened
   to work for them.

2. People who have gone through the learning curve I've suffered about
   how relative GIT_INDEX_FILE works, and put in a workaround that's
   not the obvious "use an absolute path" workaround, but is more
   complex. Like, checking the git configs and adjusting what the
   variable is set relative to. And apparently nobody in this set felt
   worth mentioning this to the list..

I am unsure about the size of 1, and am sure 2 is small to nonexistant.

> I am not sure if relative to PWD is useful.  If it were relative to
> either the GIT_DIR or the GIT_WORK_TREE, i.e. a fixed point, then
> you can set and export GIT_INDEX_FILE and chdir around without
> having to adjust it.  If it were relative to PWD, you would need to
> adjust it every time you chdir, no?

Good point, I had not considered this use case. Although if I set a
long-term environment variable and expect to chdir around, well, that's
what absolute paths are for. All my uses of GIT_INDEX_FILE
are in short-term contexts where the program does not chdir.

--=20
see shy jo

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV0NRiskQ2SIlEuPHAQJ2hQ//exfnrlqrp5qJorkZKsO9FF+ai1PwUbwJ
paFxe/Xo3HnH5D20SaZQwag1zr4RSmlI1/QBgb8qCOMAGEVvB6X3vpkEefeU0kLB
DCz2IgYcU4qqfZNR+HRhHHF1669jWEfwcx8pS2yCl0QY4rVoVn1WsRIbPo1cYLnf
YNlFUE8dKWl8DHUzz1xhvf9VGx0RcVr0oafvVgLh12nJZq9Le/y1aINHvmbRlNaS
rfC5D10ixu4jR25iC9GgfdtU7PNvMSGad13RPiJjzt99EbZYBYV0IPGIF1sxq3bq
wfqJaGxjvacx8tr/llFnldK+4tJDHi/N6H5qqx9a3/Wj4joaPpbAMYNQgQBWsBHp
y27YXHH5kZAkkNxdi4n3avT27E1VMj8sBxS3is9qOzsv4uJcqafCaaPe3bvjYAj+
70IhytpyLGGKe0EhiWKI0r6uNYoZrJA7YC6AJtf8q05L7iMAcWJ1r3aR/ybuocz7
VicW7t3WOeNsMXXOOjrPowbunMOJiUUa9QotHSOYOFYMG1wPH4MLgzsAuf0DxEv4
qtW4xvoM9n1yjAw9Dx65TQ5KGZCL9jCiCdAMmg/cPumoRFDvmkYHuM+gD6KzqXSs
yrYvo5ZsXsHKEOIKBvNsyrbcLc/puz21Ccz59xcRBrrESW+wfsVTdfGLcD7H4rx+
ZvTzb/f4VQs=
=bliQ
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
