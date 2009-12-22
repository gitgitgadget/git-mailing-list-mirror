From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git fast-import not verifying commit author lines?
Date: Tue, 22 Dec 2009 07:06:49 -0800
Message-ID: <20091222150649.GI10687@spearce.org>
References: <4B304987.7030201@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 16:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN6KO-0004M9-SN
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 16:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbZLVPHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 10:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZLVPHF
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 10:07:05 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:36927 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZLVPHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 10:07:04 -0500
Received: by ywh12 with SMTP id 12so6809344ywh.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 07:07:01 -0800 (PST)
Received: by 10.90.215.9 with SMTP id n9mr8918576agg.98.1261494420992;
        Tue, 22 Dec 2009 07:07:00 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm2651966yxe.56.2009.12.22.07.06.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 07:06:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B304987.7030201@facebook.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135580>

David Reiss <dreiss@facebook.com> wrote:
> mtn git_export produces this output on a simple repo:
> 
> blob
> mark :1
> data 8
> content
> 
> commit refs/heads/com.example.badexport
> mark :2
> author <somename> 1261454209 +0000
> committer <somename> 1261454209 +0000
> data 8
> acommit
> 
> M 100644 :1 "afile"
> progress revision 9b0e11e4d66eba8a3cf26095fb573116b886cd37 (1/1)
> #############################################################
> 
> The author and committer lines are missing the names (I've filed this as a
> bug with monotone).  git commit-tree refuses to to produce a commit object
> like this, so it seems like git fast-import should detect and report this
> instead of silently writing the invalid commit object to the repository.

Nope.

These objects can still be processed by git commands, you just can't
normally create them with Git tools.  To some extent fast-import
allows the caller to import data that you wouldn't otherwise create
in Git because we know you are coming from a foreign system where
the data might not reasonably exist.

-- 
Shawn.
