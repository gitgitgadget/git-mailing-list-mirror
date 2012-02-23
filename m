From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/4] Do attempt pretty print in ASCII-incompatible
 encodings
Date: Thu, 23 Feb 2012 12:25:21 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1202231219050.21935@ds9.cixit.se>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com> <1329834292-2511-2-git-send-email-pclouds@gmail.com> <20120221182118.GA32668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 12:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Wtg-0002A1-Mq
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 12:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab2BWLbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 06:31:36 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:45649 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750843Ab2BWLbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 06:31:35 -0500
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2012 06:31:34 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q1NBPM4W001580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Feb 2012 12:25:22 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q1NBPLpO001576;
	Thu, 23 Feb 2012 12:25:22 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20120221182118.GA32668@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 23 Feb 2012 12:25:22 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191353>

Jeff King:

> I'm not sure why we bother checking this. Using non-ASCII-superset
> encodings is broken, yes, but are people actually doing that?
[...]
> Are there actually encodings that will cause subtle breakage that we =
want=20
> to catch?

Shift-JIS could be a problem; if implemented to the letter it would con=
vert=20
0x5C to a Yen character and 0x7E as an overline. Otherwise I expect it =
only=20
being a problem with ISO 646 encodings, especially the ones that replac=
e "@"=20
with something else [1].

Also any ISO 2022 seven-bit encoding (ISO-2022-{CN,JP,KR}) could cause=20
problems, especially if there is any preprocessing done on the string t=
hat=20
does not respect its state-shifting (most 0x21--0x7E characters can be =
lead=20
and trail bytes in their multi-byte modes).

--=20
\\// Peter - http://www.softwolves.pp.se/

  [1] Trying to send Internet e-mail from a system using the extended
      Swedish seven-bit encoding, where 0x40 mapped to "=C3=89", could
      sometimes be a challenge.
