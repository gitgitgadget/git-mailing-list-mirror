From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] Make it possible to update git_wcwidth()
Date: Mon, 12 May 2014 13:38:37 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1405121334480.9884@ds9.cixit.se>
References: <536D4DF0.3060301@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, kevin@bracey.fi
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon May 12 14:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjpXm-00066Y-RT
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 14:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049AbaELMlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 08:41:16 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:44810 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757994AbaELMlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 08:41:13 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s4CCccGU022206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 May 2014 14:38:38 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s4CCcbn8022203;
	Mon, 12 May 2014 14:38:37 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <536D4DF0.3060301@web.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 12 May 2014 14:38:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248704>

Torsten B=C3=B6gershausen:

> The function git_wcwidth() returns for a given unicode code point the
> width on the display:
> -1 for control characters,
> 0 for combining or other non-visible code points
> 1 for e.g. ASCII
> 2 for double-width code points.

This all looks sane, but the problem is that this is also=20
context-dependent since there are a lot of characters with "ambiguous"=20
widths, i.e., characters that are "double" width for CJK locales (and=20
fonts), but "single" width for others. This includes Greek and=20
Cyrillic characters, which are encoded using the double-byte parts of=20
the CJK DBCS encodings.

I'm not quite sure how much impact this would have on day-to-day Git=20
operation in a CJK locale, however, as I guess they would mostly=20
encounter texts in their own language (which would mostly be "double"=20
width) or English (which would be unambiguously "single" width).

Anyone on the list running Git in a CJK locale that would like to=20
weigh in here?

--=20
\\// Peter - http://www.softwolves.pp.se/
