From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/2] bash completion: Support "divergence from upstream"
 warnings in __git_ps1
Date: Thu, 10 Jun 2010 15:31:13 +0200
Message-ID: <4C10E921.1030909@drmicha.warpmail.net>
References: <4C0EB7F1.1030707@pileofstuff.org> <cover.1276169807.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-git@pileofstuff.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 10 15:32:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhri-0005Yd-TW
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0FJNcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 09:32:09 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53439 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752940Ab0FJNcG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 09:32:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 628C9F8605;
	Thu, 10 Jun 2010 09:31:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Jun 2010 09:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3vouvEInn+HhEcJImCfcnqfxxQE=; b=IbJQrwGI/EesIXl4GJ/XeTSzpSrHG8Sm397+GY5mwj5NKmnIi6hZd4wtMUrp85caYLcceSCU2U7pCv8JScNvTQ6hzQc/wzIEgtdPuRXtRBuYVvsJc/etiALGgtpCpzP/9lswWarVf2w+cC8IQoXA24QjTBa94akw7qYV2Cy+L4I=
X-Sasl-enc: v0HjHSsJhWX22J3GedVOwBWUm0+uH+JfSgsGdzc1JnLw 1276176706
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 290C460C5F;
	Thu, 10 Jun 2010 09:31:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <cover.1276169807.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148875>

Thomas Rast venit, vidit, dixit 10.06.2010 13:47:
> Andrew Sayers wrote:
>> +                                       case "$p" in
>> +                                               \<*\>*|\>*\<* ) p="<>" ;;
>> +                                               *\<*          ) p="<"  ;;
>> +                                               *\>*          ) p=">"  ;;
>> +                                               ""            ) p="="  ;;
>> +
>> +                                               # the following case shouldn't be possible
>> +                                               # if you see this, please report it as a bug
>> +                                               * ) p="?ERROR($p)?" ;;
>> +
>> +                                       esac
> 
> I didn't really like this bit, since rev-list has to format the output
> only so you can match it.  I realized that I too have written code in
> the past to detect which way this goes (in post-receive hooks), and/or
> the number of commits as per the request
> 
> John Tapsell wrote:
>> I hate to get all feature-bloat on you...
>>
>> But could it state the number of commits as well please? :) :)
> 
> So here's an additional patch to provide rev-list logic that supports
> this feature.  I have then tweaked your original patch to make use of
> it a u+7-5 style.
> 
> I'm not too picky about the exact style that it turns out to have in
> the end; I have used my own customized version ever since we started
> printing a space before the (master *+) dirtiness indicator.  However,
> I think we should try to be as unambiguous and short as possible.
> Hence I picked the 'u' prefix to avoid ambiguity with the dirtiness
> indicator.
> 
> 
> Andrew Sayers (1):
>   bash completion: Support "divergence from upstream" warnings in
>     __git_ps1
> 
> Thomas Rast (1):
>   rev-list: introduce --count option
> 
>  Documentation/rev-list-options.txt     |    9 +++++
>  builtin/rev-list.c                     |   16 +++++++++
>  contrib/completion/git-completion.bash |   57 +++++++++++++++++++++++++++++++-
>  revision.c                             |    2 +
>  revision.h                             |    5 +++
>  t/t6007-rev-list-cherry-pick-file.sh   |   29 ++++++++++++++++
>  6 files changed, 117 insertions(+), 1 deletions(-)
> 

Checked and tested. After setting DIFF, even the tests pass!
But we can probably do without the debug_p line ;)

Liked-by: Michael J Gruber <git@drmicha.warpmail.net>
