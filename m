From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Wed, 05 Feb 2014 16:43:38 -0800
Message-ID: <xmqq1tzh135x.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	<1391480409-25727-1-git-send-email-pclouds@gmail.com>
	<1391480409-25727-2-git-send-email-pclouds@gmail.com>
	<xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com>
	<xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
	<20140205002725.GA3858@lanh>
	<xmqqob2l5vl2.fsf@gitster.dls.corp.google.com>
	<xmqqbnyl5sde.fsf@gitster.dls.corp.google.com>
	<CACsJy8Aj-5MzRjDxfWkOVtqxjo+w7v6uEjGfGAj_9s59t5eiYA@mail.gmail.com>
	<CAPc5daXvBPTVCUv=qO++kiOMQck1daTc_rmhpWrDk-KbTuvZOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 01:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBD4F-0006Ka-6C
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 01:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbaBFAnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 19:43:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbaBFAnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 19:43:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF1666A2DA;
	Wed,  5 Feb 2014 19:43:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ku8tvUel9QsYXuMlEqaWDsqaNy8=; b=Mj5Ovx
	X7WLLnE5CZRJjXRRHrkhcDlWf5UyRp9Du5jXqmbVmVKX6627ErKNlxdSuu9VFcpm
	NXcfMydjPT8fgqP9EpGiHtJrMav0pqwBvcCe4O2rg7SduZ4VvGfIRiv2YxX233BN
	wTyU7scvUhdCxsc1Gh/Ng9DXWlFCS9R7zfnwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fe9PUyAgLq6tWQU9NrFzhcqdGyEARPFg
	RVkf1lksnxjm4SUbpdQuvDz2IYY7/8BOZe9h3hWcZZA/vS+WDCySNwrl5vF6k49u
	xWVgM3Kk1R0d9xfe+lVx319J7iZlVDnV4iy8Z4gTjXSriNMghj5SNJyxCHvc30tL
	XEGFukwYQyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D306A2D9;
	Wed,  5 Feb 2014 19:43:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C1B06A2D8;
	Wed,  5 Feb 2014 19:43:41 -0500 (EST)
In-Reply-To: <CAPc5daXvBPTVCUv=qO++kiOMQck1daTc_rmhpWrDk-KbTuvZOQ@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 5 Feb 2014 16:08:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B96E36DE-8EC7-11E3-A644-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241681>

Junio C Hamano <gitster@pobox.com> writes:

> On Wed, Feb 5, 2014 at 3:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> No no. I found that duplicate, but I did not suggest removing it
>> because it is needed there..
>
> Hmph, if that is the case, we probably should make it the
> responsibility of the calling side to actually mark ce->flags with the
> bit (which would also mean the function must be renamed to make it
> clear that it does not mark).

After looking at the codepath that uses the record_intent_to_add()
before this patch, I am coming to the conclusion that it is the
right thing to do after all.  The code appears in this section:

	if (!intent_only) {
		if (index_path(ce->sha1, path, st, HASH_WRITE_OBJECT))
			return error("unable to index file %s", path);
	} else
		record_intent_to_add(ce);

which tells (at least) me: "We are not adding the contents of this
path, so we do not run index_path(); instead we call this helper
function to set the object name in ce to represent an intent-to-add
entry".

So I'll rename it to set_object_name_for_intent_to_add_entry() or
something, restore that flag manipulation back to the caller, and
add another to the new caller, and requeue.
