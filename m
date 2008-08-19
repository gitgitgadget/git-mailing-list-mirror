From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Tue, 19 Aug 2008 10:16:25 +0200
Message-ID: <20080819081625.GF11842@schiele.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org> <7vy72tkfu0.fsf@gitster.siamese.dyndns.org> <20080819072650.GE11842@schiele.dyndns.org> <7vpro5fnke.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wo0oCZYLrer5S3Oe"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMPM-00060w-FL
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYHSIQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 04:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbYHSIQa
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:16:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:63555 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbYHSIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 04:16:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1905309fgg.17
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=crRkUDvoL42wPuq4CleWHWmdVGhOXm/SFJpXqzdzqo8=;
        b=viyJpM0kbqdje/07HlJezwPszRyC5iAAdXGTep4T/veCYUvLhl14NfULYoLl+SOnpE
         eBOkxYjWQE6j6VaX8FO5Wjo1pGVUlD4Q+EbakIbblS9Q37aFLhMRZ+Y8AJsIFv/01qyz
         +lmMbqt9QawrpoV6aRlgm3syYFPaP4IapitRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=qK0VHuqqavK9a+Ysa0b3eX2VFkKhDvt6nuzwCK26urOdkS/NBKeQguVRs6zyb+LVey
         6/vQUfEEe/hdJmSOSWLTY9JDn3aGaGA6DHPlkBo1cujNDMkMXXxgWno+zxjd/w/DUvrz
         G0zJNfMs6oeQt3nXEqRUKctT7Ot0478oCfQqM=
Received: by 10.86.4.14 with SMTP id 14mr5394772fgd.20.1219133787784;
        Tue, 19 Aug 2008 01:16:27 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.123.131])
        by mx.google.com with ESMTPS id d4sm1801426fga.8.2008.08.19.01.16.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 01:16:26 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id E68FB1604F; Tue, 19 Aug 2008 10:16:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vpro5fnke.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92830>


--Wo0oCZYLrer5S3Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2008 at 12:53:21AM -0700, Junio C Hamano wrote:
> Even if that is the case, I do not like the prospect of having to maintain
> a set of duplicated variable definitions.  If we really wanted to address
> this issue, maybe we would want a separate source file that is linked to
> both git-shell and to the rest of the system that has nothing but
> definitions of these variables?  I thought environment.c was meant to be

Ok, so how about globals.c and move just global variables that have at least
two references there?

> something like that -- would linking environment.o pull in too many extra
> references these days (again, I didn't try)?

This pulls in almost everything these days.  In our specific case even the
functions that were redefined in shell.c to start the whole mess.  Thus as
soon as we add environment.c we end up with duplicate symbols on linking
git-shell again.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--Wo0oCZYLrer5S3Oe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIqoFZxcDFxyGNGNcRAs8LAJ414qzgBd9V5DPM41q0DDiwjnMmxgCglQNm
KiUCSX/Xg0nUp4/r8xwKu40=
=igTn
-----END PGP SIGNATURE-----

--Wo0oCZYLrer5S3Oe--
