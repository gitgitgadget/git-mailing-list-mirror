From: Ilya Basin <basinilya@gmail.com>
Subject: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch --tree-filter' on Solaris?
Date: Wed, 17 Oct 2012 10:47:29 +0400
Message-ID: <1109432467.20121017104729@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 08:47:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TONPu-0007Af-18
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 08:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab2JQGre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 02:47:34 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:42620 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab2JQGrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 02:47:33 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4767523lag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=EjFW8UAgFoi3+TJ+h/fppYffK6RqljMR9heYbq/dpjk=;
        b=xs69TDYZG+t6gh/Tu2wOgEhJlBkbo2BrU//6UBQbNkW9iZsVDL9tNRhms9rTfshVX/
         KDcIpemmRjbEfCjd1LdXzUJjsSsIqfHkypdUgEXhFuoYuAxHulMDWanPW6H8Ykc4T642
         tFUabB6pTqu97E/su0ih+++9ULDvb7IGPg79PL+ULCUgcz+WHfW5csm69fBRSj79fjm8
         vUuKaIo8uSQOX17WUUGWGrAhV0vcUPl7OhQAUoZ3QWy7Pe9F9U6E6sIMEnOxDacAcqlj
         N8V2kt5UA9SuOE4OOmieQ4ZSzQQdiZodvZAPu1W1U23XKI+Rwzi9E4Zo/Af6VEhmeZm+
         SVSA==
Received: by 10.152.105.44 with SMTP id gj12mr10151743lab.19.1350456451709;
        Tue, 16 Oct 2012 23:47:31 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:6c:7728:c125:e694])
        by mx.google.com with ESMTPS id q2sm6193266lbd.14.2012.10.16.23.47.29
        (version=SSLv3 cipher=OTHER);
        Tue, 16 Oct 2012 23:47:30 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207896>

The filter-branch command, the contents of ~/.gitconfig and the tree
are the same.
The command succeeds on cygwin, but fails on Solaris due to
unset GIT_AUTHOR_NAME and GIT_COMMITTER_NAME :

$ git filter-branch --tree-filter "env | grep GIT_ ; $CMD" b416b9bfc5e71531f2f05af4c396bb0ba7560741..HEAD
Rewrite 214efc6eec82b015aefe23b2280979f05b351396 (1/16)GIT_DIR=/home/tester/.ilya/builds/makepkg.rap_0.1-1_sparc.XXXXXX/src/rap/.git
GIT_INDEX_FILE=/home/tester/.ilya/builds/makepkg.rap_0.1-1_sparc.XXXXXX/src/rap/.git-rewrite/t/../index
GIT_WORK_TREE=.
GIT_AUTHOR_NAME=
GIT_COMMITTER_NAME=
GIT_COMMIT=214efc6eec82b015aefe23b2280979f05b351396
fatal: empty ident  <my@email.com> not allowed
could not write rewritten commit

If I explicitly set these 2 variables, filter-branch succeeds, but
other commit attributes like commit date aren't preserved.

I use git 1.7.6, from sunfreeware.

I hope there is some simple thing that needs to be configured.
