From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Fri, 08 Aug 2014 15:32:13 +0100
Message-ID: <53E4DF6D.8070904@ramsay1.demon.co.uk>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>	<vpqy4v1vdui.fsf@anie.imag.fr>	<xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>	<vpq61i4nld7.fsf@anie.imag.fr> <xmqqoavwjb3i.fsf@gitster.dls.corp.google.com> <53E4D986.6040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:32:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFlDT-0000uR-KE
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 16:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbaHHOcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 10:32:19 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:60313 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752244AbaHHOcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 10:32:19 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 5A6AF384088;
	Fri,  8 Aug 2014 13:53:45 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 27939384082;
	Fri,  8 Aug 2014 13:53:45 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Fri,  8 Aug 2014 13:53:44 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53E4D986.6040708@gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255018>

On 08/08/14 15:07, Tanay Abhra wrote:
> On 8/8/2014 2:01 AM, Junio C Hamano wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>>> Why is this needed? Are you now using key_value_info outside config.c?
>>>>> Or is it a leftover from a previous experiment?
>>>>
>>>> Has this been resolved in the new round?
>>>
>>> Tanay explained in another subthread why this was needed. For callers
>>> iterating over the string_list who want to get the file/line info, they
>>> need to be able to cast the void * pointer to struct key_value_info *.
>>
>> For callers that want to see all the multi-values, it would be
>> preferrable for the iterator to pass the filename and the linenumber
>> to the callback function, instead of exposing its implementation
>> detail as a single string list and telling them to pick it apart,
>> no?
>>
>> Not a very convincing argument, but OK for now in the sense that we
>> can fix it later if we wanted to before it gets too late.
>>
> 
> (cc to Ramsay)
> 
> The discussion in both threads (v8 and v9), boils down to this,
> is the `key_value_info` struct really required to be declared public or should be
> just an implementation detail. I will give you the context,

No, this is not the issue for me. The patch which introduces the
struct in cache.h does not make use of that struct in any interface.
It *is* an implementation detail of some code in config.c only.

I do not know how that structure will be used in future patches. ;-)

ATB,
Ramsay Jones
