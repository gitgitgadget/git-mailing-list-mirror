Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D900C63777
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942E72220B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 20:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgKQUPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:15:39 -0500
Received: from out1.migadu.com ([91.121.223.63]:51150 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgKQUPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 15:15:35 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 15:15:34 EST
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1605643588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=wyXrRoQ5Y/ru6TCGfj7Dujoyzk+gmmN+bOoDnMsYbnQ=;
        b=BuOWKGd/k23RbIgkTr0mU7B676AHGsVS6rCSB5W8Cp146pSbZb/dMFMLhBfibGEBxc3uwg
        Ys41NFADX9PPUZ0Lohxf50pj4okTxTNMhwz5vBXVwNCJP/MsAbLoBFVT4dKMevX3DxkoNO
        kLvZWQecPNAGKCgGYrjQqqYSGOoeDGLusYq9tLCQqx+ZrlO64Y2Cs+ylkO7YhaG7ToMLel
        WHKAvJ9vAQqw3u6lYf7K1odGM6ecSBOT1f1HPXKQC4FIIjeH8eyph9euhr3Fny+3ffOm4i
        NjaGjZV9uokIq1Bjds057ZYRVMG4DdW7PjQth1DXZhuUIG4by00LFs2UEhCVQQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "lanodan" <contact+git@hacktivis.me>
Subject: Re: [PATCH v2] help.c: configurable suggestions
Date:   Tue, 17 Nov 2020 15:05:41 -0500
Message-Id: <C75T4RXIM970.2CVY5MIDCX25Q@taiga>
In-Reply-To: <xmqqd00b698g.fsf@gitster.c.googlers.com>
X-Authenticated-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Nov 17, 2020 at 3:04 PM EST, Junio C Hamano wrote:
> Drew DeVault <sir@cmpwn.com> writes:
>
> > This allows users to disable guessing the commands or options that they
> > meant to use.
> > ---
>
> Missing sign-off.

Whoops!

> This changes behaviour for those who have relied on our promise that
> any negative value means immediate execution. Now -2 means a totally
> different thing.
>
> I thought I already showed you how to make it a "number or keyword"
> in my previous review comment to avoid such a needless behaviour
> change---did our mails cross?

I must not have understood the psuedocode you sent. I'll take another
look at it. Thanks for the feedback!

> > @@ -586,7 +597,7 @@ const char *help_unknown_cmd(const char *cmd)
> >  		     n++)
> >  			; /* still counting */
> >  	}
> > -	if (autocorrect && n =3D=3D 1 && SIMILAR_ENOUGH(best_similarity)) {
> > +	if (autocorrect !=3D 0 && n =3D=3D 1 && SIMILAR_ENOUGH(best_similarit=
y)) {
>
> I see there is nothing gained by writing "!=3D 0" explicitly here.

*shrug*
