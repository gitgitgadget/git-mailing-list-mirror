From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Mon, 22 Oct 2007 17:36:32 +0200
Message-ID: <471CC380.5030603@viscovery.net>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net> <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org> <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022143637.GP16291@srparish.net> <471CBF88.6020300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>, Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjzKk-0005NN-FM
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 17:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXJVPgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 11:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbXJVPgi
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 11:36:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4521 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbXJVPgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 11:36:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IjzKD-0005YD-MY; Mon, 22 Oct 2007 17:36:18 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0765D6B7; Mon, 22 Oct 2007 17:36:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <471CBF88.6020300@op5.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62023>

Andreas Ericsson schrieb:
> Scott Parish wrote:
>> I'm tempted to try a different approach. What if instead of looping
>> and building up strings of all the different absolute paths we want
>> to try we just prepend to PATH with the correct extra precedence,
>> and then call execvp on the command we want?
>>
> 
> That's how the original git --exec-dir feature got implemented. There's 
> even a nifty function for it in git.c; prepend_to_path(). It's a 
> provably workable solution.

The reason that this was done is for the sake of shell scripts: They need to 
have the path that was finally decided as exec-path in $PATH.

But I can't think of any negative side effect if *all* exec-path candidates 
are in $PATH. It's important, though, that all paths are absolute because 
the tools chdir every now and then.

-- Hannes
