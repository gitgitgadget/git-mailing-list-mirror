From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was
 generated
Date: Tue, 08 Sep 2009 09:57:36 -0700
Message-ID: <7vk5098jcv.fsf@alter.siamese.dyndns.org>
References: <1251481187-6361-1-git-send-email-lars@public.noschinski.de>
 <20090908092059.GA8207@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 18:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml40v-0003uE-KI
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 18:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbZIHQ5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbZIHQ5m
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 12:57:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZIHQ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 12:57:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E722A9E9;
	Tue,  8 Sep 2009 12:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkeLMtuW5varcFosZDU7n3iHQ4c=; b=UuXZPP
	5OfgqbiEcahGAasTQrBnekxdr3dEiVnpTbeKuCX7tIZpLSRJNx7hOxMh3gbALKLC
	6ZErrZIRGGepzfNux44Hl3ngVhCUEDuhoMk5nu5MfyBH1nITd8f7zX5g79iUXYes
	1pPUAUMvTHVJgZR6oPSWoUjKarfX73cYylkoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vPYyojfd5OZxhGAwA9r7Mdn/5Rcamta4
	cpRkB8ayumdZDg+Id9IzdHWeOA+eJQnwk9a4wOpOAmkb+xOdPza/JksqHeyJhCTR
	lRhQh/VCG6LAGmLAIGGGqXnIFdg3NEIOg9edoqS16GM2ArrWzjSXzzA9bPO7TUAJ
	0kCAsxwlygI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 577F72A9E7;
	Tue,  8 Sep 2009 12:57:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AEC12A9E6; Tue,  8 Sep
 2009 12:57:37 -0400 (EDT)
In-Reply-To: <20090908092059.GA8207@lars.home.noschinski.de> (Lars
 Noschinski's message of "Tue\, 8 Sep 2009 11\:20\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7FA98D6-9C98-11DE-B228-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128019>

Lars Noschinski <lars@public.noschinski.de> writes:

> * Lars Noschinski <lars@public.noschinski.de> [09-08-28 19:39]:
>> contrib/hooks/post-receive-email used to call the send_mail function
>> (and thus, /usr/sbin/sendmail), even if generate_mail returned an error.
>> This is problematic, as the sendmail binary provided by exim4 generates
>> an error mail if provided with an empty input.
>> 
>> Therefore, this commit changes post-receive-email to only call sendmail
>> if generate_mail returned without error.
>> 
>> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
>
> Is anything wrong with this patch? Or is it just queued to be committed
> some time?

It is not queued anywhere as far as I am concerned.

I was waiting for others to review the patch and nothing happened, so the
patch was in limbo.  Thanks for sending a reminder message I am responding
to.  You did the right thing when nothing happened to a patch that did not
see any discussion.

You can avoid this by CC'ing people who have been involved in the past
with the parts of the system you are patching in the initial posting of
your patch (I am not one of them, so CC'ing me didn't help).

Here are my knee-jerk reactions to the patch after a quick glance, without
thinking deeply nor looking at the other parts of the file you did not
touch, but looking only at the parts shown in your patch:

 - Slurping generate_email's output into a shell variable is a bad taste.
   You said that the message is always small enough but _how_ do we know
   it?

 - If this is to save us from a quirk in some but not all implementations
   of /usr/lib/sendmail, then shouldn't the logic be made into a new
   conditional?

 - I do not see a direct link between "if generate_mail returned an error"
   and "if ... an empty input".  What if generate_mail started its output
   but then failed halfway?  We have some output so the send_mail won't be
   fed empty, but $? would be not zero, so the patch is testing a
   different condition from what the log message claims to be checking.

People who do use this script and people who have worked on it may have
other more useful comments.

Thanks.
