From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Problem with pack
Date: Fri, 25 Aug 2006 12:07:30 +0200
Organization: ARCES - =?ISO-8859-15?Q?Universit=E0_di_Bologna?=
Message-ID: <44EECBE2.7090801@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 12:07:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGYbB-0002fy-L9
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 12:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWHYKHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 06:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHYKHe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 06:07:34 -0400
Received: from arces.unibo.it ([137.204.143.6]:40092 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S1751435AbWHYKHd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 06:07:33 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7PAKKP1011089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:20:22 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_50,USER_IN_WHITELIST 
	autolearn=unavailable version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1728/Fri Aug 25 07:55:58 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25994>

>
> > git verify-pack -v pack-ebcdfbbda07e5a3e4136aa1f499990b35685bab4.idx
> > fatal: failed to read delta-pack base object 2849bd2bd8a76bbca37df2a4c8e8b990811d01a7
>
> Eeeh! Not good.
>
> > 1) I am working on both a pc and a notebook, syncing the two everytime I move
> > from one to the other.
>
> So, you still have one "good" version? Please make a backup immediately. 
> (If only to reproduce the problem.)
>   
I have a good working tree, but unfortunately I realized that there was 
a problem with the pack only _after_ the sync:
I was not expecting this kind of problem, so I silly did a repack as the 
last thing, I went home, I attached the laptop to the net, I run unison, 
I started to work and I realized that there was a problem when I 
attempted a new repack which failed complaining about the corrupted pack...

So actually, I do not even know where the corruption came from (an hd 
error, the sync tool, ...)

I only have the corrupted pack and its index and a good last working tree.

BTW, it would be nice to have some "security measure" in git reset... 
e.g. an option to trigger the following behavior:

- saving all current changes in a temporary commit
- checking that the current HEAD can be re-checked out before the reset

> Since unpack-objects does not use the index, it cannot extract anything 
> after the first error. We _could_ enhance unpack-objects to be nice and 
> optionally take a pack-index to try to reconstruct as many objects as 
> possible.
>   
That would be very useful...
Btw, even without that, if I understand correctly, git packs are 
collections of compressed objects, each of which has its own header 
stating how long is the compressed object itself. In my case, the error 
is in inflating one object (git unpack-objects says inflate returns 
-3)... so shouldn't there be a way to try to skip to the next object 
even in this case?
> BTW I'd recommend not syncing with unison, but with the git transports: If 
> your PC and Laptop are connected, you could do something like
>
> 	git pull laptop:my_project/.git
>   
Actually, the project, including the git archive gets syncronized as a 
part of a syncronization process including all my Documents directory 
(the project is in fact a LaTeX manual with somehow complex LaTeX 
packages and classes). Syncronizing in this way actually worked very 
well so far, because at once I was getting in sync all my working trees 
and all my repos...

Sergio
