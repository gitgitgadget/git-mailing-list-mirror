From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add 'git format-patch --to=' option and 'format.to'
 configuration variable.
Date: Wed, 17 Feb 2010 00:14:11 -0800
Message-ID: <7vhbpg5lf0.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171238310.2477@vqena.qenxr.bet.am>
 <7vhbpgpsto.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002171516520.3414@vqena.qenxr.bet.am>
 <7vhbpgfrqj.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002171706290.5479@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhf3M-00022v-DR
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934158Ab0BQIOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 03:14:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934126Ab0BQIOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 03:14:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DBAD9A3AC;
	Wed, 17 Feb 2010 03:14:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MEhFXjOVGchA1spKW17lNLlGvIw=; b=wTjS91
	MGYECR7d7O32FCke7gDKS1FMsNZcn6lUIjscnmYmodNdcauZxsfqIJ9jP5geHK5y
	mghydbLbcHAcBODwW9yNTncyjR9SzqXaPtMH29ebu9Lm8UmqIZQcm3Y8r+MwZpNf
	Tjc5WXywNLrRxT+IFU3c4h+3XuwdpGyDwsuVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6HvYe5I/SYk7ldOi0ZOXa+2pwAPHDo5
	yQEqex6pJuTIH809n4dJ6ohr6XRRgM9x47VVMAjswKRGHWYZdenjfJl+gKSSQxFe
	0rGqs20dK2T99abrZQAf5DkH/YVCO6iKxW7RVH7l4v0rCjB6VxNhhuFWRb4mSeqW
	46/1MfE86qc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 233169A3A8;
	Wed, 17 Feb 2010 03:14:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B87E9A3A7; Wed, 17 Feb
 2010 03:14:13 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1002171706290.5479@vqena.qenxr.bet.am> (Steven
 Drake's message of "Wed\, 17 Feb 2010 20\:33\:38 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7086ED46-1B9C-11DF-B17F-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140215>

Steven Drake <sdrake@xnet.co.nz> writes:

> On Tue, 16 Feb 2010, Junio C Hamano wrote:
>> I tried to ask you (apparently in a garbled grammar, sorry) what
>> your workflow of sending the format-patch output to the outside world is.
>  
> $ ./git-format-patch --stdout master~5..master~1 >>~/mail/postponed-msgs
> $ alpine -I cp
>
> Only problem with doing that is that alpine changes the Date: and
>  Message-Id: header (the later being a pain if I used --threaded).

Finally.  That is the kind of "how somebody would work with format-patch
output" I was looking for.  Thanks.

> ... I would understand if you wanted to deprecate '--cc' from
> format-patch and 'format.cc' (maybe keep it for backwards compat).

No, you took me wrong.  Deprecation wasn't what I was after.

I wanted to see ways to _positively_ explain what format.{cc,to} are good
for.  With them, we can eventually have a few examples in EXAMPLES section
of the manual page to help users (hint, hint...).
