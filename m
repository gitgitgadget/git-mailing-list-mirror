Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFDDC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAED72074A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iNslZQVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgJOUmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:42:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:51055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgJOUmC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 16:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602794519;
        bh=xl9dY6K2bpEPnP9qQAWnpjkWh9kQoL3Q6Gw0XDKsw80=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iNslZQVlt1gW8zUt9cS+DXaJrM/bC07hFtDp5kr96VuYmAnM0eQluCgIf1b8h0Tvk
         ojTXALprUoAr7UBXMIWUqMOYElSPApjVusGu8bkDcIgz8yWR91rqWCqYGUt97qEohH
         8RHB2S5WZ5dL+Flg8BF1w39f0XLJ81aqk5VcQ2ME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.212.47]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f9h-1kStUO1dAF-0049Od; Thu, 15
 Oct 2020 22:41:59 +0200
Date:   Thu, 15 Oct 2020 22:41:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v11 0/7] Finish converting git bisect to C part 2 subset
 2
In-Reply-To: <20201015133838.85524-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010152241230.56@tvgsbejvaqbjf.bet>
References: <20201015133838.85524-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nC538ftHUf1c3R4gzDsHiiXjd6a7589iyByCyLlzjgFAwiBpcta
 YarT0MzG4tHzr8zmqEt4tuYXAauMJYsmiaSaMqFq8VGoSd8yvi93AFJQMpjHKq2vGTrNIji
 x9w4FjPiGVwzWyoUENBDDdtIrmAQs67mcOqbu7G0X1+X3SSVBE9wFpTBsSxk6kRcuk09TbF
 UNdIDYhuhJcVzuKDQUWDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5ehY5E6I4A=:akwNd01heyrdoSBBPy2ePq
 VkU/elOtwNYo6lMwfJuyHmIsz/Whza8lNAFkxecQzIT5glxuDgjCI3CHVKFSWLH9mO7EfVhBT
 dwe3yYnZAReE8CIvKN+2zxrQrY6nHID9GhfYuLKFtfz0ZY3des1FsbwQBD9dDuwIsXW8CKyfl
 iLuKs9kcoyGb9WCmfcA+UcN4RkezEIwYwpiI6p6fteKGI6IklrCx44r+s/y1sTtZRVzLn1bBw
 6Wqa1d9N7tuZuwyFBd32chU8WrqRN/cENzoBcPCH6GYfsGhwsDWAe7Aja16luPEhMgFT2aZnz
 Tz3l8f+fDX/jO+7yzo7u7wGk1vVy8lg9mxLAYgju/BGQhmuuE6aa3i3vqs3xATRZCYYa3kn/E
 u5LM2B2cKDgt16yA84s0v+NWnVfufKujizkqAJLoUVOPKzlJJIluOpWvXU6mxGWgBYqQp6tYG
 j3X4acwzVUJiECDCNhaDCq97MwPO0IwWcTJV9DhV0YtzXWpajfFwaKF25LmJSV/nbBxOb56Yx
 hp+jWlp1PWGH8U3jFm2Gm+vIFBv8gZcIYf2sPUsYM6tN4FhmN334JebzVERQyMq/G1/n7GigJ
 MU175F0FOK/AGWtR0AAC4GXCKv7fai06M6yLAkoUSa0t2BBHupcRSD7CLkrhvBo0ulhw2jbPC
 TvrDJWmRo3va1WBPSYPAL3vRZ9a/pB3kM0N1g6AwWjx81qcJAXz26JO77INkC7AY+auNtgULL
 GCBsz0XbwESTKyp20HfsvYyWC8cKhDfPLaRjsKYWtfx6krsW7HQdlf3JPX8zr78m8tm3GG0Hg
 /zbPsRBYXWnTdt6EIFj/BwQse5TAIlJKSyNaMS5z3Ktk+TznIZPJtBh0KQk1d8Vcpkx3iibCq
 17qW8PYx5JKL+8HnTyVqOGeHUel4loHJ/Jc0HhRlM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 15 Oct 2020, Miriam Rubio wrote:

> These patches correspond to a second part of patch series
> of Outreachy project "Finish converting `git bisect` from shell to C"
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This patch series version is composed by the last seven patches of part2
> set.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v11-subset2=
.
>
> I would like to thank Johannes Schindelin for reviewing this patch serie=
s.

Thank you so much for driving this forward.

This entire series is Reviewed-by: me.

Thanks!
Dscho
