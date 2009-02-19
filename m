From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Recovering from missing objects?
Date: Thu, 19 Feb 2009 15:08:23 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 15:11:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9b7-0008IO-9R
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZBSOIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZBSOIZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:08:25 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:44051 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751494AbZBSOIY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 09:08:24 -0500
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 9DBA758ABD
	for <git@vger.kernel.org>; Thu, 19 Feb 2009 15:08:23 +0100 (MET)
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110701>

	Hi all,

I start to see suspicious messages about missing objects in one of my w=
orking
repositories:

| vixen$ git gc
| error: Could not read c406ab0be69c912ea59233595a071478103cdad8
| fatal: bad tree object c406ab0be69c912ea59233595a071478103cdad8
| error: failed to run repack
| vixen$=20

My setup:
  - I have one reference repository (cloned from Linus' linux-2.6.git)
  - I have several working repositories, cloned using --reference to my
    reference repository. A working repository has several remotes (clo=
ned from
    other Linux kernel repositories).

I always do a `git pull' in the reference repository, before doing a `g=
it
remote update' in a working repository. When I do `git gc' in a working
repository, it cleans up all objects that are not in the reference repo=
sitory.
Hence I only need to care about backup of the .git directories in the w=
orking
repositories (the stuff I'm working on), and not about the reference
repository (its objects are publicly available and replicated all over =
the
world).

I identified the missing object listed above to be part of a remote rep=
ository.
Doing a `git remote update' doesn't fetch it again, as git is too smart=
 and
thinks I already have everything.

If I clone the remote repository, I have the object in the new clone.
However, how do I get the missing object back into the .git directory o=
f my
working repository? Is there an easy way to do that, or should I just r=
ecreate
my working repository from scratch, and reimport anything I can recover=
?

As for the cause of the problem: most probably I once added the remote
repository to my reference repository, and removed it later, causing al=
l
objects to be removed during a subsequent gc.

Thanks for your answers!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
