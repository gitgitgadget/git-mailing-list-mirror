From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Adding gitweb.owner, last shot
Date: Fri, 08 Feb 2008 02:34:55 -0800 (PST)
Message-ID: <m3abmb4tyx.fsf@localhost.localdomain>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bruno Ribas <ribas@c3sl.ufpr.br>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQa8-0006Hq-Ix
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbYBHKfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933915AbYBHKfA
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:35:00 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:15537 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977AbYBHKe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:34:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so360756wah.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=vrJEKwiR5iZEZutU8NoemcCbCenGjb0RFIuI8cipuCM=;
        b=B14LSCgRHJKNB10rhbn8N/2v9V6S92jz8xwEGjuyY2JJKNl0TbX2zfOnVynVcxX6Ektjt0Q0/RVw2X/rp5v4Fuf6/Ev/X4tywAD6Qqxu8vFXfq+zN+V2I9QuC/pu7aBqZ2mvyERzSHhEXYSpx1RSCYFJcNvPXIMqgqutbpbzd6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=ZAVbPkSrBBasNf1HVSoiQhHXMqHAMJVwTq1u0kXTA3Y3BPFrokzFtl0xxzuSmCjaS6elrbQEDXuqjMQg4Wb14J/Tih1U226/3WYOqLfrryobNasSM51wsvrZxOYjWtZjOmKpm4oLMkUw9fvD6hsOBqv1pyYB0bHYm/hK8kaUbEA=
Received: by 10.115.49.16 with SMTP id b16mr6407263wak.65.1202466897719;
        Fri, 08 Feb 2008 02:34:57 -0800 (PST)
Received: from localhost.localdomain ( [83.8.242.186])
        by mx.google.com with ESMTPS id g17sm31360201nfd.10.2008.02.08.02.34.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 02:34:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m18AYo5F027260;
	Fri, 8 Feb 2008 11:34:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m18AYkYQ027257;
	Fri, 8 Feb 2008 11:34:46 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73070>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> After some study about the insertion of a new repository configuration,
> which sets repository owner, it was decided by the group that creating
> another small file inside .git/ is not a good idea. So I started to bench
> the viability to add just the gitweb.owner configuration, using gitweb.owner
> together with gitweb.description there is no major performance downgrade
> compared to $projects_list , as seen below:
> 
> 8<-------
> These times i got with a 1000projects running 2 dd to generate disk IO.
> Here comes the resultm
> NO projects_list  projects_list
> 16m30s69          15m10s74       default gitweb, using FS's owner
> 16m07s40          15m24s34       patched to get gitweb.owner
> 16m37s76          15m59s32       same above, but without gitweb.owner
> 
> Now results for a 1000projects on an idle machine.
> NO projects_list  projects_list
> 1m19s08           1m09s55       default gitweb, using FS's owner
> 1m17s58           1m09s55       patched to get gitweb.owner
> 1m18s49           1m08s96       same above, but without gitweb.owner
> 8<-------

It looks like there is almost no difference between using only FS
owner, and reading also repository config using "git config -z -l"...
Could anyone using gitweb on MS Windows or MacOS X, where fork is mich
slower, check those figures?

Pasky, could you please try to benchmark this (well, at least without
gitweb.owner set) on a _real_ large set of repositories?
 
> The idea of creating only the gitweb.owner can be a case of study to
> centralize all gitweb repository configuration in one file. Maybe even
> change the way $projects_list is formated, as gitweb.cgi needs to check
> repository configuration to get repository description to generate
> project_list page, we could just list repository's directories.

I was thinking about git-config-like format (but simplified to make it
easy to parse it in Perl, just like git-cvsserver configuration), in
the form of

[gitweb "<repository path, relative to $projectroot>"]
        description = <project description>
        url = <first URL>
        url = <seconf URL>
        owner = <repository owner>

The problem with parsing lies (among others) in the in-line comments,
novalue keys, and key after section, I think...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
