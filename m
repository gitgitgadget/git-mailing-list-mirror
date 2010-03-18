From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/9] Multiple remotes without conflicts
Date: Thu, 18 Mar 2010 12:07:12 -0700
Message-ID: <20100318190712.GD10981@spearce.org>
References: <cover.1268913163.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:08:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsL3y-00049K-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab0CRTHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:07:17 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:51548 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0CRTHP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:07:15 -0400
Received: by pxi36 with SMTP id 36so1733751pxi.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:07:15 -0700 (PDT)
Received: by 10.141.106.21 with SMTP id i21mr1735422rvm.287.1268939235293;
        Thu, 18 Mar 2010 12:07:15 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm187352iwn.8.2010.03.18.12.07.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 12:07:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1268913163.git.agruen@suse.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142494>

Andreas Gruenbacher <agruen@suse.de> wrote:
> I'm still trying to find a simple and painless way of sharing the object
> store among multiple repositories: the idea is to have a "parent"
> repository which contains the actual object store, and a number of
> "child" repositories which link to that object store.  The obvious
> problem is garbage collection: we can only garbage collect the parent
> once it has all refs of all its children.
> 
> One way of ensuring that is to make each child a "remote" of the parent,
> and to fetch all remotes first.  This works for branches, but not for
> tags or for the reflog.

This just feels like the wrong solution.

Why can't we have a "$GIT_DIR/children" subdirectory with a symlink
or file-containing-path to each child repository.  Modify the fsck
and gc paths to include these additional reference and reflog spaces,
and that's that.

Child registration is then just a matter of installing the symlink
in the parent, or removing it, and gc/fsck never needs to worry
about a fetch up front in order for it to be accurate.
 
-- 
Shawn.
