From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 15 Feb 2016 15:56:33 -0800
Message-ID: <xmqq4md9o7da.fsf@gitster.mtv.corp.google.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
	<1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
	<xmqqegcdpqhh.fsf@gitster.mtv.corp.google.com>
	<20160215225938.GA30631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Johannes.Schindelin@gmx.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:56:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVT0S-0007HB-NB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcBOX4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 18:56:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752444AbcBOX4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 18:56:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE7DE45B98;
	Mon, 15 Feb 2016 18:56:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aax7eCGTqZB+QdGpd6tF7RfEprU=; b=r2kSmG
	PQsrWnOA8jINeckMJrapc/K6tWxkZZN1794vQNi16RuAwsxSKnUHOhtoz44dhKGn
	TjACTYfrwISY/UoY32wQxsYWwrgUhYH6/tkWFxpk8Uj7sB5SyeMw9x9jU262zKQz
	Z+x5//cFNaDqrZEUCZKnYLEXF8m4X95HkgG/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U6ZbGd2a4aW86I8qjxSRwTdQSLeGfdiV
	WowHQOqhdfVm1zE0/ku3SMJ4a9l1TfG7ghUJuiwtf03/WopY5lCvy53uC1WlO24b
	/3DmBqcH2yy43SLBx9S29deHEvtSnJdp+auJmU1gDQj6eKn+JacLKM8UUlJmvEuN
	HuRMjSNZUiU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D60645B96;
	Mon, 15 Feb 2016 18:56:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB2E545B94;
	Mon, 15 Feb 2016 18:56:34 -0500 (EST)
In-Reply-To: <20160215225938.GA30631@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 15 Feb 2016 17:59:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE7BB394-D43F-11E5-9B0C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286293>

Jeff King <peff@peff.net> writes:

>> An existing test t3300 tells me that a test that uses a path with a
>> tab needs to be skipped on FAT/NTFS.  If your goal is to make sure
>> dquote is exercised, can't we just do with a path with a SP in it or
>> something?
>
> It has to trigger quote_c_style(). You can see the complete set of
> quoted characters in quote.c:sq_lookup, but space is not one of them.
> Probably double-quote or backslash is the best bet, as the rest are all
> control characters.

Yeah, 3300 seems to use dq for that.

Thanks for checking.
