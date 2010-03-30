From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] fmt-merge-msg: remove custom string_list
 implementation
Date: Mon, 29 Mar 2010 22:18:51 -0700
Message-ID: <7vzl1qwfno.fsf@alter.siamese.dyndns.org>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
 <1269414964-9518-7-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 07:19:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwTr4-0002yr-BP
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 07:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab0C3FTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 01:19:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab0C3FS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 01:18:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D82C4A6FAB;
	Tue, 30 Mar 2010 01:18:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4Sw5/CI6STUZRpGQ6sLKje5d3d0=; b=izRV5n9o/c721qDS4gyBLur
	86FrTvb2vdRIqt+he6K7gS27uvv0CKE+IVjlMglzi9l2Pxnq/gH/QCc902QAcU+l
	4MHuWBXFa1QF2aO65f8/naWDBXPDiBTbO5dRaSLTX1Bw642C1ftMkjOez1nSozbs
	7CDeNqC6KTYEChpQk7eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dM5uDtI838cZQsh3pk/64Nw24NxDGZIeNv4vQx/9/0XUFOAsS
	bHpENdKCSyUK1XKPER/i7upqrGnbJo8tysFXcuaMwH+6kyFJzlXLblWsbp9InEj8
	6Ercih+DZdShQNQYz3kIltt1UEEPQbqVTZOWzbP9G2OyK18FlQoMg3rDfI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3C1BA6FAA;
	Tue, 30 Mar 2010 01:18:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17DAFA6FA9; Tue, 30 Mar
 2010 01:18:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC37616E-3BBB-11DF-928B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143545>

Stephen Boyd <bebarino@gmail.com> writes:

> This command uses a custom version of string list when it could
> just as easily use the string_list API. Convert it to use string_list
> and reduce the code size a bit.

Thanks, although the above is a bit unfair.  Back when 00449f9 (Make
git-fmt-merge-msg a builtin, 2006-07-03) was written, there was no such
thing like string-list (nor path-list, its predecessor).

> Anyone else annoyed that string_list_append() is the only function
> that takes doesn't take the string list as the first argument?

Yes.

> On another note, git-compat-util.h:115 says:
>
>   #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with...
>
> which may be unnecessary now that struct list is gone. Need someone
> on AIX 5.3L to test that though.

Yeah, finding testers for less common platforms is always the hardest
part.

> Finally, this doesn't free some of the lists since I wanted it to be a
> straight conversion. I'm feeling lazy right now but I'll think about it.

Thanks.
