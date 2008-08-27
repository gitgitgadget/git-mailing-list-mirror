From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 08:35:48 +0200
Message-ID: <48B4F5C4.9020404@viscovery.net>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 08:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYEed-0002Lv-Gh
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 08:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbYH0Gfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 02:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYH0Gfy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 02:35:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19445 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbYH0Gfx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 02:35:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KYEdA-0004wo-RO; Wed, 27 Aug 2008 08:35:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 71B636B7; Wed, 27 Aug 2008 08:35:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48B44C61.2020206@gnu.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93860>

Paolo Bonzini schrieb:
> Junio C Hamano wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Paolo Bonzini schrieb:
>>>> +	/*
>>>> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
>>>> +	 * in die().  It also avoids not messing up when the pipes are
>>>> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
>>>> +	 */
>>> I see your point, but I don't have an opinion whether this stretch is
>>> necessary.
>> This is going too far.  Have you seen any other sane program that do this?
> 
> Busybox.  But it runs setuid, as Steven pointed out.

I straced tee (it was the only tool I found that opens files for writing
without also opening some for reading). If one of 0,1,2 is closed, it
*does* dup() the fd that it is going to write.

Don't you now feel like Reg in "Life of Brian":

"All right, but apart from the sanitation, the medicine, education, wine,
public order, irrigation, roads, a fresh water system, and public health,
what have the Romans ever done for us?"

;)

-- Hannes
