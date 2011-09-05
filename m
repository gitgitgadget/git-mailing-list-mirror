From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable
 variable expansion
Date: Mon, 05 Sep 2011 00:45:53 -0700
Message-ID: <7v39gbxwi6.fsf@alter.siamese.dyndns.org>
References: <8762l73758.fsf@elisp.net> <4E647442.9000005@viscovery.net>
 <7v7h5nxxwf.fsf@alter.siamese.dyndns.org> <4E647BD5.8060609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 09:46:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Tsb-0003WT-Km
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 09:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab1IEHqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 03:46:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab1IEHp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 03:45:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 736C912D2;
	Mon,  5 Sep 2011 03:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xX3ImKUoulJj4CnMWT4Xbu84PmQ=; b=SXhD8v
	BXZOXewf42xIwL4aN0d119Ad1ptpgimdHnBNDZbHHSw58Qkx41o6WX8zs7LGtZ8g
	SN4N7eQiMaMaC3XHu9rdRqN7LBwTsaXh3DKiAVCweHAimhebisRQrHf5oFfRBIOC
	VFxRIlUrCg3+ab2e5l/Dkm+8Z5MsN1ygBrve8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TunFzgae0OE8ZBWpesNbguE30HmDMfPS
	ZvbhU1mlXx90UotspO4qZiUBQndynfs62jaCTXrIs6fLr0UnDLoPSXM3Ehrq4a8P
	NNb7vbIUierM76Fz7T6+FLP/wi0O7mPmKr9uOcdKpKXjrmcg2YcXj02TyHGHGOyW
	dKX4Kk8Y9Nc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A3F12D1;
	Mon,  5 Sep 2011 03:45:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9C5A12D0; Mon,  5 Sep 2011
 03:45:54 -0400 (EDT)
In-Reply-To: <4E647BD5.8060609@viscovery.net> (Johannes Sixt's message of
 "Mon, 05 Sep 2011 09:35:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15F5839C-D793-11E0-A441-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180723>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Actually, it's the opposite: Within double-quotes, a backslash is only
> removed when the next character has a special meaning (essentially $, `,
> ", \), otherwise, it remains and loses its quoting ability. This means,
> that the backslash would remain as a literal character in our patterns on
> the right of % or #, and they would not work anymore as intended.

That's strange...

I thought that VAR=<any string without $IFS character in it> would behave
identically to VAR="<the same string as above>". You seem to be saying
that they should act differently.

>> If that is the case, either the above or my [?] would work it around, I
>> would think.
>
> [?] instead of \? is certainly also worth a try.

I obviously agree. Besides, [?] would sidestep the tricky backslash vs
double quote issue entirely, so it would be a more robust solution to
leave it around than "sometimes you need to avoid double-quote and some
other times you would need double-quote" for other people to mimic writing
tests later.
