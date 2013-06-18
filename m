From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] checkout: respect GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 09:53:51 -0700
Message-ID: <7vli675pi8.fsf@alter.siamese.dyndns.org>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
	<1371557670-12534-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozAM-0000MP-UE
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996Ab3FRQxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:53:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932974Ab3FRQxx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:53:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33EB229F3E;
	Tue, 18 Jun 2013 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K1wxvUkXl2xqN9o5dQxgccyVklQ=; b=bt+d3G
	/TATw5V20KIqttDbDusUvAh2WOP7tJ+4WKL1AHTt46uX7cA9lKkSqZu+JNK5VC2e
	kzV2ceL8lnw28ThMUIUjLZxmULchJgNjDfxzwwG21nY1asXIMVqEkb7a3JOrNX/g
	ovWs4Zm9yw6sKFCHzTVVs7ZKKeS4w6EaYoPuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cm6Kvv9ktqqCpcAeFxtUN6wPY7i2vWtZ
	uiD6+GAt6Q4+0zNVuM/xRhDswjVVCKJ0pALahhuY89SP+wzZI3LLKOJquouaCP1H
	SAGd3mOvS3kXUXUhlNTl5SpvWXRLdi1cAVmDxQ7w/OSftQjUVHPCc37Z4xBHnYUd
	TXpAtcqcj/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2357229F3C;
	Tue, 18 Jun 2013 16:53:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2F529F3A;
	Tue, 18 Jun 2013 16:53:52 +0000 (UTC)
In-Reply-To: <1371557670-12534-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 18 Jun 2013 17:44:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7DFBE0C-D837-11E2-8DF5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228273>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Fix the failing tests in t/checkout-last by making checkout respect it
> too.  You can now expect
>
>   $ git checkout -
>
> to work as expected after any a rebase [-i].  It will also work with any
> other scripts provided they set an appropriate GIT_REFLOG_ACTION if they
> internally use "git checkout".

Yes, it is better to clearly say that this just opens the door to
fix others and at this step "rebase" is the primary thing that is
fixed.

By the way, please stop doing "t/checkout-last" which I have to
manually fix-up every time to its actual prefix (i.e. I cannot
review with "less t/checkout-last*" to see what the log message is
talking about; I can with "less t/t2012-checkout-last*").
