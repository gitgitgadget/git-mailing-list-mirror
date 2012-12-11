From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (bug?) Inconsistent workdir file timestamps after initial clone.
Date: Tue, 11 Dec 2012 14:30:02 -0800
Message-ID: <7vr4mw6x3p.fsf@alter.siamese.dyndns.org>
References: <50C79D1F.1080709@xiplink.com>
 <7vy5h47003.fsf@alter.siamese.dyndns.org> <50C7AE84.2060400@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYLV-0005pe-LL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2LKWaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:30:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570Ab2LKWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:30:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC8DA3F1;
	Tue, 11 Dec 2012 17:30:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tPrGzCD3RoGT7bdUEmLixEYlUZE=; b=QsLoMF
	qrju4YRVnLqJOZYB7a2eOwymYEwYo4qpDBOz2ymSk2284TwkgcAO3n48adKCX86w
	Gv6DS3q3SEI3LqAtPVDeSezrPsn+T7uNMfMVB6e9e5nyJGCfPrjG3bQ1qeJn88gX
	L/iOOJSOuAYJHVo+5G8SwK55h0pSepX7PhVkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WY6U+zHCi43RjRRrxgFQIikX/VFlrTYb
	0s1AYwx6S9aF+jqecHQEW3AFyHHmKEVuJi8dnFb8eAH3vB4cF3YAJ89V1rpS9uJV
	JLdj9RPLTAVQewVpPzVbdq79m8uee0NYo35TERpAoEOThlaf221hbwdGzc2MfCvG
	hkivt4cmhqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AF6DA3F0;
	Tue, 11 Dec 2012 17:30:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 566BBA3E8; Tue, 11 Dec 2012
 17:30:08 -0500 (EST)
In-Reply-To: <50C7AE84.2060400@xiplink.com> (Marc Branchaud's message of
 "Tue, 11 Dec 2012 17:07:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51810CC6-43E2-11E2-BCD1-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211309>

Marc Branchaud <marcnarc@xiplink.com> writes:

> My point is that the initial checkout into an empty working directory should
> create all files with the same timestamp.
>
> Or, to be a bit more precise, whenever git-checkout *creates* files in the
> work dir, *all* the created files should have the *same* timestamp (i.e. the
> current time measured at the start of the checkout's execution, not some
> bizarro other time specified by some arcane heuristic).

My knee-jerk reaction is that it is insane to do so, but what other
SCM does such a thing? Even "tar xf" wouldn't do that, I think.

>> While not including files that can be rebuilt from the source may be
>> the ideal solution, I've seen projects hide rules to rebuild such a
>> "generated but needs special tools to build" and/or a "generated but
>> normal developers do not have any business rebuilding" file (in your
>> case, Makefile.in) in their Makefiles from the normal targets (like
>> "make all") for this exact reason, when they choose to distribute
>> such files by including in their commits.
>
> I prefer to use the third-party code as-is, without hacking it, to have
> smooth upgrades in the future.

Then perhaps take the complaints to that third-party upstream, not
here?
