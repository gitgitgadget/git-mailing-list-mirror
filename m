From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's 
 line count
Date: Thu, 11 Feb 2010 16:25:24 -0800
Message-ID: <7vfx57mhaj.fsf@alter.siamese.dyndns.org>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
 <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
 <7vwrykapfp.fsf@alter.siamese.dyndns.org>
 <76718491002101139m4061fb90qcee7d34fca9f242f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 01:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfjLt-0006U3-D3
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 01:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628Ab0BLAZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 19:25:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348Ab0BLAZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 19:25:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73AAD99EA6;
	Thu, 11 Feb 2010 19:25:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kl23atS3oxWQ
	QgqQCSfdeNj3Skg=; b=Q9z/XF/iabG/PAFftpv6fq0rz/BhptxFmNzXoornsEtv
	BVLepZ1McBqNALNqzepGXPv6mQcgNX6a8rxmOQmU6xRXGIfzPG/pqxYJ0V6rfRg1
	/9FhCK/svt3DjmTeyiNPbRdZTuj1q1L5INtlXmMCtzYG+EgznqJ8NJ4aOkigXGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fKxVIX
	xUwabDLeur1uDH8xE2lJbOwNS794sHMekdY7ouQ43FJBMB4sAOwLsVb2slH9NWl1
	3W1mNxR9cQUWWmCWmQ/YMPRo/n8GkIm5bYj5FIpZ2VcHi+P5zr0Ie0OoulKIRcuz
	LP2alb0s+uP39aIzlcVTXwtR0MUnx8VeWrTdU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8B399EA5;
	Thu, 11 Feb 2010 19:25:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71D4F99EA4; Thu, 11 Feb
 2010 19:25:26 -0500 (EST)
In-Reply-To: <76718491002101139m4061fb90qcee7d34fca9f242f@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 10 Feb 2010 14\:39\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 201CB8D2-176D-11DF-B9EA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139647>

Jay Soffian <jaysoffian@gmail.com> writes:

>> Another thing we _might_ want to consider doing is something like:
>>
>> =C2=A0 =C2=A0-L'*/^#ifdef WINDOWS/,/^#endif \/\* WINDOWS \/\*/'
>>
>> to tell it "I don't care to count how many WINDOWS ifdef blocks ther=
e are;
>> grab all of them".
>
> That was my aim, but the syntax I'd settled on was to use
> -L/pattern/..END where END is either a numerical argument or another
> pattern. IOW, ".." instead of ",".

I would suggest against using that syntax.

Users of different systems use A,B or A..B as range notations, but ther=
e
isn't anything that helps the unsuspecting learners to learn and memori=
ze
that double-dot variant A..B has a repeating semantics and comma A,B do=
es
not.
