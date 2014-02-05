From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Wed, 05 Feb 2014 12:39:40 -0800
Message-ID: <xmqqk3d92t0z.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
	<xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
	<87zjm6v99y.fsf@fencepost.gnu.org>
	<xmqqmwi67cty.fsf@gitster.dls.corp.google.com>
	<87vbwuuf5g.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9GC-0000n0-Tb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbaBEUjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:39:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbaBEUjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:39:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E8969087;
	Wed,  5 Feb 2014 15:39:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LrtDe2MbGse8Uq/eYayE/lPGtjM=; b=rgy0pp
	EoMgrNibBF0h82eUV/RzENKAgIP7CpFzsWTUU7JVRIMVI6EymaTifj20AMvFQ1zV
	IiHJ44P6R2UDOd9FW8WoZmBqdz2GoXhTkm0PbaUYy/00qxeiTmsESdMRBU1bGDCg
	pablNSKeT4UWTDYhTPqJ8NruUTXOGOhUsLdNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=naOP7sJ1WjDL8VSezQVXtaNeKZqOBjLE
	WAY0OElFEXUgDH6uX7NEGwbk4WhsdnkPJ2h3kIJOkMc/QPZXNJJ3BE8SQNxav8Di
	HasiPLFk22vMp7g9jEEsQaxv2ebmfrpc9mLwQ5R/gcZFoQS2B8FAer4Py3DQm4H7
	4CzLsXoDMW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08D769085;
	Wed,  5 Feb 2014 15:39:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ADB669082;
	Wed,  5 Feb 2014 15:39:42 -0500 (EST)
In-Reply-To: <87vbwuuf5g.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Wed, 05 Feb 2014 09:39:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3E7CDC4-8EA5-11E3-9B32-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241657>

David Kastrup <dak@gnu.org> writes:

> It's snake oil making debugging harder.

OK, that is a sensible argument.

>> This was fun ;-)
>
> At the expense of seriously impacting my motivation to do any further
> code cleanup on Git.

Well, I said it was "fun" because I was learning from a new person
who haven't made much technical or code aethesitics discussion here
so far.  If teaching others frustrates you and stops contributing to
the project, that is a loss.

But the styles matter, as the known pattern in the existing code is
what lets our eyes coast over unimportant details of the code while
reviewing and understanding.  I tend to be pickier when reviewing
code from new people who are going to make large contributions for
exactly that reason---new blood bringing in new ideas is fine, but
I'd want to see those new ideas backed by solid thiniking, and that
means they may have to explain themselves to those who are new to
their ideas.
