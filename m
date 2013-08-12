From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 08:51:44 -0400
Message-ID: <rmieh9zdqcf.fsf@fnord.ir.bbn.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
	<20130810102834.GA6237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 14:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8rbD-0004Zp-FP
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 14:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab3HLMvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 08:51:47 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:50358 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756204Ab3HLMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 08:51:47 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 98FCAAFE4; Mon, 12 Aug 2013 08:51:44 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130812:tg@mirbsd.de::8tLpdf59oOjTExPq:000001nhh
X-Hashcash: 1:20:130812:jrnieder@gmail.com::X75OL8/r1CYMNi17:000000000000000000000000000000000000000000035ES
X-Hashcash: 1:20:130812:mhagger@alum.mit.edu::2JIt9IGS0cSSztQb:000000000000000000000000000000000000000005166
X-Hashcash: 1:20:130812:matthieu.moy@imag.fr::4QNHdPQWREShDv/p:000000000000000000000000000000000000000000OVh
X-Hashcash: 1:20:130812:git@vger.kernel.org::pvPo/7B8Q1JTmwef:0000000000000000000000000000000000000000001HYT
X-Hashcash: 1:20:130812:peff@peff.net::695nt08DkTg+G/wP:0000GEke
In-Reply-To: <20130810102834.GA6237@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 10 Aug 2013 06:28:35 -0400")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232188>

--=-=-=
Content-Type: text/plain


Jeff King <peff@peff.net> writes:

> On Sat, Aug 10, 2013 at 11:59:21AM +0200, Michael Haggerty wrote:
>
>> I intentionally don't set user.email in my ~/.gitconfig because I use
>> different identities (on the same machine) depending on what project I
>> am committing to (open-source vs. work).  After I clone a repo, I *rely*
>> on Git reminding me to set user.email on my first commit, because I
>> invariably forget to set it myself.  And for me, *any* universal,
>> heuristically-determined email address would be wrong for me for at
>> least some repos.
>
> So if I understand your use case, then you would be even happier if
> rather than giving a warning, git simply barfed and said "please set
> your identity before committing"?

I also think it's a bug that git will create commits without an
explicitly-set author.  I've seen multiple cases of the author being
something unreasonable in a shared/official repository because of this.
One was a person's personal email address on a work-repo commit,
apparently because on Mac there was some magic extraction of primary
email address from Mail.app (but I'm not 100% clear on what happened).
If name/mail are not explicitly set, failing and making the user set
them seems like the right thing.

I find all the discussion of /etc/mailname to be a bit perplexing.  The
notion that the externally-visible email of a person making a commit
should be the same as if they sent mail from that machine seems to be a
bit of a stretch.  And their username might be different.  I don't think
it's possible to reliably figure out what ought to be in the git author
field.

Another reason to fail rather than use a possibly-wrong default is that
it's very difficult (if not impossible, depending on local CM policy
about forced updates in shared repos) to recover from pushing a commit
with a bad email address.  (And the people that don't set their email
right are the same people that won't run "git log -p @{u}.." before
pushing.)  But failing and having to set it manually is easy (people who
are already competent will be slowed down a minute or two, and the
others need to learn anyway), results in something that should have been
done anyway, and has no long-term negative consequences.


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (NetBSD)

iEYEARECAAYFAlII2mAACgkQ+vesoDJhHiU5awCfSukjbXfW/XagzQIsBz8HupiX
G1QAoIUaGPBrrUSZjOMjyZPXQ/wnL0rO
=ApJR
-----END PGP SIGNATURE-----
--=-=-=--
