From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 10:45:22 -0700
Message-ID: <7vhatcc1ql.fsf@alter.siamese.dyndns.org>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:45:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpNSE-0002Ld-9s
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 19:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481Ab2GLRpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 13:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934158Ab2GLRpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 13:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2151C8101;
	Thu, 12 Jul 2012 13:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LvD8gSNWdYS5qCk5NDMvaJ7yQYs=; b=Sz8XkR
	+VPlTE5d0WGZL7QRQNYWmb8fEoc4VeDd3DzrTzLugxVlPzI0p/GW9IbCmxWwiDRO
	ju/d/uIta9i4nTsDxEhDjCl+LiAMTtUhtiFtgdaMg468SgPtxEA3cB82I1FIg86O
	f8imQpThWsQuvYEh9+5X4LAQ7Yz5hSqWqzhIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fk+UhiVbLZG/ZJWLRuwcgqZ09gMeTefv
	v9dkHyx7nTU7RfPJ6CVjmGiZ9eCIG7RP6wmz7FS7AZ57wmXSNVeSSflhhCCPWe+Q
	S7a4wea8jrc/CMKZSACFG42dvSEdsRIHHhjNGqpuCaLRHEJ9irDzaMAzWzqbouFF
	lCeOlTSFcf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 177C48100;
	Thu, 12 Jul 2012 13:45:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 888ED80FC; Thu, 12 Jul 2012
 13:45:23 -0400 (EDT)
In-Reply-To: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com>
 (Paul Gortmaker's message of "Thu, 12 Jul 2012 11:50:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B62CE70-CC49-11E1-885D-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201370>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> If git am wasn't run with --reject, we assume the end user
> knows where to find the patch.  This is normally true for
> a single patch,

Not at all.  Whether it is a single or broken, the patch is fed to
underlying "apply" from an unadvertised place.

> So, provide a helpful hint as to where they can
> find the patch ...

This is OK, but you may want to give a way to squelch it once the
user learns where it is by following the usual "advice.*" thing.

> ... to do the manual fixup before eventually
> continuing with "git add ... ; git am -r".

This is _NOT_ fine, especially if you suggest "patch" the user may
not have, and more importantly does not have a clue why "git apply"
rejected it ("am" does _not_ use "patch" at all).
