From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Mon, 6 Aug 2012 19:52:56 +0200
Message-ID: <20120806195256.43ec44de@gmail.com>
References: <20120803160229.GA13094@sigill.intra.peff.net>
	<1344023835-8947-1-git-send-email-michal.kiedrowicz@gmail.com>
	<20120803200201.GA10344@sigill.intra.peff.net>
	<7v3943bsuc.fsf@alter.siamese.dyndns.org>
	<20120804000904.13c4162b@gmail.com>
	<501D4FF0.4060109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 19:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyRUI-0003gb-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 19:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756819Ab2HFRxB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 13:53:01 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41568 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab2HFRxA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2012 13:53:00 -0400
Received: by eaac11 with SMTP id c11so931292eaa.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=GX/6zgCMFWjTeVeoTI1mPBDaqjdALEIksEE6O7kQgu8=;
        b=gOGM/288ekNkR4bR5U42VKjZ8URDfsBKFumPId06gE/0qnskiQJZS1PQfoMtZ9NvnG
         ufZpsUbfTippsXoYFzPxa1YVwoPyz5fPyiqbdwTrhHh5s2pAkl+wusxAzZEEFakK3f3b
         lxHxmrBcQ6HP2Thr8tIc2lF+U0hEDDB882hbpj8p7rX2xwb9y59EemPfKP8mHiEdApNw
         APXHT1KUQnCoFU+QSY1COKH7zKMlJ30G4w2GxNg/nqIBnbyQl8DmLqhMniJNX/zJfYfZ
         lxRRcVQA4mIm0NNBR5Y91b5GVButK0kIu7f7D1eyogclF8riBY+XDSc2TS8vGMElZXUW
         2T+A==
Received: by 10.14.175.130 with SMTP id z2mr14183409eel.0.1344275578908;
        Mon, 06 Aug 2012 10:52:58 -0700 (PDT)
Received: from localhost (94-178-78-94.net.stream.pl. [94.78.178.94])
        by mx.google.com with ESMTPS id j4sm49473469eeo.11.2012.08.06.10.52.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 10:52:58 -0700 (PDT)
In-Reply-To: <501D4FF0.4060109@kdbg.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202974>

Johannes Sixt <j6t@kdbg.org> wrote:

> Am 04.08.2012 00:09, schrieb Micha=C5=82 Kiedrowicz:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> I do not have strong
> >> opinion on calling this test_seq when it acts differently from seq=
;
> >> it is not confusing enough to make me push something longer that i=
s
> >> different from "seq", e.g. test_sequence.
> >=20
> > I prefer "test_seq" because it reminds seq which helps learning how=
 to
> > use it.  If some other seq feature is ever needed (e.g. increment v=
alue,
> > decrementing), it may be added at any time (but I don't think so, t=
here
> > are only few usages after years of test suite existence).
>=20
> And the reason for this is that we always told people "don't use seq"
> and they submitted an updated patch. What would we have to do now? We
> have to tell them "don't use seq, use test_seq". Therefore, the patch
> does not accomplish anything useful, IMO.
>=20
> The function should really just be named 'seq'.

My reasoning was that there is already test_cmp, so let's make test_seq=
,
but I agree with you that it doesn't solve the issue completely. So my =
2
cents is that it would be best to stay with not allowing seq in the tes=
t
suite.

>=20
> Or how about this strategy:
>=20
> seq () {
> 	unset -f seq
> 	if ! seq 1 2 >/dev/null 2>&1
> 	then
> 		# don't have a working seq; provide it as a function
> 		seq () {
> 			insert your definition here
> 		}
> 	fi
> 	seq "$@"
> }
>=20
> but it is not my favorite.
>=20
> -- Hannes
