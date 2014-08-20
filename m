From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/18] the beginning of the signed push
Date: Wed, 20 Aug 2014 16:41:16 -0700
Message-ID: <xmqqha16sp9f.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<1408485987-3590-16-git-send-email-gitster@pobox.com>
	<CAKPyHN0Q2bCiNy0goxZ7YnmPjbU9fyjpWYmPF8gKz8T862jvAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 01:41:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKFVV-0003fv-U9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 01:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbaHTXla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 19:41:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56488 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbaHTXl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 19:41:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FFD632678;
	Wed, 20 Aug 2014 19:41:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qjLfLNkLxYM6toKuEMl5YkgtnM=; b=LFai4e
	lX9g600nq9QpV7W+1HfEp8bTpeHuzNVpZgeUnelhdoi2Ki8Uq0LiNZSDq3FWE9R4
	oBadXerFqBwEqKKC0r6RAGDPvgErhyeLKAkijzM1VUgBKcXDsXC/H5Pl40OYBcvq
	Sep5bYGDEMpVrnJ6dNRY4yYF3GN6y48ZzhtzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=st0wZdr81/j4ctXxFWD4SrPbnMhysljc
	fM/Wzb1IHDAGJWHTBLshEBeLBFvGKuNeHAd16Ctf3VkWUfiNUn/3Xt0d5cTfSf78
	xT/lQcfBOJs9FPNMLnYpTkCO2pjzcBpysYftZJOmhkTkztcQeNrCwiqRYPnuv3rL
	swH3YE6Og0o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2495B32677;
	Wed, 20 Aug 2014 19:41:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 492EE32670;
	Wed, 20 Aug 2014 19:41:18 -0400 (EDT)
In-Reply-To: <CAKPyHN0Q2bCiNy0goxZ7YnmPjbU9fyjpWYmPF8gKz8T862jvAA@mail.gmail.com>
	(Bert Wesarg's message of "Wed, 20 Aug 2014 08:57:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B776530-28C3-11E4-B336-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255595>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Wed, Aug 20, 2014 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> The basic flow based on this mechanism goes like this:
>>
>>  1. You push out your work with "git push -s".
>>
>>  2. The sending side learns where the remote refs are as usual,
>>     together with what protocol extension the receiving end
>>     supports.  If the receiving end does not advertise the protocol
>>     extension "push-cert", the sending side falls back to the normal
>>     push that is not signed.
>>
>
> Is this fallback silently? If so I think it would be better to abort
> the push, if the receiver does not support this but the user requested
> it.

Let me change it in the reroll.  I however am not quite sure if
warning is insufficient, because there is nothing, other than
rerunning the command without "--signed", that the user could do
when it happens.
