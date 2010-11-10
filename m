From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Wed, 10 Nov 2010 11:57:11 -0800
Message-ID: <7v1v6thrzc.fsf@alter.siamese.dyndns.org>
References: <20101110170819.GA3031@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 20:57:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGnN-0002is-1M
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 20:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab0KJT5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 14:57:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0KJT5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 14:57:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7B683773;
	Wed, 10 Nov 2010 14:57:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NCXiPQSS4RTwUWhYUYuk5CtZPJo=; b=SjLzDk
	em9gyBAfbPE0Rd3jcFLB9Gd/0MyXCokEl20VTd1q0GrhHq9LOhl90wR+n8tAUthk
	H3Sfc9sgbeiz6xzJRCA8UE4r+utHMmIQLXP79QXAASQbfZMcKer/qpo6uJjfY8bp
	oI5lLo3WX0mK8yvT+2oG8OKf17GXFBPGXCLjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xWFPkYRotqf0YTzqLyugTRJFBsqa1P4+
	Gdvc4pbIu66bjKWlgK+gK99CcC4Xqat8U4DAEVLi9MDSUxsqSmfj49NraZoZSzX4
	3+S3QJc74mwC1ijNuolaqKVdp1FofGjvPwM7yEO/Ba6dLRwMKhgFAO7rqp6uvFsv
	Mz7qGzST9gU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B00B63772;
	Wed, 10 Nov 2010 14:57:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD551376B; Wed, 10 Nov 2010
 14:57:16 -0500 (EST)
In-Reply-To: <20101110170819.GA3031@gnu.kitenet.net> (Joey Hess's message of
 "Wed\, 10 Nov 2010 13\:08\:19 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9C60598-ED04-11DF-8414-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161177>

Joey Hess <joey@kitenet.net> writes:

> I've noticed that if I make a pre-commit hook change the files that are
> staged, those changes are not reflected in the commit message. For
> example, if a pre-commit hook git add's somefile, the commit message
> won't reflect that. I guess prepare-commit-msg is being run before
> pre-commit for some reason?

My intention was that Documentation/githooks.txt would document things
that are allowed (e.g. "applypatch-msg" explicitly says "The hook is
allowed to edit the message"), and anything that is not specifically
allowed is not.

"Is it kosher" is a difficult question to answer, as something may not be
allowed but there may not be an enforcement mechanism to deny it, iow, it
may happen to work by accident.

In general, pre-anything is about checking and denying and is supposed to
be free of side effects.
