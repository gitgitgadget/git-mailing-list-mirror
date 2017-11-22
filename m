Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821CA20954
	for <e@80x24.org>; Wed, 22 Nov 2017 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbdKVSg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:36:56 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:39749 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdKVSgz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:36:55 -0500
Received: by mail-qt0-f177.google.com with SMTP id p44so25002472qtj.6
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fxZroQAJ7TLGLVUq2BOyOkxfCDqF1CmgTCjCt8r+5sQ=;
        b=CxDRClQ4HTrgqYFPyfwUPO8HLBe1mQakK9RtLT7e6d8sBQ3kJwJsbqAzmSxzOZk5N2
         ck5D1AbkiSV1/kb8MmfI2oMAuMDkss/+lm7TcX1xhAl/VdHJdz0BSKU6nnwYI3x2ank0
         QOMsfdB56r2Lqu4A5gxv2U6Ip3q0S1e6jNHuhM5k2fkyVoQn1Ijf6cmz2EbvpmJYumrS
         YAryFDQbeB7he3lYkhuaQ6Fef10Xtcb5u48iTnqDrSUF0WYnyvjpp1/gjSgxAj1LgziP
         HweSp/fsubWQV3fyYF4nZV4xcoPL6js8/AZiKCGXjSgN8AT5vQIYtgSHc88m6Z8nxz3z
         VJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fxZroQAJ7TLGLVUq2BOyOkxfCDqF1CmgTCjCt8r+5sQ=;
        b=WTiWS/fl5BQog5twkypw9+cg0Zh2PnD3GJs9RHxJpqe87ZsDfnSoQJ3FExpF9MwuyW
         Aoad2U6ZGYAeesjmHDXeIA+ojqLMD2CTZVnrBfX0FMeqBV3dEljsBkZDhSsO3fcR4LvW
         5i9RptORLbOuTcbIM3fbsbi7EUtF0X43vVZYUWSWeoZe0pGHU4URN91/sn7wTcV7gwA7
         KXHms3WWlkCb1hpXJN0b+tVniOehsaJAxs0Gg2MbpGG8IWFHaeX0abhqhHmsCcFIQHDa
         DqBWAOMEty4Ol65snb4mapcyxabPfcngXAsbQR4fy8VprAUFX+lYI/PZKlhbovS5pf9z
         TfDA==
X-Gm-Message-State: AJaThX7seUFp3woKBe2qXkXVMTiWpNlD3ZKlk9fxnrdvs4z1xkuFLKZn
        HCnd/UxI/4m7etb0JjKNguyuG6Ns87j3soP67Ez5ZQ==
X-Google-Smtp-Source: AGs4zMZCuGwrrBiuxhcETzxAVEPG54QtSeY2nFKgOSf6+V5sztPCGuclUom4FkmZE23zsiIUtNM9ES+kblD0fNqVPgo=
X-Received: by 10.200.36.105 with SMTP id d38mr32484581qtd.180.1511375814800;
 Wed, 22 Nov 2017 10:36:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 22 Nov 2017 10:36:54 -0800 (PST)
In-Reply-To: <20171121080059.32304-23-newren@gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <20171121080059.32304-23-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Nov 2017 10:36:54 -0800
Message-ID: <CAGZ79kZfOUjdOKA4JE8v18ETZH1n5ViUWt+khsjFX1jsp-uY7w@mail.gmail.com>
Subject: Re: [PATCH v3 22/33] merge-recursive: check for directory level conflicts
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +                       /* We can assume it's not rename/rename(1to1) because
> +                        * that was case (1), already checked above.  So we
> +                        * know that head_ent->new_dir and merge_ent->new_dir
> +                        * are different strings.
> +                        */

micro nit:

/* we prefer comments like this */

/*
 * or like this
 */

/* but not
 * like this.
 */
