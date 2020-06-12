Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D434C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EB7206A4
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PWe0JG5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFLNTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:19:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:36097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFLNTL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 09:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591967935;
        bh=1By8mcySskbR3UXVwn23af3fOpijVO+pm1W3cmU+vOk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PWe0JG5L+BwjihWjkBQ9yzVDbbHQk0M9aA5g7KRcswKQbxQlLgOaTC8z7/d/j3mhv
         ttro3XAQmlyizODFy8c/Jy2fytc4axGHi3wyP7CWlk08LzzfVzbw147Wc1KgWSG/Tx
         9xh+/8Z1PuRN0R+EZroqn65qFerbLMB76Y/KO9WI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1j5mBS0oG9-00mtUn; Fri, 12
 Jun 2020 15:18:55 +0200
Date:   Fri, 12 Jun 2020 15:18:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2006121518160.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GAWL/s+uNeM++uWTzRcKEBqH+VF9EnRQdUn9NRw9J7EtQ6fXHKQ
 GOdCdv2VzsljKXPSt3x9Ro8FAJm1LdjVpQvQur+mZF7LfkRxEGGR8LvOfm8X8VRfFbPIrkF
 hiMvPzQHTxaTQmvWpSMI8aQLUQkoUtgCaCx5b2Jvo6Jxr+ZuVF7g3957Wc+VBrT6FyqN2w+
 qIzgOQiqP8DfRayuXt1hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IU/v0s7Xi8=:jEzZGGAPNTQ5x/1ERrjtzu
 EawLF7+QwCy5EQO1Kb2JJKiUwrY9HMTGYGbQLiZUXU4Pqpsv9Kv7EA//1M0iPGTuAYRmdExep
 jLJPUCS4bzyhN5VhuNVLuTcQ/AwOG7HKonYC2CcjNaLFoyTlqVBzdqg3XTKx/1VNo2q90QJ6F
 KSW6sgBKzXkBXycxfyX8VOO0y61+Ruv7nIOJc76YUWCRizpWdlFzFFmeP/kh/M8/h7ruzlDUG
 rH2ocRbZphHzyA5CuuG11AMIXFTQW9O7AIJV7iyO0LbAeIUanl6XyqJvfS1WY3g2+tlpcAV8u
 o/dTkth2ZQZzmArVpNtYsmEyS0jjzcyrE01+aFBWldUBRLsHxFtN2d9z5nDGt+bKlaBZuqCfB
 cS0hkyL7JznaqCeHqEZtMJzeFDjyFMYDGoyIxYYMkyrK1DVA4GOHTE6JRxCbFU7OdpV6Zi7iP
 tZvZJD/HzTAN8GycuW+wOZIDtpOu7LaEk1WjuCNh5GlqulWPk8VPggnD0MSoRlyBXU69EOXhB
 RYl4OFDu+M0LpEvSq01ljRbaBMnBsGObum+0iZkFg4vlrXsV22gOwwsHD5Pr/RstNv2Km2rPC
 HS21dHw6CWAaaXIyxxDTbl4M0yN3uzA4F6jiX3KsvjTn1cmOJeIGjxynRhzVLR9SJ/pGnVreW
 mRZjM4Q6WnMRSYifXcuMtYaaZ/dW9n2ffQgz3KYhUp8wIlqJ+LyLA5cttDkCHbL2iFhD5MEYi
 JjlQ+2keW37GkhnkPuztlj9hVc8rVnInGWSivQBiS8X6lS4OsfKnr6ysjqzjhyIji6g0Pk8Gq
 hcIzis2lJzLkLe8NH6/2Obhu/VtvJpBe9271/E0bpvOMhzAhsYP5cldJDYWXro5UQTxSdx6q9
 5I5dzviNFTEjqZ+lYIDq+/1lRlBAioK7V1wWA1u6Gbk4xfErQvdKWcFJWBrblAw149s5+aOrL
 9WyJc3sAu6StqDATBvMxBtx/Kj6PU1qvoapyQMJ78wkQUuni867EsCmkCPLWj3zN0Mwz8bX38
 DCeLoU8ek4W5BBb4TEOpF2/CCLKI0H5XimYg0qO7x6Qyf2fFwbzXvCq5TgBROUPBH1FuUTqtZ
 aZSfCQRKdnRRHc7fVC9bLZpfXo39qUIhGQBpb9R1F1i/HKTH9ZnoL5Ob1lTB7Zi596YLTDLiz
 aQam5VlTFLseYmuFLCW2Elv0ZizpE7fw24YWKlFJcSdzMFbU5WSzbOtLzHPoipAr1Ic9zw54O
 xK6FcgSPNKz4e1KVB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Jun 2020, Johannes Schindelin wrote:

