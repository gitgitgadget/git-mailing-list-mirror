From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Tue, 6 Dec 2005 08:15:16 +0100
Message-ID: <81b0412b0512052315p1917a04ek264c14abf41a1027@mail.gmail.com>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	 <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	 <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	 <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	 <20051205215059.GC4443@steel.home>
	 <7vr78r9pg0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 08:16:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjX2n-0003jN-IY
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 08:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLFHPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 02:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVLFHPS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 02:15:18 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:238 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbVLFHPR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 02:15:17 -0500
Received: by nproxy.gmail.com with SMTP id x29so96506nfb
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 23:15:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YKSulXtBuo0mDs9RTdhqQZPJNs/cOZej0a5WYn7yyLdY9RoeyJzvIG7ucz8IxlS82Yhm4MMG+KOqWo63WAtQeVFQ9CU74+Bm4hhSB6m7YMZThTAtpDd2bP7LQKfyJihDJEnvrz4qxFNT+0EpyInCFsAkZN6b/WFmoDjBBa0gG0A=
Received: by 10.48.212.20 with SMTP id k20mr25272nfg;
        Mon, 05 Dec 2005 23:15:16 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 5 Dec 2005 23:15:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr78r9pg0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13259>

On 12/5/05, Junio C Hamano <junkio@cox.net> wrote:
> >> This attempts to clean up the way various compatibility
> >> functions are defined and used.
> >> --- a/compat/mmap.c
> >> +++ b/compat/mmap.c
> >
> > I still think that compat functions should stand alone.
> > Especially if it does not costs us much (or even less than that).
> Sorry, you lost me.  What do you mean by "standing alone"?

Do not depend nor use anything from the calling code (do not take
anything from git). If it has to serve as compatibility wrapper to
mmap, it better should be mmap(2): return MAP_FAILED if error, do not
exit process, do no output. I wouldn't expect open(2) to print "File
not found", would you?

Besides, MAP_FAILED is perfectly handled in calling layers. If they
even print out errno, the case is completely covered and simplier
handled.
