From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 06 May 2011 13:10:41 +0200
Message-ID: <4DC3D731.3070503@drmicha.warpmail.net>
References: <20110505191027.GA3242@camk.edu.pl> <7vsjss6hmf.fsf@alter.siamese.dyndns.org> <4DC3A685.4080300@drmicha.warpmail.net> <4DC3CBEF.6080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 06 13:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIIvy-0007hf-4l
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 13:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab1EFLKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 07:10:44 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49206 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753646Ab1EFLKn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 07:10:43 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D66FE20AFB;
	Fri,  6 May 2011 07:10:42 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 06 May 2011 07:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NsmjoldHqmX/fx4f5XhDkiDgFrU=; b=bX2pp2+iptHflQsUSGVYaT2zMCrokfHjHB4/TAgMDlkq4WbK6rAZ/pUEMxPB4JBZ2F1GE1YVZp1dq3fGAIgsBBpdCgDdCb9PbvkiROqY4iVHRaX49ToPkcWbTOTmTLdHijqqbAfhBhKz2Ue8y2mgeHwGIRBkhyIYtcQfNxEmyoU=
X-Sasl-enc: dGGGVPk1l/uLyGBl4WQXebALrmVlR6Y609sfHd71cmJO 1304680242
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 22C1F444206;
	Fri,  6 May 2011 07:10:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <4DC3CBEF.6080303@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172969>

Johannes Sixt venit, vidit, dixit 06.05.2011 12:22:
> Am 5/6/2011 9:43, schrieb Michael J Gruber:
>> Junio C Hamano venit, vidit, dixit 05.05.2011 22:02:
>>> Kacper Kornet <draenog@pld-linux.org> writes:
>>>> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
>>>> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
>>>> +	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
>>>> +	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
>> Other than that, I have no objections if this patch makes more shells
>> happy and no happy ones unhappy.
>>
>> Is your ksh OK with all other tests?
> 
> Note that:
> 
> - With the proposed change, bash now prints the backslashes.
> 
> - The printfs should be echos, really.

I thought printfs can be relied upon better than echos (in terms of line
endings)?

> - The behavior of quoting at the right of :- when the ${...:-...} exansion
> appears in double-quotes was debated recently at length at the Austin
> group (which revises the POSIX standard). You better move the expansions
> to assignments of temporary variables, where you don't need the
> surrounding double-quotes:
> 
> 	butnot=${5:-\'$3\'} aka=${2:+ aka \'$1:./$3\'}
> 
> Here, the backslash unambiguously quotes the next character.
> 
> -- Hannes

Whatever makes most shells happy, as long as that includes current bash...

Michael
