From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v3 0/4] Add an option to git-format-patch to record base tree info
Date: Thu, 31 Mar 2016 09:46:12 +0800
Message-ID: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 03:48:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alRiT-0004U4-87
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 03:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbcCaBsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 21:48:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:36728 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbcCaBsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 21:48:03 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP; 30 Mar 2016 18:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,419,1455004800"; 
   d="scan'208";a="76271020"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2016 18:48:01 -0700
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290365>

V3 mainly improves the implementation according to Junio's comments,
Changes vs v2 include:

 - Remove the unnecessary output line "** base-commit-info **".
 
 - Improve the traverse logic to handle not only linear topology, but more
   general cases, it will start revision walk by setting the starting points
   of the traversal to all elements in the rev list[], and skip the ones in 
   list[], only grab the patch-ids of prerequisite patches.

 - If --base=auto is set, it will get merge base of upstream and rev range
   we specified and use it as base commit. If there is no upstream, we just
   error out and suggest to use set-upstream-to to track a remote branch
   as upstream.

v1 can be found here: http://article.gmane.org/gmane.comp.version-control.git/286873
v2 can be found here: http://article.gmane.org/gmane.comp.version-control.git/289603

Xiaolong Ye (4):
  patch-ids: make commit_patch_id() a public helper function
  format-patch: add '--base' option to record base tree info
  format-patch: introduce --base=auto option
  format-patch: introduce format.base configuration

 Documentation/git-format-patch.txt |  31 ++++++++++
 builtin/log.c                      | 119 +++++++++++++++++++++++++++++++++++++
 patch-ids.c                        |   2 +-
 patch-ids.h                        |   2 +
 4 files changed, 153 insertions(+), 1 deletion(-)

-- 
2.8.0.4.gcb5a9af

base-commit: 90f7b16b3adc78d4bbabbd426fb69aa78c714f71
