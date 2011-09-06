From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Question about right-only
Date: Tue, 06 Sep 2011 18:08:03 +0200
Message-ID: <4E664563.5020900@drmicha.warpmail.net>
References: <4E6607B2.2090000@intland.com> <ec1404d75fd6461fa731f31625126884-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Tajti_=C1kos?= <akos.tajti@intland.com>,
	git@vger.kernel.org
To: mfwitten@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 06 18:08:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yC5-0002wS-Op
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab1IFQIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:08:10 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56384 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754974Ab1IFQIH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 12:08:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1BC1523859;
	Tue,  6 Sep 2011 12:08:05 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 06 Sep 2011 12:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Ncaqj/Ws7Bf9RjjQd3R9yy
	wL/BQ=; b=E8993cGu7uat5eqBY4/kMcVjEyCz1cy6Zxux4jiR4yh2OlSH2dOHIO
	IKrCndCiHQ4cESaWQsdh9iflg+sBs6GPsiGJssxxYGra9+5qcr8efAWrg+kdPz4+
	cs0LyQ0H94MLi8tvMj9avvqmRF0thNLPV+1MyonH8GEeJxQjSGpw4=
X-Sasl-enc: qEbzL4NtUIQtCRCef074owCT2sm0ZYEmGz3yaLr7oM65 1315325284
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7D2988E022B;
	Tue,  6 Sep 2011 12:08:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <ec1404d75fd6461fa731f31625126884-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180809>

mfwitten@gmail.com venit, vidit, dixit 06.09.2011 17:24:
> On Tue, 06 Sep 2011 13:44:50 +0200, Tajti wrote:
> 
>> what does the right-only option of git-log actually do? The manual is 
>> not too verbose about it.
> 
> The documentation is indeed a bit messy, so let me rearrange it for you.
> 
> From `git help rev-parse':
> 
>   r1...r2 is called symmetric difference of r1 and r2 and is
>   defined as `r1 r2 --not $(git merge-base --all r1 r2)'. It is
>   the set of commits that are reachable from either one of r1 or
>   r2 but not from both.
> 
> Then we have this from `git help log':
> 
>   --left-right
>       Mark which side of a symmetric diff a commit is reachable
>       from. Commits from the left side [(r1 above)] are prefixed with
>       < and those from the right [(r2 above)] with >...
> 
> which should explain what `<' and `>' mean in the following from
> `git help log':
> 
>   --left-only, --right-only
>       List only commits on the respective side of a symmetric
>       range, i.e. only those which would be marked < resp. > by
>       --left-right.
> 
> This is probably most useful with the following option, described
> in `git help log':
> 
>   --cherry-pick
>       Omit any commit that introduces the same change as another
>       commit on the "other side" when the set of commits are
>       limited with symmetric difference.
> 
>       ...
> 
>       For example, --cherry-pick --right-only A...B omits those
>       commits from B which are in A or are patch-equivalent to a
>       commit in A. In other words, this lists the + commits from
>       git cherry A B. More precisely, --cherry-pick --right-only
>       --no-merges gives the exact list.
> 
> That is, you often run into multiple commit objects that are unique
> because of, say, differing commit dates, but that actually introduce
> the same change to the source; this combination of options is helpful
> in weeding out commits that introduce the same change.
> 
> If you're still confused, don't hesitate to poke the list some more;
> the documentation is quite lacking over all topics, so don't feel
> stupid.

Feel free to improve it :)

Though, in this case, everything is in git-log's man page, except for
the definition of "symmetric range", which is a fundamental concept and
this described by git help revisions, e.g.

Would a pointer from --left-only,--right-only to --cherry-pick help?

Michael
