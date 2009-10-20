From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: git-pack-objects gitattributes?
Date: Tue, 20 Oct 2009 10:34:00 -0600
Organization: Code Aurora Forum
Message-ID: <4ADDE678.4030001@codeaurora.org>
References: <4AD3B4F8.6030007@codeaurora.org> <4ADCB457.8050601@codeaurora.org> <4ADCBAC7.9010601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Hf0-00018u-0P
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZJTQd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZJTQd5
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:33:57 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:49033 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZJTQd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:33:56 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5777"; a="25672643"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 20 Oct 2009 09:34:01 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 7145910004C8;
	Tue, 20 Oct 2009 09:37:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4ADCBAC7.9010601@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130809>

Michael J Gruber wrote:
> Nasser Grainawi venit, vidit, dixit 19.10.2009 20:47:
>> Nasser Grainawi wrote:
>>> Hello,
>>>
>>> I'm trying to avoid doing delta compression on a number of large binary 
>>> files. I got a suggestion to use $GIT_DIR/info/attributes and a line 
>>> like this:
>>> *.bin -delta
>>>
>>> This doesn't seem to show a big improvement (and honestly I can't find 
>>> where in the git-pack-objects source the value of this attribute is used).
>>>
>>> Could someone shed some light on this attribute and any other 
>>> improvements I could make for efficiently serving up a repo over 
>>> git-daemon with near-weekly revisions of 100MB+ files?
>>>
>>> Thanks,
>>> Nasser
>> ping? any help? anyone?
> 
> Well, describing a reproducable test case would help... as well as
> telling us your git version.

1.6.5

> 
> builtin-pack-objects.c certainly refers to the delta attribute, see
> no_try_delta() and its callers.

Oops, somehow missed that while looking at the code right above it. Thanks.

> 
> Have you checked your attrs with git-check-attr? How do you measure the
> improvements you expect?

I did check, it returns 'unset' like one would expect.

I guess the big problem is that I don't have a good test case. I would have
expected a 'git repack -adf' to spend less time saying "Compressing objects",
but that doesn't seem to be happening...

Oh, wait, never mind.
I was missing some of the binaries I was trying to skip. Adding some more 
exceptions to the attributes file dropped the "Compressing objects" time from 
20 minutes (or more) to maybe 10 seconds.

Thanks Michael!

Nasser
