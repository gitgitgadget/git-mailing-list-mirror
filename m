From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Tue, 06 Dec 2011 13:15:44 -0800
Message-ID: <7vfwgxflkv.fsf@alter.siamese.dyndns.org>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch> <20111206190217.GD9492@sigill.intra.peff.net> <201112062117.57690.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:16:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2Mi-0002By-8y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab1LFVPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:15:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559Ab1LFVPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:15:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D39A25E45;
	Tue,  6 Dec 2011 16:15:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+pjs1Qlgf1sqhA8cFQhudUJ4daU=; b=ONhEqE
	W6sjKa6+hxcn+5GE87UL/HXYnEGfS6gkENqDIlaVx0uVyDI6Mpmf+JSHeyUBZb7k
	7KWHLx+LkumqJWy3eYFtAGeJEokvJP8jD9qZs9akz/hg1b0FBxkx+QQTNA5oYGyM
	HZWaQClA2s7gnSy5x0hV8UXAkt30XuFB/qpcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8B5SujgeN47sC14t9x3M3FmYHmxw7Vd
	QdnbDJlwrM1ce5buNuRBQOAG5Go5XpsGRiVInw4CsfkAHP+kkvTxVv+ID9rPDMzh
	k89W2uugxK7H6Yfw/ED2i8CfgAQPGoRiD76CFNCfuYIOOzNVNccA9eIE+w4D5FjE
	sHtcZO3zARo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB29B5E44;
	Tue,  6 Dec 2011 16:15:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 447715E3F; Tue,  6 Dec 2011
 16:15:46 -0500 (EST)
In-Reply-To: <201112062117.57690.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue, 6 Dec 2011 21:17:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76A6136E-204F-11E1-9B26-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186386>

Thomas Rast <trast@student.ethz.ch> writes:

> Actually (sadly) I'll have to revise it.  It doesn't match much of C++
> either, and I haven't yet come up with a reasonable regex that
> matches, say,
>
>   foo::Bar<int>::t& Baz::operator<<(
>
> which I would call ludicrous, but it's valid C++.

Heh, I'd rather not see us go that route, which would either end up
implementing a C++ parser or reverting the heuristics back to "non-blank
at the beginning of the line" that was already reasonably useful.
