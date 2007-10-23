From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Tue, 23 Oct 2007 13:12:03 +0200
Message-ID: <471DD703.70608@op5.se>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022143637.GP16291@srparish.net> <471CBF88.6020300@op5.se> <471CC380.5030603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Scott Parish <sRp@srparish.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 17:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkLYf-0007kX-QG
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 17:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbXJWPU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 11:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbXJWPU1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 11:20:27 -0400
Received: from mail.op5.se ([193.201.96.20]:39281 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752820AbXJWPU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 11:20:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CE09817305A5;
	Tue, 23 Oct 2007 17:20:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.455
X-Spam-Level: 
X-Spam-Status: No, score=-2.455 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, DATE_IN_PAST_03_06=0.044, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O+H82NQnD+Xn; Tue, 23 Oct 2007 17:20:24 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id AA0651730598;
	Tue, 23 Oct 2007 17:20:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <471CC380.5030603@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62129>

Johannes Sixt wrote:
> Andreas Ericsson schrieb:
>> Scott Parish wrote:
>>> I'm tempted to try a different approach. What if instead of looping
>>> and building up strings of all the different absolute paths we want
>>> to try we just prepend to PATH with the correct extra precedence,
>>> and then call execvp on the command we want?
>>>
>>
>> That's how the original git --exec-dir feature got implemented. 
>> There's even a nifty function for it in git.c; prepend_to_path(). It's 
>> a provably workable solution.
> 
> The reason that this was done is for the sake of shell scripts: They 
> need to have the path that was finally decided as exec-path in $PATH.
> 
> But I can't think of any negative side effect if *all* exec-path 
> candidates are in $PATH. It's important, though, that all paths are 
> absolute because the tools chdir every now and then.
> 

So long as they're added in "success:failed:failed" order, I don't see
any issues either. Assuming we stop prepending once we find something
that works, that should be a non-issue.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
