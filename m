From: Osamu OKANO <okano.osamu@gmail.com>
Subject: [PATCH 0/7] Document translation with po4a.
Date: Fri, 13 May 2011 22:14:11 +0900
Message-ID: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Cc: Osamu OKANO <okano.osamu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:14:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsCb-0006cz-MO
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab1EMNOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 09:14:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59800 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab1EMNOg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:36 -0400
Received: by pvg12 with SMTP id 12so1148277pvg.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=XzJfuPt4zow5ilvl9WlYIj+abWjfjPOxK1j0XGF42g0=;
        b=xPq2l8QoT6JqVyPKa7D5zIl5kgTUC0lZ5ShOA98O5gZAkTFvxVizAWn5XgHsYAGEIj
         Z/2J1dO2owCudz+XTMkg2gATp9mBD0K+jOhExrTy8mzwT5OtLD+zR/x+tN3uTmjEjWYB
         5t13SpHgHsTmN2//Fyq5h0kp3AghQTRz61Y+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hhi7Jq/TmEGX9zAh05Frrn0UAcL30QYgG9F/3vMKdJecMKdZWde88BdoV2xqB1Sc4k
         Up+q7qG2xRnTlrHcbr/FbSFMwAF6CUqvsFk93kd0s+ydHR3oiFL0Wsq8soS+2Wp8nuBc
         b0NgVnbacW+Do1DQqnbVw4yt2oJ/vExSdmtcU=
Received: by 10.68.20.9 with SMTP id j9mr2239432pbe.440.1305292475746;
        Fri, 13 May 2011 06:14:35 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173529>

1 Document translation with po4a. 
---------------------------------
I tried to translate Docmentation with po4a.
Please relive my translation flow.

1.1 prepareration 
==================
$ install po4a
$ git am 0001-Add-new-target-pot-in-Makefile.patch
$ git am 0002-add-make-shell-scripts.patch
$ cd Documentation
$ make pot    # convert .txt to .pot  with po4a-gettexize

1.2 new translation 
====================
$ mkdir ja
$ cp git-stage.pot ja/git-stage.po
  -> 0003-cp-git-stage.pot-ja-git-stage.po.patch
$ cd ja
$  translate .po by hand ...
  -> 0004-translate-ja-git-stage.po.patch
$ ../make_txt    # convert .po  to .txt  with po4a-translate
$ ../make_html   # convert .txt to .html with asciidoc

1.3 update translation 
=======================
$ git-stage.txt was updated.
  -> 0005-your-file.patch
$ cd Documentation/ja
$ ../make_update # update(merge) .po     with po4a-updatepo
  -> 0006-update-git-stage.po.patch
$ translate and remove fuzzy
  -> 0007-translate-and-remove-fazzy.patch
$ ../make_txt
$ ../make_html

=======================
Osamu OKANO (7):
  Add new target pot in Makefile
  add make(shell) scripts
  cp git-stage.pot ja/git-stage.po
  translate ja/git-stage.po
  your file
  update git-stage.po
  translate and remove fazzy

 Documentation/.gitignore      |    1 +
 Documentation/Makefile        |   15 ++++++++-
 Documentation/git-stage.txt   |    2 +-
 Documentation/ja/git-stage.po |   74 +++++++++++++++++++++++++++++++++++++++++
 Documentation/make_html       |   10 +++++
 Documentation/make_txt        |   13 +++++++
 Documentation/make_update     |   13 +++++++
 7 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ja/git-stage.po
 create mode 100644 Documentation/make_html
 create mode 100644 Documentation/make_txt
 create mode 100644 Documentation/make_update

-- 
1.7.5.1.169.g505a1.dirty
