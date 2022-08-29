Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE90ECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiH2Mqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiH2MqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:46:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD79F8C0
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661776249;
        bh=Ybck7EnI7DXdlveponVjAdelB2EL1rB8FU7G9gW+4/w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VTYliIDrsMGkAPv1JvF8CDVKvFEKL9DD13yJoCBAlbzHViK702mLXATOhJiLO2Qht
         Dk5aVlxDscj3HRA3YR/Iuah5+9euOsVLS2OjucbBOmwA7bXNQm9xVPXQ43qtUl9xaK
         Ic4GA42vWbyh0Of5ZNe4CnWXOFAX+0+6QcnXdbo0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1oRXzB0pHQ-00198w; Mon, 29
 Aug 2022 14:30:49 +0200
Date:   Mon, 29 Aug 2022 14:30:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/16] bisect--helper: make `terms` an explicit
 singleton
In-Reply-To: <220829.86o7w32vv2.gmgdl@evledraar.gmail.com>
Message-ID: <s47684sr-p257-31n6-5qr7-0p29490rsp7q@tzk.qr>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com> <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com> <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com> <220829.86o7w32vv2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1956167773-1661776250=:189"
X-Provags-ID: V03:K1:+lkkirRLIt1+0zsZ9QqjsLVB4dtCilDAd2zOU3FimAQmfP8ifbi
 hKrVVfEfHFYJtLKUBV1ljfyI8i2hNMAf5UDK6PPAwLBEUVRvJ7wG+Z6tU1la2Yk1yT1M+iE
 O0hl8Sdb7gVvTF907Lwnj7RtFyFLlm3QwJROBzObOzuHIu9z8LY48o+aW4QBRGvWQ5m7nNo
 9i3OxSSz+fuws12LdxTSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j/EzIogqnrI=:npAVe6sB+O7e/KB7ceHMPi
 ZJFiiqVDnWCOWoGfeUXpqvqGeh62SxpZYUbX9Zz2mmBcbi+MWotFKMbVIntmaCZmeUOo+Mqd/
 eFYg+vTjKv6bpQ5qzZ9R7nstRBxTx3jqFtEiiPQw9X1QhmQ5oNdElOfbkVZMikM4IwaTjLtUf
 UxPBSRwrcuhTU6dCeR3mo1tPHsd1BBw9uR9DVGtYUrxTj1qfqC+7uv6u4MQ7NV2UfS1D23/6p
 3uNtLxx+vks2BehWLEu4fm8ekCshyOjupe/7D1QCcnM+w4VX2sb/GCB3DCZKTuNLXOukG+6gk
 0GxMVMEq+qLF27G/lxZE1AEIUuWy8lE5lew0DgI3iWBd/jwS9j+71kmkrhnQJnbBwwLdVvFH8
 XREuLjos2WV/UC0/FlABU3+oPKZOogxOZs2cWyFQ6XzyPLhCD4pkS8Xz4TcsEovS+5e1vHX6q
 4hateMGwO3k2o5WWlx+oACx5Zc33bSfmGIz0d94A3vHMYq1dG6MckHVQS6klTjXMMI3VVmoss
 4UEqfpbXJY7Cvk+vy37M/5DBk/8gw6bVgLuCnzu0epAo90s1tcHfo8Xdl+7+RnkYLJ3QClTz/
 nqmR6SFwV1ao7LU8Gzqfr+mnoAzLUzXtMTpLxcNLdemJrRNB6gvJPIsCupUbkTU7zYV57KO+5
 7fQe+qbPvzxjG0Y+H03WYX7dN2qHEixGh4vk6vM5C5PWEtCCxpeZsEh0en1bN/hiT+eb8KW7k
 7f5z842zfNS/vw+rl6ROFb2+WZdgBo4xsnzomIA0Xi97ZuJpLXEQIgwIQvP8rPEkyawVPe5Eg
 8Srm/CWYYBXt5HbsXY/DY69wLtxldf6oNco0w4kr+lPSxYOM02dfQIGRNVOqQcMGOOOSLo2JS
 hcNLj0c+tavxqit+vRa7rjHEX3F4IMEs+OMYzET6Pd4JGY1GucpLFZZ2h2Kr9q1CSDNgO/Whx
 CpCsXjYyzQQ0mJlevogziiOPYSZd/ku4vrU5lFMh06b28TThBzPTbpmW1R7qH5wxpQLWjyxPM
 CN7vHHnFyfvFVUnABJVlZ7RzS6vqN+oVF2b2KtPyi3hRd/htNHDeZKyBT+k/vfnjyMJ8pkC9x
 /V4pvcZTtGNL5+xSbXyGy03bzlpiYYleZl0SNn+zVc78mkxQt1yg5lStg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1956167773-1661776250=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 29 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > [...]
> > -	free((void *)terms->term_good);
> > -	terms->term_good =3D xstrdup(good);
> > -	free((void *)terms->term_bad);
> > -	terms->term_bad =3D xstrdup(bad);
> > +	free((void *)terms.term_good);
> > +	terms.term_good =3D xstrdup(good);
> > +	free((void *)terms.term_bad);
> > +	terms.term_bad =3D xstrdup(bad);
> >  }
>
> This is pre-existing, and dates back to 0f30233a11f (bisect--helper:
> `bisect_write` shell function in C, 2019-01-02), but it appears this
> cast to a "void *" was never needed. Perhaps some C++-ism that crept in
> here?

While this is all true, this feedback is about code that is not changed by
this patch.

I am afraid that this review therefore misses the intention of the patch.

Ciao,
Johannes

--8323328-1956167773-1661776250=:189--
