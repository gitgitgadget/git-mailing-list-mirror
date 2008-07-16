From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] git-gui: Allow "Stage Line" to stage adjacent   changes
 independently
Date: Wed, 16 Jul 2008 09:15:15 +0200
Message-ID: <487DA003.3090905@viscovery.net>
References: <1216156261-9687-1-git-send-email-johannes.sixt@telecom.at> <1216156261-9687-2-git-send-email-johannes.sixt@telecom.at> <7vy742zul7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 09:16:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ1FT-0001Ru-FU
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 09:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbYGPHPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 03:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758648AbYGPHPW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 03:15:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56518 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758589AbYGPHPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 03:15:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KJ1EK-0006u9-3d; Wed, 16 Jul 2008 09:15:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AAED76D9; Wed, 16 Jul 2008 09:15:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vy742zul7.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88648>

Junio C Hamano schrieb:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
>> Consider this hunk:
>>
>>   @@ -10,4 +10,4 @@
>>    context before
>>   -old 1
>>   -old 2
>>   +new 1
>>   +new 2
>>    context after
>>
>> [Nomenclature: to "stage change 2" means to stage lines "-old 1" and
>> "+new 1", in any order; likewise for "unstage" and "change 2".]
> 
> You lost me.
> 
> Do you mean to say that you always interpret the above hunk as:
> 
>    @@ -10,4 +10,4 @@
>     context before
>    -old 1
>    +new 1
>    -old 2
>    +new 2
>     context after
> 
> and call "replace 'old 1' with 'new 1'" as "change 1", "replace 'old
> 2' with 'new 2'" as "change 2"?

No, it is not that I *always* interpret it this way. There is a problem to
fix only if I *want* to interpret it this way. Probably that's what I have
to make clear?

> If it is what you are doing, it does not make much sense to me.  "new 1"
> may correspond to "old 1" and "old 2" while "new 2" may be an independent
> addition.  E.g.
> 
>    @@ -10,4 +10,4 @@
>     context before
>    -#define add(x,y) \
>    - (x) + (y)
>    +#define add(x,y) ((x)+(y))
>    +#define sub(x,y) ((x)-(y))
>     context after
> 
> I might want to pick bugfix of add() definition without using the new
> definition of sub().

In order to that, there is nothing to fix; you can do that today without
this patch.

> Please call
> 
> 	"-old 1" - change #1
>         "-old 2" - change #2
>         "+new 1" - change #3
>         "+new 2" - change #4
> 
> and try explaining what you are doing again, pretty please?

No, this sounds like 4 independent changes, and that is not what this fix
is about.

I'll try to come up with a better wording.

-- Hannes
