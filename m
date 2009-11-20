From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] "log --stdin" updates
Date: Fri, 20 Nov 2009 09:59:30 -0800
Message-ID: <7vws1lvzzx.fsf@alter.siamese.dyndns.org>
References: <1258716315-2213-1-git-send-email-gitster@pobox.com>
 <20091120144030.GB5419@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 19:00:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBXmc-0000Sp-3c
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 19:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbZKTR7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754991AbZKTR7l
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 12:59:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbZKTR7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 12:59:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0D9281654;
	Fri, 20 Nov 2009 12:59:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S0FPimD9yaqMPqCxyMdO5NC+BWE=; b=r9xtHq
	gBxyFoWdm+5gCojpt/EYv6wnwcBLCjNpexiVtYtVhtUpsqe5QR65L2H6LoCqreXz
	hLF6knt4rLqtflJZLhd6mzgQJupNmZXgYEsbHDpaEBOJMz/d0nMfHMSP+3wQgmnI
	uR7Errx8cssBPAJrn5McxJ8k1ThfRXCRDPt6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FThrGCqdw6KX4UZGhaZp4E+42xoAfXlE
	Gved6lHKllF5vqp2tKsoaeQzggUCVaYXrZHh1eH6apiPpUmJGZQSBL2pdUzvgQw1
	mo3y3ehBebtEQuGGY2J7QPNangSN1F4c45RlCWA8ul9kpWPpTkdFzkJidEg3k0Nn
	JR00Fa0j2wE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9A2581652;
	Fri, 20 Nov 2009 12:59:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE4EA81651; Fri, 20 Nov
 2009 12:59:31 -0500 (EST)
In-Reply-To: <20091120144030.GB5419@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 20 Nov 2009 09\:40\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76A4F7C4-D5FE-11DE-A2D8-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133361>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 20, 2009 at 03:25:12AM -0800, Junio C Hamano wrote:
>
>> These three come on top of 61ab67a (Teach --stdin option to "log" family,
>> 2009-11-03), which gave "--stdin" to the log family of commands (e.g. log,
>> rev-list).  The earlier patch allowed you to feed only the revs (which was
>> what gitk originally wanted), but after zero or more revs (one rev per
>> line), you can now feed a line that consists of "--" and then pathspecs
>> (one path per line).
>
> This looks like a good API feature, though I am curious about the
> missing "4/3" that was the motivation (of course, with a feature
> like this, it may be for your out-of-git script, but as I said, I am
> curious :) ). Is it a response to
>
>   http://article.gmane.org/gmane.comp.version-control.git/133268
>
> ?

No.  This series is a follow-up to $gmane/131971; I was suspicious that I
missed something for the API feature to be complete back then (and the
patch was not signed-off partly for that reason), and I found one thing
that was lacking.
