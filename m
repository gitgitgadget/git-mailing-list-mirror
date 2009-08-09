From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v4 0/5] Re: {checkout,reset,stash} --patch
Date: Mon, 10 Aug 2009 00:26:58 +0200
Message-ID: <20090809222658.GB12932@vidovic>
References: <200907271210.40001.trast@student.ethz.ch> <200908091844.43107.trast@student.ethz.ch> <20090809212831.GA12932@vidovic> <200908092342.31733.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 10 00:27:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaGrC-0007cs-7g
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 00:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbZHIW1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbZHIW1E
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 18:27:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:13560 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZHIW1D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 18:27:03 -0400
Received: by ey-out-2122.google.com with SMTP id 9so794394eyd.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/ZiNTrKvOSOirQLZ6wpUK4Oo27DXIjI1ZSNXJDmEmoU=;
        b=D5PKeFoq2T9MFlOZV2mSCCz5vbU0Pa7e+IpwrCW5/vJvZxDUDkEXPI9prh3gljnF9f
         eRrBeK56QxNyDhbMCLND4Z94DgNgGQOdoUdWa+qsNFEmzBtxAnmPYR6BxGyEeBYCih4s
         8HXz+uOk3H2zxtc/bkr7s+ssnY7ica03Msn4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Glziy6RfUWUFTtQa1oq9ChnGM5q5fySm+j3TJaU6vTDS0V8APgsx1pG+2HzNyxJG0j
         AHRD954xdDimPIKzc42IpY6B1ep66T1g/xHbavXrzUfd8/tr1xoKSw6AUvrEFF55q1zh
         VFg8VzZYHoJoaF/QNcJrE0UNzhCYi01RCVzjU=
Received: by 10.210.13.12 with SMTP id 12mr4341296ebm.98.1249856822740;
        Sun, 09 Aug 2009 15:27:02 -0700 (PDT)
Received: from @ (91-165-128-55.rev.libertysurf.net [91.165.128.55])
        by mx.google.com with ESMTPS id 10sm9557940eyz.21.2009.08.09.15.27.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Aug 2009 15:27:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200908092342.31733.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125390>

The 09/08/09, Thomas Rast wrote:
> Nicolas Sebrecht wrote:
>
> Yes, you can, precisely as I wrote:
> 
> > > covered by 'git checkout -p HEAD'.

I did my tests including "HEAD" but only with "-- file" too...

> I figured this makes sense:
> 
>   git checkout -- file         # copy file from index to worktree
>   git checkout -p [file]       # copy hunks from index to worktree
>   git checkout HEAD -- file    # copy file from HEAD to index&worktree
>   git checkout -p HEAD -- file # copy hunks from HEAD to index&worktree

...and I don't have what's expected

  Current branch: my_branch (clean)
  nicolas@vidovic git % echo 'Hi Thomas' >> Documentation/SubmittingPatches
  Current branch: my_branch (dirty: working_tree)
  nicolas@vidovic git % git add Documentation/SubmittingPatches
  Current branch: my_branch (dirty: index)
  nicolas@vidovic git % git checkout -p HEAD -- Documentation/SubmittingPatches
  No changes.

where "checkout -p HEAD" works fine.

> Note that the patch application stage has no guarantees that what you
> picked will also apply to the index; it tries first, and if it
> doesn't, it asks if it should apply to the worktree anyway (and leave
> the index unchanged).

Ok. All of what you say above makes sense and I'm actually fine with
your whole answer. That said,

  % git checkout -p HEAD

and

  % git checkout -p HEAD -- file

behave differently here in my test above.

-- 
Nicolas Sebrecht
