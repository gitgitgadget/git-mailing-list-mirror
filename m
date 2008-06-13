From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 01:51:28 -0700 (PDT)
Message-ID: <m3iqwdra6h.fsf@localhost.localdomain>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	<20080611213648.GA13362@glandium.org>
	<alpine.DEB.1.00.0806112242370.1783@racer>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	<loom.20080612T042942-698@post.gmane.org>
	<6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	<4851F6F4.8000503@op5.se>
	<20080613055800.GA26768@sigill.intra.peff.net>
	<48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K751M-000062-4T
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761566AbYFMIvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 04:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761522AbYFMIvg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:51:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:48260 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761548AbYFMIvc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 04:51:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1964332fkq.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=3Yrra5uwGzPvXCHvxS0G+hFf9KgkhMcJHiD8Ak0I3ck=;
        b=sxeaPTy7pGVDx//1K0Kb7GVCGqw/wJv4GCOfNzBsP5C7i1TMJ9F6Jy5eCo3ZrcD9OH
         4KMl1x/lZBOnqWi1b7C5kHM8k2d6u8QMIFpvBJaT/0jmr/vQiO+wAz4pYmcm+YmmbTNT
         GWNhYyFHy378+mj8yQB+I+wSJ3ZSiL4QEzWyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=aIu/NElAl77c1hqcPASq3Q7YNtQl9Z88NretYQtG+UFTaVJb/FIWMO5xKzVa1KnsMf
         9l6/0qnDanxZCYGUyfW7n6ktr+dUL96hDMmKx0YyPuuu6HJkfKB4OX2xQs4iAhI+ipUj
         3j9mU5b8WZRpZZOL2e7oTYrYZzMUu3o9xP2NE=
Received: by 10.78.152.17 with SMTP id z17mr948514hud.63.1213347090525;
        Fri, 13 Jun 2008 01:51:30 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.221.64])
        by mx.google.com with ESMTPS id 18sm3212999hue.17.2008.06.13.01.51.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 01:51:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5D8oUWX005995;
	Fri, 13 Jun 2008 10:50:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5D8nxLc005990;
	Fri, 13 Jun 2008 10:49:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080613074257.GA513@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84850>

Jeff King <peff@peff.net> writes:

> So of course my first question is "then why didn't you use a branch?" :)
> 
> I'm not, by the way, trying to say "there is no good reason not to use a
> branch." I am trying to figure out what the reasons are, because I
> wonder if there is a more useful abstraction we can come up for handling
> this situation.
> 
> Reading your (and others') responses, it seems like there are two
> things:
> 
>   1. Stashing is about saying "save everything about where I am now with
>      no hassle". IOW, it's one command, you don't have to decide what
>      goes and what stays, and you can pull it back out with one command.
>      And maybe there is a psychological component that you are not ready
>      to "commit" such a work-in-progress (I am extrapolating here, but I
>      know that when I first started with git, I was hesitant to commit
>      because of my experience with other systems).
[...]

There is one thing that is easy to do with a stash (due to the way it
is implemented, even if it complicates it a bit), and you CANNOT do
(without much hassle) with branches, namely saving state where _index_
state matters, either partial commit (or just added files), or
conflict resolve in progress.

I'm not sure how useful such a thing can be after a month, but if
project has slow rate of development (and developer can deal with such
"ahlfway" state decently when restored), it can happen...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
