From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Wed, 8 Jun 2016 18:46:59 +0200
Message-ID: <3090c61c-533b-7119-f5e4-7d99e62f6da4@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-2-tom.russello@grenoble-inp.org>
 <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
 <f34e3636-ce71-8352-259d-9f723d63e2a8@grenoble-inp.org>
 <xmqqvb1jmzly.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, e@80x24.org, aaron@schrab.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAgdG-00083d-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 18:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709AbcFHQrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 12:47:02 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:44757 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbcFHQrB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 12:47:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 20DCD20B4;
	Wed,  8 Jun 2016 18:46:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hkcoqvnnwVnX; Wed,  8 Jun 2016 18:46:58 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 096FC20B2;
	Wed,  8 Jun 2016 18:46:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0043B2066;
	Wed,  8 Jun 2016 18:46:58 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id COGrTTdGlLiu; Wed,  8 Jun 2016 18:46:57 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id DBFE32064;
	Wed,  8 Jun 2016 18:46:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqvb1jmzly.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296811>

On 06/08/2016 06:09 PM, Junio C Hamano wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> Actually we had issues when trying to refactor send-email's email
>> parsing loop [1]. Email addresses in output file `commandeline1` in
>> tests weren't sorted the same way as the reference file it was
>> compared to. E.g.:
>>
>>   !nobody@example.com!
>>   !author@example.com!
>>   !one@example.com!
>>   !two@example.com!
>
> And the reason why these addresses that are collected from the same
> input (i.e. command line, existing e-mail fields, footers, etc.) are
> shown in different order in your implementation is...?

It's not shown in different order in our implementation, it's just a 
leftover of my refactor attempt [1].

Maybe it's a bad idea to increase tests' complexity, but IMHO tests 
should be independent to the addresses' order.

Plus, it would help refactor in the future, the data being processed 
differently: parsing and processing in different subroutines rather than 
doing everything in one gigantic loop.

We can drop it if necessary, but it may be useful to make 
git-send-email.perl easier to maintain.

[1] * http://article.gmane.org/gmane.comp.version-control.git/295753
