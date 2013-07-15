From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a shallow clone
Date: Mon, 15 Jul 2013 08:31:18 -0700
Message-ID: <7voba3dem1.fsf@alter.siamese.dyndns.org>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
	<20130713212541.GA10951@google.com>
	<CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
	<7vfvvhgeif.fsf@alter.siamese.dyndns.org>
	<CACsJy8Bx_o+9S1N_uieQaV8NBbc3T_MR_VCvF+fM==Dy-vt7tw@mail.gmail.com>
	<CACsJy8DELmhBwBCk9hmg4EpQxGeCRDPaSEr5rYp=CiMjq8j54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:31:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UykkK-0002Gc-38
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236Ab3GOPbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:31:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757603Ab3GOPbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:31:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA95831F37;
	Mon, 15 Jul 2013 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KsD7kxJakb/NCOxMIvsQsXaZMN4=; b=qe1wDA
	7THE3rEJiYbV6o3+byQ1RzVCQtQ2MZeZSfCo4JRsyj0Archf933Pji7lAFoEy6Tw
	HfCoTvGvxDN1BB/HCleAArj56Rb8U1WHY/b3JYH4dbH8UDoSEiNTnp2kexQSGVOS
	fDAnxCpRPp7ytPXEzIVe+ldYQhrn496R+yLXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mqz0eWGrdzatPV7z/lf4uV6Kofd7xiQ+
	cHMr5hU1F0rIvllrc1UrXv7h8B1o8ReePlw+CGnXOtBwex5RBrS6vzp+jqc7jOkD
	/EjbbCLW9CibNQiIKbrATJd3jeCX7WUAXH8m6BvLwgsDg/vnBuklCPxPDuJb4S2B
	aMTUU4w2Hg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF60731F36;
	Mon, 15 Jul 2013 15:31:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D4E631F31;
	Mon, 15 Jul 2013 15:31:20 +0000 (UTC)
In-Reply-To: <CACsJy8DELmhBwBCk9hmg4EpQxGeCRDPaSEr5rYp=CiMjq8j54Q@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 15 Jul 2013 13:33:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 992CD07A-ED63-11E2-AD53-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230480>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 15, 2013 at 8:01 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> Also, the sender may have cloned from the receiver (fully) and then
>>> fetched a different history shallowly from elsewhere.  The receiver
>>> may have no commit on that history, including the shallow-bottom.
>>>
>>
>> Hmm.. right. And the receiver needs to setup proper graft to seal the
>> shallow bottom. So it's really not safe to do pushing from a shallow
>> repo without 52fed6e
>
> Because this makes pushing from a shallow repo fall into "mostly
> works" category, I withdraw this patch.

Yeah, "reliably fails when it shouldn't" may be safer than before
that patch, but the fact that you cannot push from a shallow one
still remains, so we probably shouldn't tell the users to use it.
