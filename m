From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Makefile: add missing dependency on http.h
Date: Sun, 8 Aug 2010 16:48:59 -0500
Message-ID: <20100808214859.GC6962@burratino>
References: <20100808211910.GA7210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 23:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiDlR-0001Dz-2a
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 23:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab0HHVu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 17:50:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41219 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab0HHVuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 17:50:24 -0400
Received: by gxk23 with SMTP id 23so3250594gxk.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XcYixKRJBV6p1XiODT0ZJokc9zI6OCB+ziNKtLxmfbY=;
        b=ZuM+aVjMQChUBc5vpr2U0GwGpfFpsNPEbnC34kfgfhBs7IE5gLmzB5SjN/nxqLw+dd
         qyp1d0DMGwqLHlODJmATK+HSCSS5UK3aKm7Yeh1aKHz0OoRDB3GmFW6LuJ0Ya86mn+tT
         1pkA8efKjTGhjbGGXLCxRvaB2Fe/IJw/5V0dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nCa1OP0uNJbOkN296eTYVItLQv2WEnwVPqcANito8g8Gv3WXOVIZFLfXSuYynJlSqG
         V0x4WLLBZoFEzLVKRkvihlf10kAvsJoTadPUkTF+i+ldDWVZCtYFO8ZCBW9rSAm2GIt0
         yhTVbgwq2UuzDuX1mFV3fVndgFsHjcNmie2YA=
Received: by 10.101.69.16 with SMTP id w16mr16819196ank.141.1281304223739;
        Sun, 08 Aug 2010 14:50:23 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id f22sm7092869anh.24.2010.08.08.14.50.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 14:50:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100808211910.GA7210@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152935>

v1.7.1-rc0~65^2~2 (http: init and cleanup separately from
http-walker, 2010-03-02) introduced a direct dependency from
http-fetch on the HTTP request library.  Declare it.

Detected with "make CHECK_HEADER_DEPENDENCIES=3D1".

Cc: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
After this series, =E2=80=9Cmake COMPUTE_HEADER_DEPENDENCIES=3DYesPleas=
e=E2=80=9D
succeeds again.

Ideas for future work:

 - speed up the dependency checker, run it regularly;
 - port COMPUTE_HEADER_DEPENDENCIES to non-gcc compilers so it can
   be used by default;
 - speed up the redundant-dependency detector[1] enough to make it
   usable;
 - autoconf test;
 - =E2=80=9Cmake test-makefile=E2=80=9D for cron jobs.

Alas, this series did none of those things.

[1] <20100131231103.GA5287@progeny.tock> which doesn=E2=80=99t seem to
have made it out into the world.  Will resend as reply.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9a233b0..e151516 100644
--- a/Makefile
+++ b/Makefile
@@ -1856,7 +1856,7 @@ builtin/tar-tree.o archive-tar.o: tar.h
 builtin/pack-objects.o: thread-utils.h
 connect.o transport.o http-backend.o: url.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
-http.o http-walker.o http-push.o remote-curl.o: http.h
+http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h
=20
 xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
--=20
1.7.2.1.544.ga752d.dirty
