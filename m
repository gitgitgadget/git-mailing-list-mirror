From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.* configurations
 ignored for known tools
Date: Wed, 09 Jun 2010 20:24:43 +0100
Message-ID: <4C0FEA7B.9030409@hashpling.org>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr> <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 21:35:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMR3p-00045x-Dn
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 21:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347Ab0FITff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 15:35:35 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:20763 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932304Ab0FITfd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 15:35:33 -0400
X-Greylist: delayed 647 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 15:35:33 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAOKHD0xUXebj/2dsb2JhbACYHoYzcb8shRgE
Received: from outmx01.plus.net ([84.93.230.227])
  by relay.ptn-ipout02.plus.net with ESMTP; 09 Jun 2010 20:24:37 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx01.plus.net with esmtp (Exim) id 1OMQtB-0005c2-D2; Wed, 09 Jun 2010 20:24:37 +0100
Received: from heisenberg2.hashpling.org ([192.168.76.29])
	by hashpling.plus.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1OMQtB-0003f9-6V; Wed, 09 Jun 2010 20:24:37 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148808>

On 05/06/2010 03:31, Sylvain Rabot wrote:
> At this time when you define merge.tool with a known tool,
> such as meld, p4merge, diffuse ... etc, mergetool.<tool>.*
> configurations are ignored and git mergetool will use its
> own templates.
>
> This patch adds a detection for mergetool.<tool>.cmd configuration
> in the run_merge_tool function. If the configuration is set, it will
> try to run the tool with mergetool.<tool>.path if its set. It also
> consider the mergetool.<tool>.trustExitCode configuration.
>
> Signed-off-by: Sylvain Rabot<sylvain@abstraction.fr>
> ---
>   git-mergetool--lib.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 60 insertions(+), 0 deletions(-)
>

First, my apologies for only having had the time to skim this so far.

Can I just ask some basic questions about the purpose of this patch. Is 
it the intention that if mergetool.<tool>.cmd is set then you want to 
mergetool to behave 'as if' the merge tool wasn't a 'known' tool and 
just performed the "*)" case ?

If so, it seems like a lot of extra boiler-plate and error handling that 
doesn't exist in the normal "*)" case. Should we have have this in the 
"*)" case as well? If so, we should look to rework it so that we can 
re-use the code rather than duplicating it.

 From a user perspective, if they want to run a "known" tool but in a 
way that is different from the default behaviour can't they just give it 
a different name, e.g. merge.tool=my_kdiff3 , mergetool.my_kdiff3.cmd=... ?

Thanks,

Charles.

-- 
Almost dormant mergetool maintainer.
