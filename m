From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1402: work around shell quoting issue on NetBSD
Date: Tue, 08 Jan 2013 13:37:37 -0800
Message-ID: <7vboczcq5a.fsf@alter.siamese.dyndns.org>
References: <50EC8025.8000707@lsrfire.ath.cx>
 <7vr4lvcstt.fsf@alter.siamese.dyndns.org> <50EC8BE7.2010508@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Adam Spiers <git@adamspiers.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jan 08 22:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsgsF-00008F-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 22:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab3AHVhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2013 16:37:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229Ab3AHVhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2013 16:37:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 548C4BA7A;
	Tue,  8 Jan 2013 16:37:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rTn7/y/TTPUR
	AIV7MpFgZUQ5lJY=; b=oibesuzVe9lsVIySvM8tS4tCEp/wi2vnp2XLZL9kBC4D
	UY7cnB7vsQQl6mBjomToLB1gQi2Xag4wSVI0QLorX2OCB/XuVUMfDx+EkR9ugywG
	IVZmlOJ+i3v5kcoDHTqhpAI2gEIxCBqJCVdcHlBKjxHagXFhGrFRmmAJqSuj+nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=barVi4
	B3wWN6TQS8W3g0cqpOEMXEZq3N8TaK8SyRbgXPhh6z6Kcv/n9CQNLrqkdCMCIdQT
	9PXLLoo8JSG+CAdsQkd9d7VLpEvC+8tDMu99xgrzChVOYR/OEYpuyJGPVKvruEh/
	gs4l0PStSqy3iElK/GlyWqdxzQ2W6tYNlLRQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 480DBBA79;
	Tue,  8 Jan 2013 16:37:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9067BA78; Tue,  8 Jan 2013
 16:37:38 -0500 (EST)
In-Reply-To: <50EC8BE7.2010508@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 08 Jan 2013 22:13:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FD29214-59DB-11E2-8DFA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213007>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> A quick check shows that subtests 64-68 and 89-93 of t0008 fail for m=
e
> on Debian (10 in total) and subtests 64 and 89 fail on NetBSD (2 in
> total).  Unlike t1402 they don't report "bug in the test script".
>
> t0008 only uses ${:+} substitution on variables that don't contain
> spaces.  With the test changed to store the description in a variable
> first I still get the same 2 failures.
>
> There must be something else going on here.  The different results ar=
e
> interesting, especially the higher number of failures on Debian.

I forgot to mention that some of them seem to be broken under dash
but pass under bash.
