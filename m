From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Tue, 4 Oct 2005 14:31:40 +0200
Message-ID: <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 14:33:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMlxR-0001SR-Li
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 14:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVJDMbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 08:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJDMbm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 08:31:42 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:52203 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750871AbVJDMbm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 08:31:42 -0400
Received: by nproxy.gmail.com with SMTP id x37so234701nfc
        for <git@vger.kernel.org>; Tue, 04 Oct 2005 05:31:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IJhJIM3uP3kSpAwXnYDoQkjChucy+u6JOjGv8OLOEhcFbHg014Vrq90gqx4dncOcTANW9lgFtZ7pmyj1t1xAYYLHo3chbloHEhqXbHm6TRwm8eGWwH1Lih2Mb55jU6wR1QUiwy8abMtA9eQUh5e9n0A1p1Bf/aHo/YwRhITf7qM=
Received: by 10.48.226.17 with SMTP id y17mr285011nfg;
        Tue, 04 Oct 2005 05:31:40 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Tue, 4 Oct 2005 05:31:40 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433B3B10.5050407@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9675>

On 9/29/05, H. Peter Anvin <hpa@zytor.com> wrote:
> I have made a first cut at a git port to Cygwin.  It looks like the
> "git-diff-tree -p" problem has been resolved independently, or at least
> I can't reproduce it on a fresh Cygwin install (running on XP Home), but
> I have added support for running without the IPv6 and the getaddrinfo() API.
>
> There are still funnies.  In particular, Cygwin and Samba handle
> symlinks differently, so you can't trivially share a repository via
> Samba.  Linus' "symbolic refs" changes should eventually take care of that.

I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not remove the
target and returns an error (probably EPERM, but I have reasons not to trust
strerror on that thing).
The repository was on FAT.
Taking "rename(2)" from cygwin's libiberty solved this (they unlink if link(2)
returns EEXIST).

PS: Does broken rename(2) qualify a system "not worthy to support"?
