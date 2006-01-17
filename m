From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-diff-files and fakeroot
Date: Tue, 17 Jan 2006 00:27:59 -0500
Message-ID: <20060117052758.GA22839@mythryan2.michonline.com>
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 06:29:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyjPJ-0000og-Vb
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 06:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWAQF3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 00:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWAQF3L
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 00:29:11 -0500
Received: from mail.autoweb.net ([198.172.237.26]:58839 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750722AbWAQF3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 00:29:09 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EyjP2-0001si-0G; Tue, 17 Jan 2006 00:29:09 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EyjP1-0004aS-2Q; Tue, 17 Jan 2006 00:29:07 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1EyjOS-0002Dd-Lh; Tue, 17 Jan 2006 00:28:32 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14775>

On Mon, Jan 16, 2006 at 06:36:39PM -0800, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > I've been trying to track down a strange issue with building kernels
> > (and scripts/setlocalversion) and finally realized the problem was the
> > when run under fakeroot, git-diff-files thinks everything is changed
> > (deleted, I believe)
> 
> BTW, Ryan, I suspect this is where you try to append "-dirty" to
> the version number.  But I wonder why you are doing the build
> under fakeroot to begin with?  Wasn't the SOP "build as
> yourself, install as root"?

That's exactly what started this search, because I was running
"make deb-pkg". (Effectively.)  dpkg-buildpackage wants to think it is
running as root, either via sudo or via fakeroot.  I had my build
environment switched over entirely to fakeroot, as it just seems to be a
better practice, but I've temporarily switched back to sudo.

However, your explanation has pointed out to me how I can solve this -
run "fakeroot -u" instead of "fakeroot", and I think it will be fixed.

lkml cc:ed to hopefully stick this in an archive where someone else will
find it.





-- 

Ryan Anderson
  sometimes Pug Majere
