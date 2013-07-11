From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Thu, 11 Jul 2013 15:14:35 -0700
Message-ID: <7vzjtspwvo.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 12 00:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxP8P-00009V-LG
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab3GKWOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:14:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756847Ab3GKWOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:14:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD5CA30803;
	Thu, 11 Jul 2013 22:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yHKdBS72XeWNfQ4WcK2q56Ms8qM=; b=s7wNlR
	lkFtdtThAYGliA7dkza471ktbTkhS50K+0MYMJjG1iMhYbdMeP8IrezKIsi9U+yN
	XqFWDf3BNt7ZszYb6CbPOfOk5uoz9k4XxT8gBd6sRTbnID67gaxKm16kwIRp4YXt
	HzbOoPfzge+WuT/aMq2k8pHAu36aU1Q9zVSQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DD4QWIwU6TLZ96gHdj6VKVkVBcrcCMPW
	eGfK1VZ7ucL8oA7eqp/ThEpDGBjkEEDqco/6et+1HxlzaQ/4XOkDvG9EDadNYfi8
	/U3GeaHhBgNnH7/NXcLp3gHHcmRZHxmdrVfd/1L8yqsjIVoWLk32Y59KHY8fuexi
	9PNsyXdi+/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A267E30802;
	Thu, 11 Jul 2013 22:14:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E2FA307FF;
	Thu, 11 Jul 2013 22:14:36 +0000 (UTC)
In-Reply-To: <51DF1F56.9000705@kdbg.org> (Johannes Sixt's message of "Thu, 11
	Jul 2013 23:10:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45FBC6D4-EA77-11E2-8AEC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230135>

Johannes Sixt <j6t@kdbg.org> writes:

> Again: Why not just define +refspec as the way to achieve this check?

What justification do we have to break existing people's
configuration that says something like:

	[remote "ko"]
		url = kernel.org:/pub/scm/git/git.git
                push = master
                push = next
                push = +pu
                push = maint

by adding a _new_ requirement they may not be able to satisify?
Notice that the above is a typical "push only" publishing point,
where you do not need any remote tracking branches.

I am not opposed if your proposal were to introduce a new syntax
element that calls for this new feature, e.g.

	[remote "ko"]
		url = kernel.org:/pub/scm/git/git.git
                push = *pu
                fetch = +refs/heads/*:refs/remotes/ko/*

but changing what "+" means to something new will simply not fly.
