From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache.h: move remote/connect API out of it
Date: Mon, 08 Jul 2013 22:38:11 -0700
Message-ID: <7v4nc4xph8.fsf@alter.siamese.dyndns.org>
References: <7v1u78zrko.fsf@alter.siamese.dyndns.org>
	<20130709042106.GC27903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 09 07:38:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQd0-0000vv-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab3GIFiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500Ab3GIFiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:38:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA4692B05F;
	Tue,  9 Jul 2013 05:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MGCJ+1kPpyBt1Naf0rcW58Wxo90=; b=qv+Nh4
	JRoUaatQ5Ea7L+mMLJMSmYhjv21s9WruoU18OEesu4wMIYNBWylywD/oca7F6yGd
	7t5kcmBKk6a55EW1AilhBgMqvB4EWVUri2VlElyqdBOSU0x5n4q6oUZfhRu0eHK6
	ez+FGOlf/QAJPsYsZ9IDadvYOoPp7nUEapk98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SZiwUS8/bttnsrKVzd0JkmqD1JmJ/wyG
	YOqnMMdD3lSL7X8p69BmLk5l4pYcsqNuk2NvQxKbHoQ1QzqYT4LQ4tIy15xuaVWa
	nGDKiOyZDrenYLBDIROtd7RKLejqn9gGwbYYj2SHvdE4pXZwsGNoECXYjaoilwnE
	2db+MzFw7VQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B14432B05E;
	Tue,  9 Jul 2013 05:38:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E9C12B05C;
	Tue,  9 Jul 2013 05:38:13 +0000 (UTC)
In-Reply-To: <20130709042106.GC27903@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jul 2013 00:21:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF31F9C6-E859-11E2-AA3B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229914>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 08, 2013 at 02:09:59PM -0700, Junio C Hamano wrote:
>
>> The definition of "struct ref" in "cache.h", a header file so
>> central to the system, always confused me.  This structure is not
>> about the local ref used by sha1-name API to name local objects.
>> [...]
>>  * I hate to to this kind of code-movement in the middle of the
>>    cycle, but every time I follow the push->transport codepath, I
>>    become disoriented by these "struct ref"s.
>
> FWIW, this has often bugged me, too. I did not check what fallouts this
> will have for series in flight, but in general, I think it is a good
> thing to be doing.

The fallout can be seen at the tip of 'pu', which is fairly minimum
at the moment.
