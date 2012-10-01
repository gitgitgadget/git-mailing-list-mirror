From: Olaf Klischat <olaf.klischat@gmail.com>
Subject: [PATCH 0/2] git-add: -s flag (silently ignore files)
Date: Mon,  1 Oct 2012 09:14:58 +0200
Message-ID: <1349075700-26334-1-git-send-email-olaf.klischat@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org, olaf@sofd.de
X-From: git-owner@vger.kernel.org Mon Oct 01 09:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIaDv-0002UX-OD
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 09:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab2JAHPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 03:15:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39603 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab2JAHPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 03:15:13 -0400
Received: by bkcjk13 with SMTP id jk13so4702522bkc.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=5DxwRarhuo4TeBaOpO5IQ+nIimsYSIW6ZciTQg1XPL8=;
        b=C9QFgRacD8bOxiPL7UlUE3UXt0wUDEI730Cukxg3UihjdeCeUihqNIV9Py4JGyZKVd
         fhHlVHiY94ldlA+NF0j9dW3o3HFeNkEfHJr9nIOGRytDE9/QySNzoPcKpd+1HqDeaubK
         tFJiKAFxphJW8GC13V5jFPjmv//0uTXFG7JOyCpIqa5CDXTUYS74PhwK+hpaDywPDhvY
         IkpcTC69txrwc6vP8FgiybNUouaWKA4BGiY9DIO+duZz+Uwl22Gx2NuKfQ2gzsx/ZOQG
         zy5NAhB0Z4MC+dJ85evXtXm4TBiu+F1XU4eZWURnXRdW1wb7mAeoUbIEKLtZQESHPKjt
         1Kyg==
Received: by 10.204.4.141 with SMTP id 13mr5736424bkr.82.1349075711939;
        Mon, 01 Oct 2012 00:15:11 -0700 (PDT)
Received: from tack.home.local. (e178068083.adsl.alicedsl.de. [85.178.68.83])
        by mx.google.com with ESMTPS id e13sm5851880bkw.12.2012.10.01.00.15.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Oct 2012 00:15:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206720>

This adds an -s|--silent-ignore option to git-add, which causes
ignored files that were specified explicitly on the command line to be
silently ignored, rather than abandoning the command. I found this
useful for scenarios where you want to feed the file list into git add
via find or other external commands (`find .... | xargs git add'),
which you wouldn't want to carefully tune so they don't output any
ignored files. git ls-files doesn't have find's filtering
capabilities, and using it in place of find would kind of violate "one
job one tool" anyway. I'm not really a git guru, so maybe I'm missing
something, and I'm unsure how useful this new option is for a general
audience. OTOH the patch is trivial. Check it out.

The update applies on top of "master" (261b5119).

Olaf Klischat (2):
  git-add: -s flag added (silently ignore files)
  git-add: -s flag: documentation added

 Documentation/git-add.txt |   15 +++++++++++----
 builtin/add.c             |   14 +++++++++++---
 t/t3700-add.sh            |   17 ++++++++++++++++-
 3 files changed, 38 insertions(+), 8 deletions(-)

-- 
1.7.10.4
