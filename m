From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] format-patch --signature-file <file>
Date: Tue, 20 May 2014 08:06:50 -0700
Message-ID: <xmqqzjic1oc5.fsf@gitster.dls.corp.google.com>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
	<1400203881-2794-2-git-send-email-jmmahler@gmail.com>
	<20140516081445.GA21468@sigill.intra.peff.net>
	<20140517072548.GA18239@hudson.localdomain>
	<20140517074224.GA16697@sigill.intra.peff.net>
	<20140517085911.GA18862@hudson.localdomain>
	<20140517100013.GA18087@sigill.intra.peff.net>
	<20140517153943.GB31912@hudson.localdomain>
	<xmqqd2f93e0m.fsf@gitster.dls.corp.google.com>
	<20140520054621.GA28317@hudson.localdomain>
	<20140520062132.GA5222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 20 17:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmld6-00052o-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 17:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaETPG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 11:06:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60091 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaETPGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 11:06:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FEFC17BB7;
	Tue, 20 May 2014 11:06:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cVqN6g+tIabzl2MjRWRK8YJXc6E=; b=vQmhL3
	l2YSgootSe4JayjoTIPjiS+CLASX/E7kMVMcNQxMQIrG9bUJDrRN7++6cGvyDQ6y
	+iHG1L4UG0Dl/+Ptwt3schcBB0yqtWlIXHHkdvNHDwqtNHqaCCJbUFlq2IlqQsti
	7+WRgzDFRfaUVncjN8ZaM1ISZicmkIJiKxdXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uPRFjJwhBVKYZmxMbqoIOkta2bf41OYt
	C9Hyym5iLlbHgbL+n76RMC6/R8pZNoiWexrGqn2saCow9hX9irpYejj62vGUNmjN
	MgmEMMvcWFGax2rzkH2D8nxRDVKintmHD3HkugvOd8gtVfpMmZctocTD0O5XQEUc
	tvEfjEVfeU0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0505017BB6;
	Tue, 20 May 2014 11:06:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AAA3517BAF;
	Tue, 20 May 2014 11:06:51 -0400 (EDT)
In-Reply-To: <20140520062132.GA5222@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 May 2014 02:21:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5F886FC6-E030-11E3-85D0-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249692>

Jeff King <peff@peff.net> writes:

> You could do:
>
>   #define DEFAULT_SIGNATURE git_version_string
>   static const char *signature = DEFAULT_SIGNATURE;
>
>   ...
>
>   if (signature == DEFAULT_SIGNATURE)
>      ...
>
> but maybe that is getting a little unwieldy, considering the scope of
> the original problem.

I agree.  It is an invitation for doing something like

	#define DEFAULT_SIGNATURE "-- \nfoo bar\n"

which defeats the purpose.

I have an unrelated and larger design level suggestion, but it may
be better for me to refrain from sending it during the -rc freeze.
