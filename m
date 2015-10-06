From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [BUG?] parallel make interdepencies
Date: Tue, 6 Oct 2015 10:12:35 +0200
Message-ID: <56138273.6010204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 06 10:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjNMb-0002N7-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 10:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbbJFIMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 04:12:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47828 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803AbbJFIMh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 04:12:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A724720305
	for <git@vger.kernel.org>; Tue,  6 Oct 2015 04:12:36 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 06 Oct 2015 04:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=nS0
	7j7p/LrbOPe2fP7U1Dpd71YU=; b=ZSDORaX9wvndYQkjp4ceubRtupI9q1mLsWU
	jb7GbitM3xTwQbnS5KTsPI5yK8Y+uKr3aHcgMz0n5PC+60/BbtYGoGHuxccz2I/v
	3WyRyWylL49ITQ+oy2fBoEzb5KtiKL5piXGXOZbLLAB0C9WxhzKfyR+NXw4H51Q/
	JccR7eIM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=nS07j7p/LrbOPe2fP7U1Dpd71YU=; b=R3+K7
	LkhwT1fWS5B89GhPEDcRe0Bv49aSP3+WIvtb3tLJZZmxSDPlKsbleLUAVeSCzm01
	0pF4IjXHs3z3tEEL/QyXF0i4DySIO0hW02YT/SBdfEcraU8C07Un8Y+1lzi5lz7L
	FtkQOTrfBBOW+pae5QZmsihkWKxeiLRQ2xG76o=
X-Sasl-enc: TtDzcXYFKD3wyVLFCVnrhmsaM6Tr5NJVtSPLu5H0BOCt 1444119156
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 453236800D1
	for <git@vger.kernel.org>; Tue,  6 Oct 2015 04:12:36 -0400 (EDT)
X-Mozilla-News-Host: news://news.gmane.org:119
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279124>

"make -j3" just errored out on me, a follow-up "make" succeeded". This
looks like an interdependency issue, but I don't know how to track it:

    GEN git-web--browse
    GEN git-add--interactive
    GEN git-difftool
mv: der Aufruf von stat f=C3=BCr =E2=80=9Eperl.mak=E2=80=9C ist nicht m=
=C3=B6glich: Datei oder
Verzeichnis nicht gefunden

(cannot stat "perl.mak")

Generating a Unix-style perl.mak
Writing perl.mak for Git
    GEN git-archimport
Writing MYMETA.yml and MYMETA.json
Generating a Unix-style perl.mak
Writing perl.mak for Git
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
Makefile:1769: recipe for target 'git-difftool' failed
make: *** [git-difftool] Error 2
make: *** Warte auf noch nicht beendete Prozesse...
Writing MYMETA.yml and MYMETA.json
make[2]: *** [perl.mak] Error 1
make[1]: *** [instlibdir] Error 2
Makefile:1769: recipe for target 'git-add--interactive' failed
make: *** [git-add--interactive] Error 2
Generating a Unix-style perl.mak
Writing perl.mak for Git
Writing MYMETA.yml and MYMETA.json

(This is on next)
