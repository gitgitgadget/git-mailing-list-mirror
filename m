From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Move Git::SVN into its own .pm file
Date: Tue, 24 Jul 2012 23:01:02 -0700
Message-ID: <1343196066-81319-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 25 08:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stuf2-0007hj-CB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395Ab2GYGBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:01:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51502 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab2GYGBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:01:22 -0400
Received: by pbbrp8 with SMTP id rp8so869214pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=kqInQ5oWUHefi+GgG0Zt1+aOdrropbSc4eTiAIWsCrU=;
        b=M3fWC5UzljztB7QoBI/rF+ErfgRZ16tdjUG/GrUN2p0v3qixDeYdfkSyci0uNkyeKh
         wzMtdg/JnboeSEGZWbUwXIni86nKAjWcvKk1R6PHi+1Jtsb5wyiPhkdT1oVDT8Wrsv/b
         gc3m1feAXNxrroXfP0UCPFnCoUfhRncMIhwZS/7m8hhFWftQamMUx/1cYiy1grgV9jAQ
         MfHX7iQF9lg81crqPBS05GSmRNH0zApM7/SyLBzPtee9MREd27gjvut1aKU5v/US9lEB
         kJwXt3g/V4ta5zRyVHPVjZrmFiJeymt24SV9C2R8sa9mmURv0biyck6ZFdyuhIcpYofa
         Cmzw==
Received: by 10.68.131.41 with SMTP id oj9mr50323533pbb.130.1343196081846;
        Tue, 24 Jul 2012 23:01:21 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id oy8sm13681630pbc.52.2012.07.24.23.01.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:01:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202124>

This is a refactoring to move Git::SVN out of git-svn and into its own .pm file.
This will make it easier to work with and test.  This is just the extraction
with minimal work to keep all tests passing.

A couple of utility functions which were used by Git::SVN, git-svn and others
were also extracted from git-svn into a new Git::SVN::Utils.  Not the most
imaginitive name, but it's better than Git::SVN grabbing at git-svn internals
and it allows Git::SVN (and later other classes) to stand alone without git-svn.

Its was reworked to be done backwards (instead of extracting and then fixing the
resulting problems, the problems were fixed in place and then it's extracted) in
order to keep every commit passing tests and provide a useful history.  This was
something of a pain.
