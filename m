From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] gitview: Define __slots__ for Commit
Date: Wed, 30 May 2007 14:47:09 +1000 (EST)
Message-ID: <f9b34180c9ece0068109ed1021e196150cb81c57.1180500418.git.michael@ellerman.id.au>
References: <f623da83269ba030fabc64777cdb1071e5ab00bf.1180500418.git.michael@ellerman.id.au>
Cc: <git@vger.kernel.org>
To: <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 06:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtG5h-00061J-2k
	for gcvg-git@gmane.org; Wed, 30 May 2007 06:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbXE3ErM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXE3ErM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 00:47:12 -0400
Received: from ozlabs.org ([203.10.76.45]:53415 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbXE3ErK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 00:47:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
	id 65AA7DDFD6; Wed, 30 May 2007 14:47:09 +1000 (EST)
In-Reply-To: <f623da83269ba030fabc64777cdb1071e5ab00bf.1180500418.git.michael@ellerman.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48736>

Define __slots__ for the Commit class. This reserves space in each Commit
object for only the defined variables. On my system this reduces heap usage
when viewing a kernel repo by 12% ~= 55868 KB.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 contrib/gitview/gitview |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 6b54bc0..4baa1dd 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -263,6 +263,9 @@ class Commit(object):
 	""" This represent a commit object obtained after parsing the git-rev-list
 	output """
 
+	__slots__ = ['children_sha1', 'message', 'author', 'date', 'committer',
+				 'commit_date', 'commit_sha1', 'parent_sha1']
+
 	children_sha1 = {}
 
 	def __init__(self, commit_lines):
-- 
1.5.1.3.g7a33b
