X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn and rebase causes duplicate  log entries in svn
Date: Tue, 14 Nov 2006 14:55:36 -0800
Message-ID: <m2zmatiqon.fsf@ziti.local>
References: <00ff01c70836$ba7e3d00$1e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:56:51 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=q/pDCqE7qcxBOa6O0G2EPHi83lct/DPz10/dRRgD2K5hFzKzw/04zT9fTmqqZ2ggnEh5sNOriNbEdcJqmc0eKr2iEFOLiNsP2euLpcKQdhzX5HYWUy2RkMPm49ILy2pMDtVzClbuWXPaQOqaNo3A9SZPmJer9cvHoQBksSRaRxc=
In-Reply-To: <00ff01c70836$ba7e3d00$1e67a8c0@Jocke> (Joakim Tjernlund's message of "Tue, 14 Nov 2006 22:49:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31390>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk7C9-0004ST-Nw for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966429AbWKNWzv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966431AbWKNWzu
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:55:50 -0500
Received: from nz-out-0102.google.com ([64.233.162.200]:49693 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S966429AbWKNWzu
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:55:50 -0500
Received: by nz-out-0102.google.com with SMTP id l1so1114481nzf for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 14:55:49 -0800 (PST)
Received: by 10.65.243.18 with SMTP id v18mr2111483qbr.1163544949475; Tue, 14
 Nov 2006 14:55:49 -0800 (PST)
Received: from ziti.local ( [140.107.181.254]) by mx.google.com with ESMTP id
 e18sm5989029qbe.2006.11.14.14.55.48; Tue, 14 Nov 2006 14:55:49 -0800 (PST)
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Sender: git-owner@vger.kernel.org

Hi Joakim,

"Joakim Tjernlund" <joakim.tjernlund@transmode.se> writes:
> Now I want to rebase my svn branch against latest u-boot and commit
> my rebased svn branch to svn.
>
> I use git-svn commit -b svn -q remotes/git-svn..svn to commit my latest
> changes and when I do so I see my local changes once more in the svn
> log:
> Any way to avoid that?

I think you want to use git-svn dcommit, and not commit.  See the
notes in the git-svn man page.  The basic workflow
that I've been using is:

git-svn fetch  
git rebase remotes/git-svn  ## on mybranch
## make commits on mybranch
git-svn dcommit remotes/git-svn..mybranch

This results in each commit that I made on mybranch being sent to svn
as a separate commit.

