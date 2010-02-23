From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/11] several notes refs, post-rewrite, notes
 rewriting
Date: Mon, 22 Feb 2010 16:49:02 -0800
Message-ID: <7v1vgcpyip.fsf@alter.siamese.dyndns.org>
References: <cover.1266703765.git.trast@student.ethz.ch>
 <cover.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:49:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njixn-0004ZQ-HE
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0BWAtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:49:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0BWAtR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:49:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3C4F9C220;
	Mon, 22 Feb 2010 19:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NAU788ikFTONlckg8BZd2+QTC8I=; b=rTOfkL
	9GlY2h2aaRxmecfgo1cC06iZuYuLSbyTX+R4kaM1RgtGb2Y746HkGEAffAJniYvw
	JUc/EddmgLc7GoBAk7e1EwJmjD2epBdWYv8PTLVx0FTKnD+1PpDgTf5zuLk9gMCY
	Hbk7fChF5BwCZ551KqXFpyOpg8iMW/yChj6BY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eshKaL49YRkIDg2Z/hCmAEYduzHcj2qc
	RooBAU1N/duvdmm0jUTY4CWhhtuHCf0Qy6PPX7GWpk2kL9Lrs3efduWHH3CCrBPR
	X5o5SvH0zO7My3MHWspbl00zJg0u7cgywZspg5lwKsymOFolj0LObP6dqFciTs0t
	9tXg4d13VCU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A7519C21A;
	Mon, 22 Feb 2010 19:49:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E7579C218; Mon, 22 Feb
 2010 19:49:04 -0500 (EST)
In-Reply-To: <cover.1266885599.git.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 23 Feb 2010 01\:42\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41338AE0-2015-11DF-9496-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140757>

Thomas Rast <trast@student.ethz.ch> writes:

>> Yuck.  If you know what needs to be done, do that before other poeple add
>> more options, please.
>
> *shrug*
>
> I was trying to be smart and save a call to git_config() when we know
> we don't care about the config anyway.  After all it does read a bunch
> of files.

You can set a flag to skip reading the trees (which is the expensive part)
you know you are not going to use to optimize out the expensive part of
the code, no?

>> Perhaps I am not reading your code right in which case this part needs a
>> bit more commenting?
>
> The catch is in the '&& t->ref'.

Ahh, Ok, so that was what I didn't see.  Perhaps it needs to say t->ref is
set only under such and such conditions.  I am reasonably sure the next
person who needs to change this part of the code would appreciate such a
comment and that person may even be you 3 months from now.
