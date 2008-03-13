From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 15:09:56 +0100
Message-ID: <47D935B4.2070504@viscovery.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213916.GK26286@coredump.intra.peff.net> <47D8DCC0.9090303@viscovery.net> <20080313124103.GC19485@coredump.intra.peff.net> <47D9332C.4020904@viscovery.net> <20080313140415.GB30348@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:10:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZo8n-0003Bb-CA
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 15:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYCMOKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 10:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbYCMOKB
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 10:10:01 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41007 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYCMOKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 10:10:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZo7M-0000rw-1C; Thu, 13 Mar 2008 15:09:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 98C596B7; Thu, 13 Mar 2008 15:09:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080313140415.GB30348@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77090>

Jeff King schrieb:
> On Thu, Mar 13, 2008 at 02:59:08PM +0100, Johannes Sixt wrote:
> 
>>> +	status = run_command_v_opt(argv, 0);
>> ...
>>> +	return status == 0 ? 1 : -1;
>> grep can return 0 (success, something found), 1 (nothing found), and other
>> values for "real" failures like usage errors or crashes. This conditional
>> throws the latter two into the same pot, which makes git-grep unable to
>> distinguish "nothing found" from failure; cf. the call sites of
>> flush_grep(), where want to set the flag 'hit'.
> 
> I noticed that, as well, while writing it. But if you look at
> external_grep, it just lumps the two cases together anyway. It only ever
> compares "0 < status", so I think the behavior should be identical.

Yes, indeed. I missed that status < 0 is not checked for.

-- Hannes
