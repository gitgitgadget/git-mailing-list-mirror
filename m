From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Tue, 19 Jan 2016 10:44:09 -0800
Message-ID: <xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
	<CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Niek van der Kooy <niekvanderkooy@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:44:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLbGK-0001lS-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbcASSoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 13:44:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755254AbcASSoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 13:44:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E85973C62A;
	Tue, 19 Jan 2016 13:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cbzZY0hebVmV3Z6BTMvfuuzPvw0=; b=J43Ls1
	CT7SlmnDIcR8c9lmw3tTzCVPm/IGHa4UHOenzl6NgUVnoA6E3QpjSQJLi1wxy7U1
	NvQFsUIACDalA7vWYX1c1aEUgAm6N6eTfhbJeHrFExL6Xshk2kR7xgkIBbWun4HP
	P0BrmexOYp1tDYEN2hhIUNd5/BhugATpIoj50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/9JFDuvUvGpwfn2lPPqC4V9X0CBXs+/
	nGfzjtSfY6dSQs7LHIQo0GEbzqfQSyolL4lyY8wsziV4QssVSm+XxvW+ce130jQ/
	bWM3VImU8KqiCq7eqDk5T3YjkZYNkbUpKS214EEgrzPbISycI5cY4JFLom39qS8q
	ExU59DEMDqQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0E273C629;
	Tue, 19 Jan 2016 13:44:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 686E23C628;
	Tue, 19 Jan 2016 13:44:10 -0500 (EST)
In-Reply-To: <CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 19 Jan 2016 19:20:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0CB7F0A-BEDC-11E5-BD58-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284369>

Duy Nguyen <pclouds@gmail.com> writes:

> I think it's the intended behavior.

Yeah, pre-commit was designed for inspecting and rejecting, not for
tweaking and munging.  Perhaps "git commit" can be tightened to make
sure that pre-commit that returns successfully did not muck with the
working tree and the index?
