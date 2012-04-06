From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri, 06 Apr 2012 13:22:39 -0700
Message-ID: <7vbon41ugg.fsf@alter.siamese.dyndns.org>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
 <7vobr4236g.fsf@alter.siamese.dyndns.org>
 <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 22:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGFgF-0002ag-A6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 22:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923Ab2DFUWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 16:22:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab2DFUWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 16:22:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57FF87B41;
	Fri,  6 Apr 2012 16:22:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D/gSiVFWCb8pG4pgi4l2R8FbBdQ=; b=bMTSbm
	RRL57j2WkMNA33tW57i5iCSVg5Q9+zdNpmDQSMj85RbLT40iyxpXYrnr987az8K6
	dWaVGWjzTfO51N0hrlNAak2JzrZ3LjhgzYWR54E4ScW6Of/LrnscUlscrouXDPLK
	69XLA+FKn73zagdo9OyjQk5jTjENGEb0mOfJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v5uqvzsvXsfi1IzKfmHQFIJ5QlQC0gnC
	77XWXWodwXwbvX7KIDWuQxEzBSrYL/VQegNyYAPE3PcRAoTlI29pwOd5min2WkV/
	W6sRq9kequ7LnNWIIzV8l8qkz3S+G4ObVhSNyHEK9H/8FzQcM+A1wzRnjmTeaZTU
	eS70+T8sqhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5237B3F;
	Fri,  6 Apr 2012 16:22:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C290B7B3E; Fri,  6 Apr 2012
 16:22:40 -0400 (EDT)
In-Reply-To: <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com> (Felipe
 Contreras's message of "Fri, 6 Apr 2012 22:42:16 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4263A8F0-8026-11E1-ABD5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194903>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Apr 6, 2012 at 8:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Some mail servers (Microsoft Exchange) mangle the 'From' header, so
>>> while applying the patches, the author has to be fixed manually.
>> ...
>> I wouldn't say that the existing option names to send-email are great, but
>> I have to say that the one added by this is simply horrible ;-)
>>
>> The first paragraph of the proposed commit log message states the problem
>> it tries to address very clearly, which is good, but is "From: " the only
>> thing that needs this?  I am wondering if this should be named and behave
>> more like "--duplicate-header" or "--in-body-header".
>
> I have never seen any other 'in-body-header' other than From, and I
> don't see how that would be useful. Anybody else?

The "Subject:" is very often used in the wild, when responding to an
existing discussion thread with a patch, without changing the topic of the
thread (I would say it is used more than "From: " override).

When using send-email to start a thread anew, this use case is much less
of a problem, but I wouldn't be surprised if a broken MSA/MTA mangled the
subject (especially imagine a non-ASCII ones) incorrectly which would be
helped with exactly the same in-body-header mechanism.

You probably meant "I do not want to hear from Junio" by your last
half-sentence, but I replied anyway ;-).
