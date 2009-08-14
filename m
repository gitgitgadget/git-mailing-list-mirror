From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH] Fix "unpack-objects --strict"
Date: Fri, 14 Aug 2009 09:19:49 +0200
Message-ID: <20090814071949.GA2342@auto.tuwien.ac.at>
References: <20090813103231.GY14475@mail-vs.djpig.de> <20090813111933.GZ14475@mail-vs.djpig.de> <7vd46zbjae.fsf@alter.siamese.dyndns.org> <20090814060307.GA31721@auto.tuwien.ac.at> <7vocqiucpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbr4v-0008Rz-TN
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbZHNHTt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 03:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755583AbZHNHTt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:19:49 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:51134 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbZHNHTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:19:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 701F410C1C3F;
	Fri, 14 Aug 2009 09:19:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFTMPGIudpaW; Fri, 14 Aug 2009 09:19:49 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id 5CF481000DC5;
	Fri, 14 Aug 2009 09:19:49 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id 58A696800645; Fri, 14 Aug 2009 09:19:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vocqiucpw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125911>

On Thu, Aug 13, 2009 at 11:32:59PM -0700, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> > To introduce a object with one of its linked objects missing, left =
it
> > out of the pack and push it into the repository. unpack-objects wil=
l
> > unpack all objects and fail updating the ref (but leave all objects=
 in
> > the repository). As second step, simply send a ref update request,
> > which should succed, as the object is present in the repository.
>=20
> Your "ref update request" exploit does not work because your understa=
nding
> of how we decide to allow updating a ref is flawed.
>=20
> We do not blindly update a ref to a commit only because we happen to =
have
> that commit.  We require that commit to reach existing tips of refs
> without break.  The logic is in quickfetch() in builtin-fetch.c.

I'm talking on the server side of a push operation (receive-pack), not
the client side. The patchset should prevent invalid data from
entering the repository, thereby preventing upload-pack (during further
fetch operation) and other git programs (eg. called from gitweb) from
failing/segfaulting.

mfg Martin K=F6gler
