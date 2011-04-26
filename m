From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Refactor git-completion to allow ZSH usage of PS1
 functions
Date: Tue, 26 Apr 2011 12:15:15 -0700
Message-ID: <7vtydkddto.fsf@alter.siamese.dyndns.org>
References: <1303824288-15591-1-git-send-email-mstormo@gmail.com>
 <7v62q1exnj.fsf@alter.siamese.dyndns.org> <4DB702E6.5090105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:15:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEnjS-000779-Lk
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 21:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab1DZTP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 15:15:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab1DZTP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 15:15:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B0B8141C9;
	Tue, 26 Apr 2011 15:17:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0vh+EWHDWTfx5RK1U31G/2DQFT4=; b=RbrzVu
	+Tx2VYoJhbB+hpuIOA27NL6zsrZEhUutoHjh1XrV2BTOexiCFLnxA06gzSPM7N8j
	SUW3+YtwfXgTd2I/pZDjyQA8qhxkSXlAJozK4JknRgwZagb2DxyVXeSqDldvLHkU
	dhICAyjCdXMGez5X/qcinMqdtKnCiQW6WffDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aB7/+KSlyLko+KScU4w1pkXMFgh7c2FT
	s/sWtMzsQxjSUMPgyWpG6vygIylE83mEQbrOEcEzPCXRqN3zcEVrXaEFInZwX3OQ
	A6OofeniyvdCKC0t1TZN0ZuctSHQdQJfhIUJe1Ctw5xQMEQvABa+tpufNUL4oLtf
	t9SoSJSxn5A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 707E841C2;
	Tue, 26 Apr 2011 15:17:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 293B441B1; Tue, 26 Apr 2011
 15:17:18 -0400 (EDT)
In-Reply-To: <4DB702E6.5090105@gmail.com> (Marius Storm-Olsen's message of
 "Tue, 26 Apr 2011 12:37:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D10A3DC4-7039-11E0-BC14-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172122>

Marius Storm-Olsen <mstormo@gmail.com> writes:

> Junio C Hamano said the following on 26.04.2011 12:21:
>> I'd be very negative on splitting this file into more than one files.
>
> The only other option would be duplication. Is that preferred?

That is not the answer I was hoping to hear.  Can't we think of a way to
share without duplication the common parts and have tweaks per two shell
implementations?

A conditional that says "Do this part only if I am zsh" in a single file
is fine.  Makefile that concatenates the common one and specific one among
two would also be acceptable, even though it makes things more cumbersome
to the user.  But no matter what you do, I would really prefer for the
user to have to copy just _one_ file, not two.
