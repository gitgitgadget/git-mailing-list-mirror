From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/5] fmt-merge-msg: Make the number of log entries in
 commit message configurable
Date: Sat, 21 Aug 2010 22:05:18 -0700
Message-ID: <7vfwy78cfl.fsf@alter.siamese.dyndns.org>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
 <1282384699-16477-2-git-send-email-artagnon@gmail.com>
 <20100822033330.GA12380@belmont.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 07:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On2lb-0000Y3-7l
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 07:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab0HVFFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 01:05:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab0HVFFd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 01:05:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9EB2CFE7F;
	Sun, 22 Aug 2010 01:05:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rp7SQE1ZiSeWeBAmC0WmhJ0jwaA=; b=BHlBse
	c8HcccoLA5FK9tdeI5qRZoqPMwML3KrhYMrFrrS5eiZaPe/lfsDr3dw8LUFFtDYr
	wL/9voMpXj7Rwhfkw40ssLoCayGLrNySTJBqnsUJ7e3jyiWK7aXEzcSsFOIsNV4q
	IgGyW7mexD3ivEsqjaWOBducP18N1VBm+htko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkdyhzo32YQ400v96e3cuMU3NUn6DDHB
	Cpt3GeUaaerxNksGOim+XVixAqLBdDqX+OLPTjGXhZoF7xF146eFfn/MFuYKejS9
	5qCrBrz/eBPKL+xcfRdyJe3x/AYSO7dJ10yfWyG3fgumM3PhTkZCjAU1OShorBUZ
	tpWoZGEeRo4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 708E0CFE7E;
	Sun, 22 Aug 2010 01:05:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 686B7CFE76; Sun, 22 Aug
 2010 01:05:20 -0400 (EDT)
In-Reply-To: <20100822033330.GA12380@belmont.cs.uchicago.edu> (Jonathan
 Nieder's message of "Sat\, 21 Aug 2010 22\:33\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0F05B62-ADAA-11DF-9ECD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154164>

Jonathan Nieder <jrnieder@gmail.com> writes:

> FWIW if I were writing it, I would make changes in something like this
> order:
>
>  - Change fmt_merge_msg API to
>
> 	int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
> 				int shortlog_len);
>
>    where shortlog_len is 0 for no shortlog, 20 for a shortlog
>    with 20 items.  Update all callers (the changed function
>    signature makes it easy to find them).
>
>  - Update merge --log and fmt-merge-msg --log options to take
>    an optional "size of shortlog" argument.
>
>  - update [merge] log configuration to accept an integer
>    "size of shortlog" value.
>
> The first step might look like this.

Thanks; it is very pleasing to see a more experienced contributor
mentoring another with a good example to show _how_ the design of a new
feature should be done.
