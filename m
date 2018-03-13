Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46091FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 10:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeCMKZv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 06:25:51 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38295 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932521AbeCMKZu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 06:25:50 -0400
Received: by mail-wr0-f169.google.com with SMTP id l8so6669306wrg.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8GDGqK4p/1r5ak82EoD0wgj4BwmPhGGQe3tP+TpAVQY=;
        b=ddo0JlsT1ntq8emvyD32vRtaFjYyMTaH22NYDURO6D9PIAA9Eshvhc0gTJqwPnOxzd
         YxD2PGm6Xn1aY9gBc2ScbY4nJ/S4AteOsjfU3aRkU8VAnZRow2mwpN+25tglxYlfyhMf
         U3j0nbcuWfLUo4jIeA+bAJBdI9VdvmNFhDnzV501TMYt1nbk9V29iSiHOGgHX6p6dKYs
         sr9Hs78Vpbobjr1Egi0v34HRIC8kzKZtboi8R7TJx/fYRnpBb4KoYETyDhL+hwdrAP4b
         si5UNYKMKNJJLi6f1sZg6S5O4N3GehSIBPc3irUt1u4BJiCriwDFIDs7GsQGLdHpGa/F
         KYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8GDGqK4p/1r5ak82EoD0wgj4BwmPhGGQe3tP+TpAVQY=;
        b=ody4n+OJRAzNddX1jIhFyUZ6bz4nyrtOioz9giBCb1JGa1dS1qHiTCMQZfAN2OwqqH
         664DoYUJPXEcfs2TUKyeEaGDc0HoFkjxSAoh8gd7gsCTztclZ0p6jUKJnmahOHyDsF5u
         6FHXuRapqzggmbWGP2WHVxW3e17S7+MKsRPzB5GrQo/R6GMouyUv7Q+aUP5Lt9OCCOmQ
         noeel9+0YjsccN/8mSpB/fYUQQB7mLSlZVRvceb0hL9ykRiad9JHQgfTTRv/+AAuks8I
         H6XMjdJ4tVXyfsC/nciB0eBiCNjeo79WPxUJpiOB2o2abU0//FWdnHnMyw77UB+GE+0m
         lmVg==
X-Gm-Message-State: AElRT7G+a4RB3e28BWc8KuJuRjI2xWJpNXhMnAEgkYI5HFEwSjluCJTl
        aBUwkKzq0QawZr1Nd9xR5dgwaz1zPrXNJ75yixQ=
X-Google-Smtp-Source: AG47ELsaOpwr9Cmr1Cwy4SJ2sXsRxovWQXi2SAyAkR5KgocQx3N2rOEfVKe7U4p+1S/0dnJ16ySM0ls0PoKPsNDjD64=
X-Received: by 10.223.144.35 with SMTP id h32mr100402wrh.2.1520936748507; Tue,
 13 Mar 2018 03:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Tue, 13 Mar 2018 03:25:47 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 13 Mar 2018 13:25:47 +0300
Message-ID: <CAL21BmkmXKzdwYHu1pNxuHhaxqei4ekVbutbuv2jmv6=GgcG_A@mail.gmail.com>
Subject: [RFC 0/4] ref-filter: remove printing from formatting logic
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main idea of the patch is, if you want to format the output by
ref-filter, you should have an ability to work with errors by yourself
if you want to.
So I decided not to touch signature of show_ref_array_item(), but to
move all printing (I mean errors) to it. So that we could invoke
format_ref_array_item() and be sure that we cold handle errors by
ourselves.

The patch is not finished, but I decided to show it to you. There are
still many places where we could die in the middle of formatting
process. But, if you like the general idea, I will finish and re-send
it.

Another question is about verify_ref_format(). Do we need to allow its
users also to manage errors by themselves? I left the old scenario,
printing everything in verify_ref_format() and die. If you have better
ideas, please share them.

Thanks a lot!
Olga
