From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] add git-check-mailmap command
Date: Thu, 11 Jul 2013 10:55:24 -0400
Message-ID: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 17:03:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxIOB-000714-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 17:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab3GKPCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 11:02:31 -0400
Received: from mail-ye0-f172.google.com ([209.85.213.172]:61959 "EHLO
	mail-ye0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab3GKPCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 11:02:30 -0400
Received: by mail-ye0-f172.google.com with SMTP id l3so880582yen.31
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=6LgMXso/8cfmIctBCH0+sXMQYtjCtQSkf6RDymYtlJI=;
        b=mcthqiDJpY5GdU4TcLmwKDGqBRp8pXUxkPX3MBtqKo+a/awQEMP4KPbATdhOEwIUHA
         dOywsILmBC04cb2kNm5L2HMIMPkaWqa5vbRsQO3Un6eplNXcSaqJvjuK0PYbxE0V49BT
         f1cEtSwXAQIdTpkVk1oN85VJBPttTMVvIHJXSpKX5EkvFyYCJ+856IxZVNspv4Cy1iQi
         7Y8jOqgYkFpxdSVIqO6ULsQ8K8vwRUA6EZY98J12LMmkoiKwUo8h5EeqLhB6J+n49trN
         W8m3zAQ0/pEeSki/1T6qcNXrtnc934WGnWjx/fMnmmotfi5aNEI5KNDEKwa1uplFM4AD
         neqQ==
X-Received: by 10.236.137.15 with SMTP id x15mr20834161yhi.225.1373554561460;
        Thu, 11 Jul 2013 07:56:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id s29sm60841065yhf.6.2013.07.11.07.55.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 07:56:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230105>

This is a re-roll of [1] which introduces git-check-mailmap. The
primary motivation for this command is to expose git's stable,
well-tested C-implementation of .mailmap functionality to scripts and
porcelains, thus relieving them of the need to reimplement support
themselves. The git-contacts [2] script (currently at es/contacts in
'pu') would be one such client. v2 removes the RFC status and addresses
comments from reviewers [1].

Changes since v1:

* Add Documentation/git-check-mailmap.txt.

* Add --null alias for -z.

* Use OPT_BOOL rather than deprecated OPT_BOOLEAN.

* Simplify code which outputs normalized contact.

* Settle on "stdout" as argument to maybe_flush_or_die().

* Eliminate diff noise from patch 4/4.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/230068/
[2]: http://thread.gmane.org/gmane.comp.version-control.git/229533/

Eric Sunshine (4):
  builtin: add git-check-mailmap command
  t4203: test check-mailmap command invocation
  t4203: test mailmap functionality directly rather than indirectly
  t4203: consolidate test-repository setup

 .gitignore                             |   1 +
 Documentation/git-check-mailmap.txt    |  55 ++++++++
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/check-mailmap.c                |  69 ++++++++++
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |   1 +
 git.c                                  |   1 +
 t/t4203-mailmap.sh                     | 234 +++++++++++++++++----------------
 9 files changed, 251 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/git-check-mailmap.txt
 create mode 100644 builtin/check-mailmap.c

-- 
1.8.3.2
