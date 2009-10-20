From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extra checks for PERL_PATH and SHELL_PATH?
Date: Mon, 19 Oct 2009 23:36:26 -0700
Message-ID: <7vr5syshat.fsf@alter.siamese.dyndns.org>
References: <20091020035051.GA3237@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08Ks-0002Jc-1D
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbZJTGg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbZJTGg3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:36:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZJTGg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 13B507E66C;
	Tue, 20 Oct 2009 02:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tOKdrFatANssnyJYWT04qB7AwNk=; b=EPKWw+
	eVGnfoIgYjOMa4P3AxhFo6nIFJga/hFtuTPcZY97iGo5lDzb2rQa6gJBdfyF8YBC
	q5o8YxiNQFMNEoenMSPS46UhL2hnGCLWmRroJFsg5Eoenyn31m8OtpaqnxDHdwLE
	p76FNvauPoZCvt/zPrr/iH5OYEe6pkvGIfg8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ePJRYrA2uak/wleYf1ATbc70BCp31ybT
	OO6bE/oSJdK6eBsh0tLL0nZpuwSLHWbOi4uYvCYlG/SU+3HCRMpMg+i/c1JGLVJR
	0knbuxEKM0hJsMXhHQVpQSthYknBWf8xMopxT4jagczCHdYs2VSiWcOk5Ynvra3J
	A6BZiOOGK24=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8F717E66B;
	Tue, 20 Oct 2009 02:36:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 077DB7E66A; Tue, 20 Oct 2009
 02:36:27 -0400 (EDT)
In-Reply-To: <20091020035051.GA3237@ftbfs.org> (Matt Kraai's message of
 "Mon\, 19 Oct 2009 20\:50\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E70628AA-BD42-11DE-82F8-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130765>

Matt Kraai <kraai@ftbfs.org> writes:

> The top-level Makefile currently contains
>
>> ifndef SHELL_PATH
>> 	SHELL_PATH = /bin/sh
>> endif
>> ifndef PERL_PATH
>> 	PERL_PATH = /usr/bin/perl
>> endif
>
> The checks are only necessary if these variables need to be overridden
> by environment variables, not just via the make command line.  Is this
> the case?

It may not have been the original intention, but the above would mean that
some people may have learned to run "SHELL_PATH=/bin/ksh make" and
changing it would break things for them, no?

I do not think changing them is bad per-se, but we would need to add extra
warnings in the release note to explain this change, that's all.  This
would only affect people who build from the source (including distro
people) so it is not really a big deal.
