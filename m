From: Marc Singer <elf@buici.com>
Subject: Re: git clone rsync:... ?
Date: Mon, 11 Jul 2005 15:21:12 -0700
Message-ID: <20050711222112.GA21248@buici.com>
References: <20050711213050.GA18693@buici.com> <7v4qb1ouwk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:31:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds6lA-0006AD-DN
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 00:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVGKWZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVGKWXl
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 18:23:41 -0400
Received: from florence.buici.com ([206.124.142.26]:13463 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262941AbVGKWVN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 18:21:13 -0400
Received: (qmail 21569 invoked by uid 1000); 11 Jul 2005 22:21:12 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4qb1ouwk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2005 at 03:11:23PM -0700, Junio C Hamano wrote:
> Marc Singer <elf@buici.com> writes:
> 
> >   elf@florence /git > git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> >   defaulting to local storage area
> >   ssh: rsync: Name or service not known
> >   fatal: unexpected EOF
> 
> Hmph.  "git clone rsync://rsync.kernel.org/pub/scm/git/git.git git.git"
> seems to work so does the exact command you show above.  Is it
> possible that you are running git-clone-script from an older Git?

What I've been doing is pulling the cogito source, this time directly
from the net accessible repo, building it, and then copying the
binaries to a special directory I added to my path

  elf@florence ~...git/bin > cat git-clone-script
  #!/bin/sh
  repo="$1"
  dir="$2"
  mkdir "$dir" && cd "$dir" && git-init-db && git-clone-pack "$repo"

What more could I need?

> 
> > Moreover, I'd like to be able to
> > keep one repo that is just pulling from the net and then clone it for
> > different working directories.
> 
> That is a sane thing to ask.  Assuming you have solved the above
> problem:
> 
>     $ ls
>     linux-2.6
>     $ git clone -l linux-2.6 linux-ms
>     $ git clone -l linux-2.6 linux-ms-net
>     $ git clone -l linux-2.6 linux-ms-ide
>     $ git clone -l linux-2.6 linux-ms-usb
> 
> would make local clones of vanilla linux-2.6 repo you locally
> have ("-l" knows to use hardlinks when possible).

That, too, has been failing.  I think for some different reason.

  elf@florence ~/z/embedded > git clone -l linux-2.6 linux-2.6-cloned
  mkdir: cannot create directory `linux-2.6': File exists

Looks like something's borked.
