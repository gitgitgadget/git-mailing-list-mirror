From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 00:13:05 -0800
Message-ID: <7vlio9n5ym.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 11 09:13:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw85Q-0004wQ-WB
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 09:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab2BKINJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 03:13:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab2BKINH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 03:13:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88B6944B2;
	Sat, 11 Feb 2012 03:13:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ELmcThpWeTpkqQOCbX4ufxs2UlI=; b=K5Ga8S
	RwRuBjhBAF+lRw1+3Du+9uFy6AEQ0cEUL4V4evp7O6FwgE79qV71OvJ8Scault+M
	MmsKBHzboCMIsMMDFXmfAUMkFGTj3XesA0Aw6q2Glsuzhc9yR2owXdIbT/RGdA25
	kpzPo4MWj+DDMxN1kaOFVPm9Tzp571nZwYil8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9iT2RMyEn/jb5H7ZBPtEcJF+VqZILB8
	ZwttPhEH1htdvkPtB8+dFNVCjzAD6gc5VFxJywcbxSvGDhWr9zE5o/JNxUROCT9B
	wMN58Jn3ggswz4fduGDnB/xXv3S0LENn8yV8d8wC0ayiJXOscm6U+9RsdDhSB7fV
	2dtRdawv2jM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8054E44B1;
	Sat, 11 Feb 2012 03:13:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14EAE44AF; Sat, 11 Feb 2012
 03:13:06 -0500 (EST)
In-Reply-To: <4F361DD4.9020108@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 11 Feb 2012 08:50:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A76ED06-5488-11E1-8E7A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190501>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The proposal, amended to use "^" instead of "!", is that
>
>     git for-each-ref A B ^C
>
> should mean "the reference names A and B but not C".  Therefore, the command
>
>     git rev-list $(git for-each-ref A B ^C)
>
> , which consistency suggests should do the same thing as the first
> command,...

That is an utter rubbish that does not even deserve a response.

Your argument is like saying

     git for-each-ref A

and

     git for-each-ref $(git rev-parse A)

should somehow magically produce the same (or related) result. The
for-each-ref command operates on refname patterns, while rev-list and
rev-parse takes object names.
