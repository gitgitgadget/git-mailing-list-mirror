From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix
 regression)
Date: Tue, 17 Jan 2012 10:46:48 -0800
Message-ID: <7vty3urwtj.fsf@alter.siamese.dyndns.org>
References: <20120114152030.GX30469@goldbirke>
 <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjjhwvdy.fsf@alter.siamese.dyndns.org> <vpqhazv3m17.fsf@bauges.imag.fr>
 <7vsjjfuuwk.fsf@alter.siamese.dyndns.org> <vpqr4yy1pv6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 17 19:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnE3f-00027S-WE
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 19:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab2AQSqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 13:46:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab2AQSqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 13:46:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7A364BB;
	Tue, 17 Jan 2012 13:46:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jl5Kl+WCghGZ5knUD1Rj6vMRx6M=; b=q+4cJ9
	n0TADH/DVRYsRStSn9R6dNYqr5jSPGx2J2voj6n2c0KBnw6PZ7ek/fxiASjPZ9pf
	uCzs+w3J1FwO3HTdClcg8k8R4SOnmNGAL4251F6vfq9aZ0I1RNyg7IYzkuT5GH5+
	Oz0BKZhrivDIqqeSeauNgyXM5JPwG/Dn8rTu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ld+lY19SBVqpLaMb0dG27opbAVQ8RM6N
	5jBxvmU4eh07NtZ+nuQkvHvN+u6pGvhjEZoJ11Ba8O7djRsMWVVoAvGEV1bbG0j0
	y3inCVwIsFJOhNqh60gYFw/pD5cd8hygZ2b1wdY8GLQoY9tPjHI4GnqaWoo0FB2T
	XRxQw/zik94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 432CB64B9;
	Tue, 17 Jan 2012 13:46:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBF2E64B7; Tue, 17 Jan 2012
 13:46:49 -0500 (EST)
In-Reply-To: <vpqr4yy1pv6.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 17 Jan 2012 13:21:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D760082-413B-11E1-94D0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188710>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I doubt that would be sufficent or appropriate. If some caller _WANTS_ to
>> add a SP, shouldn't we be devising a way to tell zsh to add it without
>> quoting,
>
> Yes, this is the point. But up to now, nobody found such a way so we're
> just trying to work around it in the less painfull way for the user.

Ok, I take it that the original patch is meant as a small step in making
it a usable state, by not adding useless "quoted SP". In the ideal world
it may be better to add SP but we do not know how without zsh interfering
with our attempt to do so and adding an unwanted quoting, so we are taking
the second best approach that we at least know works.

Which is fine by me, and as you said, the completion script always asked
zsh users to add SP themselves, so it is not even a regression.

The real reason I am continuing this thread is to keep it alive so that a
zsh guru would jump in from somewhere and show us "here is how to tell Zsh
not to quote $suffix"; that does not seem to be happening yet, so let's
use your patch as-is.
