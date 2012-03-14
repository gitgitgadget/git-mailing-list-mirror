From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 13 Mar 2012 21:36:09 -0700
Message-ID: <7vhaxrsssm.fsf@alter.siamese.dyndns.org>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <m3pqcjt6s2.fsf@carbon.jhcloos.org> <7v4ntvx87v.fsf@alter.siamese.dyndns.org>
 <4F5F1FEA.8020103@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Wed Mar 14 05:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7fwg-0007kW-E4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 05:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab2CNEgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 00:36:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab2CNEgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 00:36:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F277B2C;
	Wed, 14 Mar 2012 00:36:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HuQ0Ezh4Cc9rHqq7/OZxX0zXn/8=; b=pGPjuZ
	oi8wK6oFp/GpsKTQRAVyJeRCxmCgchBYiS17SCYpj5eolzOZU8Ryb0yJqd0Fbnq9
	apmqtuPjDgOQAN//CGHaR839sxSTf482uSKeI5TjXatwlsPrZbw5fjb4Rp2uXN6L
	PW7z9CI2Kq9uQTGW2idIA4X0DFAi7kmoNbA2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qmPtxxX/jb5X6lNopiCeG5bxaT/UEvyU
	QPXkDzgOREEo3dVduvUAGqeiYcB5aWIR0QXMDuT2bwQEDsn2705O4XxwU4lf1o7t
	5PAQO4pyk8wmbtO1JL70PEsUU2jtFWZhhs5xw+HNhVC/gIa+ifdL7KSkgsGLVyJP
	A0EGIKhe3Pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68DA37B2B;
	Wed, 14 Mar 2012 00:36:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCEA17B2A; Wed, 14 Mar 2012
 00:36:10 -0400 (EDT)
In-Reply-To: <4F5F1FEA.8020103@seap.minhap.es> (Nelson Benitez Leon's message
 of "Tue, 13 Mar 2012 11:22:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 397543BA-6D8F-11E1-BDCB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193082>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 03/11/2012 08:12 PM, Junio C Hamano wrote:
>> James Cloos <cloos@jhcloos.com> writes:
>> 
>>> Please include a way, eg via ~/.gitconfig, to ignore any http_proxy in
>>> the environment and connect directly.
>> 
>> Hrm.
>> 
>> I think without this patch series, the "NO_PROXY" environment
>> variable is honored by the curl library when it uses http_proxy
>> to make the decision. If this patch (or a future reroll of it) fails
>> to do the same, it would be a regression.
>> 
>> Nelson, do you agree?
>
> I agree, so I would need to handle $no_proxy in the patch-set, will look
> into that.

Are you sure $no_proxy is spelled in lowercase?  man curl(1) seems to
indicate otherwise.
