From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: __git_ps1_colorize__gitstring() in git_prompt.sh: colors are
 hardcoded?
Date: Mon, 20 Oct 2014 16:45:35 +0200
Message-ID: <5445200F.1030003@drmicha.warpmail.net>
References: <5441524C.6040302@ulb.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: nathdwek <nathdwek@ulb.ac.be>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 16:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgEDO-0003rh-3n
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 16:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbaJTOpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 10:45:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55841 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbaJTOph (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 10:45:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by gateway2.nyi.internal (Postfix) with ESMTP id 200BF20981
	for <git@vger.kernel.org>; Mon, 20 Oct 2014 10:45:37 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 20 Oct 2014 10:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=NBho/eXR8b1VQZarcogaoT
	9hwJk=; b=qL8jFr/x4KzhXw/R7MSq+ORhZBS8DqCTybIxSZo/zgH7mCIIiQ2T7a
	40N3ivYRutScCt99otJ3KQ9rcgUb1qfmEiHdvWKxyhv93mZdGzfryaSja81EwPQD
	exSptof3eorxm9BcPq6Fdc1/HuenXcT/8whODcqJKnQT4KCJLo/dU=
X-Sasl-enc: DfMFrkiJbbwu4+d5HBX8wx70Qdm/V8VW642gMkRl71XF 1413816336
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9FF666800C4;
	Mon, 20 Oct 2014 10:45:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <5441524C.6040302@ulb.ac.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nathdwek schrieb am 17.10.2014 um 19:30:
> Hello,
> 
> It seems to me that the colors used to indicate the repo's state in the
> prompt are hardcoded although the top comment says otherwise.
> 
> From contrib/completion/git-contrib.sh:
> 
> [83]# If you would like a colored hint about the current dirty state, set
> # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
> # the colored output of "git status -sb" and are available only when
> # using __git_ps1 for PROMPT_COMMAND or precmd.

That should have said "... on the default colors used for the colored
output of..."

> [228]__git_ps1_colorize_gitstring ()
> {
> 	if [[ -n ${ZSH_VERSION-} ]]; then
> 		local c_red='%F{red}'
> 		local c_green='%F{green}'
> 		local c_lblue='%F{blue}'
> 		local c_clear='%f'
> 	else
> 		# Using \[ and \] around colors is necessary to prevent
> 		# issues with command line editing/browsing/completion!
> 		local c_red='\[\e[31m\]'
> 		local c_green='\[\e[32m\]'
> 		local c_lblue='\[\e[1;34m\]'
> 		local c_clear='\[\e[0m\]'
> 	fi
> 	local bad_color=$c_red
> 	local ok_color=$c_green
> 	local flags_color="$c_lblue"
> 
> 	local branch_color=""
> 
> 
> As expected upon seeing this snippet, the color.status.<slot> entries in
> the git config file do modify the git status -sb output but don't modify
> the colors used in the prompt.
> 
> Regards,
> 
> Nathan

The script could query config for these colors, but that would amount to
4 additional forks and "git config" calls each time a prompt is
generated. If you want the colors to be configurable, you should
probably rather introduce environment variables - or edit your copy of
the script ;)

Cheers,
Michael
