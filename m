From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Review of git multimail
Date: Wed, 03 Jul 2013 01:16:19 -0700
Message-ID: <7vzju4giss.fsf@alter.siamese.dyndns.org>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
	<7vsizwiowt.fsf@alter.siamese.dyndns.org>
	<51D3DA9A.9090604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIEo-0007T9-OL
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab3GCIQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:16:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542Ab3GCIQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:16:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBF482B7C7;
	Wed,  3 Jul 2013 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pOAmsctjJWzX9v67UWoxDI4+tx0=; b=HonXs3
	VfhVWIuAlaCAVRjdA3bg1rzfnSRvpTETVjUq3l3C1yNkr2C1sBS+j8pNzSn5h3Vq
	CErzGLSnTnPDja6/dXg2vQHvvDHNrC/rXZsLkjSOps22YzWZUDDiZjOv8jlI17Nl
	qwN9osHbsySeQ9hMSbJlqvMHY3zjpMY2r2Gj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMgssVuo3m+lik2FBjDdfuxncoV43qH1
	x+HLPFS+7QDwccfbbVZZWTaoc0EOsaNCd7hu7eHBg03ehQfc2CjAagm6qn8BzsVm
	sCJBScHjS+YgtVINVh/AW1LieGMooZ91tCnVNJaa5Y7qEGYSUr44A3DhvJAXdr4i
	sojY/LORCq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C12102B7C5;
	Wed,  3 Jul 2013 08:16:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4408A2B7C3;
	Wed,  3 Jul 2013 08:16:21 +0000 (UTC)
In-Reply-To: <51D3DA9A.9090604@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 03 Jul 2013 10:02:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D80EEA62-E3B8-11E2-AC39-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229464>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I would be happy to add the checking that you described, but I didn't
> have the impression that it is the usual convention.  Does code that
> wants a single value from the config usually verify that there is
> one-and-only-one value, or does it typically just do the equivalent of
> "git config --get" and use the returned (effectively the last) value?

In most cases, variables are "one value per key" and follow "the
last one wins" rule, which is the reason why we read from the most
generic to the most specific (i.e. $GIT_DIR/config is read last).
For such uses, reading from "--get", and not from "--get-all", is
absolutely the right thing to do.

But then as Ram said, there probably is not a need for --null; you
can just read from textual "--get" to the end without any splitting
(using splitlines is of course wrong if you do so).

Thanks.
