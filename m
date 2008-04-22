From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch description
Date: Tue, 22 Apr 2008 11:59:16 -0700 (PDT)
Message-ID: <m33apdra0w.fsf@localhost.localdomain>
References: <alpine.DEB.1.10.0804221945060.3452@pollux.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:00:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNiw-0005Hp-HD
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 21:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbYDVS7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbYDVS7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:59:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:24466 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbYDVS7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 14:59:22 -0400
Received: by ug-out-1314.google.com with SMTP id z38so223343ugc.16
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=3K27jyIJiAXdzZtwpimCmmRb/TGvPgJLwRrd44dd1a8=;
        b=uHuLbvS+7WCoel/2B7Wrxmq5XpaBP/QG+WSmYIsXlpE+z5b14m5KvER3zd7+GiSV5uabZ5TGwD+PzqQS9M4RJHgmSFznbNP8gLQ1wnAFydvh42mX4VSuaevUoELCy1+AYQGrSWio3O7XI7k9+Mc7a42LDvmFD+zsuHJLlqXvwHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=eW90eBn3j3NO8WeOU5l/g5zKsgwRp3SheFBt+6xW0m/UxLMT8QhITrdkyq6rQqEpwYd0GPy12rgFDHE2YdbTtu5E/obwmx1xf+ZFLiFimmwpL02fPwAnwaJ7rtYS/pO/35WvVjiC/N/A/lT1h5LQgJPAzOZCIvb4m2Sxwi59KeU=
Received: by 10.66.243.2 with SMTP id q2mr7284403ugh.14.1208890760915;
        Tue, 22 Apr 2008 11:59:20 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.207])
        by mx.google.com with ESMTPS id j3sm177600ugd.6.2008.04.22.11.59.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 11:59:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3MIxDCO005964;
	Tue, 22 Apr 2008 20:59:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3MIxC83005960;
	Tue, 22 Apr 2008 20:59:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.10.0804221945060.3452@pollux.milkiway.cos>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80160>

Michael Dressel <MichaelTiloDressel@t-online.de> writes:

> On Friday 18 April 2008, Jakub Narebski wrote:

> > Let me sum up here proposals where to put branch description:
> >
> > [...]
> 
> what's the opinion of having a new branch object? Actually the tag
> object probably already does the job? This would spoil the elegant
> light weight current branch references. But tags are not that heavy.
> 
> In this approach the tags would not reference commits but tags. And
> tags have annotation. The difference to the normal tags would be that
> these tags are referenced from refs/heads/<branch> instead of
> refs/tags.
> 
> I have no clue how involved this change would become and if the
> benefit would justify the effort. I guess using proper objects for
> branches would only be justified if additional advantages could be
> achieved.

This won't work.  With described (annotated) branches, there are two
pieces of data associated with a branch:
 * commit it points to (branch head)
 * description of a branch

Branch head changes frequently (commit, reset, bisect, rebase), while
description should change rarely.  Those two pieces of data are
independent.  Tag object would unnecessary join/fuse those two
together.


Also, for exach commit on a branch, or for each moving of branch ref
(reset, amend, bisect), you would have to create tag object, which
would accumulate only to be garbage collected some time in the
future...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
