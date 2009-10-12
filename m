From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/4] git check-ref-format --print
Date: Mon, 12 Oct 2009 16:36:48 -0700
Message-ID: <7vococ6v73.fsf@alter.siamese.dyndns.org>
References: <4AD0C93C.6050306@web.de>
 <7vws327wbp.fsf@alter.siamese.dyndns.org>
 <20091012052536.GA11106@progeny.tock> <20091012053141.GD11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUY0-0007dA-DZ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbZJLXho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 19:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756934AbZJLXho
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:37:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772AbZJLXhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 19:37:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E292562F7;
	Mon, 12 Oct 2009 19:36:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQBkgxEY1d3IrBzNRd42IfWr4Ck=; b=gs9KCB
	mht8raCs2nwUwxKLY10Bjpzvu/2+x7HB2gBnix3CXZxMlVbRYrC1JMd6LYMgr0/S
	h/0r2+sMc8c9OVeIsRQFgLPSNIyPbw+BIwif1IfRx2zvbY42hoedJA+YPCPJ4Yjz
	/5oP5JQ7AR6yOO/hkplp3cTv1crjKnLhlegsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p7L2BAO3t/+9OblCNLZaX7TYHqK00i5n
	NR0vwjBb7M6akETA9HIKuhPCqtv2c2+ZsNJH9WxUhlCJJc6bANWIiHNTGsI+iG+G
	q+11C7lOPER/U+PCBQw07vU7idYpsx9uaGpZjeuMz1yqTcNsiYSs86UxFQajHwfr
	/d6YbToo8aA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34A40562F6;
	Mon, 12 Oct 2009 19:36:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76D09562F2; Mon, 12 Oct
 2009 19:36:50 -0400 (EDT)
In-Reply-To: <20091012053141.GD11106@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 12 Oct 2009 00\:31\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 203AEDE2-B788-11DE-A26A-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130093>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In the future, it would be very nice if this command could be
> modified to transform Unicode ref names to some appropriate
> normalization form, to make Unicode ref names usable in Mac OS X,
> too, and less confusing everywhere.

I do not disagree with a desire to help fixing the unicode insanity on
that platform, but I suspect that check-ref-format is a wrong place to
tackle the issue.  You would need a similar filter for outputs from the
likes of ls-files and "diff --name-only", iow, anything that deal with
pathnames, no?

It would have be something like "check-ref-format --print | iconv ..."
pipeline (conceptually, if not forcing the pipeline to the end users, that
is).

Also are people happy with "--print"?  I was waiting for others to reword
it to "--normalize" or something like that.  In your documentation you
explain it to "canonicalize", and in your tests you name the output
"normalized".  I am fine with either wording, but would like to see us
using only one, not both.

Thanks.
