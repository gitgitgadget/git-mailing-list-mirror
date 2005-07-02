From: Tony Luck <tony.luck@gmail.com>
Subject: Re: "git-send-pack"
Date: Sat, 2 Jul 2005 10:44:47 -0700
Message-ID: <12c511ca05070210441c0d3a33@mail.gmail.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
	 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org>
	 <42C482ED.1010306@zytor.com>
	 <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>
	 <42C5D553.80905@timesys.com>
	 <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org>
	 <42C61351.10306@zytor.com>
	 <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org>
	 <42C61818.30109@zytor.com>
	 <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 19:47:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dom4w-00031N-Ry
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 19:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVGBRqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGBRqO
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 13:46:14 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:34420 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbVGBRor convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 13:44:47 -0400
Received: by zproxy.gmail.com with SMTP id i11so267412nzh
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 10:44:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f+RI2FEsaIAPNr4djhZ8xb5DU5KFvuOUl6qlWMuBsye1XzBxbpkFxQjqvtLrbgXChOrcSpvLYaY3q4PS5n1YXszmQ96vsakEZqN9p6mvz9e6aj+UrFIYYIOcQyaC/fdgCNVvcmhX1Fiz6mmyA6Knq0taveJnuB+v5B+Ly7q+D7I=
Received: by 10.36.222.38 with SMTP id u38mr1126707nzg;
        Sat, 02 Jul 2005 10:44:47 -0700 (PDT)
Received: by 10.36.59.4 with HTTP; Sat, 2 Jul 2005 10:44:47 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's another approach.

Teach the variants of git-pull to look for a file that names an
alternate repository
that should be used to get any object that is referenced in the repository, but
doesn't exist in it.

At least part of the problem for kernel.org is that there around 50 repositories
that are tracking the 2.6 kernel.  All of them have 50,000 objects that are
duplicates of each other ... and a few hundred 'unique' objects that belong
to just one repo, or are minimally shared.

If there was a way to specify an alternate repo, then a large GIT server like
kernel.org could set up a "git-history"[1] repo which each of the hosted repos
could point to.  Then a cron job could look for duplicates, and move them
off to the history area.

-Tony

[1] Different projects, like git and sparse, might never have any common
files with the Linux kernel ... but they can all share the same history.
