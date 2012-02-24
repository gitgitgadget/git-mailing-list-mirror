From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Fri, 24 Feb 2012 15:40:52 +0100
Message-ID: <20120224144052.GF9526@pomac.netswarm.net>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 15:41:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0wKR-0001Iu-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 15:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688Ab2BXOky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 09:40:54 -0500
Received: from mail.vapor.com ([83.220.149.2]:37106 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756111Ab2BXOky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 09:40:54 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 9481C40C674;
	Fri, 24 Feb 2012 15:40:52 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 4F8008E06C1; Fri, 24 Feb 2012 15:40:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1330086201-13916-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191438>

On Fri, Feb 24, 2012 at 07:23:21PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This command unpacks every non-delta objects in order to:
>=20
> 1. calculate sha-1
> 2. do byte-to-byte sha-1 collision test if we happen to have objects
>    with the same sha-1
> 3. validate object content in strict mode
>=20
> All this requires the entire object to stay in memory, a bad news for
> giant blobs. This patch lowers memory consumption by not saving the
> object in memory whenever possible, calculating SHA-1 while unpacking
> the object.
>=20
> This patch assumes that the collision test is rarely needed. The
> collision test will be done later in second pass if necessary, which
> puts the entire object back to memory again (We could even do the
> collision test without putting the entire object back in memory, by
> comparing as we unpack it).
>=20
> In strict mode, it always keeps non-blob objects in memory for
> validation (blobs do not need data validation). "--strict --verify"
> also keeps blobs in memory.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Actually, nevermind my last report - i had missed a merge :(

And now that i merged that part it seems like it doesn't do much..
(No real output for 2+ minutes)

I think i should reapply the patches again and verify that everything i=
s
correct before reporting any additional progress.

But, this might not be before monday, unfortunately... But *thanks* for
posting the patches!
