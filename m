From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] tree-walk: don't parse incorrect entries
Date: Sun, 6 Jan 2008 18:23:22 +0100
Message-ID: <20080106172322.GA27967@auto.tuwien.ac.at>
References: <1199555243534-git-send-email-mkoegler@auto.tuwien.ac.at> <7v1w8w80a3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 18:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBZDy-0002tT-Al
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 18:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbYAFRXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2008 12:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbYAFRXX
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 12:23:23 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60205 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbYAFRXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 12:23:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 42CAF680BEA2;
	Sun,  6 Jan 2008 18:23:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ElaGOQZJMPs; Sun,  6 Jan 2008 18:23:22 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 1FE26680BEA0; Sun,  6 Jan 2008 18:23:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1w8w80a3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69735>

On Sat, Jan 05, 2008 at 12:50:28PM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> > * The start of the path may not be after the last zero (21 bytes be=
fore the end).
>=20
> How can that be possible?
>=20
>  - you know end points at NUL and buf < end;
>=20
>  - get_mode() starts scanning from buf, stops at the first SP if
>    returns a non NULL pointer; anything non octal digit before
>    it sees that SP results in a NULL return;
>=20
>  - the return value of get_mode() is the beginning of the path.
>=20
> The second point above means when get_mode() scans buf, it would
> never go beyond end which you already made sure is NUL (which is
> not SP and not an octal digit).  If it hits end, you would get NULL
> pointer back, wouldn't you?

Yes, I agree with you.

> Rejecting an empty path may be sensible (i.e. checking "!*path"
> instead), though.

I sent a new patch with both changes.

mfg Martin K=F6gler
