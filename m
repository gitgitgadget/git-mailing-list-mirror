From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 09:18:56 +1200
Message-ID: <46a038f90704171418p354cde19h8ab3c47eed36f04e@mail.gmail.com>
References: <200704171041.46176.andyparkins@gmail.com>
	 <200704171803.58940.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0704171107510.5473@woody.linux-foundation.org>
	 <200704172012.31280.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 23:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdv4n-0006o3-At
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030768AbXDQVS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030767AbXDQVS6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:18:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:59781 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030773AbXDQVS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 17:18:57 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2193636wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 14:18:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KU+DyBN+TOwVBgxfmNyhaWxETky4cazOKZWDUlJGfjdgHzIjiMvc8eSPQSORXwthAXqL5B8bzTdfDf/RoYtqaUqhGtOpJha4OrMvmbHCV+U6iWYT/oViX9Esd/TIaWQTdYmLSkso8JI2PrkwLWMpE86rGElMrbkHuXX23QsWSCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wf8z/vPTrKoPvWtDe6mTDoeUb1EAZFsd3DkyoElpJQivtEahWmPU88hdDrbEm3HPpG1BAlvVQDVtJzDXEwxBosShW9cyS37MvClBvVlWeX0olgY8JFo3N/whAvC+gRTYbfMNRr8WqleDZko/c8gOif0RmenZTDkNdsJ/foUy7lU=
Received: by 10.90.105.20 with SMTP id d20mr1233526agc.1176844736722;
        Tue, 17 Apr 2007 14:18:56 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Tue, 17 Apr 2007 14:18:56 -0700 (PDT)
In-Reply-To: <200704172012.31280.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44829>

On 4/18/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007, April 17, Linus Torvalds wrote:
> > So you will never work with anybody outside of git?
> For my projects - correct; I don't care about the rest of the world.
> For projects that do - don't enable keywords, it's an option, all I
> want is to have that option.

GIT's fundamental respect for the contents its tracking (in not
munging them with keyword expansion) means that it works great in
contexts where other SCMs tools are used. And being content-centric at
the SCM layer means that it is possible to track a git project with -
say - Mercurial (and vice-versa) with nothing more than a bit of perl
glue and no guessing at all. The content is the content is the
content.

When the SCM has "munge-the-content" options, your "upstream" can make
things completely un-trackable. Tracking CVS with git is a breeze but
there is breakage related to keyword expansion. I should write some
better heuristics for it, but it's impossible to know with 100%
certainty that you are doing the right thing, and getting the correct
content from CVS.

All this talk of breaking non-git-patch goes back to the same. With
the current design, projects that use git are easily trackable if you
just look at the content, and ignore the SCM. That's an outstanding
property and quite central to the design, and I wouldn't include an
option to "turn it off" even if the patch to implement it turns out to
be trivial.

Probably using make will help - you might be able to wire it to work
off a post-update-hook so it's completely transparent.

cheers,


martin
