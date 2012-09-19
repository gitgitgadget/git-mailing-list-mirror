From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 16:34:19 -0700
Message-ID: <7vr4pxegec.fsf@alter.siamese.dyndns.org>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
 <20120919182039.GE11699@sigill.intra.peff.net>
 <7vr4pxg507.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:34:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETmw-000343-K7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab2ISXeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:34:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930Ab2ISXeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:34:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D77198DE;
	Wed, 19 Sep 2012 19:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ls6GFlAahplx+qWdiQKd9WfHe0E=; b=WPpAY4
	rWS482XPNOAECUzxByeE1OI5IBnKToJKEqZaI7dEz/XQCk92TmKk89rQJZ6/Evb8
	UoU3rc/0++uJrWzXywcQ5M9XbEUGXsBNlk/jIVQ+Eev2MdQ9dKSzGsNDgaClb9wc
	fbw68/1cq7ABkk2Yd4WZeaZyk13ymDa5L81TM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hNBLXZoVlkrZ+IaD/8fUC8lcBXB2NK95
	SgcXkHHF8zqXOLi+hN69TVaQrHj67f/HyZaJkRmA9881XpIQLGVffeQ/mW9QOkuQ
	U9y6Xrxx15RcOwEkxIN1tZi3+UbNhO4JlvBH0eA9Zl6fbV0ygM1qpcWOtyO25PCI
	qbAlYMp399w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AFF698DD;
	Wed, 19 Sep 2012 19:34:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B13F98DC; Wed, 19 Sep 2012
 19:34:20 -0400 (EDT)
In-Reply-To: <7vr4pxg507.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 19 Sep 2012 12:57:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89474682-02B2-11E2-AF48-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206011>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> We should also consider briefly whether anybody is relying on --oneline
>> for machine parsing. I think "log --oneline" is fair game, but I wonder
>> if people calling "rev-list --decorate --oneline" should be considered.
>> It seems kind of unlikely to me, considering that the decorate output is
>> ambiguous to parse anyway (if you see parentheses, you cannot tell if it
>> is decorate output or part of the commit subject).
>
> Yeah, I do not think it is likely.  Among the in-tree scripts,
> git-stash does use rev-list --oneline but the purpose of the call
> exactly is to grab a human readable one line summary, and it will be
> happy with any change to make --oneline more human readble.

Having said that, one of my often used alias is

    [alias] recent = log --branches --oneline --no-merges --decorate --since=3.weeks

to help me see what topics in flight may potentially interact with
an incoming patch, when deciding on which commit to base the patch
on.  Pushing the decoration at the end to let it fall off the right
edge of the screen severely reduces the usefulness of it and defeats
the point of using --decorate, at least for this use.

I could use --source instead, though, if it is not moved by the
patch.
