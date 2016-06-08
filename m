From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 3/6] send-email: shorten send-email's output
Date: Wed, 8 Jun 2016 21:18:35 +0200
Message-ID: <4253fcd6-dba5-fc9a-d63e-e40ba10bb9e7@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-4-samuel.groot@grenoble-inp.org>
 <xmqqeg87mviz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:18:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAj01-0002Ft-Db
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161717AbcFHTSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:18:41 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:38892 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161420AbcFHTSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:18:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0BD7E2584;
	Wed,  8 Jun 2016 21:18:35 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7kXfu2BeHTxc; Wed,  8 Jun 2016 21:18:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id F03D1222F;
	Wed,  8 Jun 2016 21:18:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EA6232066;
	Wed,  8 Jun 2016 21:18:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zIBYs6gsrVma; Wed,  8 Jun 2016 21:18:34 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id CD97A2064;
	Wed,  8 Jun 2016 21:18:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqeg87mviz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296834>

On 06/08/2016 07:37 PM, Junio C Hamano wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>> +				printf("Adding cc: %s from From: header\n",
>> +					$1) unless $quiet;
>
>> +					printf("Adding to: %s from To: header\n",
>> +						$addr) unless $quiet;
>
>> +					printf("Adding cc: %s from Cc: header\n",
>> +						$addr) unless $quiet;
>>  					push @cc, $addr;
>
>> +				printf("Adding cc: %s from Cc: header\n",
>> +					$_) unless $quiet;
>
> These make the end result prettier by not repeating the same address
> twice, but is it just me who finds these inexplicable case
> differences irritating?  Shouldn't these field references in the
> result mirror the field references in the origin of the information?

It makes sense only in the case below...

 >> +		printf("Adding cc: %s from From: header\n",
 >> +			$1) unless $quiet;

... because the sender should receive its own copy (at least to avoid 
breaking threaded view in his mailer) and be cc-ed. By the way, we 
should cc the sender when sending the cover letter too for the same reason.

But in other cases, it seems pointless to display identical field 
reference twice.
