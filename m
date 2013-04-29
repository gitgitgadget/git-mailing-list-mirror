From: Treeve Jelbert <treeve@scarlet.be>
Subject: git  -build failure with gettext-0.18.2.1
Date: Mon, 29 Apr 2013 21:25:19 +0200
Message-ID: <4428316.71zalWqGCo@horos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 21:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtyE-0008J6-32
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396Ab3D2Tm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:42:28 -0400
Received: from eir.is.scarlet.be ([193.74.71.27]:52221 "EHLO eir.is.scarlet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758137Ab3D2TmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:42:23 -0400
X-Greylist: delayed 1020 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Apr 2013 15:42:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
	s=scarlet; t=1367263520;
	bh=9Pj3PTRSqMVl1AMV6+BZHea4XicvgFIZNjxxy4HwnZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Zfkxo2nNcUUh95IofMffAXt7o6LlN/8TID+mBv6GaqXaDYwgmlh7jlsMpws7Ugjqt
	 xqmsSjYVyITbmBwnFojakyG/eDo4WYXw0jWcXHA/TVQhCGNopRyIsv50tHXuzGKBK/
	 p64hasuejqL7aziZqB49kjtGi9k9vRdVOikHAVCw=
Received: from horos.localnet (ip-83-134-134-228.dsl.scarlet.be [83.134.134.228])
	by eir.is.scarlet.be (8.14.5/8.14.5) with ESMTP id r3TJPJNv026400
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 21:25:20 +0200
X-Scarlet: d=1367263520 c=83.134.134.228
User-Agent: KMail/4.10.2 (Linux/3.9.0; KDE/4.10.2; x86_64; git-8e13207; 2013-04-25)
X-DCC-scarlet.be-Metrics: eir 20002; Body=1 Fuz1=1 Fuz2=1
X-Virus-Scanned: clamav-milter 0.97.1-exp at eir
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222853>

git-1.8.2.2
glibc-2.17
gettext-0.18.2.1

Recent gettext versions install several libraries:
/usr/lib/libgettextlib-0.18.2.so
/usr/lib/libgettextsrc-0.18.2.so
/usr/lib/libintl.so.8.1.2

/usr/include/autosprintf.h
/usr/include/gettext-po.h

while glibc installs

/usr/include/libintl.h

git reports:

checking for gettext in -lc... yes


checking libintl.h usability... yes
checking libintl.h presence... yes
checking for libintl.h... yes





git build fails while trying to link

    LINK git-imap-send
libgit.a(diff.o): In function `parse_dirstat_params.isra.19':
diff.c:(.text+0x1f0f): undefined reference to `libintl_gettext'


I tried adding 

export LIBS="-lintl"


I also tried 

export NO_GETTEXT=1

before the build but to no avail
