From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh - define and use GREP_STRIPS_CR
Date: Sun, 21 Jul 2013 14:04:51 -0700
Message-ID: <7vip03sjyk.fsf@alter.siamese.dyndns.org>
References: <7vtxjt56dc.fsf@alter.siamese.dyndns.org>
	<1374183897-11408-1-git-send-email-mlevedahl@gmail.com>
	<51EAE7F6.3080509@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, jrnieder@gmail.com,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 21 23:05:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V10oN-0002Mr-2k
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 23:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab3GUVEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 17:04:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab3GUVEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 17:04:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72821321A7;
	Sun, 21 Jul 2013 21:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vCjwSZQIctil04VCVOKth/IUwbU=; b=ezIT/2
	xtGiUwbtKaEKfd5wywMPfVlh16zlIVekKAWFpJOuur0gh6w+9vG6LJJm6iDDF7j1
	S7Wf9zOKklkaQHFzIeUZqz0YgqsV0nqVFgj8FVHWNgAVvMqwmOuq85ns/JPD2SOV
	/Q4LYpyCtwhvc/rYw7LR75xyEaJ2pwCp/Wg/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vag8jvG1xRb/bZffopmLDFp5Bqw+r7Dk
	Lv1nPiQBq9m2onGhY/34G9cnP1jt4EmXFjs+/majgJt99Wmcunl1J2XchPNXT/zr
	aQgjXi8nfn0Fk8FsP9YaOSDpgORcnpLpFoNwUcHt4Xh80kZMBEC4ptRdlTp/WMo6
	6PubKr0EQr0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6832D321A6;
	Sun, 21 Jul 2013 21:04:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1CE7321A4;
	Sun, 21 Jul 2013 21:04:52 +0000 (UTC)
In-Reply-To: <51EAE7F6.3080509@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 20 Jul 2013 20:41:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 301922F6-F249-11E2-BDF8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230944>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Mark Levedahl wrote:
>> Define a common macro for grep needing -U to allow tests to not need
>> to inquire of specific platforms needing this option. Change
>> t3032 and t5560 to use this rather than testing explicitly for mingw.
>> This fixes these two tests on Cygwin.
>> 
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>> ---
>> This replaces my earlier patch against t3032 (8896b287 on pu)
>
> Yep, this looks good and (as expected) it works on cygwin 1.5 too. :-D
>
> Thanks.

After this patch lands 'master', we may want to add a note to these
SED/GREP workarounds for CRLF platforms that we assume the platform
use GNU sed/grep.

Incidentally, don't we also need "unset SED_OPTIONS" in
t/test-lib.sh net to where we unset GREP_OPTIONS?
