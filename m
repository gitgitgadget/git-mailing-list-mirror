From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] pack-objects: don't traverse objects unnecessarily
Date: Fri, 11 Nov 2011 22:55:12 -0800
Message-ID: <7v1utdrfsf.fsf@alter.siamese.dyndns.org>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
 <1318915284-6361-3-git-send-email-dpmcgee@gmail.com>
 <7vk47qxe9x.fsf@alter.siamese.dyndns.org>
 <CAEik5nNmAnPni+rnLm7n5tO7f=LV_1TuTbVqxgjVaoqqaF_Ukw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 07:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP7Up-00042O-Et
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 07:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab1KLGzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 01:55:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab1KLGzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 01:55:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A019B2CAA;
	Sat, 12 Nov 2011 01:55:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yVwP//dmwRD8krH8jEe+bjZNjMs=; b=vRIzSi
	ULULfU6OMk/pA3W9RLdm2GijpmKYd7VADbbt4kIQEVGFfVl/dV67tjSIMSRLMD2T
	fy2+/UMzk/vgA8eFWtra1u/S2FcMW6sisoxQ8DDDlSAwqbo+W5JNRUUC8X0b/B+o
	82pUnosER+RehHY5s8bR2dGHqAdE+gnugEeLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CsXcE73GSmmOoQLe9SaT4A8ya2Htd6tt
	FLaH6yO68g+3aymay7QA3nV/fVbFhzFHBtvlXaogEXR/MK2Py3uNbySoUacFq2Lt
	u9GcK02H5G/dZQE9IgUO+K8AI0NLlXGlog47A96QGcIIALqdBggbpj34mEOvF7Fk
	Q6xCWLZZaQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D5A2CA9;
	Sat, 12 Nov 2011 01:55:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EFC22CA8; Sat, 12 Nov 2011
 01:55:13 -0500 (EST)
In-Reply-To: <CAEik5nNmAnPni+rnLm7n5tO7f=LV_1TuTbVqxgjVaoqqaF_Ukw@mail.gmail.com> (Dan
 McGee's message of "Tue, 8 Nov 2011 22:31:48 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45886690-0CFB-11E1-B0AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185301>

Dan McGee <dpmcgee@gmail.com> writes:

> On Thu, Oct 27, 2011 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I am not sure if this produces the identical result that was benchmarked
>> in the original series.
> I was not either when I wrote the patch, and I had hoped to confirm
> the results you showed in the message of 1b4bb16b9ec.

I actually am reasonably sure the result will not be identical, but I also
do not think it matters. The differences would appear only for entries
that have been filled earlier, which should be a minority.

> unable to figure out how you generated those numbers so I wasn't able
> to do so (and had planned to get back to you to find out how you made
> those tables). Were you able to verify the ordering did not regress?

No; I was hoping you would redo the benchmark using 5f44324 (core: log
offset pack data accesses happened, 2011-07-06).
