From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Fri, 12 Jul 2013 10:40:02 -0700
Message-ID: <7vli5bllsd.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 12 19:40:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhKH-0003Pd-3L
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810Ab3GLRkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:40:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932813Ab3GLRkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:40:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B47B2FC19;
	Fri, 12 Jul 2013 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l3V/Q5owjty1eFm7t8wImCExWAg=; b=J5TgrA
	dgLVsI+07Ij5oZ5svtJg/g/I0NnscEuXWr8YwZ2dVHw9mdu46m5u/7XX1pnqsgnH
	UX3fPcz37wrY312vqGaB4uaYJjyg/QrptJ2NG4ppIRceD1JJ1x/3wxZBIci4mUEE
	3qqyUs2WcRzxDD+g6b9gooDevoCxp7Q79D0mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZ06uRkLxGZXRqTLVMOivWPFjUaPVEmv
	l0jJTYaV+loDq7BrG4cbWbmb+JyfxtpNBp9QvQufVK9gRBxtfpl8y2kGTIKmVJui
	QRtLNmA/BZ69SfTxe2Y7b3Jmm7WprwEGra9QEN2gZpb1t8KfEuNs/UUgro/5dl/G
	gfxsJQZMPf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 228152FC18;
	Fri, 12 Jul 2013 17:40:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 631AD2FC13;
	Fri, 12 Jul 2013 17:40:04 +0000 (UTC)
In-Reply-To: <51E03B18.5040502@kdbg.org> (Johannes Sixt's message of "Fri, 12
	Jul 2013 19:21:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15EE685E-EB1A-11E2-9856-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230233>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.07.2013 00:14, schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>>> Again: Why not just define +refspec as the way to achieve this check?
>> 
>> What justification do we have to break existing people's
>> configuration that says something like:
>> 
>> 	[remote "ko"]
>> 		url = kernel.org:/pub/scm/git/git.git
>>                 push = master
>>                 push = next
>>                 push = +pu
>>                 push = maint
>> 
>> by adding a _new_ requirement they may not be able to satisify?
>> Notice that the above is a typical "push only" publishing point,
>> where you do not need any remote tracking branches.
>
> Why would it break? When you do not specify --lockref, there is no
> change whatsoever.

I thought your suggestion "Why not just define +pu as the way to
achieve _THIS_ check?" was to make +pu to mean

	git push ko --lockref pu

which would mean "check refs/remotes/ko/pu and make sure the remote
side still is at that commit".

If that is not what you meant, please clarify what _THIS_ is.
