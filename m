From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: git blame swallows up lines in case of mixed line endings
Date: Thu, 19 Feb 2015 13:48:03 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F2D1F46@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 15:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YORgF-0004di-1F
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 15:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbbBSOCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 09:02:10 -0500
Received: from goliath.siemens.de ([192.35.17.28]:34650 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbbBSOCJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 09:02:09 -0500
X-Greylist: delayed 842 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Feb 2015 09:02:08 EST
Received: from mail1.sbs.de (localhost [127.0.0.1])
	by goliath.siemens.de (8.14.3/8.14.3) with ESMTP id t1JDm49G023178
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 14:48:04 +0100
Received: from DEFTHW99ERMMSX.ww902.siemens.net (defthw99ermmsx.ww902.siemens.net [139.22.70.142])
	by mail1.sbs.de (8.14.3/8.14.3) with ESMTP id t1JDm4Ku030064
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 14:48:04 +0100
Received: from DENBGAT9ER5MSX.ww902.siemens.net (139.22.70.80) by
 DEFTHW99ERMMSX.ww902.siemens.net (139.22.70.142) with Microsoft SMTP Server
 (TLS) id 14.3.224.2; Thu, 19 Feb 2015 14:48:04 +0100
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.249]) by
 DENBGAT9ER5MSX.ww902.siemens.net ([139.22.70.80]) with mapi id
 14.03.0224.002; Thu, 19 Feb 2015 14:48:03 +0100
Thread-Topic: git blame swallows up lines in case of mixed line endings
Thread-Index: AdBMSq6uIhmDfLX5RVankGP+MpKSCQ==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.51]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264100>

Hi Folks,

I encounter unexpected behavior in the following case:

file content:

line1<CR><LF>
line2<CR>
line3<CR><LF>
line4

This is what I get as console output (on Windows):

> git blame -s file.txt
7db36436 1) line1
line3436 2) line2
7db36436 3) line4

This is the real content:

> git blame -s file.txt > blame.txt

blame.txt opened in Notepad++:

7db36436 1) line1 <CR><LF>
7db36436 2) line2 <CR>
line3 <CR><LF>
7db36436 3) line4 <LF>

Admittedly, very stupid editors, such as Windows Notepad, cannot handle mixed line endings as well. But is this also the way git blame should behave?

Kind regards
Konstantin
