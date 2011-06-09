From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/2] Remove noreturn function pointers in usage.c
Date: Thu, 9 Jun 2011 08:31:45 +0200
Message-ID: <20110609063145.GC15448@one.firstfloor.org>
References: <1307569417-8924-1-git-send-email-andi@firstfloor.org> <7v4o3z264s.fsf@alter.siamese.dyndns.org> <20110609045915.GA15448@one.firstfloor.org> <20110609055224.GA27780@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:31:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUYmX-0001Wd-TZ
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 08:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab1FIGbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 02:31:49 -0400
Received: from one.firstfloor.org ([213.235.205.2]:58127 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1FIGbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 02:31:48 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 76FF51ED80AD; Thu,  9 Jun 2011 08:31:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110609055224.GA27780@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175493>

On Thu, Jun 09, 2011 at 01:52:24AM -0400, Jeff King wrote:
> On Thu, Jun 09, 2011 at 06:59:15AM +0200, Andi Kleen wrote:
>=20
> > >  - Potential impact to people who do not use Gcc 4.6 with profile=
 feedback
> > >    is not explained away well, except for "Doesn't seem to make a=
ny
> > >    difference."
> >=20
> > I merely went by "there are no new warnings" (I assume that's the m=
ain
> > motivation)
>=20
> On your compiler and settings, perhaps. With your patch I get:
>=20
>   usage.c: In function =E2=80=98die=E2=80=99:
>   usage.c:70:1: error: =E2=80=98noreturn=E2=80=99 function does retur=
n [-Werror]

Ok.  Hmm, all I can say it compiled here.

Ok then we have to remove it. I didn't really like Junio's approach
to only do it for a single file because that would break with LTO / lin=
k
time optimization which requires declarations to match between=20
translation units.

Maybe it's better to stick an extra exit() at the end to shut up
the extra warning. I'll do that I guess.

BTW 4.6.2 or so will have the problem fixed.

-Andi
