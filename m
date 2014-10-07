From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Tue, 07 Oct 2014 11:37:46 -0700
Message-ID: <xmqqzjd7enet.fsf@gitster.dls.corp.google.com>
References: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:37:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZdx-0005wH-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbaJGSht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 14:37:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52679 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754371AbaJGSht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:37:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B40C141B2;
	Tue,  7 Oct 2014 14:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SMqGKKOIK9s3sO+nd+mhM/KTofQ=; b=Wo5AFF
	YFR4qO/LDUHmBvcqkNAVVs0dRJsGjmDT+9yaMMv2P32OlzI/ljLtMtsL11quK0bp
	JILKfha5xbVaaWrxNOkasxKVNcxzX2N5iZwD1GkIVtYuJWvR8e2x2kWWmrOQxsDd
	vFl0RsM51ZEG6pV5BZXumOjK7y4BNYNchgHGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jhq6Ar/aqtEdVhzNcWeWx0vRydNF5Ij+
	l1bJFRopi31osmAnBRg9UsZzxJwX6wsAvY+Fwb2jH6vB/++gTEwZxTmnQkFLRYg4
	b/GYcPO0SB/1vT/FEFecg/6jJh6X2fJadR87xxiW3g/Z+0lUnz2BDfVx1kuNp3oo
	jJviJV/RSKI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5130D141B1;
	Tue,  7 Oct 2014 14:37:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB578141B0;
	Tue,  7 Oct 2014 14:37:47 -0400 (EDT)
In-Reply-To: <1412699710-3480-1-git-send-email-sorganov@gmail.com> (Sergey
	Organov's message of "Tue, 7 Oct 2014 20:35:10 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09026550-4E51-11E4-9876-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257939>

Sergey Organov <sorganov@gmail.com> writes:

> This option allows to create merge commit when fast-forward is
> possible, and abort otherwise. I.e. it's equivalent to --ff-only,
> except that it finally creates merge commit instead of
> fast-forwarding.
>
> One may also consider this option to be equivalent to --no-ff with
> additional check that the command without --no-ff  would indeed result
> in fast-forward.
>
> Useful to incorporate topic branch as single merge commit, ensuring
> the left-side of the merge has no changes (our-diff-empty-merge).
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---

The workflow this implements sounds like "because we can", not
"because it will help us do X and Y and Z".  Why would it be useful
to limit the history to a shape where all merges are the ones that
could have been fast-forwarded?

I cannot justify that sensibly myself, which in turn makes the
feature smell to me that it is encouraging a wrong workflow.
