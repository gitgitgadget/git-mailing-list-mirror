From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 16:05:37 -0700
Message-ID: <20100326230537.GC10910@spearce.org>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIb6-0002Jh-0I
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab0CZXFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:05:41 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:51657 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab0CZXFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 19:05:40 -0400
Received: by ywh2 with SMTP id 2so3825288ywh.33
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 16:05:40 -0700 (PDT)
Received: by 10.150.1.14 with SMTP id 14mr2158839yba.12.1269644740168;
        Fri, 26 Mar 2010 16:05:40 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1205247iwn.2.2010.03.26.16.05.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 16:05:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BAD3C6E.4090604@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143296>

"Mike.lifeguard" <mike.lifeguard@gmail.com> wrote:
> Apparently Scott Chacon has some clue about this error:
> http://support.github.com/discussions/repos/2566-strange-warning-from-fsck-and-github-repo-using-too-much-diskspace
> so I've added him to CC. (Note that changing all SHA1s is not really a
> problem for us, there are only 3 copies of the repo, and the project has
> only been using version control for 2 days)

Scott, please fix that library on GitHub.  JGit's fsck has a hard
failure on these malformed trees, because the leading '0' mode
causes the tree to come up with the wrong SHA-1 hash given its
logical content.  They shouldn't be created like this.


Mike, it sounds like you might be able to fix your project by just
running something like:

  $ git filter-branch --index-filter '' --all

It rewrites the trees, which will change their SHA-1s (and the commit
SHA-1s downstream from there) with correctly formatted tree objects.

-- 
Shawn.
