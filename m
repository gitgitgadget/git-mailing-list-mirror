From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove gitenv macro hack
Date: Thu, 19 May 2005 16:41:43 -0700
Message-ID: <7vd5rmyea0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505191800280.16809@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 01:48:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYukE-0006pU-G9
	for gcvg-git@gmane.org; Fri, 20 May 2005 01:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVESXri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 19:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVESXnx
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 19:43:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51332 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261354AbVESXlp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 19:41:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519234145.DPVH12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 19:41:45 -0400
To: Dan Weber <dan@mirrorlynx.com>
In-Reply-To: <Pine.LNX.4.62.0505191800280.16809@mirrorlynx.com> (Dan Weber's
 message of "Thu, 19 May 2005 18:01:17 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Please do not do this.

I believe we have that in quite a few places.  IIRC, it is one
of the Linus-approved GCC extensions and also used extensively
in the kernel source.

./cache.h:39:#define gitenv(e) (getenv(e) ? : gitenv_bc(e))
./commit-tree.c:149:	commitgecos = gitenv("GIT_COMMITTER_NAME") ? : realgecos;
./commit-tree.c:150:	commitemail = gitenv("GIT_COMMITTER_EMAIL") ? : realemail;
./commit-tree.c:151:	gecos = gitenv("GIT_AUTHOR_NAME") ? : realgecos;
./commit-tree.c:152:	email = gitenv("GIT_AUTHOR_EMAIL") ? : realemail;
./fsck-cache.c:359:	char *git_dir = gitenv(GIT_DIR_ENVIRONMENT) ? : DEFAULT_GIT_DIR_ENVIRONMENT;
./diff.c:35:	diff_opts = gitenv("GIT_DIFF_OPTS") ? : diff_opts;
./diff.c:358:		prepare_temp_file(other ? : name, &temp[1], two);
./diff.c:398:			builtin_diff(name, other ? : name, temp);
./diff.c:717:	diff_rename_minimum_score = minimum_score_ ? : MINIMUM_SCORE;
./sha1_file.c:203:	const char *alt = gitenv(ALTERNATE_DB_ENVIRONMENT) ? : "";
./sha1_file.c:215:			cp = strchr(last, ':') ? : last + strlen(last);

