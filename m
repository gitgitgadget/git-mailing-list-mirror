From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/18] GSoC update: Sequencer for inclusion v3
Date: Wed, 27 Jul 2011 08:48:57 +0530
Message-ID: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QluhX-0005s7-B1
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab1G0DWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:22:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab1G0DWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:22:18 -0400
Received: by pzk37 with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=PRueXjqA++Arl7wMqpmesbWzSOJg9bCrK1w5IKogwxE=;
        b=a8HRXw63ee1Jj7PgtrEacudM9UUTS2bnGOAgqBAhxkCEz+q5ah4MaFc56lt1AkuwL9
         oRmJCgZz1fdnKn+YdMufRZ/coP/Hw1Kwhue9Q+WlB4I1eXeleGeJDH8Rn9DhYbKRnWdE
         98CxjM6+GV1GNXfI/4cEu4/ZTnQ92lVku/v2k=
Received: by 10.68.36.99 with SMTP id p3mr11570798pbj.275.1311736937704;
        Tue, 26 Jul 2011 20:22:17 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.22.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:22:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177904>

Hi,

Nothing new has been introduced; a couple of minor changes have been
made since last time (rewrite "config: Introduce functions to write
non-standard file" and remove "Please, " in hint: messages).  I will
hencefourth refer to this series as "sequencer-stable" -- I've started
building post midterm work* on top of this.  If something critical
comes up, I can always fixup this series, rebase and quickly continue
my work.

While Junio and others are not entirely happy with "revert: Remove
sequencer state when no commits are pending", and there is still some
confusion about how '--abort' will work in the future, I think we have
discussed these issues sufficiently.

* I haven't made anything public yet, because it's still in its
  infancy stages; I'll hopefully have something to show by the end of
  the week.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (18):
  advice: Introduce error_resolve_conflict
  config: Introduce functions to write non-standard file
  revert: Simplify and inline add_message_to_msg
  revert: Don't check lone argument in get_encoding
  revert: Rename no_replay to record_origin
  revert: Propogate errors upwards from do_pick_commit
  revert: Eliminate global "commit" variable
  revert: Introduce struct to keep command-line options
  revert: Separate cmdline parsing from functional code
  revert: Don't create invalid replay_opts in parse_args
  revert: Save data for continuing after conflict resolution
  revert: Save command-line options for continuing operation
  revert: Make pick_commits functionally act on a commit list
  revert: Introduce --reset to remove sequencer state
  reset: Make reset remove the sequencer state
  revert: Remove sequencer state when no commits are pending
  revert: Don't implictly stomp pending sequencer operation
  revert: Introduce --continue to continue the operation

 Documentation/git-cherry-pick.txt |    6 +
 Documentation/git-revert.txt      |    6 +
 Documentation/sequencer.txt       |    9 +
 Makefile                          |    2 +
 advice.c                          |   31 ++-
 advice.h                          |    3 +-
 branch.c                          |    2 +
 builtin/revert.c                  |  743 +++++++++++++++++++++++++++++--------
 cache.h                           |    2 +
 config.c                          |   36 ++-
 sequencer.c                       |   19 +
 sequencer.h                       |   20 +
 t/7106-reset-sequence.sh          |   43 +++
 t/t3510-cherry-pick-sequence.sh   |  219 +++++++++++
 14 files changed, 969 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h
 create mode 100755 t/7106-reset-sequence.sh
 create mode 100755 t/t3510-cherry-pick-sequence.sh

-- 
1.7.4.rc1.7.g2cf08.dirty
