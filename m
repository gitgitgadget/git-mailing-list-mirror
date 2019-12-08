Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23276C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE34B20663
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 19:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HNPoBTUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLHTMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:12:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:54815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfLHTMI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 14:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575832325;
        bh=qDUWrDdx4Fo+8MFdU9H5lQxksCV3RbXaTICL3rdhfk0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HNPoBTUbqOhf74RrfyV4Jf6CLkge3PdbJLeYIoc7DmBvtVIR4n5L4iyc/x5Sy6Ct2
         A1CkFrWyOuc3mx+Q5yHPeqghFIjKAHxGa53jd5FBliIh5kpHN9IXsSh499MvX1ywYC
         MhxbhAD+98azcILAt4tOa8b3U7ds5IIHkEValeIA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1hi8F13jt9-0167ZL; Sun, 08
 Dec 2019 20:12:05 +0100
Date:   Sun, 8 Dec 2019 20:11:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy] [PATCH] bisect--helper: refer branch.buf before
 strbuf_release(...)
In-Reply-To: <20191208172813.16518-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912082003420.31080@tvgsbejvaqbjf.bet>
References: <20191208172813.16518-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C9cOgEqz99P50Gvfs+LCXP3X1VO1Ah7eZC6is2dwEhzjd45g7Dp
 Kvx3Jr2ezielnQN6qsW1gbpKBWWZwo9JxKB7CIQAiJab+D4DFc4vFjlmDFd7h5eAgks1Kur
 A4d5z1Ztf13Lx1RIRqIu8QIH4fNMraSZcuDuEXHNpW8NMTK3YyyAE8ba4OsA1bvX3EYTElr
 dpyuHvZIalsAMa3tsM0wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AAgkq8H1kSw=:b+rOms53haf37ZaN+O/ay/
 u07ctGh78YFNbXjwK0Gpe0ppuHq2BXrGECgImwzNQF8RG5ozfYZcYeJWSk0+wrFjTyzcHIGy1
 EfOp6P/73EwqZYjgVtlR8/LWId5WGO/5wLw1quB8FVoegiMfoPtV2ND2iec34J6tT/dD3UBAj
 nI97UOJtY3atLswtnYtHrBE17suIx+4eCDuGGRg/uh8tb0flh6k6bnqUYqxAS8BleHuhmZWwc
 2LekbKBPPIZVRXlC8dYyYoQvLN2mGFy8F3aGksXnqIZ3He7K53MSqHw7tVojaM/ncUz/fnb9K
 X39nGoUqZ6iWoJemjBwtDP8xXuiuH4VUhdb5UtKfd2XXNfJ0fNj6sRCDZv1MCtHCSvGhxj3W+
 tgFAbhE0hS+996cumq+/OvY0lj+aoC3jZuDCs3SpXtSyQcFOLU+wLMJa3noJFlhGXxJhc/9uw
 yvfM9UdKkcRTJr0nOnZ0lqcdssULgdkUQkLL4U4CX0Rlxeg0vtyxOqeZSC+O1/VtHSxjB2e6V
 kYPJuA+RjJhCBrB8eR/wMhhVqSNHyDuEyQNqPaolrNuoAN6cN3g1X9a9tAvIpgbc685G415WN
 SsRCRAKEXG8eU28NCzXbf/5/m3DH/Xb0ORBlbTVTPdzziCOZUYqxPyqNmqt86WjMvtjYPjbq9
 8dUjsZ2AIuDfBmgZQdaZ6tGLNEdcaKMjI13P8iCsFKNXb86vjE+KRtkvd5RhgXwkqwz1Dcmqg
 AVGwkQesl+JKau4sNCBtHIBSEtPE/8Iajr5Gz2eD1gN2ERxsmmpXR68hgJAFx4duQqhhDyNRz
 euRARYL0/djFsaIhxv9TfYPKDjL1VSPV1p2yWbTIr8s/lS1pTm4VAotL6AR359aE2hFPS1538
 EnGz07jG0r5t1C3d5nBKs2zb/lTQ1b9rUL7IaJmSBwK4mXmVMLNRowLmOMvJ6RqGNiZma8Olo
 vCRUReKqLPBZCZ4ZvbjA2s9wKxemAUHlinEqSWXtophA8F9xNBPevUKW/mDe1G8pwQSd6s63I
 Drcb6JMvw3YvysVoLhsY+OATxMeqS9dcIVeQE8Onbrfr+zZoAyFgAP5zTmzaQuSgzDq5REZ27
 JTL4iemRph60wHby1j8RT3gZqsjn2UmNNHl+aEqnYT14TSBQ0qXo7sidpC600aULZXu78yFk5
 vYoTpWWFPSICQPk6XVfBetYVD3ylsGQrwkVGg3qiL3RhjUrtubNYYLdmz9GaG3kLzD/Z3BP2l
 ZDlI/0A9cVIGrkUIiyT2hB5mp0DhfvN1RECbvruqXE6+pST9tBnSL/BqiefA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

welcome to the Git project!

On Sun, 8 Dec 2019, Miriam Rubio wrote:

> From: Tanushree Tumane <tanushreetumane@gmail.com>

Is this really a patch authored by Tanushree, or is this a fix written by
you, intended to fix a patch authored by Tanushree?

If it is the latter, please use a completely new commit message and take
the authorship yourself.

> Move `error("...%s...", branch.buf);` before `strbuf_release(&branch);`
> to release string buffer `branch` and the memory it used.

This describes the "what?", but the patch already does that. The commit
message should be more about the "why?".

In this instance, I believe that the commit message should read more like
this:

=2D- snip --
bisect--helper: avoid free-after-use

In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
2019-01-02), the `git bisect reset` subcommand was ported to C. When the
call to `git checkout` failed, an error message was reported to the
user.

However, this error message used the `strbuf` that had just been
released already. Let's switch that around: first use it, then release
it.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
=2D- snap --

>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1fbe156e67..3055b2bb50 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
>
>  		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>  		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +			error(_("could not check out original"
> +				" HEAD '%s'. Try 'git bisect"
> +				" reset <commit>'."), branch.buf);
>  			strbuf_release(&branch);
>  			argv_array_clear(&argv);
> -			return error(_("could not check out original"
> -				       " HEAD '%s'. Try 'git bisect"
> -				       " reset <commit>'."), branch.buf);
> +			return -1;

The patch looks good.

Thanks!
Johannes

>  		}
>  		argv_array_clear(&argv);
>  	}
> --
> 2.21.0 (Apple Git-122.2)
>
>
