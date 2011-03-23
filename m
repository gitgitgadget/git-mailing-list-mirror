From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PULL svn-fe] vcs-svn: simplifications, error handling improvements
Date: Tue, 22 Mar 2011 19:32:40 -0500
Message-ID: <20110323003240.GA4949@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 01:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2C0t-0005kH-MO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 01:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab1CWAdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 20:33:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60497 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1CWAdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 20:33:14 -0400
Received: by ywj3 with SMTP id 3so3133719ywj.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 17:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XvpyATlZ6jp+KaHm6l0AIHbK8Ubx3++w+QKPZHkrZrs=;
        b=AqjL1U6YlIetkkiUphrhlG+kDHIL+6dbmdSVF7Bj+fWR6rhGI99TU1GcmIeLPwEtHi
         QPbNx5sRYo67adwJb/SOL834qKGB8T6qvdNUnTZrLfCedX4JNPoDeu/5SyHncwzX/vCi
         Nggm2kKLba/dXamOpBYiLN6qnhF/NlYo2ziQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fMUSRGj0gGVnt5syxTDt8fnmmTp2NIcrxb+dznouHdO5y+xiGr2M95Toog21G9Sbif
         kLUNJh3OMSuIU593s4kMEWhX84qFYEOFep4ejkgk/wWXdu9xM6zfguW5yhXp5FqxAL+/
         pPgoSRddGb7LnhUHkgO7BrvH9fZ7uSbSLoXQk=
Received: by 10.151.95.16 with SMTP id x16mr6081424ybl.46.1300840392728;
        Tue, 22 Mar 2011 17:33:12 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id p41sm1984431ybk.29.2011.03.22.17.33.06
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 17:33:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169790>

(culled cc list)
Hi Junio,

Please pull

  git://repo.or.cz/git/jrn.git svn-fe

to get the following changes on top of master.

These are the patches from David's recent code-purge series that do
not require incremental import support.  I'd like to push out
incremental import support soon, too, but since that makes svn-fe
require feedback from fast-import as it runs, it would be nice to
provide some simple wrapper script to set everything up at the same
time to avoid inconveniencing users too much.

The main impact of the patches currently in svn-fe should be to
improve error handling a little.

David Barr wrote:

> Patch 6 follows the spirit of patches 4 and 5, for a consistent
> approach to switching on constant strings.

I've skipped this one and applied the rest.  You can see the result
in the svn-fe-pu branch.

Thoughts, suggestions, improvements welcome as always.

David Barr (5):
      vcs-svn: use strbuf for revision log
      vcs-svn: use strbuf for author, UUID, and URL
      vcs-svn: implement perfect hash for node-prop keys
      vcs-svn: implement perfect hash for top-level keys
      vcs-svn: use strchr to find RFC822 delimiter

Jonathan Nieder (9):
      vcs-svn: introduce repo_read_path to check the content at a path
      vcs-svn: handle_node: use repo_read_path
      vcs-svn: simplify repo_modify_path and repo_copy
      vcs-svn: allow input errors to be detected promptly
      vcs-svn: improve support for reading large files
      vcs-svn: make buffer_skip_bytes return length read
      vcs-svn: make buffer_copy_bytes return length read
      vcs-svn: improve reporting of input errors
      Merge branch 'db/length-as-hash' into svn-fe

 vcs-svn/fast_export.c   |   27 +++--
 vcs-svn/fast_export.h   |    5 +-
 vcs-svn/line_buffer.c   |   36 ++++---
 vcs-svn/line_buffer.h   |    6 +-
 vcs-svn/line_buffer.txt |    3 +-
 vcs-svn/repo_tree.c     |   43 ++++---
 vcs-svn/repo_tree.h     |   10 +-
 vcs-svn/svndump.c       |  307 +++++++++++++++++++++++++++++------------------
 8 files changed, 265 insertions(+), 172 deletions(-)
