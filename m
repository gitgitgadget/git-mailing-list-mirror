Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C094BEC8726
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjIGRul (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbjIGRuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:50:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046A1FD0
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694108948; x=1694713748; i=johannes.schindelin@gmx.de;
 bh=1nzmyeAStbSG8SAM+WsRy3SEyNnl/MF62vOkuJgYRco=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=Mf0gRKNunatAj2xVX/xFZR6udIbHV/LVLV6oHjnW1Oge4vGf6b+WjkUAlOOQjbONxqrWlnX
 0/3aPoLOROtpHGWg7mz85x60dKGkbl0jPjCfLIRzhztzjCa0TAiuqDiMdnF5vunhnJ8eDlnB0
 d2gbggKGF3mD5LuKc4tOtvh/DyIRGklHZEOZuod9mxeJtO09IohQRQt1KBxOkdHCm/9G4JymS
 Vgqlx5Xq1+eFnBD/87Gte2J9GRNGX1zoEUJLD5ciH26en49V544ninBbGXpR3yVrn2u7tt5Fi
 AUfk4CXHgkHsWU7cpYNP5QmFnEY0ge2D5p9llFKqd9Xw/5VfQmLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1pyHPZ2SLY-00g3XF; Thu, 07
 Sep 2023 13:04:29 +0200
Date:   Thu, 7 Sep 2023 12:25:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/15] Introduce new `git replay` command
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
Message-ID: <d07487c2-4ee6-3ffa-014d-418793a5a584@gmx.de>
References: <20230602102533.876905-1-christian.couder@gmail.com> <20230907092521.733746-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P4lsYPUUFXzuUymKaXgtyO3ou/BcNz0E+DanNk1kpYJSR7DRfLT
 brgzU/1bNcnzeOgv/HnQ4DFiciSWDF57huXXLGwx5w3tWLCAhSsAa7VGWgMqCZ6oe2EVvLm
 YusN6+phl1wBewNaRpePrh2lJ+f2Sk6/CX0zkx8uvtrviyw7RuGlP5I04csbrs2RR6EC2ZO
 7DH3w6Rt6FGVe5xu6X83w==
UI-OutboundReport: notjunk:1;M01:P0:sNBGZ97lwOM=;2/NtwUA4KoJHiLKiAIbWGVEufng
 plvbFoWb8UrIv8ExnPL2r9oysoP5+Xy7Ui6ok91eEZ1WKPtjcC85oxlZe01EvY+DvPrwVr5tv
 UJkAn5cUFbZFzCAExaU6nosKdQoQaFFpt+GOHQhgj5TaFqO5pdWT4W+dSIC19JMWKSh4Z36Jk
 mZadTAWV9JkP7pTcu4kOCYfAeLLaZuLpINl7hgSKxG9izrBrShS2ooQ4sKM0xcuNC7N1iINjR
 OuZJAmxueH0wnIkHXonj2UATG+RuZGS0GK2niZRUyxvVk/G9fdALdATEvgqmGEIOZK3y8mMwV
 BZ8GiTxwi5n2IUI3Yram7W0S8NjzNdMaDFcYDEhZvbCt4yMeIjm2inZbLKlFwh9zF3wR3d+Oc
 jH0VPW/XrCDLOw/K+KEus4j6hK4BW9sEuQ4CjhDA9DdFXuCoHxkME057AAD6ATBpjCFonzN8k
 gKkyEwzHmRywoCVGd4E225BIHyEjzeIL/jgy4r9PMBGjsKdHJ91Acvoqw4pCcfU5GsJddCun1
 m/eU+w/YX0kYP+3xc3ot74LHa43SfMRv7gQJ8a/8cL8IF72oi0GUrw/wwO3wDEYxGkuH2tKk+
 IhI4UiK8Ju2wL7lgM9iq5LsNmbc9HLSzgH2r3QPnC4NsbJqwyVzwuAOzZvC86bTSQSi8DEE1U
 bgwz0ShcA4U5epoWhJ04yommxVd4A3hinVK670CH4O7OM/u4up9vERx2lZJEA2OMwuK3Onb6Z
 bekNUqSJIrV6Rcn+bJkKfoqolXuYUjzGkpBouUEmq2pUC6rhe+nZwEu4ZY3Do4ZeDc7XjZkQ6
 M9oXt7jNXe0yGrQADmm9iom+gTP+BRDjAG3HYtKgdOV71zQt+7ZZ3WQsFprB/ToZByA708Sh8
 Ze4xd1MYA9rZvNO8N5VZc/6r56OUbK1LxfLX0rSkMJNwxSL7iKqnTGLT9XPNCmuUAQVSAP9XN
 0MmifsDqiQ/KQYG8hfB2nY5VfYQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

hope you had a restful vacation!

On Thu, 7 Sep 2023, Christian Couder wrote:

> # Changes between v3 and v4
>
> Thanks to Toon, Junio and Dscho for their suggestions on the previous
> version! The very few and minor changes compared to v3 are:
>
> * The patch series was rebased onto master at d814540bb7 (The fifth
>   batch, 2023-09-01). This is to fix a few header related conflicts as
>   can be seen in the range-diff.
>
> * In patch 10/15 (replay: make it a minimal server side command) a /*
>   Cleanup */ code comment has been removed as suggested by Toon.
>
> * In patch 11/15 (replay: use standard revision ranges) the git-replay
>   documentation related to --onto has been improved to better explain
>   which branches will be updated by the update-ref command(s) in the
>   output as suggested by Junio.
>
> * In patch 12/15 (replay: disallow revision specific options and
>   pathspecs) an error message has been improved as suggested by Junio.
>
> * In patch 13/15 (replay: add --advance or 'cherry-pick' mode) the
>   commit message and the git-replay documentation have been improved
>   to better explain that --advance only works when the revision range
>   passed has a single tip as suggested by Junio.
>
> * Also in patch 13/15 (replay: add --advance or 'cherry-pick' mode) an
>   error message has been improved, and a few tests have been added to
>   check that `git replay` fails when it's passed both --advance and
>   --onto and when it's passed none of these options, as suggested by
>   Toon.

I left a bit of feedback and think that once my concerns are addressed, a
v5 will be ready for `next`.

Ciao,
Johannes
