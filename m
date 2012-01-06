From: Erik Blake <erik@icefield.yk.ca>
Subject: Re: Warning from AV software about kill.exe
Date: Fri, 06 Jan 2012 14:51:55 +0100
Message-ID: <4F06FC7B.5010206@icefield.yk.ca>
References: <4EF2E08C.3050502@icefield.yk.ca> <87mxalkn9q.fsf@thomas.inf.ethz.ch> <878vm4lb9q.fsf@fox.patthoyts.tk> <4F0418B1.5050403@icefield.yk.ca> <CABPQNSbd++dAOGu+5+WNMXzF6xtsdTpZq=xeXPbHwmxputXVRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 06 15:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjAqR-00052i-J5
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933237Ab2AFOcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:32:31 -0500
Received: from bosmailout03.eigbox.net ([66.96.188.3]:49284 "EHLO
	bosmailout03.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933195Ab2AFOca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:32:30 -0500
X-Greylist: delayed 2425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jan 2012 09:32:30 EST
Received: from bosmailscan21.eigbox.net ([10.20.15.21])
	by bosmailout03.eigbox.net with esmtp (Exim)
	id 1RjADE-00023D-4R
	for git@vger.kernel.org; Fri, 06 Jan 2012 08:52:04 -0500
Received: from bosimpout01.eigbox.net ([10.20.55.1])
	by bosmailscan21.eigbox.net with esmtp (Exim)
	id 1RjADD-0005Gk-6i; Fri, 06 Jan 2012 08:52:03 -0500
Received: from bosauthsmtp16.eigbox.net ([10.20.18.16])
	by bosimpout01.eigbox.net with NO UCE
	id JDs21i0280LoEWa01Ds29a; Fri, 06 Jan 2012 08:52:02 -0500
X-EN-OrigOutIP: 10.20.18.16
X-EN-IMPSID: JDs21i0280LoEWa01Ds29a
Received: from 243.130.251.212.customer.cdi.no ([212.251.130.243] helo=[192.168.0.197])
	by bosauthsmtp16.eigbox.net with esmtpa (Exim)
	id 1RjADC-0007YG-J0; Fri, 06 Jan 2012 08:52:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABPQNSbd++dAOGu+5+WNMXzF6xtsdTpZq=xeXPbHwmxputXVRA@mail.gmail.com>
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:fb4e807829017c6d805c060c7025d0c2
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 212.251.130.243
X-EN-OrigHost: 243.130.251.212.customer.cdi.no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188029>



On 2012-01-05 17:33, Erik Faye-Lund wrote:
> On Wed, Jan 4, 2012 at 10:15 AM, Erik Blake<erik@icefield.yk.ca>  wrote:
>> On 2011-12-22 19:19, Pat Thoyts wrote:
>>> Thomas Rast<trast@student.ethz.ch>    writes:
>>>> Erik Blake<erik@icefield.yk.ca>    writes:
>>>>
>>>>> I'm running git under Win7 64. As I selected "Repository|Visualize all
>>>>> branch history" in the git gui, my AV software (Trustport) trapped the
>>>>> bin\kill.exe program for "trying to modify system global settings
>>>>> (time, timezone, registry quota, etc.)"
>>>>>
>>>>> Does anyone know the details of this process and what it's function
>>>>> is? First time I've seen it, though I'm a relatively new user.
>>>> 'kill' is a standard unix utility that sends signals to processes, in
>>>> particular signals that cause the processes to exit or be killed
>>>> forcibly by the kernel, hence the name.  (I don't know how the windows
>>>> equivalent works under the hood, but presumably it's something similar.)
>>>>
>>>> git-gui and gitk use kill to terminate background worker processes that
>>>> are no longer needed because you closed the window their output would
>>>> have been displayed in, etc.
>>> You might try replacing the command in the tcl scripts with 'exec
>>> taskkill /f /pid $pid' and see if that avoids the error. taskkill is
>>> present on XP and above as part of the OS distribution so shouldn't
>>> suffer any AV complaints.
>>>
>> Another way to implement this (on Windows) would be for the git programs to
>> tag themselves with a mutex. Then the "kill" program can determine which git
>> programs are running and send them user-defined windows messages to shut
>> themselves down. Alternatively, you could send the programs the standard
>> windows WM_CLOSE message, but the OS or an AV program might still be
>> troubled by that behaviour.
>>
>> This is how we implement this type of behaviour in our windows programs. It
>> does not raise the ire of the OS or AV since you do not have one process
>> trying to shut down another. It also bypasses all issues with process
>> privileges etc.
>>
>> Erik
>>
> No thanks. A process is allowed to terminate another process on
> Windows (as long as they are running as the same user, and the access
> token has not been messed with). If your AV detects this and prevents
> it, then your AV is broken. Re-building a kind of cooperative process
> termination for that reason is not the way forward.
>
> But the problem might be that MSYS' kill does more than it's supposed
> to (or misbehaves in some other way). This is, however, something you
> should take up with the MSYS developers, not the git development
> community.
>
> I would take this up with Trustport support. Overly eager AV
> heuristics is a fairly common problem, and usually gets fixed quickly.
>
Either solution should work, but "trying to modify system global 
settings (time, timezone, registry quota, etc.)" suggests kill.exe is 
overstepping the requirements for terminating another process. As you 
suggest, I'll send a note to the MSYS developers. Maybe also ask 
Trustport for details on that triggers this message.

e.
