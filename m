From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Merge David's SVN exporter into git.git
Date: Fri,  4 Jun 2010 15:26:22 +0200
Message-ID: <1275657988-29765-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 15:25:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKWtf-0005bu-Dd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 15:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab0FDNZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 09:25:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:59404 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0FDNZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 09:25:05 -0400
Received: by ey-out-2122.google.com with SMTP id 25so102086eya.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=LzJpqfBttcthoGuGVOOv6QKaKGgkMYmpEUrO+Ok43v0=;
        b=NuJsOsifrP6VWPRzmUK749I0FmUN6jREOmA6F9W8Fnlzoe5LSmBii94m4srlo5g0ez
         vbzGrQQISEOl+W1c9lZbGi22sy94X47mceQygECG0gO/rKq9DDtAvP6war6oeKICbx0F
         SCLRJnpLrjjg2JAlbZZs0c49ZGhLv6durTuVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I7fP4OiTd+K6plRIewK6VwKKiD3S1uE3Y/UBaM7uYTl5fp7BN/DM4btU/Hqe88bTPs
         ftLvFxtxk5yl7YdxogHVsRvOazG0GxH1I73su1n3FY+iCJBBa169MH58Wt4qm6XIyEDN
         hQ3tymjMv0nUXWRfcJG5S5TTqMqNjd6rZ37rM=
Received: by 10.213.113.193 with SMTP id b1mr7786218ebq.24.1275657904226;
        Fri, 04 Jun 2010 06:25:04 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm722333ewy.8.2010.06.04.06.25.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 06:25:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148400>

Hi,

This is another attempt to merge David's SVN exporter into
git.git. What changed since last time: David implemented incremental
dump support, and I fixed certain things for the merge, as suggested
by Jonathan Nieder. Preparing patches for the list eats up a lot of my
time, and if this batch is more-or-less okay, I'd like it to be merged
atleast into `pu`: we can squash in minor fixes later. The exporter is
functionally complete and validated against ~940k revisions of the ASF
repository.

You can see the complete revision history in my `git-merge` branch of
my fork of svn-dump-fast-export [1].

The issue of authorship has already been discussed, but what exactly I
should do isn't very clear to me- in my opinion the author of all six
patches should be hand-edited to:
David Barr <david.barr@gmail.com>

[1]: http://github.com/artagnon/svn-dump-fast-export

Ramkumar Ramachandra (6):
  Add memory pool library
  Add cpp macro implementation of treaps
  Add library for string-specific memory pool
  Add stream helper library
  Add infrastructure to write revisions in fast-export format
  Add SVN dump parser

 vcs-svn/fast_export.c |   69 ++++++++++
 vcs-svn/fast_export.h |   14 ++
 vcs-svn/line_buffer.c |  129 ++++++++++++++++++
 vcs-svn/line_buffer.h |   14 ++
 vcs-svn/obj_pool.h    |   98 ++++++++++++++
 vcs-svn/repo_tree.c   |  353 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   27 ++++
 vcs-svn/string_pool.c |  110 +++++++++++++++
 vcs-svn/string_pool.h |   14 ++
 vcs-svn/svndump.c     |  294 ++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h     |    7 +
 vcs-svn/trp.h         |  118 ++++++++++++++++
 vcs-svn/trp.txt       |   62 +++++++++
 13 files changed, 1309 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
 create mode 100644 vcs-svn/trp.txt
