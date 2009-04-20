From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [EGIT PATCH] Add support for writing/appending .gitignore file
Date: Mon, 20 Apr 2009 03:40:42 +0100
Message-ID: <636fd28e0904191940t3476b016qc76c0e1e624f7b37@mail.gmail.com>
References: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com>
	 <200904192350.56348.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 04:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvjSa-00039d-Tr
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 04:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbZDTCkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 22:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbZDTCko
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 22:40:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:10341 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZDTCkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 22:40:43 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1192204ywb.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S9tuaJ4eaXqBf3RYhHGmEb2XheOulVjGFQX5aVQTiEU=;
        b=eRNlpoMXEaxcYoWRza04kogPVC1gSMZf8g7gylRwed3KmLSas/yrzXmoMzwTsUG+U5
         eQKTL/lwyDDLGjfmbV0SRfJuIZy781PypBE0u42fQyN44sCDGSNmJtpfrnqSH/iivCmQ
         QQveR4X5OKg84mgIVEuXR9EWF8/TaEiCH6CFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FTJvfuVnXzOLHSFFMomz1UG8XUNR8StKelFyesEuWjGkkDmaYbVFmX1aTRFYLYhXRT
         Uq+AVR0u0IgDR3+8F5aIrPkCox3bkK+yY2LYG6blRDFY7Fusno/GhSoa7qU4eL0MqkBo
         9uOw6P5fpWRDdN090Tny+vqEz2u3fbLzAyB4Y=
Received: by 10.100.11.14 with SMTP id 14mr1228115ank.84.1240195242220; Sun, 
	19 Apr 2009 19:40:42 -0700 (PDT)
In-Reply-To: <200904192350.56348.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116928>

On Sun, Apr 19, 2009 at 10:50 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
>
> First, Ferry Huberts is also working on a solution for ignore See
> http://thread.gmane.org/gmane.comp.version-control.git/114825 though =
you
> focus on different aspects.

Yup, saw the issue 32. I'll keep an eye on that and hopefully I can
leverage what that does when it's ready.

> This patch is whitespace damaged. =C2=A0Pasting into gmail won't work=
=2E Gmail
> has authenticated SMTP on port 25 and 465 (SSL) so git-send-email sho=
uld work that way.

One advantage of attaching issues is you don't have MUA problems :-)
I'll try and get a patch to work via git-send-email later.

>> + =C2=A0 =C2=A0 private static final String GITIGNORE_ENCODING =3D "=
UTF-8";
>
> For the time being we use Constants.CHARACTER_ENCODING

Great, thought there'd be something already. Will use that.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NullProgressMonitor m =3D=
 new NullProgressMonitor();
> I guess this method should execute fairly fast, but in general we sho=
uld run
> with a real progress monitor. See an action, like Track (maybe we sho=
uld
> rename to TrackAction...).

OK, will put in a real one.

> I think this series should be one patch only.

I've been incrementally committing to my local git copy. Whenever I do
git format-patch <since> it spews out individual patchettes. How can I
use git to generate one patch? I could git diff <since>, but that's
not following the SUBMITTING_PATCHES, is it?

> Some actual error logging would be nice. Activator.logError for just =
logging and MessageDialog.openError
> for posting an error message to the user.

Righto, next on the list.

Alex
