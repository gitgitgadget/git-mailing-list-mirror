From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Tue, 04 Sep 2012 15:44:42 -0700
Message-ID: <7v627t8l2d.fsf@alter.siamese.dyndns.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de>
 <7vr4qqzsbe.fsf@alter.siamese.dyndns.org>
 <002201cd86ce$285841b0$7908c510$@schmitz-digital.de>
 <7vfw74s3oy.fsf@alter.siamese.dyndns.org>
 <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de>
 <7vpq64f935.fsf@alter.siamese.dyndns.org>
 <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
 <7v1uijexor.fsf@alter.siamese.dyndns.org>
 <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de>
 <7vzk55bu8s.fsf@alter.siamese.dyndns.org>
 <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de>
 <7vwr09abim.fsf@alter.siamese.dyndns.org>
 <7vobllaami.fsf@alter.siamese.dyndns.org>
 <002c01cd8ae6$f23d7ec0$d6b87c40$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 05 00:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T91rY-0001lg-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 00:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735Ab2IDWop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 18:44:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757824Ab2IDWoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 18:44:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50A8E9E02;
	Tue,  4 Sep 2012 18:44:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0USwfo8lDPMhl8wVFhboTEi/C1Y=; b=N1qYvf
	uJyVNUItE9475345N7TrfhuHI+9AQPE0gOt82nJp/dbe0M0KV9jHfNLyIP+J/162
	j5i0FXSAYSuOoo7pb4jomIE6whc5qemAUfEmQeRXGi695lPJ/AWr+zk86rREmtpA
	3E3PA4lTLUcaZ9kuCBzm81bhe9pJLDT5OzJeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BEP1xJ35I6FDgcFNHVcQckrn/SLJjMdt
	366T/ee00vcvbBDiNEXsa1PNScuIKBfuKZJWsIbHwEGE6cpnh76bbsFzIzzocTPq
	LFKL/TqYSdQk1vguud8ssUYa1uP8QIZTrOaUdSbCuFUrZQYquP78beN81yS/FYid
	cA88/Bq4cCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C7FD9E01;
	Tue,  4 Sep 2012 18:44:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 887339E00; Tue,  4 Sep 2012
 18:44:43 -0400 (EDT)
In-Reply-To: <002c01cd8ae6$f23d7ec0$d6b87c40$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 4 Sep 2012 23:47:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EAF4486-F6E2-11E1-975B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204789>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Sent: Tuesday, September 04, 2012 8:47 PM
>> To: Joachim Schmitz
>> Cc: git@vger.kernel.org; 'Johannes Sixt'
>> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
>> 
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>> >
>> >>> Only with the observation of "clone", I cannot tell if your timer is
>> >>> working.  You can try repacking the test repository you created by
>> >>> your earlier "git clone" with "git repack -a -d -f" and see what
>> >>> happens.
>> >>
>> >> It does update the counter too.
>> >
>> > Yeah, that was not a very good way to diagnose it.
>> >
>> > You see the progress from pack-objects (which is the underlying
>> > machinery "git repack" uses) only because it knows how many objects
>> > it is going to pack, and it updates the progress meter for every
>> > per-cent progress it makes, without any help from the timer
>> > interrupt.
>> 
>> I think the "Counting objects: $number" phase is purely driven by
>> the timer, as there is no way to say "we are done X per-cent so
>> far".
>> 
>> Doesn't your repack show "Counting objects: " with a number once,
>> pause forever and then show "Counting objects: $number, done."?
>
> Yes, only once, when it is done
> $ ./git repack -a -d -f
> warning: no threads support, ignoring --threads
> Counting objects: 140302, done.
> Compressing objects:   1% (1385/138407)

So this strongly suggests that (1) your "poor-man's" is not a real
substitute for recurring itimer, and (2) users could live with the
progress.c code without any itimer firing.

Perhaps a no-op macro would work equally well?
