From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: update-index --index-info producing spurious submodule commits
Date: Thu, 18 Aug 2011 20:27:07 -0400
Message-ID: <rmiliuq2qlg.fsf@fnord.ir.bbn.com>
References: <rmivctuv12s.fsf@fnord.ir.bbn.com>
	<7vd3g272tk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 02:31:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuD05-00051g-OU
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 02:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab1HSA1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 20:27:11 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:51943 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab1HSA1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 20:27:09 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 8A25F53AA; Thu, 18 Aug 2011 20:27:07 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:110819:gitster@pobox.com::lOHZPVyV2U1wG99d:000000000000000000000000000000000000000000001yIg
X-Hashcash: 1:20:110819:rhansen@bbn.com::o0AltrtzKhrOooqf:0038AA
X-Hashcash: 1:20:110819:git@vger.kernel.org::o0AltrtzKhrOooqf:0000000000000000000000000000000000000000004x9i
In-Reply-To: <7vd3g272tk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 18 Aug 2011 15:49:27 -0700")
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179667>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> Greg Troxel <gdt@ir.bbn.com> writes:
>
>> git ls-tree HEAD foo
>> git ls-tree HEAD foo | git update-index --index-info
>
> This --index-info definitely looks wrong, if "foo" is a directory, as the
> entries in the index are supposed to be either blobs or commits.

In the man page for update-index in the --index-info section, what I'm
doing seems to be covered by point 2, which specifically talks about
output of ls-tree.

I realize the index is a data structure that has pairs of paths to
blobs.  But I also think of it as a representation of a tree object that
would be referenced were one to commit (even if it isn't in that form
yet).  So I would argue that update-index with a tree should walk that
tree and insert all the paths resulting from expansion into the index?

> The command could just instead barf, saying the input is wrong, but the
> option was so low-level that it was deliberately written to accept and
> store anything you throw at it --- even when it is nonsensical for the
> version of plumbing, later updates to the data structure might have made
> it making sense, which was the way to ease development of the system.

If what I'm doing is an abuse of update-index, do you or anyone else
have a suggestion to make a directory in the index match a tree object?
(I'm trying to use an index filter; it takes 11 hours to run
filter-branch (5500 commits, 400K files in index, 800MB .git, ~2+GB
working directory, tmpdir on NetBSD tmpfs (all in ram)).)

Thanks,
Greg

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk5NrdsACgkQ+vesoDJhHiUmzgCfWnw/q+S8T+dk48OyWyJJ8knD
slYAmwVHC2A4/SwPkYS28Xu9CbGQQ51j
=0Qcb
-----END PGP SIGNATURE-----
--=-=-=--
