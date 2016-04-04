From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] t5520: tests for --[no-]autostash option
Date: Mon, 04 Apr 2016 10:00:22 -0700
Message-ID: <xmqqmvp95mxl.fsf@gitster.mtv.corp.google.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqshz125jr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mehul Jain <mehul.jain2029@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:00:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7rj-0002Ms-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 19:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbcDDRA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 13:00:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932351AbcDDRA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 13:00:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 621C74F390;
	Mon,  4 Apr 2016 13:00:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2IPE3wwu1TDDYmc0tO8GLaBgd8=; b=VCEVT8
	JSq8QDEbuXd92ID+0zzqngSiUW3bTVa/5urgAsaRMDHzIWvoix6I9tEonDrJJUc9
	pgUFRt5wB8AagJcuIm88qOGQCKL0+XEg/3z4Iy9SWk0JzjwrJorfxcsG5UdNa97c
	U6n68OnX+tOWnMgbpbZDhEoxBjyTFFzztQ6Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ERjJoRIbm+tVW5Ihn/s4bzIgsmiEnrcj
	OASiqt2x06f4jyN114kBx7U2rSm+Iaon85SHLd4PrDmJ+BBsX9bcm+xj/aDpGKM9
	KBx/yT8UobnSaLpRj9Hx+/+2HuIwrYjbxI/J08AtRMmr5RPiX2siuypZGopE+/lw
	V5WhTICufNk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A3AD4F38F;
	Mon,  4 Apr 2016 13:00:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E4EE4F38D;
	Mon,  4 Apr 2016 13:00:23 -0400 (EDT)
In-Reply-To: <vpqshz125jr.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	04 Apr 2016 09:31:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8B36A34-FA86-11E5-962A-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290700>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> -test_rebase_autostash () {
>> +test_pull_autostash () {
>>  	git reset --hard before-rebase &&
>>  	echo dirty >new_file &&
>>  	git add new_file &&
>> -	git pull --rebase --autostash . copy &&
>> +	git pull $@ . copy &&
>
> Not strictly needed here, but I'd write "$@" (with the double-quotes)
> which is the robust way to say "transmit all my arguments without
> whitespace interpretation".

Yes, these should be "$@" (with the double-quotes).

> I don't mind for this patch since there's no whitespace to interpret,
> but some people (sysadmins ;-) ) have the bad habit of writting $@, $*
> or "$*" in wrapper scripts and it breaks when you call them with spaces
> so it's better to take good habits IHMO.
