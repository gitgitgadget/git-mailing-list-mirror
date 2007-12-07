From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:43:58 -0500
Message-ID: <9e4733910712071343k2d88d2fck1fa3fa333258e8e3@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <20071207213928.GA11613@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0l0D-00052Y-3R
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbXLGVoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbXLGVoB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:44:01 -0500
Received: from ro-out-1112.google.com ([72.14.202.176]:59213 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029AbXLGVn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:43:59 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7320235roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3iBh8Z/uy7jU16SV9txVfyv1m9OxpCXPYLrC8Eis3VQ=;
        b=TqKE6Sl2mNrDEzr/t57wi1Xea1G1L0pJCiG8XjacqrPVJhT+vZr9CFz4lsuhc9mlwAq5hrOEivW7GNJerrBg0INKum1QHsFh7VImqaBthdcwxjqFwD3ABDxqCJuG14TvV3QctsMS7+GVLTcHSkuZATVbFH7Q6VfjsFl51pt37EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=weD+I1yVsMrj4kauwpTUg8O+wMRL9as9QFzu/Gbo1gLygBGQee/EQsOJIqQQ8L0atuZ8pm182KR3TnhZsOTyWuRxAWpugp+Un5MURtuND89EXEeYtUuI0jWsu7WOeuEPtEa6zVUD7uaK2WuqVKpKxyKzBQJgaCYgCMf29/uWUeg=
Received: by 10.114.190.6 with SMTP id n6mr3815511waf.1197063838691;
        Fri, 07 Dec 2007 13:43:58 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 13:43:58 -0800 (PST)
In-Reply-To: <20071207213928.GA11613@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67472>

On 12/7/07, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 07, 2007 at 03:07:05PM -0500, Jon Smirl wrote:
>
> > I noticed two things when doing a repack of the gcc repo. First is
> > that the git process is getting to be way too big. Turning off the
> > delta caches had minimal impact. Why does the process still grow to
> > 4.8GB?
> >
> > Putting this in perspective, this is a 4.8GB process constructing a
> > 330MB file. Something isn't right. Memory leak or inefficient data
> > structure?
>
> Keep in mind that you are trying many different deltas, which are being
> held in memory, to find the right one and generate the 330MB file. And
> when you multiply that times N threads going at once, _each one_ is
> using a bunch of memory.
>
> As Nico suggested, you could probably drop the memory usage by reducing
> the size of the delta cache.

Delta cache is disabled --

pack.deltacachelimit = 0

Unless this option is broken?

>
> -Peff
>


-- 
Jon Smirl
jonsmirl@gmail.com
