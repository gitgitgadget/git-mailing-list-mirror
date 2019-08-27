Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5011F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 18:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfH0Str (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:49:47 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:61104 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbfH0Str (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:49:47 -0400
Date:   Tue, 27 Aug 2019 18:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1566931784; bh=NlHu43Oxq5PqthfpIgOnRtHU/cboItiMIBC/vpPLdSw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=WDSfoieeTyenQf4kvX/BAYqaCJ+oZbkX5qCrgAlkFfx6EBgO+lGeyrv8BObGrvbky
         HGsI3Kc7CQuj5xzOoLjh5/F5JCqlZxZBoca+K5KUXF+3ttZX0zd+RehR3On1K0JXxa
         wNyzO4TAfh6ai8N0JPRQKnTAHlco+kLJCEWE7K8ZZ7uaERJPH8Z47WCLEcYKrMbBaZ
         ++XA2kFM0wZBgNhbdEgoEoPdxxr47DFgYtg7poAqpDRRjgAlK5dMA/4xvLtGUXjoFw
         PrZyOiQ5K2zYBrU8DC1Dqz96PR5LJrCENUR2Ryhr+b8wPJnMAioncTwyIt9sL5Ckd8
         o294wymaMDMfg==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   Ibrahim El <ibrahim.el@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Ibrahim El <ibrahim.el@pm.me>
Subject: Re: [PATCH 0/5] New signing interface API with pluggable drivers
Message-ID: <roBm3J_8ZgID_Uc8ZPZ8rJP0Ljc4ChC5MD9MGGbYIjQISuzvRxM36ZwcPcWQlKydxl-mwVT7tWWnA01ZGLhqdENo5ljEHkmfkIq3trGBM2k=@pm.me>
In-Reply-To: <20190826231543.GD11334@genre.crustytoothpaste.net>
References: <tz1YiiRtWStGrH2sc42DyD-8bDtH1A52rOCCapct59Qos6jEikqscvusUs7QeOBRNmCF7L_AL1ezKurbTp6qEZCmEk7L9B28wH-TVQGBSdY=@pm.me>
 <20190826231543.GD11334@genre.crustytoothpaste.net>
Feedback-ID: RXIF8gqyi_fC5k95OfXmu3uPk6ALUZ4LT1y2TXMvXkIlhKcvgGbg1qhMCvct9LiRFa1gVJ9p8_D_liW8QUFSlg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thx for your feedback. I will incorporate the config based improach into a =
generic driver and will re-submit the patches.


Ibrahim El

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, August 26, 2019 11:15 PM, brian m. carlson <sandals@crustytoothp=
aste.net> wrote:

> On 2019-08-26 at 19:57:45, Ibrahim El wrote:
>
> > Following previous introduction mail 1, this first series of 5 patches =
is a re-write of the signing interface API in an effort to support easily t=
he addition of new tools with minimal effort and also keeping backwards com=
patibility with current tools and configuration.
> > All existing tests currently pass with backward compatibility.
> > The patches are ordered as follow:
> > [1/5] - Adding Documentation files explaining the different changes usi=
ng a design document and updates to the configuration part
> > [2/5] - Adding new files that define the signing interface API and also=
 drivers for the existing GPG and GPGSM X.509 tools
> > [3/5] - Migrating the code to using the new signing interface API. Old =
GPG Interface code is commented and ommited
> > [4/5] - Removing the old GPG interface and updating the code to remove =
all gpg mentions from it to make it transparent to the signing tool that is=
 being used
> > [5/5] - Duplicating existing signature related tests and updating them =
to using the new configuration aliases
>
> I haven't done an in-depth review of this series, but I did point out a
> few things that stood out to me. I think the consensus on the list in
> the past was that for adding future tools, we'd like the drivers to be
> configuration-based so that Git need not learn about every signing tool.
> I think such a change would be welcome if done right.
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------
>
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


