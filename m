From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Mon, 04 Nov 2013 10:17:32 -0800
Message-ID: <xmqqzjpkyqtf.fsf@gitster.dls.corp.google.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
	<1383212774-5232-2-git-send-email-artagnon@gmail.com>
	<xmqq38nh411p.fsf@gitster.dls.corp.google.com>
	<CALkWK0nEMpVUkzafjDkVV-uaLTYzHYUTsZkmwRPkLFa=8NEkPA@mail.gmail.com>
	<xmqqli182mde.fsf@gitster.dls.corp.google.com>
	<CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 19:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdOib-0002Bf-EL
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 19:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab3KDSRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 13:17:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab3KDSRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 13:17:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D8574D15E;
	Mon,  4 Nov 2013 13:17:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bme73X3l8SWZd3T+p/5MJgmMNZY=; b=R0Mrya
	c9xSWUxjKzOzzsfrCZ+mu0LyNcbctCCNp0aEmTv60KzswTCsdjkrDKK/jz0DFJ8V
	96VmWBMkkgZg2DJFm9y+/xGmtGXjIgCYg+pySslz2E/crhIiOAwD6tAYlVmyVUha
	mibvMake/BJbqt2dDLdJ3gTh1LNvoLhXzQgTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJDvefLiDF5ASCrl9qvdbtgvWwOx4h5B
	yA7Y0GthfG8Xn6nvi9vPFy89O+lHzFz5jowI6Mgm7F7Eub50sI8cvszD2gIz8qSU
	4O25JR96tyKZF6wFF1gaTyr2uvR6Q1jAXDOM6FCvsmPYT4NkjBXdqkbzepcOwfKT
	t5LU1nqnmGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70EE54D15D;
	Mon,  4 Nov 2013 13:17:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D48384D15C;
	Mon,  4 Nov 2013 13:17:34 -0500 (EST)
In-Reply-To: <CALkWK0k-8noAJbgzPx3NEx-ucUdZoS4VmqNCKjm3R_5eqFnR7w@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 2 Nov 2013 11:32:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60D10148-457D-11E3-8912-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237293>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> This patch is about for-each-ref and your series does not seem to
>> aim to unify it in any way with pretty-formats, so I would have
>> expected an enhancement in line with the former, not the latter.
>
> While I might never attempt a unification again, there's no harm in
> getting the formats to resemble each other in part.

Yes, but...

> it's likely that
> users of f-e-r format will be familiar with pretty-formats.

... users of for-each-ref format will be _more_ familiar with
formats used by for-each-ref, and it would make a lot more sense to
keep the syntactic resemblance between existing features to show
magic things in for-each-ref and the new feature to show color
(which is merely one new "magic" to the vocabulary in the context of
for-each-ref), no?
