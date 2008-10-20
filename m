From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, RFC] diff: add option to show context between close
 chunks
Date: Mon, 20 Oct 2008 16:43:34 -0700
Message-ID: <7vabcy3k9l.fsf@gitster.siamese.dyndns.org>
References: <48FB757B.9030105@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:58:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks4Qp-0008DK-GF
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYJTXno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2008 19:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbYJTXno
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:43:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYJTXnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 19:43:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 29EA28D5B8;
	Mon, 20 Oct 2008 19:43:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1784A8D5B7; Mon, 20 Oct 2008 19:43:36 -0400 (EDT)
In-Reply-To: <48FB757B.9030105@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sun, 19 Oct 2008 19:59:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED55BBBE-9F00-11DD-9739-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98746>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> I think it makes sense to make 1, or even 3, the default for this
> option for all commands that create patches intended for human
> consumption.  The patch keeps the default at 0, though.

I think defaulting to 1 would make sense, or alternatively, just
hardcoding that behaviour without any new option.  That would give you
more information with the same number of patch lines, iow, upside witho=
ut
any downside.

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d3d9c84..3bf2581 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -60,9 +60,9 @@ static int xdl_emit_record(xdfile_t *xdf,=20
  */
 static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *=
xecfg) {
 	xdchange_t *xch, *xchp;
=20
 	for (xchp =3D xscr, xch =3D xscr->next; xch; xchp =3D xch, xch =3D xc=
h->next)
-		if (xch->i1 - (xchp->i1 + xchp->chg1) > 2 * xecfg->ctxlen)
+		if (xch->i1 - (xchp->i1 + xchp->chg1) > 2 * xecfg->ctxlen + 1)
 			break;
=20
 	return xchp;
