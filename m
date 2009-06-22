From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: git diff --chunk-pickaxe?
Date: Mon, 22 Jun 2009 22:07:22 +1000
Message-ID: <fcaeb9bf0906220507q45a61dc3w25ad41a4a65a2d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 14:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIiJT-0003H3-Si
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 14:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbZFVMHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 08:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbZFVMHl
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 08:07:41 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:10821 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZFVMHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2009 08:07:40 -0400
Received: by an-out-0708.google.com with SMTP id d40so6465964and.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=YvRYPSWpEvF3iJ57PWEzBDYIP88Tz7gAm8Zubx19+s8=;
        b=MGXQN/mPaA7Xi0qo9AAwR7OYMTRhMixaIQSOzPGA7v5xBFX+9EF3DoKPWIAHWTCTn3
         ABzddcxpXRKxlZp7cCXrVIom5ccBeREueq50CmsTvu/fnCeXwlkFOp8vcwmH65Nc7I19
         evZU8FUX5Nf6fPsbrB93aX9NM8/3KX7F2GSeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=ErxnBE8MYCVdu/eBAj1NUAcRBEYTwZhaRo50Md5VNxbaZyXYtDmI/sPtdZtU8lnRB1
         Nb286+DMY186A81d7Xr41LCCBM1PfOS7TUikW1hjy2LjqPJe4KbvpnTqXNY0yVweCY06
         D4XaE0myySAhH6vvPjSXhdKT+6TU8cBmkLTZc=
Received: by 10.100.164.12 with SMTP id m12mr7943622ane.131.1245672462145; 
	Mon, 22 Jun 2009 05:07:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122029>

Hi,

Another use case for Git. This time for .po translations. In GNOME,
=2Epo files are usually updated with intltool, then translations are
updated manually by translators. Intltool updates comments too and
makes it extremely hard to review translations, something like this:

-#. http://en.wikipedia.org/wiki/HD_DVD
 #: ../data/nautilus.xml.in.h:8
+#. http://en.wikipedia.org/wiki/HD_DVD
 msgid "Blank HD DVD Disc"
 msgstr "=C4=90=C4=A9a HD DVD tr=E1=BA=AFng"

-#. http://en.wikipedia.org/wiki/Blu-ray_Disc
 #: ../data/nautilus.xml.in.h:10
+#. http://en.wikipedia.org/wiki/Blu-ray_Disc
 msgid "Blu-Ray Video"
 msgstr "Phim Blu-Ray"

-#. http://en.wikipedia.org/wiki/Red_Book_(audio_CD_standard)
 #: ../data/nautilus.xml.in.h:12
+#. http://en.wikipedia.org/wiki/Red_Book_(audio_CD_standard)
 msgid "Compact Disc Audio"
 msgstr "=C4=90=C4=A9a nh=E1=BA=A1c Compact Disc"

What I want is only show diff chunks that add or remove a line that
does not start with '#', something like a chunk-level pickaxe. Any
pointer where to start? It looks like I can start from
xdi_diff_outf(). Just wanted to make sure I won't follow a wrong way
from the beginning.
--=20
Duy
