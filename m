From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] Wider exposure for index-v4
Date: Sat, 15 Feb 2014 20:23:12 +0100
Message-ID: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 20:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEkqQ-0006Ho-8N
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 20:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbaBOTYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 14:24:05 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:55334 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaBOTYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 14:24:04 -0500
Received: by mail-la0-f48.google.com with SMTP id mc6so10068955lab.21
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 11:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5ZUv+Vimau6CUMpQwVE2gUpiIKDO27rQjIdNvAfkuTE=;
        b=BJNI6Yaai9s0aiuM83yCPOyTezq1RPxbn/F6ahUP4a45Wlo77gvmmuwmEXUMecrEzH
         9kFVfX4hMyb8Zc8aAkBH7mTPSa05GCtpV92v+V5LOINSZKkmoJaw8e+uWK9Bh1eQTD6X
         X1jpD3U041lNJeCXftA/gp2LWDmeZ1lHO5IH5+1b51dnJr2pk2/3VHPQJ2luNnszAphC
         3FOrGa6dNJxlkDfTQMKZpNYyV9MQxU5RRD+p0Yrip470ZWSM01fhQk7DN0mHwwtDW8Nt
         ooHLZifIIVRCsMVkXu6+OoDVanrZhs1Be7QqIdTmP5Y7gEuxr6RdSUGkkPRv80i05w7k
         4OJw==
X-Received: by 10.112.134.38 with SMTP id ph6mr10415382lbb.16.1392492240964;
        Sat, 15 Feb 2014 11:24:00 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id v5sm15282963laj.0.2014.02.15.11.23.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2014 11:24:00 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.300.gb39ba80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242198>

Hi,

since index-v5 didn't seem to generate enough interest to be merged, I
have a few patches that give users users easier access to index-v4.
Until now users have to go into the source code and compile git
themselves to use index-v4 by default, or use git-update-index to
change the index file to the new version.

With this patches it's possible to set the default index file format
either in gitconfig or in an environment variable.  It also simplifies
testing index-v4 by adding a Makefile knob to use it for running the
test suite.  For safety, existing repositories are not changed when
the environment or the config variables are set.

I'm not sure about the precedence in patch 3, right now the environment
variable has precedence, but it should be easy to give the config
option precedence over that.

Thomas Gummerer (3):
introduce GIT_INDEX_VERSION environment variable
test-lib: allow setting the index format version
read-cache: add index.version config variable

Documentation/config.txt              |  4 +++
Documentation/git.txt                 |  5 ++++
Makefile                              |  7 +++++
read-cache.c                          | 36 +++++++++++++++++++++++-
t/t1600-index.sh                      | 52 +++++++++++++++++++++++++++++++++++
t/t2104-update-index-skip-worktree.sh |  2 ++
t/test-lib-functions.sh               |  5 ++++
t/test-lib.sh                         |  3 ++
8 files changed, 113 insertions(+), 1 deletion(-)
create mode 100755 t/t1600-index.sh

--
1.8.3.2
