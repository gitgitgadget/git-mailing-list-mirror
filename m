From: Mina Almasry <almasry.mina@hotmail.com>
Subject: Re: Feature request - discard hunk in add --patch mode
Date: Wed, 15 Aug 2012 16:58:08 -0400
Message-ID: <BLU0-SMTP112EF6B9308C55734C4F10293B60@phx.gbl>
References: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl> <87txw41okl.fsf@thomas.inf.ethz.ch> <7vvcgk58le.fsf@alter.siamese.dyndns.org> <7vmx1w56z1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1kfR-00013T-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756286Ab2HOU6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:58:12 -0400
Received: from blu0-omc3-s17.blu0.hotmail.com ([65.55.116.92]:50378 "EHLO
	blu0-omc3-s17.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab2HOU6L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2012 16:58:11 -0400
Received: from BLU0-SMTP112 ([65.55.116.73]) by blu0-omc3-s17.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 15 Aug 2012 13:58:09 -0700
X-Originating-IP: [142.151.169.12]
X-EIP: [uhpA78ImxwzuL9cG4M7NE2tMxSDntMxJ]
X-Originating-Email: [almasry.mina@hotmail.com]
Received: from [192.168.1.101] ([142.151.169.12]) by BLU0-SMTP112.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 15 Aug 2012 13:58:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vmx1w56z1.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 15 Aug 2012 20:58:09.0847 (UTC) FILETIME=[AD354470:01CD7B28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-08-15 02:46 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> This has come up before, and actually led to the introduction of
>>> 'checkout -p' and 'reset -p':
>>>
>>>    http://thread.gmane.org/gmane.comp.version-control.git/123854
>> That is a blast from the past.
>>
>> Why is saying "git checkout ." too much work, after "add -p" that
>> you excluded the debugging cruft?
> Please forget this question.  A better way in the form of "stash -p"
> was suggested in the old thread to get rid of debug cruft in the
> tree before an "add -p" session (or during a series of "add -p"
> sessions).
>
> So is this still an issue?
>
>
I read most of the thread, and I do think it still is. Here are my 2 cents:

1. The alternative commands aren't nearly as time efficient:
     - git checkout . is fast and awesome, but you can't use it if, for 
example, you have to maintain a dirty         working tree
     - git (stash|reset|checkout) -p make you go through (all|most) of 
the hunks you have to hunt down             those 2 lines that say "echo 
'This line is runningantoeuhaoeuaoae'"

2. All of the safety concerns can be alleviated with the right 
interface. I am glad the u option mentioned in the thread did not go 
through since I agree it is not ideal. However, if the command is:
     (a) something with a '!', then no one will hit it by mistake, and
     (b) the prompt makes it clear that work is lost
then I think it would be fine

The advantages of a command like this are pretty huge IMO. I can see 
this being a big time saver.

How about adding this to the git add -p prompt:

     r! - remove this hunk. The hunk is discarded from the working tree, 
and is irrevocably lost.
