From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Best way to optimize a git repository?
Date: Sat, 3 May 2008 12:02:35 +0200
Message-ID: <20080503100235.GA16989@cuci.nl>
References: <2729632a0805021734h72196639x8789a00ce9be4059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat May 03 12:03:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsEaT-0004dg-EL
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 12:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761135AbYECKCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 06:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760899AbYECKCh
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 06:02:37 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:48095 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758637AbYECKCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 06:02:37 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 3CB255461; Sat,  3 May 2008 12:02:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2729632a0805021734h72196639x8789a00ce9be4059@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81065>

skillzero@gmail.com wrote:
>I want to periodically optimize my repositories even if it takes a
>long time to run the command. Should I do 'git gc --aggressive', 'git

>I also read somewhere (but can't find now) that some of these commands
>shouldn't be run while other people might be accessing the repository.

Caveat emptor, indeed.

I have in my /etc/gitconfig the following:

[repack]
   UseDeltaBaseOffset = true
[pack]
   compression = 9
[alias]
   packall = !rm -rf .git/ORIG_HEAD .git/FETCH_HEAD .git/index .git/logs .git/info/refs .git/objects/pack/pack-*.keep .git/refs/original .git/refs/patches .git/patches && git prune --expire now && git repack -a -d --window=200 && git gc

A subsequent "git packall" does the trick, but this is best done on an
otherwise idle repository.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
"What do I do when I see someone *extremely gorgeous*?
 I stare, I smile, and when I get tired... I put the mirror down."
