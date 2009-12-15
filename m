From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Tue, 15 Dec 2009 02:25:14 +0100
Message-ID: <20091215012514.GB1317@atjola.homenet>
References: <20091214183337.GA25462@atjola.homenet>
 <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
 <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
 <7vhbrtdtth.fsf@alter.siamese.dyndns.org>
 <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	jk@silentcow.com, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 02:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKMAI-0007dG-5o
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 02:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758985AbZLOBZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 20:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758957AbZLOBZT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 20:25:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:59763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758981AbZLOBZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 20:25:18 -0500
Received: (qmail invoked by alias); 15 Dec 2009 01:25:17 -0000
Received: from i59F56AFC.versanet.de (EHLO atjola.homenet) [89.245.106.252]
  by mail.gmx.net (mp050) with SMTP; 15 Dec 2009 02:25:17 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18V3J9SQDUV6ML/ID3bpc/+yNJEZjCGm/xsdWvc3X
	4J9/3h12MS2YRX
Content-Disposition: inline
In-Reply-To: <ee63ef30912141650ie05baf4kab8505adf160c62e@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135259>

On 2009.12.14 18:50:44 -0600, Brandon Casey wrote:
> I think it is more correct to say that the line termination in an ema=
il is
> ambiguous.  CRLF does not necessarily mean that the original had CRLF=
 line
> termination if RFC-2822 is followed explicitly.

Right. And checking, after sending a patch containing CRs with mutt, it
lost those CRs. Even the local copy saved directly by mutt, which didn'=
t
leave my box, lacks the CRs. So it seems basically impossible to send
patches to CRLF files inline.

RFC-822 still allowed bare CRs/LFs :-/

So the commit didn't break with anything mails conforming to RFC-2822,
those won't work for files with CR being patch. But it still breaks the
the raw format-patch generated patches, so even attaching them to the
actual email as a workaround won't do.

That makes a "use the first line to decide whether or not to strip CRs"
approach look like a good idea. Real mails are broken anyway, and the
format-patch output has LF on the first line, so mailsplit wouldn't mes=
s
it up... Unless git on windows produces CRLF format-patch output...

Bj=F6rn
