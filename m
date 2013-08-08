From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Thu, 08 Aug 2013 14:57:08 -0700
Message-ID: <7vd2pn977v.fsf@alter.siamese.dyndns.org>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
	<1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
	<alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info>
	<20130808163539.0b59b20a@sh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, avarab@gmail.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7YCr-0002S9-U9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153Ab3HHV5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:57:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab3HHV5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 17:57:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 342E037D04;
	Thu,  8 Aug 2013 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BhTNuIcS7X7lNi+H7ObdRs7zhX8=; b=HOevU5
	mjlTX6az+w57soVBHxt/dNDioQGWVpfn6RcRwG1fEZc82potYGGEC/P+6gxhC961
	MrcgT4uVCdpxxIRcOijXk21wWRRM39lSJ0MXBM7as+n0vRaHMJ4ZEWfLTOEtQDl3
	71l6p/LUgQEpyM+u5cutiyV5Rd88L1E6n6xSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfrSTXS9e/4BPpf1NLGT7NwvccH8sSiJ
	L+XYp9IPkpwSYOKA7XfBs5UV+nlNaUfcsAGsNsFfOOkQ9asWQvfngH+dhsZyLNDF
	41BUcEjihfuEUV4M/HhmqT9tdpYxQyRIDxfkUxoGbMzv1xmmhBK8S9ApIy1STCIu
	Zhd62lYiia8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27E2E37D03;
	Thu,  8 Aug 2013 21:57:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38DC337D00;
	Thu,  8 Aug 2013 21:57:10 +0000 (UTC)
In-Reply-To: <20130808163539.0b59b20a@sh9> (Stephen Haberman's message of
	"Thu, 8 Aug 2013 16:35:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79982064-0075-11E3-8524-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231942>

Stephen Haberman <stephen@exigencecorp.com> writes:

> Hi Johannes,
>
>> This should probably be added to config.txt and
>> Documentation/git-pull.txt, too, right?
>
> Yep, I meant to note that I'd do that after getting an initial
> confirmation that the pull.preserve-merges was the preferred approach.

If you were to go that route, no dashes in the last component of
configuration variable names, please.

> (I was being lazy and didn't want to write up docs only to switch to
> overloading pull.rebase or what not.)

I think we have a recent update that allows you to say

	[pull]
        	rebase = false

to mean "I want 'git pull' to use merge".  Currently the other
choice is:

	[pull]
		rebase = true

to say "I want to run 'git pull --rebase'".  I do not think it is
unreasonable to extend it further so that

	[pull]
		rebase = preserve

is understood.
