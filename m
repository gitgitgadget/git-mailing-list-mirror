From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] count-objects: report garbage files in pack
 directory too
Date: Thu, 14 Feb 2013 09:02:09 -0800
Message-ID: <7v8v6q3k32.fsf@alter.siamese.dyndns.org>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
 <1360746799-3668-4-git-send-email-pclouds@gmail.com>
 <7vehgkb43v.fsf@alter.siamese.dyndns.org>
 <CACsJy8DxRuML1+gSCZaGC1hA4MU9sWnoGJGZMbeUVdaipOH7vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:02:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U62Cj-0007Q4-30
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 18:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760017Ab3BNRCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 12:02:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043Ab3BNRCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 12:02:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9DD1C5C4;
	Thu, 14 Feb 2013 12:02:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jTeuyyhLVz7o/Wu21f31Mp+tH+0=; b=tolN4+
	3UCrY9KTF11h4UPQ4Xx1FpwWBrqCBBa7vmVenx/tbldDyz158dBppryVTtHLOLs5
	ktHfym9Vq5oLOY4jclapx4NgRoIaoWaOg/R0bd9ClUxum2n3N48MWmAkYViEEccE
	+11dYJ0mkD8vma54rsKfQdIyjIFVh873QFU2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sHVnde1tPLU6KuyrFl4tTe3vVyodz7I/
	9y2LiNELZazlASAyE42vo6hoN/MNSlqgYrUvd9gW2kk2XqclWR15Qe6ycZKsni/p
	l6hibAlTb2FIpTEbL2jzx6HAoF4t0YikQlhc5Rof3OulgHjiu9azut6BeRs3Mevg
	9MGLCGYVA3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C22CC5C3;
	Thu, 14 Feb 2013 12:02:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 088FAC5B8; Thu, 14 Feb 2013
 12:02:10 -0500 (EST)
In-Reply-To: <CACsJy8DxRuML1+gSCZaGC1hA4MU9sWnoGJGZMbeUVdaipOH7vA@mail.gmail.com> (Duy
 Nguyen's message of "Thu, 14 Feb 2013 16:24:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45C25368-76C8-11E2-81A9-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216323>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 13, 2013 at 10:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +     default:
>>> +             return;
>>> +     }
>>> +     for (; first <= last; first++)
>>
>> This looks odd.  If you use the usual last+1 convention between the
>> caller and callee, you do not have to do this, or call this function
>> with "i - 1" and "list->nr -1" as the last parameter.
>
> I know. I just don't know how to name the variable to say "the element
> after the last one".

In case it was unclear, by the "usual last+1 convention", I meant
that it is perfectly normal to write

	for (i = first; i < last; i++)
	for (i = begin; i < end; i++)

in C.  Saying these as

	for (i = first; i < beyond_last; i++)
	for (i = begin; i < beyond_end; i++)

look non-C.
