From: Michael Poole <mdpoole@troilus.org>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sun, 04 Apr 2010 10:50:47 -0400
Message-ID: <87zl1js248.fsf@troilus.org>
References: <201004030005.35737.elendil@planet.nl>
	<p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
	<201004040123.06877.elendil@planet.nl> <87oci0m5v4.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>, Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 16:59:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyRHw-0003f2-MJ
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 16:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0DDO64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 10:58:56 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34933 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754417Ab0DDO6y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 10:58:54 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Apr 2010 10:58:54 EDT
Received: from source ([209.85.212.47]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS7ipLfCeaJniuMh+zzZKhpxC3YO834Hn@postini.com; Sun, 04 Apr 2010 07:58:54 PDT
Received: by mail-vw0-f47.google.com with SMTP id 11so39147vws.20
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 07:58:53 -0700 (PDT)
Received: by 10.220.60.137 with SMTP id p9mr2034824vch.180.1270392650605;
        Sun, 04 Apr 2010 07:50:50 -0700 (PDT)
Received: from graviton.troilus.org (pool-72-83-66-147.washdc.east.verizon.net [72.83.66.147])
        by mx.google.com with ESMTPS id 21sm56878313vws.2.2010.04.04.07.50.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Apr 2010 07:50:49 -0700 (PDT)
In-Reply-To: <87oci0m5v4.fsf@catnip.gol.com> (Miles Bader's message of "Sun,
	04 Apr 2010 09:14:07 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143930>

Miles Bader writes:

> Frans Pop <elendil@planet.nl> writes:
>>> > I haven't had the patience to let it finish
>>>
>>> There's your problem.
>>
>> Yes, I had seen that. But there's a difference between taking much more 
>> time and slowing down to such an extend that it never finishes.
>>
>> I've tried it today on my linux-2.6 repo as well and the same thing 
>> happened. At first the progress is not fast but reasonable. When it gets 
>> to about 45% percent it starts slowing down a lot: from ~1500 objects per 
>> update of the counters to ~300 objects per update. And who knows what the 
>> progress is going to be when it reaches 70% or 90%: 10 per update?
>
> Are you sure it doesn't subsequently speed up again?

I have seen asymptotic slowdown as "git gc --aggressive" progresses on
certain repositories.  It is particularly bad with
git://git.infradead.org/gcc.git (on an x86-64 system with 4 GB RAM).
git seemed to be thrashing swap badly as time went on.  I don't know
that git gc --aggressive would *never* finish on my gcc-git repository.
I just know that it got to about 80% done in less than an hour, to 90%
after twelve hours, and about 94% after another twelve hours.  (The same
operation on linux-2.6.git takes about 40 minutes with all the default
settings.)

I may have been dreaming, but I thought with some 1.6.x version of git,
reducing core.packedGitLimit and pack.windowLimit (now windowMemory?)
mostly made the thrashing go away.  When I try again with v1.7.0.2,
though, it doesn't seem to help very much -- there is still a lot of
swapping, and the git process got to about 7 GB virtual size before I
killed it after about 10 hours of operation.

Michael Poole
