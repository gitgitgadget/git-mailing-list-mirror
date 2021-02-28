Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243E3C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2B664E60
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhB1LYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 06:24:34 -0500
Received: from mout.web.de ([212.227.15.3]:59757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhB1LYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 06:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614511355;
        bh=0OlA+GiSZq5stUWg9j+Lba+27ovaybBaFoiQSyUgmZ4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bpcDutl9Q8girMyE2nzkZ3oWSGxYJdFiDW/P+3O87mr6Hsb3l/SxOjdVKEenuaqrd
         B+htI/sFLOs87f0JE3IOCM1zyk0wqCBrMIPjkmaPHi4fJQg8e7f1i5w4vpDolbbpAd
         sRvk4d/bcfO609WSQoocmCwCziDIvz6CKYt7ny6g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LgYRZ-1ldEIY1bXh-00o16M; Sun, 28 Feb 2021 12:22:35 +0100
Subject: Re: [PATCH 1/2] pretty: add %(describe)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <87pn109nhr.fsf@evledraar.gmail.com>
 <xmqqft1vrgxa.fsf@gitster.c.googlers.com>
 <87mtw3a5af.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <c65039f2-46d3-bbb4-1aa1-e0ce89f69b64@web.de>
Date:   Sun, 28 Feb 2021 12:22:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87mtw3a5af.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q9iBvyhenCLJzmrTtR8kcmVSsqxGgC2baIivxcr0LqW4f24PZYG
 6PlPx3rXu2zheivDm57SzYm96w4TcafJBH6u84vIABkG0I8cNpfAaQdhj0Jzg5ndyRIkZ4K
 p788Vq2bJkt7dGpAbnYi7TqKgZPbjVUVCxtPTyLOnNCmB17hEKB6mYs70JtW3XOjPan9oOe
 G9IsdSgSJ2t1IbEnul5fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QX8uMk/aq3I=:apxPsXeD7pefFp40UOvioh
 KnjQfy9ZStHfaR5+hQPSfsxSvv13yRFATVtyQ8uTUKPJQ1EmaW7quTRszHjDMsR5DlsmiGGA2
 3yc/OBriUqA0fwwsKvuej5u8fqQZIKdiIWBZpmaH9lmS8+F8f+IbH41WyFO3TPW6+uoy80Yvn
 F6MwpGjYSua+LT4epjwsvXEbfGGjbbtVs9+aRc80aGxaJTWOKmI9wbJMy4WpZzHn90kI0s7nk
 irI1LV6oHpdP7R1+XaMNGQrHCh/IINwR9bvNX/uMk9t6zsctxuI6LSyuhj4MoCJfurHerZvIy
 w9/6qNPQho4D1M10JqHk1H5/OTqKo43Ho0umAS3YJuRwr2p15wUAwuAfr6mhEcCPjoCfsJzxR
 b3b8c4zNHwJN920k6c8M9qWhTz3BniINuHLHtZNxffGdP+TC3+erlspUrL1/EgUQblD8U0EOH
 PJvldfVz/TWVGg2gA0Km2XZykvsd9A3Q+/kTNFr5i7PAJkgjZHRPQMr0s7ZYkEx4sKf1uszRw
 aNPZrbJUr/Gn+9UPWpiP1xN3XBDBtJ2Yi3XJypGRkLhW5ed55jkBlqpPh3GH4LbGOudCEMhHi
 Dmsp5Oa6QYEw7nU+8TDGET+MfQuzswupb98fXGWvkcw40u+TdcDdVfJOAWV8urogjYRD1Nheo
 wCMPcroo3OZsfuE0RsUTaXth4JUz8Dbqkljr1f5IMchQMolTrxUgEeWKgwMwE8NBr1/DEzkVU
 jb0CKq4/gF2cNYikulmMzAXf9RNo7oXvMsiKkSWnZA/oGKD1BgkkCW51G6rALlsgaluBy8o6C
 llKni+R/iD+bPx1/YxgUrPVLqXusNiCZrKBfaEEg6EuoRg9s+ofJ1Snt067vXXi34NdUN03ib
 5CV2BkPA1NKWR7tFB6kg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.02.21 um 01:47 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Usually something shelling out has going for it is that even if it's
> slow it's at least known to be bug-free, after all we use the command
> like that already.
>
> I just wanted to point out this edge case, for "git describe <commits>"
> we do the ref list once at the beginning so our N list will be
> consistent within itself.
>
> Whereas one might expect "git log" to also format such a list, but due
> to the internal implementation the semantics are different.

It shouldn't matter for the intended use case (git archive containing a
spec file with a single "$Format:%(describe)$") and I cannot imagine how
consistency in the face of tag changes would be useful (what application
would be OK with consistently outdated output, but break with partly
outdated descriptions).  But it makes sense to mention it in the docs.

=2D- >8 --
Subject: [PATCH] pretty: document multiple %(describe) being inconsistent

Each %(describe) placeholder is expanded using a separate git describe
call.  Their outputs depend on the tags present at the time, so there's
no consistency guarantee.  Document that fact.

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/pretty-formats.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-forma=
ts.txt
index 231010e6ef..45133066e4 100644
=2D-- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -212,7 +212,9 @@ The placeholders are:
 			  linkgit:git-describe[1]; empty string for
 			  undescribable commits.  The `describe` string
 			  may be followed by a colon and zero or more
-			  comma-separated options.
+			  comma-separated options.  Descriptions can be
+			  inconsistent when tags are added or removed at
+			  the same time.
 +
 ** 'match=3D<pattern>': Only consider tags matching the given
    `glob(7)` pattern, excluding the "refs/tags/" prefix.
=2D-
2.30.1
