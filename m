From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add without whitespace
Date: Mon, 30 May 2016 15:00:44 -0700
Message-ID: <xmqq8tyr8aur.fsf@gitster.mtv.corp.google.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	<xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
	<CAHd499Drdt6GoScdksNNWLrsvG3Dex7fTYNhatL-qboCPW5RZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 00:00:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7VF4-0004bV-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 00:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbcE3WA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 18:00:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162182AbcE3WAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 18:00:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 296EE20F4E;
	Mon, 30 May 2016 18:00:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O3Fdd7YKebz9CyfFCyo1UUbtMB8=; b=FIHNzh
	+2358JtFnT725b4SBxPXD1bczQaSjp7HuJFVOzEEj/0PDUy496enVXRjp94pwGJR
	xsdNciyUKXc8LuyO4ovZseaaWYWSKop0NQ9EDpoM+JyF+C0pGpCAhQ/bZdUhoSDM
	171G5UchbleqTq62ofT4IGsGzShA8DjeAC2lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RYnAELnLRTLASuHUd2PzqpxH16z+VBTY
	7vSPICRjNU0ZiPwpJKelxsc6+HL/stwSB+o26V21Upy7ACkA1OUbS4R/BEN3da1S
	ma3pHTN5F7wQUVh9WoQPzSHS2BpQeXVDEjrO8FQ4VI02xWFw48TIwNeFeOKFMyVV
	iaHBID7KfL8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 219E320F4D;
	Mon, 30 May 2016 18:00:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C9F520F4C;
	Mon, 30 May 2016 18:00:46 -0400 (EDT)
In-Reply-To: <CAHd499Drdt6GoScdksNNWLrsvG3Dex7fTYNhatL-qboCPW5RZQ@mail.gmail.com>
	(Robert Dailey's message of "Mon, 30 May 2016 14:50:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6692C40-26B1-11E6-B70B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295935>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I like your solution better than mine because it utilizes the rules
> defined in .gitattributes.

A difference that may be more important is that I do not do
generation of a patch or application of it without ignoring
whitespaces with things like -w and --ignore-whitespace.  That way,
if my edit is a correction of existing whitespace breakage (e.g. I
noticed a line that is indented by 8 spaces, and I corrected it by
replacing them with one tab), that is shown as a change by "diff"
and kept in the result.  I suspect that your "diff -w | apply --ignore"
will ignore that manual fix?

> What does the checkout at the end do? That part confuses me (granted
> I'm not well-versed with bash script).

I correct whitespace-broken updates the user (i.e. I) made in her
working tree file by adding a corrected version to the index, and
then I checkout the result out of the index to the working tree.

That corrects the breakage in both the index and the working tree,
so that my further edit to the file will start from a ws-corrected
version.
