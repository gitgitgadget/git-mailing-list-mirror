Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED296C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B498B61287
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEMGLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhEMGLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:11:46 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08988C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:10:36 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id f184so4240960oig.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=rtTdSz/wNsC/E75ZzlmxnXTpN5ea9w0rQTXrI1FGiDg=;
        b=eZooZVLhispaO486YCE7boOIEjYMA9QWdQ9c8D07Z88i+2fZKSNyA7l0qFUQE/1zkY
         qnZX9On4DmOeeiapdZNSpX5Z7ve+ytEkhjztpkmieIKFIAAO3p0SubqmhJMljxdVAhKr
         2xX12sBORWPMdfNoiV5gk8i6xGXVjL41idrWPnvq3l+zJ25cV4r0mcbM7lzy2FL3SFWV
         xol0OcT6TVInqL5ZwpYbb10PkfQTc0zCrwT+DYwsj7Ew5FHyWP4rcTOx3NWGEweB/Dvn
         qFk/tCyMptomOHM2tEHsiWg0zXTDp3EJY71faXWhcxG5AJQI3ObipzUv6FUPi8oX8Toz
         G1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=rtTdSz/wNsC/E75ZzlmxnXTpN5ea9w0rQTXrI1FGiDg=;
        b=oHnKNKjXnLFmkUbVimCTAMdj0irE/qw+NqN+4XEmgoE5w78HphHDSNV/5kG8MoWizP
         UrqOcNfsGdfaygY8lj4d0p+VN1XnhvvcFAcItdahQmntX3P/y5qeivnAk+lef+PcAfy+
         r98mn8jhL4tQu38J0aHhIRp5RsTqYNv8rOKz5PJLJtGGZDCZiG3++f6ga6b/4sdAM9QL
         Wq1LzK80HuKaUS55qft1BWOykSIyLBBFvKtPf2P7OcHrUtwCjI7gr2/3KLpJIsHxy0Ei
         YlbtAPmL1eQCox4p353quLtWUHcZohSeRUkwzh+3J5OPz3rdLbKKvk5SiwQrlyu4x8pz
         Nucg==
X-Gm-Message-State: AOAM531AO/7IMPRxE7/tE88Nn47+4O4zMh4d9xOv/pOBzw+/O8DlvHjm
        TEf7CjW4PNDbcvepCqoT9G8=
X-Google-Smtp-Source: ABdhPJy1ymojAqZHlucXD4t2fO4qcTmbrMCYOgnWaZAG1lGO7YvczTT9TBcj+PfnASRP8s4dGVzP+w==
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr1884315oiv.166.1620886235430;
        Wed, 12 May 2021 23:10:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id f30sm488742ooh.10.2021.05.12.23.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:10:34 -0700 (PDT)
Date:   Thu, 13 May 2021 01:10:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <609cc2ca7cf26_1e7820868@natae.notmuch>
In-Reply-To: <xmqqmtszb47p.fsf@gitster.g>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
 <20210512222803.508446-5-felipe.contreras@gmail.com>
 <xmqqmtszb47p.fsf@gitster.g>
Subject: Re: [PATCH 4/8] doc: simplify the handling of interruptions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > +"${args[@]}" -o "$out" "$1" ||
> > +{ rm -f "$out"; false; }
> 
> It would be so nice if this worked, but here is what I saw in a
> quick-and-dirty experiment:
> 
>     $ f hoi || rm hoi ;# wait a bit and hit ^C
> 
> So, I suspect it unfortunately may not work well.

That's because the interrupt signal is not caught.

This works:

  sh -c 'echo foo >"$1" && trap "exit 1" INT && sleep 20' test hoi || rm hoi

And so does this:

  #!/bin/sh

  ruby - hoi <<EOF || rm hoi
  File.write(ARGV[0], 'foo')
  begin
    sleep(10)
  rescue Exception
    exit(1)
  end
  EOF

Both asciidoc and asciidoctor trap the signal.

> We need to get 2/8 redone without bash-ism,

Yes, if we agree this approach is indeed desirable I can do that.

Cheers.

-- 
Felipe Contreras
