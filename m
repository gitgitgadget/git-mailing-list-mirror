From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to tell if a file was renamed between two commits
Date: Tue, 2 Feb 2010 18:53:47 -0800
Message-ID: <20100203025347.GB13092@spearce.org>
References: <ron1-2EA926.18292002022010@news.gmane.org> <20100203023219.GA13092@spearce.org> <ron1-08A0F6.18483502022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 03:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcVNN-0006EE-T0
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 03:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab0BCCxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 21:53:50 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:43063 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab0BCCxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 21:53:49 -0500
Received: by iwn39 with SMTP id 39so1007339iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 18:53:49 -0800 (PST)
Received: by 10.231.148.208 with SMTP id q16mr1499424ibv.9.1265165628793;
        Tue, 02 Feb 2010 18:53:48 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 21sm7069567iwn.6.2010.02.02.18.53.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 18:53:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ron1-08A0F6.18483502022010@news.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138803>

Ron Garret <ron1@flownet.com> wrote:
> In article <20100203023219.GA13092@spearce.org>,
>  "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > > So... is there an easy way to work around this?  Is there a way to get, 
> > > say, rev-list to tell me when the file it is tracking changed names?
> > 
> > Maybe use the -M flag to git log, or the --follow flag to
> > log/rev-list?
> 
> Nope.  git log --follow will follow through a name change but won't 
> actually say when the name changed happened or what the previous name of 
> the file was.
> 
> And actually playing around with it some more, it appears that git 
> rev-list doesn't actually track file renames, or at least it doesn't do 
> it all the time.  Weird.  I'm going to have to play around with this 
> some more.

Use:

  git log --format=%H -M --name-status --follow -- path 

I just tried it:

$ git log --format=%H -M --name-status --follow gerrit-prettify/src/main/resources/com/google/gerrit/prettify/client/prettify.js
8db22c85c49814b99639b2e6346583e9be4c289f

R100    gerrit-patch-gwtexpui/src/main/java/com/google/gwtexpui/safehtml/client/
544546fcd680f82a88df3e9eba7df8acfadf1e46

M       gerrit-patch-gwtexpui/src/main/java/com/google/gwtexpui/safehtml/client/
d83ac11a52c1b6d4acae932a8495daf1e9129fdf

R100    gerrit-patch-gwtexpui/src/main/java/com/google/gwtexpui/safehtml/public/
44671f5c6929a8f05223dd359182610286ceb98a

R100    src/main/java/com/google/gerrit/public/prettify20090521/prettify.js     
56fc9e3d951b0886c4781a5c8623dbc3da824f30

A       src/main/java/com/google/gerrit/public/prettify20090521/prettify.js


Yay, its been renamed 3 times in its life here.  :-)

-- 
Shawn.
