From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 23:06:07 -0500
Message-ID: <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
	 <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
	 <1196995353.22471.20.camel@brick>
	 <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Harvey Harrison" <harvey.harrison@gmail.com>,
	"Daniel Berlin" <dberlin@dberlin.org>,
	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 05:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0UU0-0000A0-7F
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 05:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbXLGEGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 23:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbXLGEGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 23:06:09 -0500
Received: from ro-out-1112.google.com ([72.14.202.182]:44020 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbXLGEGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 23:06:08 -0500
Received: by ro-out-1112.google.com with SMTP id p4so6956107roc
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 20:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k9qY68wel79gdy5HhVvAczuP/JugkYDpcQaxYlqspGo=;
        b=h/EhuKUNZNrBXFLlUD3r1RFxxG7vEZKOdHsVHcdC2yoAIe8vCITkjlZEqv6VnoMEY248Tbn3uMMC2x/3jU/BLtE0PNjPEfiYb+4wcfXx1c5PW5celwlp6fdHg9y9m3jqydhfQbwrRa0fdcYyqVt0u/jKIU6AUPM4ihzhtTUidbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ueLNq8AeN1hIRIqO1kNs8qRH5L4QGq4GbM95akgOC0sdD76emherZ/a101ud/i4dBPfnjZmJ2ZsCz46JOyHA0MuY6+xWhrMK6TCIjTwfeo2zoi7HTgDd2EgjvS3HfxTXko8KR+O1LaxHSfwXtLzqCsjPsJrztbR4tapoOiGEKks=
Received: by 10.115.88.1 with SMTP id q1mr2642862wal.1197000367222;
        Thu, 06 Dec 2007 20:06:07 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Thu, 6 Dec 2007 20:06:07 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67375>

On 12/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 Dec 2007, Harvey Harrison wrote:
> >
> > I've updated the public mirror repo with the very-packed version.
>
> Side note: it might be interesting to compare timings for
> history-intensive stuff with and without this kind of very-packed
> situation.
>
> The very density of a smaller pack-file might be enough to overcome the
> downsides (more CPU time to apply longer delta-chains), but regardless,
> real numbers talks, bullshit walks. So wouldn't it be nice to have real
> numbers?
>
> One easy way to get real numbers for history would be to just time some
> reasonably costly operation that uses lots of history. Ie just do a
>
>         time git blame -C gcc/regclass.c > /dev/null
>
> and see if the deeper delta chains are very expensive.

jonsmirl@terra:/video/gcc$ time git blame -C gcc/regclass.c > /dev/null

real    1m21.967s
user    1m21.329s
sys     0m0.640s

The Mozilla repo is at least 50% larger than the gcc one. It took me
23 minutes to repack the gcc one on my $800 Dell. The trick to this is
lots of RAM and 64b. There is little disk IO during the compression
phase, everything is cached.

I have a 4.8GB git process with 4GB of physical memory. Everything
started slowing down a lot when the process got that big. Does git
really need 4.8GB to repack? I could only keep 3.4GB resident. Luckily
this happen at 95% completion. With 8GB of memory you should be able
to do this repack in under 20 minutes.

jonsmirl@terra:/video/gcc$ time git repack -a -d -f --depth=250 --window=250
real    22m54.380s
user    69m18.948s
sys     0m23.773s


> (Yeah, the above is pretty much designed to be the worst possible case for
> this kind of aggressive history packing, but I don't know if that choice
> of file to try to annotate is a good choice or not. I suspect that "git
> blame -C" with a CVS import is just horrid, because CVS commits tend to be
> pretty big and nasty and not as localized as we've tried to make things in
> the kernel, so doing the code copy detection is probably horrendously
> expensive)
>
>                         Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
