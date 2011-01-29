From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Fri, 28 Jan 2011 21:47:46 -0800
Message-ID: <7vsjwcb6rh.fsf@alter.siamese.dyndns.org>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
 <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx>
 <7v1v3wd1al.fsf@alter.siamese.dyndns.org> <4D437CA0.1070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 29 06:48:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj3fM-0007lv-4B
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 06:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784Ab1A2FsB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 00:48:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab1A2FsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 00:48:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D47FE22D2;
	Sat, 29 Jan 2011 00:48:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p1298vYNMMlQ
	5oQXiuiUFijhss0=; b=QYBZGRhx3tCBKa4KnDCsRp0D6ai2DGORrezXLP+e9QT5
	5Y9/Q+SK2t8RNBa2JYC0Lm4zRUKAW1eBEXXr7Z43XNnwF8Cy8yLBVwy0fbttRRl+
	pTyKHCOyALCgeqiheo5yaaq6q4943VkV8L8WJotibiZhR6qGYawXVJIZGQdU6K8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Uc2RqZ
	IFWQIU0tjL/6eufrdkta8PQ0vtGBoxgk8hikQKqTKUpTNRzXpb3h1V6JEr1unPWM
	oFWEQGFkqu84lZO4KmvUxkc0bnYZddicfWvzE7L88axoGXTSlqgCdcZ2cVpa1X7L
	y3JFqyNUfqTklW8OtAlkyLvArk54eue+iL1jQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91CD022D1;
	Sat, 29 Jan 2011 00:48:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5008022CD; Sat, 29 Jan 2011
 00:48:39 -0500 (EST)
In-Reply-To: <4D437CA0.1070006@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat\, 29 Jan 2011 03\:34\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F0AC228-2B6B-11E0-B2AE-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165654>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Perhaps we should check my underlying assumption first: is it reasona=
ble
> to expect a git log command to show the same commits with and without=
 a
> path spec that covers all changed files?

The simplest case would be "git log ." vs "git log" from the root level=
 of
the repository, right?  Traditionally, the former is "please show _one_
simplest history that can explain how the current commit came to be"
(i.e. with merge simplification), while the latter is "please list
everything that is behind the current commit" (i.e. without), I think.

It feels unintuitive, but my understanding of the rationale behind the
design is that, the expectation Linus had when he first did the pathspe=
c
limited traversal was that most of the time "git log $path" is used to =
get
an explanation.  It follows that having to say "git log --simplify $pat=
h"
would have been a nuisance, so "with pathspec, we simplify" was thought=
 to
be a reasonable default.
