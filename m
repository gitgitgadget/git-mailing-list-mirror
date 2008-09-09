From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Commit templates are not readable after 'make install'
Date: Tue, 9 Sep 2008 12:02:01 -0700
Message-ID: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: johannes.sixt@telecom.at
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 21:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd8Uc-00049z-DE
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYIITCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 15:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYIITCG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 15:02:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:58292 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbYIITCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 15:02:03 -0400
Received: by ey-out-2122.google.com with SMTP id 6so950517eyi.37
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=SVjPSiwKbS1X8HEeghy2JT5mq1tC61TmH8I7dJP4yoI=;
        b=q6cU1gdf+CZcfSqQM+UAFNU6qrNkMZnjfk8BaTYbZhuAg+Sd0K7/M4s+GyaERFHYyH
         B+Ddv2kTUX4GXyE42/WgkRXZR8V/KS4z2rWKksaIZYyglq/I/Q4SR2XkhdobUaN2crjf
         zmvE4jP2JUe6aS/FLn+QxzfFGwrd7oolBWvww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QG3i8eo+yuYG4/tiocrYL7vK7x8wky24fPqr0VsueSBJ+ecMM+OzeH7i52gBoq23ad
         O2a7HCFTroIjjfyUmYqu9camKWYcgNqknRRRkJSgLlaBDOtNKZK+c61LV/n9Gbu99MQ2
         tOSa8THho3pFc+BzzgWIawawKQ3slxTEirnlE=
Received: by 10.210.112.4 with SMTP id k4mr70175ebc.180.1220986921679;
        Tue, 09 Sep 2008 12:02:01 -0700 (PDT)
Received: by 10.210.130.11 with HTTP; Tue, 9 Sep 2008 12:02:01 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95416>

Hi,

I build git from sources and I have one small permissions issue that
(I think) should be fixed.

So I build it as described in INSTALL file
make prefix=/usr all
sudo make prefix=/usr install

Everything goes fine here and we have a new version of git installed
$ git --version
git version 1.6.0.1.285.g1070

But when I want to create a new repo, I have a fatal problem
$ git init
fatal: cannot copy
/usr/share/git-core/templates/hooks/applypatch-msg.sample to
/personal/sources/opensource/1/.git/hooks/applypatch-msg.sample


Because of the template files are readable only for root
$ ls -l /usr/share/git-core/templates/hooks/
total 44
-rwxr-x--- 1 root root  452 2008-08-29 11:04 applypatch-msg.sample
-rwxr-x--- 1 root root  894 2008-08-29 11:04 commit-msg.sample
-rwxr-x--- 1 root root  160 2008-08-29 11:04 post-commit.sample
-rwxr-x--- 1 root root  553 2008-08-29 11:04 post-receive.sample


I could fix the problem by running
$ sudo chmod a+r -R /usr/share/git-core/templates


But I think it should do 'make' when it installs git-core, isnt it?

-- 
anatol
