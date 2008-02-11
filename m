From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Suggestion: git status --untracked
Date: Mon, 11 Feb 2008 02:56:26 -0800 (PST)
Message-ID: <m3bq6ng3sb.fsf@localhost.localdomain>
References: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:57:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWLR-0007l9-Gg
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbYBKK43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYBKK43
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:56:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:21113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbYBKK42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:56:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so255756ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=9L3gxMZPpG0yCsc3H0f3mpw8LH/q4R2ucCK22bsxAvs=;
        b=LmtVCjLJVgrcNcpDnd5Ind92Bo+1XMGwre9+QvOz08GC2iHJbw7hU9nY4eq4S5jRP8SAsX+dPYnrlyhN/7+Zt1INWvVDjgmpa/MP+w+8NafnRDHho1w4mFTy/Quu5cO8vopEijJ14Yemp3Ewc6ARtRXKkk7kjzjmS64hwixMuvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=nqLa0OR7BHTRyWeAjRzXeCn2a+0guTFgo81VcUjQJvMtoLY2UliUmyWlgZMZDERjGMX3lSEHX+m57HNtHZ+UyexqNc3J69l4PLc3nlsQWigpDuKDeNiSUWInzIL+GnJhoLcjZOlXvTrl2YbgFJJyZml8uMAwE+ccUAKwkzhyCp4=
Received: by 10.67.115.10 with SMTP id s10mr469925ugm.89.1202727387395;
        Mon, 11 Feb 2008 02:56:27 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.19])
        by mx.google.com with ESMTPS id j4sm1930305ugf.49.2008.02.11.02.56.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 02:56:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BAuL6v005129;
	Mon, 11 Feb 2008 11:56:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BAuKWW005126;
	Mon, 11 Feb 2008 11:56:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <b77c1dce0802110146o708e26a7lef56683f6b823365@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73513>

"Rafael Garcia-Suarez" <rgarciasuarez@gmail.com> writes:

> I find myself wanting sometimes to filter out the output of
> git-status, to feed it to another command (for example, git-add, or
> rm, or cat >> .gitignore). However it's not currently very easy to
> parse in a one-liner.

Probably because git-status is porcelain, and is meant to be used by
end user, not in scripts.
 
> I'm suggesting to add options to control this behaviour. My suggestion
> would be (for a start) to add an option --untracked that will list all
> untracked files on stdout, without a leading "#\t", and without
> listing the added / modified / removed files.
> 
> I'm willing to implement it, but I'd like to have some discussion
> about the interface first. Is that a good idea at all, and how could
> it be improved interface-wise?

To list all untracked files you can use plumbing command, namely
"git ls-files --others" (Show other files in the output), or perhaps
"git ls-files -o --directory --no-empty-directory --exclude-standard"

If you want to use git command in script, it is better to find
appropriate plumbing command to do what you want, for example
git-ls-files instead of git-status to list untracked files,
git-symbolic-ref instead of git-branch to get current branch name,
etc.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
