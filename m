From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Update hard-coded header dependencies
Date: Fri, 8 Aug 2014 14:58:26 -0700
Message-ID: <20140808215825.GH12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 23:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFsBI-0005NB-7T
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 23:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbaHHV6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 17:58:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38541 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177AbaHHV63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 17:58:29 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so7963494pab.12
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=k9OMyqArhyDCCG7Ap/EAVArBRZSb50KVlGlNRAGwwEk=;
        b=QMrab/F2dxCVAphDkISMIHnL4CkReyWvLRkGL4aR0i0RBUIesDaiE5hGpIfpyp7lKH
         ku+E/RUTkPQNOA+ViAKB9JnBBKsGAKZNSuxo0rwt4C7HeQzT+G6BzE0n5V+N3/z2QqDz
         Bm30zQnkF0vQYW+RRDGshPg2PTKTEZ1OVXbxOXuQqolS0FGsw0s8aByfTtZVDvc2Wgqv
         hWkLAwPf+KXin00YFZ66JmClnmt18KtHYx6jbZC5dGZnlSEmu0eBGzyyeJg4Oe2f1NSr
         B9tiu1QPUcUkcclSss9wsW7u0siX83OFwSyzb+mS7Bu89gfFEZ5XIsSOOUB7k4uSr2Y/
         KHIg==
X-Received: by 10.70.118.9 with SMTP id ki9mr26822946pdb.104.1407535108727;
        Fri, 08 Aug 2014 14:58:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c044:7341:6a62:5897])
        by mx.google.com with ESMTPSA id y4sm3983869pbt.60.2014.08.08.14.58.27
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 14:58:28 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255067>

The fall-back rules used when compilers don't support the -MMD switch
to generate makefile rules based on #includes have been out of date
since v1.7.12.1~22^2~8 (move git_version_string into version.c,
2012-06-02).

Checked with 'make CHECK_HEADER_DEPENDENCIES=yes'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Maybe it's worth switching to plain

	LIB_H += $(wildcard *.h)

?  People using ancient compilers that never change headers wouldn't
be hurt, people using modern compilers that do change headers also
wouldn't be hurt, and we could stop pretending to maintain an
up-to-date list.

 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 2320de5..18f0fad 100644
--- a/Makefile
+++ b/Makefile
@@ -646,15 +646,19 @@ LIB_H += cache.h
 LIB_H += color.h
 LIB_H += column.h
 LIB_H += commit.h
+LIB_H += commit-slab.h
+LIB_H += compat/apple-common-crypto.h
 LIB_H += compat/bswap.h
 LIB_H += compat/mingw.h
 LIB_H += compat/obstack.h
 LIB_H += compat/poll/poll.h
 LIB_H += compat/precompose_utf8.h
 LIB_H += compat/terminal.h
+LIB_H += compat/win32/alloca.h
 LIB_H += compat/win32/dirent.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
+LIB_H += connect.h
 LIB_H += connected.h
 LIB_H += convert.h
 LIB_H += credential.h
@@ -678,6 +682,7 @@ LIB_H += grep.h
 LIB_H += hashmap.h
 LIB_H += help.h
 LIB_H += http.h
+LIB_H += khash.h
 LIB_H += kwset.h
 LIB_H += levenshtein.h
 LIB_H += line-log.h
@@ -721,6 +726,7 @@ LIB_H += sha1-lookup.h
 LIB_H += shortlog.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
+LIB_H += split-index.h
 LIB_H += strbuf.h
 LIB_H += streaming.h
 LIB_H += string-list.h
@@ -728,6 +734,7 @@ LIB_H += submodule.h
 LIB_H += tag.h
 LIB_H += tar.h
 LIB_H += thread-utils.h
+LIB_H += trace.h
 LIB_H += transport.h
 LIB_H += tree-walk.h
 LIB_H += tree.h
@@ -744,6 +751,7 @@ LIB_H += vcs-svn/repo_tree.h
 LIB_H += vcs-svn/sliding_window.h
 LIB_H += vcs-svn/svndiff.h
 LIB_H += vcs-svn/svndump.h
+LIB_H += version.h
 LIB_H += walker.h
 LIB_H += wildmatch.h
 LIB_H += wt-status.h
-- 
