From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Wed, 12 Dec 2007 13:00:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712121237540.5349@iabervon.org>
References: <20071211195712.GA3865@bitplanet.net>  <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
  <1197416286.7552.4.camel@hinata.boston.redhat.com> 
 <7vejdsbo7d.fsf@gitster.siamese.dyndns.org> <1197473063.9269.20.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-705779769-1197482408=:5349"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Vsq-0007V1-Db
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbXLLSAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXLLSAM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:00:12 -0500
Received: from iabervon.org ([66.92.72.58]:55871 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbXLLSAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:00:10 -0500
Received: (qmail 18328 invoked by uid 1000); 12 Dec 2007 18:00:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Dec 2007 18:00:08 -0000
In-Reply-To: <1197473063.9269.20.camel@hinata.boston.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68076>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-705779769-1197482408=:5349
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Dec 2007, Kristian H=F8gsberg wrote:

> However, let me just say that the patch I sent is almost just that.
> Part of the patch refactors init-db to be useful from clone, part of the
> code is option parsing and figuring out the git dir, work tree.  Also,
> the part of the patch that does 'git checkout' is approximately 20 lines
> that end up calling unpack_tre() and then write_cache().  The bulk of
> the work here is really just builtin boilerplate code, option parsing
> and the builtin-clone tasks you describe below (HEAD discovery, --shared
> and --reference optimizations and the local hardlink optimization - all
> these are in the 500 line builtin-clone.c I sent).
>=20
> And maybe it makes sense to use builtin-remote for the remote add -f
> part, but the fetch part of the patch is 10 lines to set up for
> fetch_pack().  So while I do agree that it makes sense to keep remotes
> handling in one place, doing the fetch_pack() in builtin-clone.c doesn't
> seem like a big duplication of code.  And either way, I agree with
> Dscho, once we have either builtin-clone or builtin-fetch it's easier to
> share code and refactor, and there is not a strong reason to do one or
> the other first.

Er, we have builtin-fetch. We just don't have a way of calling it with all=
=20
of the option parsing done, but that should be easy. I was expecting that=
=20
step to get done when clone got converted, or maybe remote...

I agree that the checkout special case when the code knows in advance that=
=20
you don't have anything checked out beforehand is particularly trivial,=20
and it's probably just as easy to call unpack_trees() and write_cache() as=
=20
to use an actual checkout implementation.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-705779769-1197482408=:5349--
