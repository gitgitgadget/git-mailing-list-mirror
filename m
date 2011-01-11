From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Don't barf if import-marks file is missing
Date: Tue, 11 Jan 2011 12:05:32 -0800
Message-ID: <7vei8j435f.fsf@alter.siamese.dyndns.org>
References: <7vwrmd7kxe.fsf@alter.siamese.dyndns.org>
 <1294766058-29739-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 21:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckTx-00022s-6d
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 21:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab1AKUGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 15:06:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab1AKUGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 15:06:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D78436E3;
	Tue, 11 Jan 2011 15:06:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pvq2t6t5jCDAmZw31aGpYM6lB8o=; b=HKiAcI
	3gSIB37bCnyV3HXf5CLYANz13d2hs6w1H/EjBh3YWZfqMe5JdS9tvxOsSlHr2wug
	eXYWN1Yr8oYHEziNpFqyh7EfcrFvMYjCTzvo0ilwmUWABe4zXEVXykahGCRsGo9F
	kclEm+/uwA+sW6eqIQ4PDa2pAlN/fwMf0BpR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k1dnq1nRB40bpHe+2SDhcdkkWjtV6DDy
	jkdYFyUmVljUzEMJ3ILsvB1Bffd5/AMXpES7B9kVfoEgwVtTmz2AdzAcWfcP2SV6
	A52duq2RMcxL5xfeCdsnep3xzwdVhjro1BheKvxXYwjbiVMC6Fyien+hhH2stUtE
	LTSz7qpyVdU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24BC336DC;
	Tue, 11 Jan 2011 15:06:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F5AC36AB; Tue, 11 Jan 2011
 15:06:15 -0500 (EST)
In-Reply-To: <1294766058-29739-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue\, 11 Jan 2011 22\:44\:18 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51009F4C-1DBE-11E0-BED5-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164987>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The --import-marks option used to barf when the specified marks file
> doesn't exist. Change its meaning to "read marks file if it exists" so
> that callers don't have to handle bootstraping as a special case.

It is very plausible that people other than you are relying on "barf if it
does not exist" semantics, and the above does not justify breaking their
workflow.

I'd suggest making this an optional feature.
