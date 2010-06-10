From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Leaving large binaries out of the packfile
Date: Thu, 10 Jun 2010 11:04:57 -0700
Message-ID: <20100610180457.GO14847@spearce.org>
References: <4C108556.8040102@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:05:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMm7p-0006Uk-4F
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518Ab0FJSFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:05:02 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61063 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab0FJSFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:05:01 -0400
Received: by pwi1 with SMTP id 1so34256pwi.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 11:05:00 -0700 (PDT)
Received: by 10.141.88.6 with SMTP id q6mr368969rvl.218.1276193099988;
        Thu, 10 Jun 2010 11:04:59 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id k17sm248235rvh.17.2010.06.10.11.04.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 11:04:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C108556.8040102@workspacewhiz.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148898>

Joshua Jensen <jjensen@workspacewhiz.com> wrote:
> Sometimes, 'git gc' runs out of memory.  I have to discover which file  
> is causing the problem, so I can add it to .gitattributes with a  
> '-delta' flag.  Mostly, though, the repacking takes forever, and I dread  
> running the operation.

If you have the list of big objects, you can put them into their
own pack file manually.  Feed their SHA-1 names on stdin to git
pack-objects, and save the resulting pack under .git/objects/pack.

Assuming the pack was called pack-DEADC0FFEE.pack, create a file
called pack-DEADC0FFEE.keep in the same directory.  This will stop
Git from trying to repack the contents of that pack file.

Now run `git gc` to remove those huge objects from the pack file
that contains all of the other stuff.

-- 
Shawn.
