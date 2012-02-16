From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Thu, 16 Feb 2012 14:22:23 +0100
Message-ID: <CAA01Csrj0FuV7OP3fCbp2QswM0u3Eph8ee6JBUd9TiyRmLZ_9Q@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<CACsJy8DBG2A91=ppCOC6Hf6aYM2soUXXdsY0GU9hr2xqjj4RYA@mail.gmail.com>
	<CAA01CsoW-32kOtD2g==2FDcYaxfSVD4Xdy1bYG_wJBWDNept4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 14:22:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry1I5-0005iL-HH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 14:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506Ab2BPNWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 08:22:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43434 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab2BPNWY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 08:22:24 -0500
Received: by iacb35 with SMTP id b35so2882627iac.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Wz2DowXd4sJJUfTPBMRPGlZLE7u87+Ifb0eXYvLHiF8=;
        b=Ghf+SYtnsrxyVNSyN8sE77pUeEQZBpWyZEFFemGwQE2HRnGarkS0Ptjj4lp/nmMV0T
         AoSlmlVKgE5EDdggp103YtGmDk05nTn3rfc0FX+pNMIhnBdEywpPrC/ok687VGl5sCrN
         XmO814Nw/xdZV4rf6jhzOvB7RVblfgQYGoQGM=
Received: by 10.50.203.100 with SMTP id kp4mr2926523igc.6.1329398543909; Thu,
 16 Feb 2012 05:22:23 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Thu, 16 Feb 2012 05:22:23 -0800 (PST)
In-Reply-To: <CAA01CsoW-32kOtD2g==2FDcYaxfSVD4Xdy1bYG_wJBWDNept4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190892>

On Wed, Feb 15, 2012 at 4:14 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> On Wed, Feb 15, 2012 at 12:01 PM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
>> On Wed, Feb 15, 2012 at 3:57 PM, Piotr Krukowiecki
>> <piotr.krukowiecki@gmail.com> wrote:
>>> Indeed, after gc the times went down:
>>> 10s -> 2.3s (subdirectory)
>>> 17s -> 9.5s (whole repo)
>>>
>>> 2 seconds is much better and I'd say acceptable for me. But my ques=
tions are:
>>> - why is it so slow with not packed repo?
>>> - can it be faster without repacking?
>>
>> gc does more than just repacking. If you still have the un-gc'd repo=
,
>> Try these commands one by one, and time "git status" after each:
>>
>> =A0- git pack-refs --all --prune
>> =A0- git reflog expire --all
>> =A0- git repack -d -l
>> =A0- git prune --expire
>> =A0- git rerere gc
>
> It will take some time but hopefully I'll have the stats for tomorrow=
=2E

Here they are. I did 'status' three times to get reliable results and
before each run have dropped caches. Backed up repository was copied
before each 'status'. Full log is at http://pastebin.com/VmB7J9CJ

git version 1.7.9.rc0.10.gbeecc

Results after each command:

status on whole repo:
18.5s - after git count-objects -v
16.0s - after git pack-refs --all --prune
20.2s - after git reflog expire --all
13.0s - after git repack -d -l
16.8s - after git prune --expire now
19.7s - after git rerere gc

status on subdir:
9.7s - after git count-objects -v
9.2s - after git pack-refs --all --prune
9.3s - after git reflog expire --all
4.4s - after git repack -d -l
9.2s - after git prune --expire now
9.0s - after git rerere gc


--=20
Piotr Krukowiecki
