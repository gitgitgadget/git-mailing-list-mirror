From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push and http-fetch: handle URLs without leading /
Date: Sat, 19 Jan 2008 16:29:48 +0100
Organization: glandium.org
Message-ID: <20080119152947.GA26553@glandium.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org> <1200756171-11696-2-git-send-email-gb@gbarbier.org> <1200756171-11696-3-git-send-email-gb@gbarbier.org> <1200756171-11696-4-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-15?Q?Gr=E9goire?= Barbier <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 16:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFev-0001Rx-7V
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644AbYASPaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 10:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760609AbYASPaI
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:30:08 -0500
Received: from vuizook.err.no ([85.19.215.103]:53418 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761452AbYASPaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:30:06 -0500
Received: from aputeaux-153-1-59-190.w82-124.abo.wanadoo.fr ([82.124.13.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JGFe8-0001Pp-Tk; Sat, 19 Jan 2008 16:30:19 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JGFdk-0006xv-En; Sat, 19 Jan 2008 16:29:48 +0100
Content-Disposition: inline
In-Reply-To: <1200756171-11696-4-git-send-email-gb@gbarbier.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 5.2): Yes, score=5.2 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71119>

On Sat, Jan 19, 2008 at 04:22:50PM +0100, Gr=E9goire Barbier wrote:
> Since HTTP/302 is not handled in the git code calling curl, URLs with=
out
> leading / used to lead to frozen git-fetch or git-push with no error =
message.
>=20
> Furthermore, http-push freeze forces the user to interrupt it (^C) an=
d
> therefore to leave a dandling webdav lock that makes the remote repos=
itory
> un-pushable for 10 minutes.
>=20
> The patch does not make curl calls handle HTTP/302 but instead adds a=
 / at
> the end of URLs that does not have it yet.

Actually, it would be much better to do just that, i.e. handle HTTP 302
return codes. I suspect there may be other cases leading to similar dea=
d
locks with other HTTP codes. But that might just be easier to deal with
once my refactoring will be done ;)

Mike
