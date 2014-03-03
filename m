From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 00/14] Use ALLOC_GROW() instead of inline code
Date: Tue,  4 Mar 2014 02:31:48 +0400
Message-ID: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:32:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbPE-0001zm-SN
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbaCCWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:32:11 -0500
Received: from forward5o.mail.yandex.net ([37.140.190.34]:39155 "EHLO
	forward5o.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbaCCWcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:09 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward5o.mail.yandex.net (Yandex) with ESMTP id 689CE170127E
	for <git@vger.kernel.org>; Tue,  4 Mar 2014 02:32:07 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 4511B1E1357
	for <git@vger.kernel.org>; Tue,  4 Mar 2014 02:32:07 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-W6vm0X7L;
	Tue,  4 Mar 2014 02:32:06 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: b878a328-5cf5-449a-ad2a-146b9664159e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885926;
	bh=I1qrA9uesxqd+UjXUMi+ran/0AV3w2/Knn3APHKvBs8=;
	h=From:To:Subject:Date:Message-Id:X-Mailer;
	b=cA0z6NScBqBBGZNt3Q8rhCzft91Uzd87s8hMlCwDB9sFt9TxJuRcCS2JucVzr8lsr
	 q+1SHiHHruDPxh+ZtMEPddfsGHQWkbDgxH1Wt7x9EyAX0gtms0PvZd96KSB2dOJyop
	 AwEgLMt+4Nnll/etNOI+3xdih0LQdLiTQQaVbhKg=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243278>

This version differs from previous [1] the following changes:
  - added three new commits with similar changes in "builtin/mktree.c",
    "cache-tree.c" and "sha1_file.c".
  - updated commit messages: "use ALLOC_GROW() in function_name()" instead of
    "change function_name() to use ALLOC_GROW()"
  - updated [PATCH v2 01/11] [2] to keep code lines within 80 columns in 
    "builtin/pack-objects.c"

Duy Nguyen, Michael Haggerty, Junio C Hamano, Eric Sunshine, and He Sun, 
thanks you very much for your remarks and advices

[1] http://thread.gmane.org/gmane.comp.version-control.git/242919
[2] http://thread.gmane.org/gmane.comp.version-control.git/242920

Dmitry S. Dolzhenko (14):
  builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
  bundle.c: use ALLOC_GROW() in add_to_ref_list()
  cache-tree.c: use ALLOC_GROW() in find_subtree()
  commit.c: use ALLOC_GROW() in register_commit_graft()
  diff.c: use ALLOC_GROW()
  diffcore-rename.c: use ALLOC_GROW()
  patch-ids.c: use ALLOC_GROW() in add_commit()
  replace_object.c: use ALLOC_GROW() in register_replace_object()
  reflog-walk.c: use ALLOC_GROW()
  dir.c: use ALLOC_GROW() in create_simplify()
  attr.c: use ALLOC_GROW() in handle_attr_line()
  builtin/mktree.c: use ALLOC_GROW() in append_to_tree()
  read-cache.c: use ALLOC_GROW() in add_index_entry()
  sha1_file.c: use ALLOC_GROW() in pretend_sha1_file()

 attr.c                 |  7 +------
 builtin/mktree.c       |  5 +----
 builtin/pack-objects.c |  9 +++------
 bundle.c               |  6 +-----
 cache-tree.c           |  6 +-----
 commit.c               |  8 ++------
 diff.c                 | 12 ++----------
 diffcore-rename.c      | 12 ++----------
 dir.c                  |  5 +----
 patch-ids.c            |  5 +----
 read-cache.c           |  6 +-----
 reflog-walk.c          | 12 ++----------
 replace_object.c       |  8 ++------
 sha1_file.c            |  7 +------
 14 files changed, 21 insertions(+), 87 deletions(-)

-- 
1.8.3.2
