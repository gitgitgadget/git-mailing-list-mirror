Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E95CC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEFC24655
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aIwW9H4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAWM1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:27:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:55139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWM1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 07:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579782419;
        bh=9GL6xm6XLMRJr5QFQzFoFLJf7nqKqZbw+JHU+HjMDZI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aIwW9H4oUBEp7TK3J+vdviP7i2IG9xc/DflS7a5ZW/WmKNO7gyreX2BB9SF433ZuK
         0sWNpYPQiNlZ27Fg7vmr5wW9a7evh949dzY14ZwFw+jiPyo5cIem5brTQ9lfmmONLy
         CK1PKNoOaBO+rSnJSvUtQThvfEDynrOlUUL0nR2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1jiKcG2rDD-016C6o; Thu, 23
 Jan 2020 13:26:59 +0100
Date:   Thu, 23 Jan 2020 13:26:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] parse_insn_line(): improve error message when
 parsing failed
In-Reply-To: <xmqqlfq08nzz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001231326310.46@tvgsbejvaqbjf.bet>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com> <pull.529.v2.git.1579304283.gitgitgadget@gmail.com> <2ae2e435b0ef6888e72defc7abee1909b29aa914.1579304283.git.gitgitgadget@gmail.com> <xmqqlfq08nzz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tqwpKYjrtok6VqHfasRTHYofAOkrtTP+ZdaH+Kv5PjLlup8PXPq
 EVOL0BiwOxu8YFX/TqG7KJtfzGJp60IU8za1L6YXM8rhfRJIaH2tM51KhHa3Zyxqr+Azc19
 QD9jT/agwOtsaeDS3VJOtivGlSbPRpaNn9Nq/tTe8i0kglEWIN4dDnpC15Pp6a/xcLcKKzV
 YaXfqC7LprNiqZb2paqpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tY508ssPqrc=:QNfSam/GVn/Mqe2p7H6oBv
 eOzvlVyrIPisX1hYqOtav5ffu32LMomMKqrG2lKHVhCAZFzGiHAlt5oV98XfNQFJH4gcelr7g
 smdBraHiJQy0FDJHH7VJi+j0aE9BfU5jJoSxTvMlPpm0IdBeFbfyz2DPGPeI3DsNAMcx2ZxXi
 A7lyvaEEXHcFSuSBMm7FvDz1ZoUzf92dSG39Ir1ludawc/v/SvRbmrqu/fFijumx83tDZPygb
 hvLAdw1OP1sLYc/HTqeMtBOw8ZuPgpRCYkOR5vsljS+lZVwMJqNxRL/Qwz4zgbyGq9N28efqs
 9w8HvUb9+42QgqC90eVIgZfJUPysUehZe5wFJzXPr/tIjC8DGoUj31kXQYkLJn/HENpUTmI9E
 jXt8koyVQlDt4JgHk5nMyIAOHcVvzeuaSsVav/18DD5/Tf22RH0nUS0CQ8IyCjuN5nFQ8D0Vs
 Uxhbz353OMG9hZlzZfUUSK9iYyu8gHhYGqwlUj9Eocv4gp2guA6J4jM+Tj3F+0HmgMFIIMEcm
 N2hdrIIX9P8TIBtKExhzlfvuKfj6wDIesutHjX8KGijgurMnWIczPOV1Xy0ToURtZlrPaaHMB
 bNdMaUhy9f9DUFna9fmgRUtpMagtpp0m9tpv27QX2uacLsAiSxlLvwO39rYHBnQhzravC7XyY
 OjgNvSBedpmfTpi6yGMmy8PwH9pO0PunC32ePM00SO18S19FzCr1Oa4gP/Y/1wIAv0eyyoaer
 rtkPmhr4yYWUGM/3VtztfvugknCpwhtc+Gm+XODZ32OnJR3bP/r5KAeHeFD9KfOhH8AMxCfMO
 iDkDIr+A1AcPIXPDNy1hQ7/2eeBfyb19zGxXh9WIeSsOEtZjuMmY9pI2N50c5pWLy2TdDuqBT
 HKeXc/L0gGruVNyfumDfpeqBuJqMt9M9B46G1S9xDVC3DzEWyCDR9iARD6nT/ZSNnPJPLJVdA
 QhQozMCYsd8ZSXKlSC9y5a5J1EWXItXXO2a73+v0HXv0d9bxiBtxBi+n2sfUaW23tmAvOflb5
 14oweKIrRDBuM4iBeGZnsvu3Bq+xZcSVya8d8g064CZm5CDGLg97lw9agz+wPD65OMgf0Zl2B
 KDntLun8XvGIAtwzrU9yGtEN/F4XiQFTxDITk8KOub/nUZhkGtlfnSHNKX0BKKBDT1MwrNe89
 bW4ydPJRLqrdvtUp9SnQGAOr4owrmA8FpZ54gpYB2671Qjvm/rhAWlHD+MPd40elG1p2xxFx9
 FZ9v1wy9/9sxfbaaC
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 21 Jan 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the case that a `get_oid()` call failed, we showed some rather bogu=
s
> > part of the line instead of the precise string we sent to said functio=
n.
> > That makes it rather hard for users to understand what is going wrong,
> > so let's fix that.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ...
> > @@ -2125,11 +2127,10 @@ static int parse_insn_line(struct repository *=
r, struct todo_item *item,
> >  	item->arg_len =3D (int)(eol - bol);
> >
> >  	if (status < 0)
> > -		return error(_("could not parse '%.*s'"),
> > -			     (int)(end_of_object_name - bol), bol);
> > +		return status;
> >
> >  	item->commit =3D lookup_commit_reference(r, &commit_oid);
> > -	return !item->commit;
> > +	return item->commit ? 0 : -1;
>
> This changes the polarity of the error exit from positive 1 to
> negative 1.  The only caller of this function takes anything
> non-zero as a failure so this would not cause behaviour change, but
> returning negative is more in line with the practice so it is an
> improvement.
>
> It is unrelated to the theme of this patch, and the proposed log
> message does not even mention it, though.

You're right. I amended the commit message. Will send out a v3 soon.

Thanks,
Dscho