> On Thu, 11 Jun 2020, Junio C Hamano wrote:
>
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index 85868162ee..a306a60d25 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -522,7 +522,7 @@ static const char *anonymize_refname(const char *r=
efname)
> >  	 * anything interesting.
> >  	 */
> >  	if (!strcmp(refname, "refs/heads/master"))
> > -		return refname;
> > +		return "ref0";
>
> I just realized that the comment above reads:
>
>         /*
>          * We also leave "master" as a special case, since it does not r=
eveal
>          * anything interesting.
>          */
>
>
> Obviously, we need to change that comment here because we do not leave t=
he
> name unchanged. How about this?
>
>         /*
>          * We special-case the main branch, anonymizing it to `ref0`.
>          */

Also, t9351 obviously needs to be adjusted. This one works for me:

=2D- snipsnap --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 11 Jun 2020 08:05:38 -0700
Subject: [PATCH] fast-export: do anonymize the primary branch name

In a fast-export stream with --anonymize option, all the end-user
data including refnames are munged to prevent exposure, but the
'master' branch is left intact.

There is a comment that explains why it is OK to leave 'master'
unanonymized (because everybody calls the primary branch 'master'
and it is no secret), but that does not justify why it is bad to
anonymize 'master' and make it undistinguishable from other
branches.  Assuming there _is_ a need to allow the readers of the
output to tell where the tip of the primary branch is, let's keep
the special casing of 'master', but still anonymize it to "ref0".
Because all other branches will be given ref+N where N is a positive
integer, this will keep the primary branch identifiable in the
output stream, without exposing what the name of the primary branch
is in the repository the export stream was taken from.

This is in preparation for introducing a mechanism to affect the
name of the primary branch used in the repository.  Once the
mechanism is in use, the name of the primary branch won't be
'master', and may not be allowed to be exposed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/fast-export.c            | 7 +++----
 t/t9351-fast-export-anonymize.sh | 9 +++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85868162eec..f10e3b35e5b 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -497,7 +497,7 @@ static void *anonymize_ref_component(const void *old, =
size_t *len)
 {
 	static int counter;
 	struct strbuf out =3D STRBUF_INIT;
-	strbuf_addf(&out, "ref%d", counter++);
+	strbuf_addf(&out, "ref%d", ++counter);
 	return strbuf_detach(&out, len);
 }

@@ -518,11 +518,10 @@ static const char *anonymize_refname(const char *ref=
name)
 	int i;

 	/*
-	 * We also leave "master" as a special case, since it does not reveal
-	 * anything interesting.
+	 * We special-case the main branch, anonymizing it to `ref0`.
 	 */
 	if (!strcmp(refname, "refs/heads/master"))
-		return refname;
+		return "refs/heads/ref0";

 	strbuf_reset(&anon);
 	for (i =3D 0; i < ARRAY_SIZE(prefixes); i++) {
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonym=
ize.sh
index 897dc509075..2415f0ec213 100755
=2D-- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -26,8 +26,9 @@ test_expect_success 'stream omits path names' '
 	! grep xyzzy stream
 '

-test_expect_success 'stream allows master as refname' '
-	grep master stream
+test_expect_success 'stream translates master to ref0' '
+	grep refs/heads/ref0 stream &&
+	! grep master stream
 '

 test_expect_success 'stream omits other refnames' '
@@ -57,7 +58,7 @@ test_expect_success 'import stream to new repository' '
 test_expect_success 'result has two branches' '
 	git for-each-ref --format=3D"%(refname)" refs/heads >branches &&
 	test_line_count =3D 2 branches &&
-	other_branch=3D$(grep -v refs/heads/master branches)
+	other_branch=3D$(grep -v refs/heads/ref0 branches)
 '

 test_expect_success 'repo has original shape and timestamps' '
@@ -65,7 +66,7 @@ test_expect_success 'repo has original shape and timesta=
mps' '
 		git log --format=3D"%m %ct" --left-right --boundary "$@"
 	} &&
 	(cd .. && shape master...other) >expect &&
-	shape master...$other_branch >actual &&
+	shape ref0...$other_branch >actual &&
 	test_cmp expect actual
 '

=2D-
2.26.0.windows.1

