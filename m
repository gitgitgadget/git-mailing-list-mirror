From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: git submodule should honor "-c credential.helper" command line
 argument
Date: Sun, 7 Feb 2016 14:48:07 +0100
Message-ID: <56B74B17.4040304@syntevo.com>
References: <56B0E3AA.30804@syntevo.com>
 <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 14:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSPgu-0007ho-1R
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 14:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbcBGNrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 08:47:19 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:35928 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcBGNrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 08:47:18 -0500
Received: from [91.113.179.170] (helo=[192.168.92.25])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1aSPgI-0005U7-FC; Sun, 07 Feb 2016 14:47:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285728>

On 07.02.2016 05:41, Jacob Keller wrote:
> On Wed, Feb 3, 2016 at 3:44 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Ok so I am not sure we even really need to use "-c" option in
>> git-clone considering that we can just use the same flow we do for
>> setting core.worktree values. I'll propose a patch with you two Cc'ed,
>> which I think fixes the issue. There may actually be a set of
>> configuration we want to include though, and the main issue I see is
>> that it won't get updated correctly whenever the parent configuration
>> changes.
>>
>> Thanks,
>> Jake
>
> I tried adding the config as part of module_clone in
> submodule--helper.c but it didn't pass the test I added. I haven't had
> time to look at this in the last few days, but I am stuck as to why
> submodule--helper.c appeared to not use module_clone as I thought.

I've tried to just comment out clearing of environment variables in 
git-sh-setup.sh, clear_local_git_env(). I've noticed that "-c 
credentials-helper ..." is stored in $GIT_CONFIG_PARAMETERS and with 
existing code is reset there. If not clearing the environment variables, 
at least "git submodule init" is working properly. I didn't try with 
other commands nor to run tests.

-Marc
