From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Thu, 18 Apr 2013 10:05:44 -0700
Message-ID: <7v38un93br.fsf@alter.siamese.dyndns.org>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com>
	<1365348344-1648-2-git-send-email-ralf.thielow@gmail.com>
	<516F95D1.5070209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:05:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsHQ-0001FV-VW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967271Ab3DRRFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:05:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966557Ab3DRRFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:05:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09C0E17222;
	Thu, 18 Apr 2013 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LHrpQ8nfBW/+EliSqdiqt7v+iBo=; b=kB+WON
	UEoQzs+CaMTbeMvZt09GSVSVKJHBpNmzDDam70sKTOwnBTUYnlvnvTE0INB+Vs4i
	kZXMhkXHX/Pl3d7HQfj/7hqQVyP7qViXDzbRw0wbDNz2tv0v78Z+AfvKtdWvUme7
	pPk0sc22zLp1FEylX1SC/99UZxCI6e0DoNuN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tE78GUqfxQP/j7YhCnf14l1xdaqUKFAW
	XtKKKgT+2TTlbvK9EFqYLYvuDhfhF0KlNJAzlbHEv7ojGMegdZBFrHsh5kO25hUk
	Lv/s+euVkWtrKXfqXSAk6tBafxvwe8aYQ8uxv5ZYJcoRrvNBU5yV3xRf6UGdauRz
	TboFXP3FuNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F19C017221;
	Thu, 18 Apr 2013 17:05:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65B7017220;
	Thu, 18 Apr 2013 17:05:46 +0000 (UTC)
In-Reply-To: <516F95D1.5070209@viscovery.net> (Johannes Sixt's message of
	"Thu, 18 Apr 2013 08:42:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36296730-A84A-11E2-8168-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221667>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> MSYS bash interprets the slash in the argument core.commentchar="/"
> as root directory and mangles it into a Windows style path. Use a
> different core.commentchar to dodge the issue.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ...
> -	git -c core.commentchar="/" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
> +	git -c core.commentchar="x" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&

Sigh... Again?

Are folks working on Msys bash aware that sometimes the users may
want to say key=value on their command line without the value
getting molested in any way and giving them some escape hatch would
help them?  Perhaps they have already decided that it is not
feasible after thinking about the issue, in which case I do not have
new ideas to offer.

I'll apply the patch as-is, but this feels really painful to the
users.

Thanks.
