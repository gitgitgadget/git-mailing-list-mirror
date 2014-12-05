From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 10:33:47 -0800
Message-ID: <xmqqwq66osj8.fsf@gitster.dls.corp.google.com>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 19:33:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwxhR-0003vy-PA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 19:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbaLESdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 13:33:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaLESdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 13:33:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E99512293F;
	Fri,  5 Dec 2014 13:33:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q5NTS5iFkx31m2gq31HGm/oouMk=; b=hI+kVU
	CPW017b93oGsvtf7rQ7oybUm1eMvZlYUrkcEAxV8wloNlsA25nUSMj52gsHtsinP
	iOMiJpfJorORpUzdufWg6Lqc2es6X3ZtmUAYFCyqJoSkXRX423kRxiFgumktsjOi
	IA3LlxoP2CS1Zmr74tYoOjTLaOklWeqMuQxdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQx2+pwYWsE9fgSRCZEqgJX6X/z3328I
	vvuLo+FPNkdQPLQQEtJ4fDGc9pQsDBLF6hsOp7BeXl+HLKPyjb4s2Ky6DWoG/OOi
	rGnVSUXaJSLXQsNA7wapBOqywM/+0MukIFEwUFhXrMw/AT5lyRbERXJ39ugyh/x4
	5QbPqfwSC4Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF9052293E;
	Fri,  5 Dec 2014 13:33:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 644BF2293D;
	Fri,  5 Dec 2014 13:33:48 -0500 (EST)
In-Reply-To: <CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 5 Dec 2014 17:52:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40AD311C-7CAD-11E4-A97A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260881>

Duy Nguyen <pclouds@gmail.com> writes:

> You are correct about the original idea behind --assume-unchanged. But
> over the time I think we bend over a bit and sort of support these use
> cases. For example, aecda37 (do not overwrite files marked "assume
> unchanged" - 2010-05-01). The change is one-liner, so I don't mind
> doing it.

I think that was a misguided change to make the semantics muddy and
to break the existing users who use the bit for its intended purpose
(i.e. to avoid lstat() by promising that it is not necessary), and
not "bending over to support".  Offhand, I doubt we would want to
add more of the same kind.
