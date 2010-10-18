From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Mon, 18 Oct 2010 12:26:30 -0700
Message-ID: <7vaamb480p.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
 <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com>
 <7vbp6vduly.fsf@alter.siamese.dyndns.org>
 <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 18 21:27:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7vMM-0005wz-T8
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 21:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829Ab0JRT0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 15:26:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932471Ab0JRT0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 15:26:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F4C9DFEC4;
	Mon, 18 Oct 2010 15:26:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAHiDKSdDBOa9uCs09NoJsXAv5U=; b=BRTftR
	7oDtrhyclQkG+1Ye4cwxWofBgVjOqU6bpgOHFs8Leu3Pg3qQx25F9nVrHWszskBs
	Fi3FtvsOLcrd/MSzV+KCvcpbDCsRHA7LLIVv6ZFKz9PkkztJkSeCsV+hwYQm1Hzx
	hxRazUzNz4McTb0FZgzLFACb/bIJAtZUUoxw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bn20xAOKF0DouhHXVzzegE89xZMLVZGd
	sMLCyFQrK1Eh0wDSrzZrHKGo/qLrHMgTaKuXrlf1YHNwvZWIgl6LKPMmFgjAdKFb
	Y7Ij1Enm97Gn5bPsKyDQUx69QMatObAEOH7rNjFPyHwt113yqjTtnproR9Px4EWk
	X3P4Czy3UJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF14BDFEBF;
	Mon, 18 Oct 2010 15:26:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3F4CDFEA7; Mon, 18 Oct
 2010 15:26:31 -0400 (EDT)
In-Reply-To: <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
 (Erik Faye-Lund's message of "Mon\, 18 Oct 2010 14\:05\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0FE9882-DAED-11DF-91BB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159283>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> (I'm going a little off-topic here, I hope that's OK)
> I'm not too happy with some of the pretend-really-hard-to-be-posix-magic
> around in the Windows-port. In fact, I have some patches to reduce
> posixness in some areas, while getting rid of some code in
> mingw.c. Would such patches be welcome, or is pretend-to-be-posix the
> governing portability approach? In some cases, this comes at the expense
> of some performance (and quite a bit of added cludge), which is a bit
> contradictory to the Git design IMO.

If the part of the codepath you need to make conditional can be better
helped by abstraction that is higher-level than POSIX, that would be a
very acceptable approach.  The "struct credential" idea Jonathan gave you
is an example of such.  The goal is not to force POSIX on Windows or make
POSIX emulation on Windows more complete---that is not git's job.  Just
that in most of the case the level of abstraction POSIX gives has been
adequate for our codebase.

>> This is especially
>> true if you are making the "drop-privileges" part a helper function, no?
>
> I don't follow this part. What exactly becomes more true by having a
> drop-privileges function?

By using a bit higher level abstraction than POSIX primitives give you
(e.g. initgroups(), setgid(), etc.) that does not have to depend on
particular POSIX implementation details (e.g. "struct passwd", gid_t,
etc.), you can make the main codepath cleaner and free of ifdefs.
