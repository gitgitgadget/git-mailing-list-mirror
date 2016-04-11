From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v4 0/4] Add --base option to git-format-patch to record base tree info
Date: Mon, 11 Apr 2016 10:47:49 +0800
Message-ID: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 04:48:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apRuL-00048W-W0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 04:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbcDKCsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 22:48:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:53722 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbcDKCsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 22:48:52 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP; 10 Apr 2016 19:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,462,1455004800"; 
   d="scan'208";a="955872789"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2016 19:48:49 -0700
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291198>

V4 mainly addresses Junio's comments on V3, Changes include:

 - Polish up the documentation to make output files git-format-patch.1 and
   git-format-patch.html more sensible.

 - Add error handling when base commit is not ancestor of revision list
   specified in cmdline.

 - Specify topo order to do the traverse work, and show the base tree info
   block in a more natural sequence.
 
 - If --base=auto is set and there is more than one best merge base, instead
   of picking up a random one, it will error out for they may be complicated
   situation such as criss-cross merges.

 - Add tests for the --base option and format.base configuration.

 - Fix a segfault error due to bases structure hasn't been initialized when
   --base option is not set, Thanks for Ramsay's report.

Xiaolong Ye (4):
  patch-ids: make commit_patch_id() a public helper function
  format-patch: add '--base' option to record base tree info
  format-patch: introduce --base=auto option
  format-patch: introduce format.base configuration

 Documentation/git-format-patch.txt |  64 +++++++++++++++++++
 builtin/log.c                      | 123 +++++++++++++++++++++++++++++++++++++
 patch-ids.c                        |   2 +-
 patch-ids.h                        |   2 +
 t/t4014-format-patch.sh            |  48 +++++++++++++++
 5 files changed, 238 insertions(+), 1 deletion(-)

-- 
2.8.1.120.g24d6b3f

base-commit: 7b0d47b3b6b5b64e02a5aa06b0452cadcdb18355
