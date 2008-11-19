From: "Kevin Menard" <nirvdrum@gmail.com>
Subject: Re: New converstion tool: svn2git.py
Date: Wed, 19 Nov 2008 14:39:26 -0500
Message-ID: <7e3605160811191139t34c5de7q1912475f778386e8@mail.gmail.com>
References: <20081119191320.GA20870@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neil Schemenauer" <nas@arctrix.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 20:40:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2sur-0006MZ-7y
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 20:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYKSTja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 14:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYKSTja
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 14:39:30 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:7693 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYKSTj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 14:39:29 -0500
Received: by ey-out-2122.google.com with SMTP id 6so49000eyi.37
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iGO8O5UbOAMQER88cCB2FEVlLfiZfWZlZf/LyiqrJx4=;
        b=cOhHvPRUhOUElaMeRGEo/hvU00U7CSaPStzSC618a/3Tb1uOETCK8oKsjmaF0/ZzFc
         h/GKv9LhSemfiJkTMvX9wFlbMgFVODOUMaJGP9ijKxOFSkjj1JVZGGrqJMgOkXNnXjg4
         nLqU7NPU9nhARQZwv10q4UWKYg2a7arZltcWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UTc7tF2QQutKZdVLn2XcbIvTJ1mg81iV0CZlz6YX77QuEqsCv2umZMSo+QbWEW/ZQl
         tNGAhmL0xGscxW01mtTI+3z4T4boGyQ937dK3FvSD47w8LiqdrNoKcOhtDCUN54AHcQH
         V2IBz7e5xg+UIsP/plnbGKpAcim625+24EIQc=
Received: by 10.86.70.3 with SMTP id s3mr926146fga.78.1227123566791;
        Wed, 19 Nov 2008 11:39:26 -0800 (PST)
Received: by 10.86.59.15 with HTTP; Wed, 19 Nov 2008 11:39:26 -0800 (PST)
In-Reply-To: <20081119191320.GA20870@arctrix.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101371>

Hi Neil,

You may want to look at this Ruby implementation for more ideas:

http://github.com/nirvdrum/svn2git/

I forked it from a project originally by James Coglan, but should be
able to answer most questions about it.
-- 
Kevin



On Wed, Nov 19, 2008 at 2:13 PM, Neil Schemenauer <nas@arctrix.com> wrote:
> Hi,
>
> I'm working on a tool to do conversions from SVN to git using a SVN
> dump.  It's in early development but perhaps some people would be
> interested in it:
>
>    http://python.ca/nas/python/svn2git.py
>
> I would like to improve it so that it intelligently converts SVN
> branches and tags into git branches (when possible).  The basic idea
> is to map SVN paths into git branches, e.g. trunk -> master,
> branches/foo -> branch-foo, tags/bar -> tags-bar.  Next, specific
> SVN dump actions like:
>
>    Node-path: branches/foo
>    Node-kind: dir
>    Node-action: add
>    Node-copyfrom-rev: 3
>    Node-copyfrom-path: trunk
>
> need to be detected and the commit needs to performed with the
> correct parent.  One complication is that SVN can create a branch or
> tag from anywhere, for example, the action
>
>    Node-path: tags/bar
>    Node-kind: dir
>    Node-action: add
>    Node-copyfrom-rev: 3
>    Node-copyfrom-path: trunk/subdir
>
> would create tags/bar based on revision 3 of trunk/subdir.  There
> doesn't seem to be a good way to convert that into git.  I was
> thinking that the tags-bar branch in that case would have no parent.
> Would git still efficently pack that or would you end up with extra
> blobs?
>
>  Neil
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
