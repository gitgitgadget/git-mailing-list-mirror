From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 16:42:44 -0700
Message-ID: <7vodz980az.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 01:43:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT626-0000qU-DX
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 01:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDJXmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 19:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWDJXmy
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 19:42:54 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:5053 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932190AbWDJXmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 19:42:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410234245.PSWW25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 19:42:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18595>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 9 Apr 2006, Junio C Hamano wrote:
>>
>> And this makes "git log" to take common diff-tree options, so
>> that it can be used as "git whatchanged".
>
> I wonder... This all looks fine, but there are actually two different 
> "diffs" that can be shown for "git log --diff <pathlimiter>":
>
>  - the whole diff for a commit
>
>  - the path-limited diff
>
> and I think we'd likely want to have some way to select the output. 
> Probably with the path-limited diff being the default (that's what 
> "git-whatchanged" does), but perhaps with "--full-diff" showing the whole 
> commit diff (which is what "gitk" does).

Yes, but it turns out it is a bit tricky, given that the way
tree-diff.c is written it pretty much assumes the same pathspec
is used for diff operation during the lifetime of the process.

I think we should move (nr_paths, pathlens and paths) to struct
diff_options.  Two patches to follow shortly.
