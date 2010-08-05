From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] git gui blame  fails for multi-word textconv filter
Date: Thu, 05 Aug 2010 11:59:50 +0200
Message-ID: <vpqlj8l2xd5.fsf@bauges.imag.fr>
References: <20100804192525.GA13086@landau.phys.spbu.ru>
	<4C59FBD5.5090209@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 05 12:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgxIs-0002DN-D5
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 12:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055Ab0HEKDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 06:03:53 -0400
Received: from imag.imag.fr ([129.88.30.1]:56533 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574Ab0HEKDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 06:03:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o759xpvo014008
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 11:59:51 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgxEs-0007nN-VI; Thu, 05 Aug 2010 11:59:50 +0200
In-Reply-To: <4C59FBD5.5090209@ensimag.imag.fr> (=?iso-8859-1?Q?=22Cl=E9me?=
 =?iso-8859-1?Q?nt?= Poulain"'s message of "Thu\, 05 Aug 2010 01\:46\:29
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 05 Aug 2010 11:59:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152629>

Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> I wonder if spaces can be the reason of this. Looks like Tcl is
> looking for an executable called "run-mailcap --action=3Dcat", and
> doesn't distinguish path from options.

Yes, and it does this because we asked it to do so. Whitespace
interpretation is done by the shell, and there's no shell involved
here.

> I do not have much experience with Tcl, so I can't figure out how to
> solve that. Some help would be appreciate :-)

Patch follows. It just runs the textconv using a shell, which does
whitespace interpretation (and more if needed). Tested with

textconv=3Dodt2txt --width=3D40

and a file containing whitespaces.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
