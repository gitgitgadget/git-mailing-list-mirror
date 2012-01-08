From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Sun, 8 Jan 2012 16:01:27 -0600
Message-ID: <20120108220127.GA4050@burratino>
References: <20120108213134.GA18671@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk0j9-0002hl-Mk
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab2AHV40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:56:26 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47748 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2AHV4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:56:25 -0500
Received: by ggdk6 with SMTP id k6so1338564ggd.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WMhNpmMFn38jk0OJ8pWgWUuGfVDf/qH0Z/bwRQQvHr8=;
        b=YYW4HVisF0Bzmf+vaaYVumStA3am6RK92+++kaWHmXFH1l0nHlUBzMlTP1TGNCv7lV
         sGLI5vlN1vuoi1SgrG2X2QHwbKU9YsOJuyEacmrUwGa58oQV4dtxJGRagEEdfuKlyVTq
         IA0VV+3kPcoT07On83C0VsS0c5/3Bv0ebDjm8=
Received: by 10.236.144.227 with SMTP id n63mr17307185yhj.131.1326059785183;
        Sun, 08 Jan 2012 13:56:25 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a48sm62335093yhj.2.2012.01.08.13.56.23
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 13:56:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120108213134.GA18671@ecki.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188145>

Clemens Buchacher wrote:

> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -332,6 +332,15 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
>  	user edit that list before rebasing.  This mode can also be used to
>  	split commits (see SPLITTING COMMITS below).
>  
> +--fix=<n>::
> +	Searches commit history backwards from the current commit until the
> +	most recent merge commit, or until a maximum of <n> preceding commits
> +	(default: 20), and runs rebase -i <commit>^. The resulting range is
> +	typically large enough to contain recent commits which the user might
> +	want to edit, while avoiding the usually undesirable effects of
> +	rebasing a merge commit, which obviates the need to find a suitable
> +	base commit manually.

Funny. :)  I wonder if this is possible to generalize, to something like

	git rebase -i foo^{last-merge}

or even something like

	git rebase -i foo^{first:--merges}

(where "<commit>^{first:<rev-list args>}" would mean something like
"the first commit listed by "git rev-list <rev-list args> <commit>").
What do you think?
