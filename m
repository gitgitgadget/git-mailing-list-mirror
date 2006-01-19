From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 11:42:46 +0100
Message-ID: <81b0412b0601190242m4792e73bg181172e478b6e0c2@mail.gmail.com>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
	 <20060119052914.GC8121@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 11:43:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzXFl-0007Qq-JY
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 11:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWASKmt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 05:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWASKmt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 05:42:49 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:46180 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161155AbWASKms convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 05:42:48 -0500
Received: by uproxy.gmail.com with SMTP id s2so169855uge
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 02:42:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LbiXJxqp9cortFoOWGVrPMdoTYf6fJXTrC9Wt3xAkZGYLy3HHJVVPihX7E74OqrAV+p169bkpVru8/QpIw9KdRAVzsowBMor+Qx/McVbNXRtanjpxXB1M76/VwjE2lwakfhM6HXgaUtGiiktP1m8GY9FVTixDgjPW75aVBejWvc=
Received: by 10.49.22.15 with SMTP id z15mr29345nfi;
        Thu, 19 Jan 2006 02:42:46 -0800 (PST)
Received: by 10.49.14.20 with HTTP; Thu, 19 Jan 2006 02:42:46 -0800 (PST)
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20060119052914.GC8121@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14896>

On 1/19/06, Christopher Faylor <me@cgf.cx> wrote:
> "They" probably don't like it when people treat an open source project as
> if it was some unresponsive proprietary enterprise which does not listen
> to or accept patches.

Please, accept my appologies for the sarcasm in the original post.
Sometimes I get an impression of cygwin being not maintained at
all, and that, if not justifies my behavior, but at least is an attempt
to explain it.

> >And on top of that, they removed dirent->d_ino (or probably replaced it
> >by __ino32, if at all).  BTW, can we somehow avoid using d_ino?  It is
> >referenced only in fsck-objects.c Anyway, to workaround this I put
> >
> >COMPAT_CFLAGS += -Dd_ino=__ino32
> >
> >It helps, but surely is not the solution.
>
> I don't see how it could help since __ino32 is not actually filled in
> with anything.  In fact, I'll rename the field to __invalid_ino32 to
> make that clear.

But why keep the DT_-macros?! And why there is two fields
hinting at d_ino, and why there is 3 (!) "struct dirent"
definitions in dirent.h (sys/dirent.h)?
Some with different names (d_reserved?).
And if cygwin is aiming for posix, what would d_fd or d_version
be (Open Group Specs v6[1] mention only d_ino and d_name)?

[1] http://www.opengroup.org/onlinepubs/009695399/basedefs/dirent.h.html
