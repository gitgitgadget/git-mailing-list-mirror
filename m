From: Ailin Nemui <ailin.nemui@gmail.com>
Subject: Feature request: Add word wrapping to gitk display
Date: Sun, 01 May 2016 11:37:52 +0200
Message-ID: <1462095472.542.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 11:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awnpA-0003F1-BB
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 11:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbcEAJh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 05:37:56 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36367 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbcEAJhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 05:37:55 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so75109259wmn.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=olS4COgbgDusmYTwXQXKBT2SKlRVbrXRgT4qpGFI+Hk=;
        b=0VRbICEDJsvcKOPbrnd80kOSa/Xht1sZh51f5ICynUEKcoMaTjWC0GywnP10VxLK5h
         B/zRShA8xsHHhgiqYw9SsXRQVOBrOsT7VdzjkNWIom7TqvYEdH0uyeXXz9zLs8PSH3/Z
         eybKeR/+9xEloAtoO3eVCd3zTtUG77VF+zXpUBER7czXkTyzu/t3F8Gj48cjz2cs0JnF
         MsN6EaKTmstUelB+Vtl/sCZNDUzJ7XLpKh+wbKxm+CCrzlSwfNGixJAF+MAKpyS6npvI
         PPyIG7Cm3wgIGBLiJcnqq4hBkW1h9YqhK57GuYfHY5tNnhdZ1U8ZlgN27/usw3dac6x7
         RSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=olS4COgbgDusmYTwXQXKBT2SKlRVbrXRgT4qpGFI+Hk=;
        b=GuB17bU1Qdfse8RuX9uJI79wFmcPY3xkU5CMuRVwaNdd9Mem7AtGh0o3LJN0vhU4Gp
         xurvuWqnb12Xj78VfQqhXYQXCnpGFMwBOqvcHPKkvtpGbOgYlGpHkwYT2pJ7Bx2DbULs
         wOQ4Qdz3zwf+X4e6+unzzl8Sq/1YsWNfx/y0DVevn8qilUXNVD0e05WHHlhKqphO312K
         yfUjCS1ftGqTLoUWvlXT843eY51NXdG97cT9SaegvC8ODQ1B5dis7n29NH1PKBzNwFmO
         GpVhL7H6nKsa5obaH536FEHAOjj8iEIxt+VPj5tj32A5w6gJc+1f8kq2EK5FGdfPfus9
         srHg==
X-Gm-Message-State: AOPr4FU/YuGaVcUFaAyc9OH3GaW/gxNphIti1j1wlYk7w5VE4zKkxOvwFXMhh1X1PYVlPw==
X-Received: by 10.194.61.40 with SMTP id m8mr30714331wjr.106.1462095473686;
        Sun, 01 May 2016 02:37:53 -0700 (PDT)
Received: from ?IPv6:2001:638:902:200b:50e4:c794:21cc:e2ff? ([2001:638:902:200b:50e4:c794:21cc:e2ff])
        by smtp.gmail.com with ESMTPSA id i11sm24012018wjn.36.2016.05.01.02.37.52
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 May 2016 02:37:53 -0700 (PDT)
X-Mailer: Evolution 3.20.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293145>

Hi,

when working on text files with long lines, "word diff" can produce
appropriate diff display. However, the long lines cannot be viewed very
well in gitk (requires excessive scrolling).

I found out that it is quite easy to achieve this


index 805a1c7..5ba7472 100755
--- a/gitk
+++ b/gitk
@@ -2404,7 +2404,7 @@ proc makewindow {} {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0set ctext .bleft.bottom.ctext
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0text $ctext -background $bgcolor -foregro=
und $fgcolor \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-state disabled -font t=
extfont \
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-yscrollcommand scrolltext -=
wrap none \
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-yscrollcommand scrolltext -=
wrap word \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-xscrollcommand ".bleft=
=2Ebottom.sbhorizontal set"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if {$have_tk85} {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ctext conf -tabstyle w=
ordprocessor


however I'm not otherwise knowledgeable about Tk to make this a
properly configurable switch. I think it would be a very nice addition
to have, a check box next to "Line diff/ color words" that says "Wrap
words in display".


Thanks,
Nei
