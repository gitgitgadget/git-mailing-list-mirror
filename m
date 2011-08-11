From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Thu, 11 Aug 2011 16:47:51 -0700
Message-ID: <7vk4ajo6hk.fsf@alter.siamese.dyndns.org>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com>
 <20110811215650.GA13839@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:48:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qreyr-0007yP-1v
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 01:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab1HKXr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 19:47:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab1HKXry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 19:47:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1394494E;
	Thu, 11 Aug 2011 19:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7TXohndy6DpLF9OWiaYlgq+fNFA=; b=cEyox+
	CN7IN159OQwQhieI4u4ig6lyVJap70XzMK7TCE0ewmBkWXD5ffzaNwh/53m6N8NF
	6qFVl6FtJpas1e08ZHgbBENmxr88/fo435uMS6RFlBZZBErSOg5KXJmTkg0d76ov
	dDbs/vOZBAOQxJrkoiXBuRo9gZxQ+kr36/wq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bHiTsntVsN795DmM0b6U9odKju2cKTTQ
	JmFBJbb6HEmeCeRpDK5L3oFAwRIOG5tLmDnXBJ37lvmBlc1klqwBWnhFS2y+lfvr
	YeYhoq8CO823AbfKUnptOPsXHYyzxRsLetJa9GBQGjsuNMrzIzDlgmA9C5CwXw9P
	nnxUT7t7wWo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 985E3494D;
	Thu, 11 Aug 2011 19:47:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21443494C; Thu, 11 Aug 2011
 19:47:53 -0400 (EDT)
In-Reply-To: <20110811215650.GA13839@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Thu, 11 Aug 2011 16:56:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 545D278E-C474-11E0-98E7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179156>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Another thought.  I wonder if it's possible to leave
> sequencer_parse_args() private to builtin/revert.c, making the split
> a little more logical:
>
>  - the builtin takes responsibility for its commandline interface
>  - the library takes over once the builtin has figured out what the
>    user wanted.

That's a very natural separation of tasks.
