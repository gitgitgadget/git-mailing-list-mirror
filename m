From: John Keeping <john@keeping.me.uk>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 2 Jul 2013 10:19:36 +0100
Message-ID: <20130702091936.GA9161@serenity.lan>
References: <20130524012324.295dec77@hugo.daonet.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utwkb-00012h-56
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab3GBJTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:19:48 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:42811 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268Ab3GBJTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:19:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2817ACDA5B4;
	Tue,  2 Jul 2013 10:19:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G-fOfIqK5I5d; Tue,  2 Jul 2013 10:19:45 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BCEA4CDA5DA;
	Tue,  2 Jul 2013 10:19:41 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130524012324.295dec77@hugo.daonet.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229384>

On Fri, May 24, 2013 at 01:23:24AM +0200, Alois Mahdal wrote:
> Hello!
> 
> This [has been reported][1] to this list about half a year ago
> but with no response so I'm  not even sure if it's been
> acknowledged as bug.
> 
>   [1]: http://marc.info/?l=git&m=135215709307126&q=raw
> 
> When I use `git log --follow file` all is OK, but once I add
> `--reverse` to it, it no longer follows the file beyond renames.
> 
> This makes it hard to query for when the file was really added,
> which I was trying to achieve with
> 
>     $ git -1 --reverse --follow several_times_renamed_file

In my testing it actually seems to be worse than that.  In git.git:

    $ git log --oneline builtin/clone.c | wc -l
    99
    $ git log --oneline --reverse builtin/clone.c | wc -l
    99
    $ git log --oneline --follow builtin/clone.c | wc -l
    125
    $ git log --oneline --follow --reverse builtin/clone.c | wc -l
    3

So the combination of --reverse and --follow appears to have lost the
majority of the commits!
