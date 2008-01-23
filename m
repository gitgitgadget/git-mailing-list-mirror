From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 16:01:18 +0200
Message-ID: <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 23 15:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHgAw-0000oO-FZ
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 15:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYAWOB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 09:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbYAWOB2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 09:01:28 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:2400 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYAWOB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 09:01:27 -0500
Received: by mu-out-0910.google.com with SMTP id i10so8103283mue.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Jb+rRg89Axh7IbSkj/YZ4TPK6VmwNIvN4aclWrlCokI=;
        b=Zam1n/0UsP8Dv3Hpc1nmi+HPaSEpvuWQ1g2LuecHGdjcDaLwOStMhx3FT5dyAtbTBFWsiGWMetj4HJiWWhG7Bu8J06TD/2CVdMFtavJ5JjbALzeeErUS0kP1xtkpHXd/yek9PxbX9vdtQbTGtc7gmgihZ3nVG1xVQ1i/dCPvXWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tq4UrYDQmrk4ihMyeZ6/gi1gC+gLThyqbfq4yNtYlvKMWN5KRLoULGkFTopak6RJlh9sUxpMEk8KiqCTuw7twxaPUaCeP0CVpqeCaPdNoRZusOV+AscomqRjIHrXtkoTjKtPGbzpH9R+UvIj6/g8hX76MQDHBze7A9nE4gzZVuA=
Received: by 10.78.147.6 with SMTP id u6mr13170754hud.78.1201096878616;
        Wed, 23 Jan 2008 06:01:18 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Wed, 23 Jan 2008 06:01:18 -0800 (PST)
In-Reply-To: <4797095F.9020602@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71541>

On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
> Dmitry Potapov wrote:
> > On Wed, Jan 23, 2008 at 09:32:54AM +0100, Andreas Ericsson wrote:
> >> The FNV hash would be better (pasted below), but I doubt
> >> anyone will ever care, and there will be larger differences
> >> between architectures with this one than the lt_git hash (well,
> >> a function's gotta have a name).
> >
> > Actually, Bob Jenkins' lookup3 hash is twice faster in my tests
> > than FNV, and also it is much less likely to have any collision.
> >
>
> >From http://burtleburtle.net/bob/hash/doobs.html
> ---
> FNV Hash
>
> I need to fill this in. Search the web for FNV hash. It's faster than my hash on Intel (because Intel has fast multiplication), but slower on most other platforms. Preliminary tests suggested it has decent distributions.

I suspect that this paragraph was about comparison with lookup2
(not lookup3) because lookup3 beat easily all the "simple" hashes
in my testing.  Only competitor was Hsieh one which was like 50:50
faster or slower depending on alignment / compiler / cpu.

> ---
>
> My tests ran on Intel. I also noticed I had a few hashes commented out when
> doing the test, one of them being Paul Hsie's. For some reason, Jenkin's and
> Hsie's didn't perform well for me last time I used the comparison thing (I
> did a more thorough job back then, with tests running for several minutes
> per hash and table-size, so I commented out the poor candidates).
>
> I still believe that for this very simple case, the lookup3.c case is not
> very practical, as the code is that much more complicated, which was my
> main point with posting the comparison. Iow, not "switch to this hash,
> because it's better", but rather "the hash is not as bad as you think and
> will probably work well for all practical purposes".


If you don't mind few percent speed penalty compared to Jenkings
own optimized version, you can use my simplified version:

  http://repo.or.cz/w/pgbouncer.git?a=blob;f=src/hash.c;h=5c9a73639ad098c296c0be562c34573189f3e083;hb=HEAD

It works always with "native" endianess, unlike Jenkins fixed-endian
hashlittle() / hashbig().  It may or may not matter if you plan
to write values on disk.

Speed-wise it may be 10-30% slower worst case (in my case sparc-classic
with unaligned data), but on x86, lucky gcc version and maybe
also memcpy() hack seen in system.h, it tends to be ~10% faster,
especially as it does always 4byte read in main loop.

-- 
marko
