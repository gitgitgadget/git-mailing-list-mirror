From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 22:03:34 +0200
Message-ID: <20050508200334.GG9495@pasky.ji.cz>
References: <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz> <1115574035.9031.145.camel@pegasus> <20050508175156.GA9495@pasky.ji.cz> <1115578658.8949.9.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:01:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrvl-0007IM-Bh
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVEHUFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVEHUEm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:04:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:733 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262779AbVEHUDj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 16:03:39 -0400
Received: (qmail 20247 invoked by uid 2001); 8 May 2005 20:03:34 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115578658.8949.9.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 08:57:38PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hello,

> look at the attached patch. We should use "fmt -s" to keep newlines that
> are inside the commit message and there is one unneeded empty CG: line.

thanks, fixed and pushed out.

> I also put back in the "mess", because if there is no commit message
> provided via -m it gives us an initial empty line to start in. This is
> the same that CVS does and it makes the life inside vi a lot more
> easier.

Well, I use 'O' to start editing. ;-) (Actually, I use the -m arguments
extensively; the way it is now is how I always dreamt of it since I
started using SCMs. Possibly in conjuction with -e to add some fancy
stuff.)

Your way might be cunning, fast, or even clever, but it was certainly
not clear, therefore not maintainable well. I tried to implement it in a
simpler and more clear way. Does it behave as you want now?

> > > If you want the extra newline(s) then it is a good idea to add something
> > > that strips heading and trailing empty lines from the final commit
> > > message, because otherwise it will be ugly if you don't enter extra text
> > > for the merge.
> > 
> > Isn't that what I initially suggested? :-)
> 
> But this hasn't been done so far. And I don't know any shell tool for
> this job, beside some crazy awk or sed stuff. However stripspace.c from
> git-tools can do this job.

#/bin/sh

leading=1
emptylines=0
while read line; do
        if ! [ "$line" ]; then
		[ "$leading" ] && continue
		emptylines=$(($emptylines + 1))
        else
		leading=0
                while [ $emptylines -gt 0 ]; do
                        echo ""
                        emptylines=$(($emptylines - 1))
                done
                echo $line
        fi
done

or something? (Based on someone else's script since I was too lazy. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
