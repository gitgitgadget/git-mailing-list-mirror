From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 00:58:41 +0300
Message-ID: <20070517215841.GB29259@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 23:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Honzm-0004iV-BH
	for gcvg-git@gmane.org; Thu, 17 May 2007 23:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbXEQV6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756555AbXEQV6m
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 17:58:42 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:50471 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbXEQV6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 17:58:42 -0400
Received: by py-out-1112.google.com with SMTP id a29so979713pyi
        for <git@vger.kernel.org>; Thu, 17 May 2007 14:58:39 -0700 (PDT)
Received: by 10.65.213.4 with SMTP id p4mr5064661qbq.1179439118848;
        Thu, 17 May 2007 14:58:38 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id q14sm3317928qbq.2007.05.17.14.58.36;
        Thu, 17 May 2007 14:58:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47560>

> What I was "handwaving" (or "envisioning") was to have something
> like this in .gitmodules:
> 
> 	[subproject "kernel/"]
>         	URL = git://git.kernel.org/pub/linux-2.4.git
> 
> (or 2.6, depending on the revision of the superproject) and per
> repository configuration would maps this with these two entries:
> 
> 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
>         	URL = http://www.kernel.org/pub/linux-2.4.git
> 
> 	[subproject "git://git.kernel.org/pub/linux-2.6.git"]
>         	URL = http://www.kernel.org/pub/linux-2.6.git
> 
> The intent is 
> 
> 	(1) "kernel/" directory is found to be a gitlink in the
>             tree/index; .gitmodules is consulted to find the
>             "URL", which is just a handle and the initial hint
> 
> 	(2) That "initial hint" is used to look up the
>             subproject entry from the configuration, to find the
>             "real" URL that is used by this repository

I'm reading up on submodules, two questions on this:

1. I understand the usefulness of the hint for public repositories, (the user might
need help discovering where to get submodules) but for private ones would this
create a hassle: I start with a subproject in ~/subprojecttest and if that gets
put in the URL hint, I have to maintain a map for ~/subprojecttest in my
.git/config forever even after I move it to ~/subprojectproduction, just to make
old releases build?
Do you think it might make sense to support a mode where .gitmodules
is empty, and URLs come from the config directly?

2. Suppose .gitmodules in upstream tree points at subproject repo at kernel.org,
and I clone from there - my repo will point at kernel.org by default?
But now, I'd like everyone who clones from *my* repo to get
pointed at *my* server by default (e.g. for mirroring),
but would not changing .gitmodules create a commit so my
head will now differ from upstream  - so it won't be signed properly etc...
Did I misunderstand something?

-- 
MST
