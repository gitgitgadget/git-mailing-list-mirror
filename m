From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A couple of rebase --autosquash proposals
Date: Mon, 09 Dec 2013 12:20:30 -0800
Message-ID: <xmqq1u1lzshd.fsf@gitster.dls.corp.google.com>
References: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
	<52A56887.4070909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Randall <javabrett@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 09 21:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq7Jm-0004NO-UK
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 21:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab3LIUUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 15:20:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968Ab3LIUUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 15:20:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E79594C4;
	Mon,  9 Dec 2013 15:20:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RsRylF7cVwd+Syy5hce6brxVTCQ=; b=lSlirG
	ICu5SsdKsKYjGguZCzUmawaLYXnDDNNF7l6pnxl9d/G0ZNmEa+NcNHiJrmOCCsz5
	iANdMwzhbeBoFmZ+Z0qGfJtVXqTsa4ECsEHOzWOS9mTBMPLomPlirEFyHoJ33z8E
	BRdIgqO/qREzLcHwx1Ix+qOS0GLKqiXSAkOMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SHV3mOWsT3kKdeiz9WFK96gIeDKMsk+9
	Bd0cYREy16/KWZxzUkZEmKgkdXnJMqDB6kqeHoseoOV0jGWTQTtHWnIe4k/tOrSW
	7Tx+4zPAjMytGHYKaaxgT6HYpQxVHflYNtL1Hsz0xzJYOM2pRQzvU2a8Ln6PI+0K
	LLqoBYWeb3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECF6594C3;
	Mon,  9 Dec 2013 15:20:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 532B6594C0;
	Mon,  9 Dec 2013 15:20:32 -0500 (EST)
In-Reply-To: <52A56887.4070909@viscovery.net> (Johannes Sixt's message of
	"Mon, 09 Dec 2013 07:51:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5A9734FC-610F-11E3-AD16-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239087>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 12/9/2013 3:23, schrieb Brett Randall:
>> * fixup! or squash! on it's own would default to fixing-up the
>> previous commit (or result of previous step of rebase if that was a
>> squash/fixup).
>
> Why would you want that? To fixup the previous commit, just use 'git
> commit --amend'. What am I missing?

When you are not absolutely sure if the amend is a good thing to do.

Then

	work work work
        git commit --fixup HEAD
	work work work
        git commit --fixup HEAD^
	work work work
        git commit --fixup HEAD^^
	...
	git rebase --autosquash -i ...

may become a good way to polish a single commit.
