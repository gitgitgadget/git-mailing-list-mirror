From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 08:36:30 -0700
Message-ID: <xmqqtx7sai9t.fsf@gitster.dls.corp.google.com>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
	<xmqq7g4obypt.fsf@gitster.dls.corp.google.com>
	<53972229.5040104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:36:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuO6L-0006Yi-OS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 17:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaFJPgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 11:36:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54571 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbaFJPgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 11:36:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EED91D254;
	Tue, 10 Jun 2014 11:36:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QoBUkMPs77BkU3PMkuCb/k0/PTM=; b=Fh1hLB
	QT1VwEhb5WDsnt6pvMaMZnqNAcIaoykX+17EFb6iPVaOPuF4p6XZL/HUWG57nUsW
	vNFIMMWGeF4bVgnTFtTnZwX6DfSBUj5aZR/PU/Za5Y3u42IjctRgQ0SMBTPblMIA
	2a0DRGsmcBMreonO20Hlwx9AFCWihtoMX1fyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cRqehEytwhh2/eGkXHGHRvXFEHVl2Hh5
	UHcRwYHWgqSfE2b4zc0SmRMZZZtt3eVoQCJI9zDSC7QDvrDzjpguqfe1BBQ+xhfO
	hpJdxUeIdlcu0qakWHu+jBxvK+RHrpldynajVYLYn3agzLROFVzFQdN3sCD+Odo2
	d/NaBna0nmY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63B9B1D253;
	Tue, 10 Jun 2014 11:36:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5EC931D24D;
	Tue, 10 Jun 2014 11:36:32 -0400 (EDT)
In-Reply-To: <53972229.5040104@viscovery.net> (Johannes Sixt's message of
	"Tue, 10 Jun 2014 17:20:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF9533C0-F0B4-11E3-8E08-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251200>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/10/2014 16:55, schrieb Junio C Hamano:
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>> 
>>> @@ -832,7 +832,7 @@ Maybe you want to use 'update --init'?")"
>>>  			continue
>>>  		fi
>>>  
>>> -		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>>> +		if ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
>> 
>> Which part of test conditions does that "!" apply in the original,
>> and in the updated? 
>> 
>> I think the new test after || also needs negation, no?
>
> Not just that; the || must be turned into && as well.

I think our mails crossed ;-)
