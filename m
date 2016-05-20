From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack.c: use of parse-options API
Date: Fri, 20 May 2016 09:52:21 -0700
Message-ID: <xmqq60u8fz96.fsf@gitster.mtv.corp.google.com>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr>
	<xmqq60uakmr4.fsf@gitster.mtv.corp.google.com>
	<1446970271.10941827.1463727190993.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 20 19:00:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3nf4-0005E0-1y
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbcETQwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:52:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751331AbcETQwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:52:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2A751CA30;
	Fri, 20 May 2016 12:52:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lMmvqt5xwwHDdPUoUywmjHxLRLY=; b=b2VTtx
	F4qyUeQveO8a4IRsxloW16wb0BluY2eoWBC5ZzLZUgAmiklbIYu5shsd9f2Z2Vxh
	brtvXuS7QiJ/lEYs7S9nlbgJbUivTzhGi7ZwbceU5IeyjiJksfwSTkjhtWbsd7gq
	FC2aPI3GfaMnLULPuwDc7mXcbBfqDamnWrZ4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nknaQ6HSlcS6cWlf2dOsxf7I/tEDcMyA
	hRrvuCh2iJKuNtxpFNn7BP1Cb1cf7iLMKPZzPsyjbMu0MkGGm2i7D5cExVvwuOAT
	BB8esjIzwZ7KnWnHMdmYRcu8xOillDTh2hWOl/8/UdQQ3AlXUMa80kX/Ry1rONH2
	79RYgcqC1HM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA23B1CA2F;
	Fri, 20 May 2016 12:52:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 502EA1CA2E;
	Fri, 20 May 2016 12:52:23 -0400 (EDT)
In-Reply-To: <1446970271.10941827.1463727190993.JavaMail.zimbra@imag.fr>
	(Matthieu Moy's message of "Fri, 20 May 2016 08:53:10 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3972F85E-1EAB-11E6-8C33-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295185>

Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:

>> Using "format-patch --patience" or some other diff option, and pick
>> the best one to give to "send-email" would indeed be a way to do so.
>
> It's a matter of taste. My flow is "send-email-only", I do as much as
> possible in-tree, and when I notice something to do during "git send-email",
> I just abort and retry. So "Oops, looks ugly, I'll try with another
> option" is OK in this flow.

Ah, I didn't consider "final-review in send-email and aborting".

I agree that it is just the matter of preference, if it is easy to
review everything that you would be sending out, and decide to
abort.  I just thought that final review would be cumbersome in that
flow.
