Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC6C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 00:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAEA22597
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 00:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAXACy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 19:02:54 -0500
Received: from mail.pdinc.us ([67.90.184.27]:49252 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhAXACw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 19:02:52 -0500
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 10O0222q030028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jan 2021 19:02:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 10O0222q030028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611446523; bh=/jGIthS753fLy/9yrHswmMSCzHLKuHEiq1KdHoYrUOw=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=rEVILjN7tEtCq+XOClV0xX049fBzDtMR/g02fNU8XGo1mThUY/bL0Ejqaqq0gM/kA
         qmImknhCsuSG1eC/SthX7VfVAD37c9v6ByH+QPZ70MJJw3EQy0KqFKlUXoTHfhsk6E
         SzpNPMuvM/a3cA+PRpsBmxpxe+RcAV2dE0nxjyJNOXQCaXXXQKMGe/eVBFffpqaKaI
         VwvFv5SSlPdXJ6EpNtb5an8HgBC71c1gf7XrWvVS21DEDdPp45yqlr1Dl+tyOgNKuk
         jwH/A2hpN1ut6evYIHGNF5nbybShD4YJLcPkEVleOCknRjFwTanG+263LbSmL7AiBX
         HJ/z4cxiz6apw==
Reply-To: "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
          "'Kyle Marek'" <kmarek@pdinc.us>,
          "Junio C Hamano" <gitster@pobox.com>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>        <20210117110337.429994-1-kmarek@pdinc.us>        <20210117110337.429994-2-kmarek@pdinc.us>        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>        <xmqqr1mij88k.fsf@gitster.c.googlers.com>        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>        <xmqq1reginnq.fsf@gitster.c.googlers.com>        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>        <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>        <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us>        <xmqq35yvff98.fsf@gitster.c.googlers.com>        <009a01d6ef80$326572d0$97305870$@pdinc.us>        <xmqqh7n74jdt.fsf@gitster.c.googlers.com>        <057b01d6f1db$c46d7d50$4d4877f0$@pdinc.us> <xmqq7do32p6q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7do32p6q.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH 1/2] revision: Denote root commits with '#'
Date:   Sat, 23 Jan 2021 19:02:13 -0500
Message-ID: <00a801d6f1e4$2b693140$823b93c0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQJHGJacgXqgwI3Z8mKvOOtpVC9QaQIPWPTxAWqKtJ0CjS/zDwIOmFXbAj4EO1oBSKUeLQJMhZdkAgqPsIIBueaIOAHxr5jOAbl0TYoB42v/AgFWk/VJARzJfs0BrkuzVwKstMD+qGVBiqA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano
> Sent: Saturday, January 23, 2021 6:45 PM
>=20
> "Jason Pyeron" writes:
>=20
> > One and the same issue. Placing an * directly above another * is the =
issue.
>=20
> OK, I re-read the messages in the thread, and it appears that this
> part from Kyle
>=20

Added more of the context below.

> >>>   While root commits are not a special case in the sense that =
--graph=20
> >>>   makes ancestor implications for more than just root commits, =
root=20
> >>>   commits are a special case when we think about interpreting the =
presence=20
> >>>   of hidden lineage in --graph output.
> >>>  =20
> >>>   Considering one of your examples:
> >>>
> >>>             C
> >>>            /
> >>>           O---A---B
> >>>                    \
> >>>             X---Y---Z
> >>>
> >>>   When graphing C..Z, git produces output like:
> >>>
> >>>   *   0fbb0dc (HEAD -> z) Z
> >>>   |\
> >>>   | * 11be529 (master) B
> >>>   | * 8dd1b85 A
> >>>   * 851a915 Y
> >>>   * 27d3ed0 (x) X
> >>>
> >>>   We cannot tell from the above graph alone that X is a root and A =
is not.

This was a side track down the left right issue. I personally feel that =
using the left right features is a buyer beware situation.

>=20
> was the only thing that argued that A and X (if the graph drawing
> happend to place an unrelated commit immediately below it) should be
> drawn differently so that you can tell X (root) and A (non root)
> apart.
>=20
> And you are saying (and it seems that you have consistently been
> saying) that it is OK to draw A and X (again if other unrelated

I am neither saying or not saying that - partial graph issues are =
outside of my concerns. Kyle was attempting to reconcile comments on =
this list about partial graph rendering when his patch was submitted.

> commits were immediately drawn below them) the same way.  So I guess
> all is well.  We do not have to use more 6 different symbols ("{#}"
> to show commit above boundary, three more to show roots) but need to
> introduce only three, if we were to go with the Solution #1 route.

Honestly, I do not care about the <>{}. Whatever makes sense.

>=20
> It seems to me that Solution #2 is a special case of Solution #3 ;-)
> They are both direct answers to the "graph drawn incorrectly can
> imply ancestry that does not exist" problem.
>=20
> Adding the "--decorate-roots" option that annotates the root commits
> in the "git log" output can still be done, but that is an orthogonal
> issue.  It does solve, together with any one of three options you
> presented, the issue Kyle brought up, I would think.
>=20

Yes, adding --decorate-roots to add more wide descriptive text before =
the message would do it, but it is the worst solution #4.

> Thanks.

