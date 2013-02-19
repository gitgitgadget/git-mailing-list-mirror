From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] clone: suggest index version 4 when the index is
 bigger than 512 KiB
Date: Tue, 19 Feb 2013 10:59:47 -0800
Message-ID: <7vobfg5duk.fsf@alter.siamese.dyndns.org>
References: <1360848843-12092-1-git-send-email-pclouds@gmail.com>
 <loom.20130219T113730-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 20:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7sQf-0007Ua-07
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 20:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934185Ab3BSS7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 13:59:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933921Ab3BSS7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 13:59:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF632BF71;
	Tue, 19 Feb 2013 13:59:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VuB3M1vmc7YEHxyNm8pwtVI3wIc=; b=npFdE4
	wT6pZSRGglrInJrLMia2u+cXma7PaUGi06/StOVbHgliaaYmjG26rcL195p4kGzv
	pFFvLyA3RQZv6Xm7iZ0ymA3dNr9XoA+77ddBXMOfcJbBQhrz70XrJb514CrKETN+
	/fnMq3U7P7NaYci8RpNLLqPoojakBIXRsZkV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OfRrOFeCo3zgYo4Rxd9eCRd0M7VVIcTE
	bIQZ0xxq9U17u20cXgX0SD9ud7wBAT2wO7bUKOVxdxhvkp7pgxtyfzxDek17qP2U
	zGiI0dA1TaZHxNF2PRLMcnVUXeRg2wIInCTt+j56eo7P4te6MBLy9f0XtoYMsszs
	J82hOkQ1Vfo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C50BF6E;
	Tue, 19 Feb 2013 13:59:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56EC4BF60; Tue, 19 Feb 2013
 13:59:49 -0500 (EST)
In-Reply-To: <loom.20130219T113730-546@post.gmane.org> (Thomas Ackermann's
 message of "Tue, 19 Feb 2013 10:45:04 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E9474E-7AC6-11E2-8D8B-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216647>

Thomas Ackermann <th.acker@arcor.de> writes:

> Is V4 really recommended for general use?

If you stick to C-git, I do not think there is any reason to avoid
it.  It is already a mature technology, the difference between 2 and
4 are so trivial that it is very unlikely for a latent bug to be
hiding in corner cases.

It is a different matter if various reimplementations already
support the format.  You can try it out, and if you find that other
tools based on reimplementations of Git you use do not understand
the format, you can safely go back with

	git update-index --index-version 2

after you upgraded to version 4.
