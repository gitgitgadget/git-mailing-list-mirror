From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: Possible bug: --ext-diff ignored with --cc in git log
Date: Fri, 11 Mar 2016 03:04:46 +0100
Message-ID: <E1aeCRp-0005Jn-C1@smtp.tt-solutions.com>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com> <xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="1041389241-41-1457661886=:12660"
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 03:05:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeCS1-0000HG-6t
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 03:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933381AbcCKCFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 21:05:09 -0500
Received: from sunset.tt-solutions.com ([82.240.17.225]:39482 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933259AbcCKCFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 21:05:07 -0500
Received: from [192.168.17.86] (helo=Twilight)
	by smtp.tt-solutions.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <vz-git@zeitlins.org>)
	id 1aeCRp-0005Jn-C1; Fri, 11 Mar 2016 03:05:01 +0100
In-Reply-To: <xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
X-VZ-SMTP-Helo: Twilight
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288670>

--1041389241-41-1457661886=:12660
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Thu, 10 Mar 2016 14:33:55 -0800 Junio C Hamano <gitster@pobox.com> wrote:

JCH> Vadim Zeitlin <vz-git@zeitlins.org> writes:
JCH> 
JCH> > I.e. the
JCH> > command "git log --ext-diff -p --cc" still outputs the real diff even for
JCH> > the generated files, as if "--ext-diff" were not given. ...
JCH> > Is the current behaviour intentional? I see it with all the git versions I
JCH> > tried (1.7.10, 2.1.0, 2.7.0 and v2.8.0-rc1), but I don't really see why
JCH> > would it need to work like this, so I hope it's an oversight and could be
JCH> > corrected.
JCH> 
JCH> I think this is "intentional" in the sense that "--cc" feature is
JCH> fundamentally and conceptually incompatible with "--ext-diff".

 Thank you for your reply, Junio, I hadn't realized that --cc was dependent
on textual diff output format before, but now I understand why it can't
respect --ext-diff.

JCH> I haven't tried it myself, but if the contents you are using
JCH> ext-diff on can be compared in a format that is easy-to-read for
JCH> humans by passing them first to "textconv" filter and then running
JCH> the normal "diff" on, that may be a viable approach to do what you
JCH> are trying to do, as "textconv" feature is meant to still produce
JCH> the output that still follows the usual "diff" convention.  Its
JCH> output should be usable by any tool (e.g. diffstat) meant to
JCH> post-process patch output, and would be a better match for the
JCH> "--cc" mechanism.

 I can't think of a way to make the output as concise as it is now (i.e.
just a single line saying that a generated file has been modified but the
changes to it are not being shown) with this approach.

 Maybe I'm clutching at straws here, but I wonder if it could be possible
to have a file attribute specifying whether --cc or -m should be used for
it when showing merges? Because this is, basically, what I want here: --cc
for normal files for readability but -m for the files I'm not interested
in. It's probably too specific to my particular hack^H^H^H^H use case to
add support for it to Git itself, but I wanted to mention it on a chance
that somebody else might think it's a good idea.

 Anyhow, thanks again for your explanation,
VZ

--1041389241-41-1457661886=:12660
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAlbiJ74ACgkQBupB3k9sHobk/wCeNW3BeaZbrHAZJUB+e8xGIZSm
pdoAoJuOI4BYlfSY+Azo227Fsntu7aMH
=qsjH
-----END PGP SIGNATURE-----

--1041389241-41-1457661886=:12660--
