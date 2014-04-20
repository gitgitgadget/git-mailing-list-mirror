From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/8] transport-helper: refspec support
Date: Sun, 20 Apr 2014 13:59:22 -0500
Message-ID: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8B-0005Yz-Rs
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbaDTTJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:09:53 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:44633 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaDTTJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:09:51 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so2933159yha.16
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kDvL8zcMcrTJlvaNn8j2hBdE+CuEW7XLKSV4MT8dLik=;
        b=prD4ybS7tMvd8tE4Fs2cDitTj/4INwNWnvbplmIuRhJAzi0ki1ERiXIiJfsj4cLZAl
         qHDqt7wQvGRYtjqabG6P2xYuUkYkR4HimPbQc0jUuf2fd7KUCXJKS7A6nLgreuwYZIR3
         Gaj3yYOwFZWRGeFi0k7Im5ZTHCgE1L7PiIONRDfjTbfwtbUzTmtQWcMauert3lnAF4HU
         unzAczoBUgx47UjLxUzSQ64Hh1ppx7in8kDi7MdzdHpbnIkiPtS3q4pODldhkejJyO6R
         1kmyvYo+VWJ8DsRtyHEO3JgHhJBJdo/ZYIEHIGwpRRSVAb0ocN5SPC9YfBoer0P8ZAj5
         Ggfg==
X-Received: by 10.236.175.37 with SMTP id y25mr3562500yhl.100.1398020990819;
        Sun, 20 Apr 2014 12:09:50 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g65sm65405151yhm.28.2014.04.20.12.09.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:09:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246558>

Hi,

Here are the patches that allow transport helpers to be completely transparent
by adding the remaining missing feature: pushing refspecs and deleting branches
(old:new :delete).

These were already sent before, but dropped in later patch series because Junio
didn't like some name.

Apparently Git v2.0 is already advertising this feature, but it's missing the
actual patches.

Felipe Contreras (8):
  fast-export: improve argument parsing
  fast-export: add new --refspec option
  transport-helper: add support for old:new refspec
  transport-helper: add support to push symbolic refs
  fast-import: add support to delete refs
  fast-export: add support to delete refs
  transport-helper: add support to delete branches
  transport-helper: remove unnecessary strbuf resets

 Documentation/git-fast-export.txt |  4 ++++
 Documentation/git-fast-import.txt |  3 +++
 builtin/fast-export.c             | 49 ++++++++++++++++++++++++++++++++++++++-
 fast-import.c                     | 13 ++++++++---
 t/t5801-remote-helpers.sh         | 18 +++++++++++++-
 t/t9300-fast-import.sh            | 18 ++++++++++++++
 t/t9350-fast-export.sh            | 18 ++++++++++++++
 transport-helper.c                | 32 ++++++++++++++++++-------
 8 files changed, 141 insertions(+), 14 deletions(-)

-- 
1.9.1+fc3.9.gc73078e
