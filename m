From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Wed, 24 Jul 2013 08:10:48 -0700
Message-ID: <7vbo5s6ljb.fsf@alter.siamese.dyndns.org>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
	<1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
	<20130723175942.GA21019@goldbirke>
	<7vvc416qvq.fsf@alter.siamese.dyndns.org>
	<CAPig+cTPcFJ_kfQ7zveE-Uf-itRRw2O99vQ61Or0QHvkKnxc_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 17:10:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V20iP-0001W7-4V
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 17:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab3GXPKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 11:10:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab3GXPKv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 11:10:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F00ED32A0A;
	Wed, 24 Jul 2013 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wjXDCKWMOWWC
	0AjTFl3U4yHGP8k=; b=pdrsnr55ue9zbk6e7Hf4TkPeyliXoGbO0XBLuRFmUORD
	ogV51eveW5XaCw7j8r8QeBbBkDiA8zN7MhETqkLR3qjfY1Hl5Z4hzZAjw927w0nP
	/P1nTLIj70LjOir8BKnJjY8gDNfPO6M3FYMHsCY9Q/51BfefKIDrdI7/TGrtehg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wnc5TW
	B/wlGXk/tgLblWEwQrJagN3I3uJ6ZwnPG/Ky6j4gxpZ9WsKo809Fv9RQb6IYQkgx
	enbJZtF1jl6T2gUM4lY9AJXA4sXWE+nBvDLTR1XoRo5H2M+TKVt97yUljzBqfhRe
	LNwGEvhZJKQMYttKwuXwZJJwzkgoVaCGs5tSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E41BF32A08;
	Wed, 24 Jul 2013 15:10:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 444FB32A06;
	Wed, 24 Jul 2013 15:10:50 +0000 (UTC)
In-Reply-To: <CAPig+cTPcFJ_kfQ7zveE-Uf-itRRw2O99vQ61Or0QHvkKnxc_g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 23 Jul 2013 19:15:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39DC8568-F473-11E2-BB26-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231102>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 23, 2013 at 3:03 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>>> You could avoid the 'cat' here and patch in 4/5 by doing $(wc -l <b=
=2Ec).
>> Correct.
>
> Thanks, I like that better.
>
> Unfortunately, what actually got queued on 'next', after applying thi=
s
> fix-up and re-ordering the patch series, is slightly bogus.

The lesson is that one should not rebase while waiting for a flight
in a hurry X-<.

Will queue the following on top.

Thanks for spotting; really appreciated.

-- >8 --
Subject: t4211: fix incorrect rebase at f8395edc (range-set: satisfy no=
n-empty ranges invariant)

Wnen I rewrote "cat b.c | wc -l" into "wc -l <b.c" to squash in a
suggestion on the list to this series, I screwed up subsequent
rebase.  Fix it up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4211-line-log.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 00a850d..7665d67 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -68,7 +68,6 @@ test_bad_opts "-L :foo:b.c" "no match"
 # thus to demonstrate this particular bug, the empty -L range must fol=
low a
 # non-empty -L range.
 test_expect_success '-L {empty-range} (any -L)' '
-	n=3D$(expr $(cat b.c | wc -l) + 1) &&
 	n=3D$(expr $(wc -l <b.c) + 1) &&
 	git log -L1,1:b.c -L$n:b.c
 '
--=20
1.8.3.4-1049-g22454dd
