From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Wed, 16 Nov 2011 14:08:50 +0100
Message-ID: <201111161408.50700.trast@student.ethz.ch>
References: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu> <4EC34FA5.2020809@alum.mit.edu> <4EC3A45F.9080005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 16 14:08:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQfEY-0004uC-VM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 14:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756Ab1KPNIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 08:08:53 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:32001 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525Ab1KPNIx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 08:08:53 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 16 Nov
 2011 14:08:51 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 16 Nov
 2011 14:08:50 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4EC3A45F.9080005@alum.mit.edu>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185542>

Michael Haggerty wrote:
> 36 [2]. How can I escape AsciiDoc markup?
>=20
> Most AsciiDoc inline elements can be suppressed by preceding them wit=
h a
> backslash character.  These elements include: [...] But there are
> exceptions=E2=80=89=E2=80=94=E2=80=89see the next question.
[...]
> Note Escaping is unnecessary inside inline literal passthroughs
> (backtick quoted text).

Beware!  We actively change the inline literal quoting behaviour to
ensure consistent output with different versions of asciidoc.  See
this commit:

commit 71c020c53ec472b04678237d8fe5687f2299db2a
Author: Thomas Rast <trast@student.ethz.ch>
Date:   Sat Jul 25 14:06:50 2009 +0200

    Disable asciidoc 8.4.1+ semantics for `{plus}` and friends
   =20
    asciidoc 8.4.1 changed the semantics of inline backtick quoting so
    that they disable parsing of inline constructs, i.e.,
   =20
      Input:	`{plus}`
      Pre 8.4.1:	+
      Post 8.4.1:	{plus}
   =20
    Fix this by defining the asciidoc attribute 'no-inline-literal'
    (which, per the 8.4.1 changelog, is the toggle to return to the old
    behaviour) when under ASCIIDOC8.
   =20
    Signed-off-by: Thomas Rast <trast@student.ethz.ch>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
