From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: do not accept non-blobs as new notes
Date: Wed, 09 May 2012 10:52:56 -0700
Message-ID: <7v4nrptf5z.fsf@alter.siamese.dyndns.org>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <20120508160334.GA26838@sigill.intra.peff.net>
 <CACsJy8DHotHhF0ADDwjUZx5m8SGjXFuXV9fY=mfHmswyZxzeSQ@mail.gmail.com>
 <20120509173701.GB30487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 09 19:53:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSB4T-0003kB-Sp
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759652Ab2EIRxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823Ab2EIRw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01DDB6C9D;
	Wed,  9 May 2012 13:52:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qGbcgyYpIqquy1Iw/se1Nss5W2k=; b=AKtOpx
	DLoOcZE4AXCmdNaqxR5NLUyAsRZ4JnpWxmNZ4MRhDT8XSJEaUgUKjt11kMfafjNx
	WrxM+c4plEq2WSYXOuKKAxXhvDCSwPsYGSIiYjF5bv4bJFWEL028S8a+X/HF6ySm
	nEgZ6RPghCl+rRaichALnlfTxiLb+iSiZN7D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSB6TLq2k9oHjjt5IdO7WdQMFCbexE0b
	JwCh5pxNu9M+T2Ok7no/QtKQ6ferahHCRbQJPx+P6GmE0H+BkeRksypMaihGu62/
	dGAwwE25euat5GRkXXwCAu3OvflaeVrAKHeddoNnIW7CleqIWc/UUB2r0ml/3J85
	epAkrCM1ipQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED4446C9C;
	Wed,  9 May 2012 13:52:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A9486C9B; Wed,  9 May 2012
 13:52:58 -0400 (EDT)
In-Reply-To: <20120509173701.GB30487@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 9 May 2012 13:37:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D01D6DB4-99FF-11E1-A00C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197485>

Jeff King <peff@peff.net> writes:

> Hmm. I was thinking that we supported arbitrary sha1s as note values via
> the command-line interface. But we don't; that is only the internal C
> API, and it is quite difficult to do anything useful with non-blob notes
> via the command-line interface. As you noticed, you can trick it into
> doing so with "-C", but even "-c" has disastrous results (unless you
> like dumping the binary tree object into your editor).

It is fair to restrict anything that involves an editor or end user
interaction with the terminal output for sanity, and raw tree object data
is on the other side of the border line that defines what is sane, so I
wouldn't have much problem with a new restriction on the command line
interface, except for "-C".  Advertising that we store arbitrary binary
out of an existing blob as-is and then starting to refuse taking it sounds
like a non-starter.
