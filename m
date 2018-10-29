Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7B71F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJ3And (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:43:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35651 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJ3And (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:43:33 -0400
Received: by mail-io1-f65.google.com with SMTP id 79-v6so5276507iou.2
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yLJxC2Pao247n/jbMRC32LHgtR3fDA5o5jt18WX3qM0=;
        b=eu9of2RjCT7xzDhOUblLySoRcgAPWUTYwmNHv9AEtjGylhgjGjw3sSZNaXrdH2T/RI
         f0TB+/gmC7yjof/v41FxRwCxtNcZakeBPoRF0TM9pveWD1h3O9u+2xyIepcC8ucbnX8r
         ScEPu9zdOFA2W8KdvXQSvoC3XJ0Efz4AD3b9JnC5Uf6H/Acf9/fWTuoBIxNLOwli/oJE
         H9PGpckEenmyS1gmUMsCCJuqlhPHX+1VxqZMbBQsI0xHbT2byEH+yXUgtG9mvP3fNnLq
         OkXnSdmKVMg10pja0QD1FeZiInD9+zIpbVuDexTQVfeoJIKuXpqV+ZsaWO71hSqyl7i7
         hcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yLJxC2Pao247n/jbMRC32LHgtR3fDA5o5jt18WX3qM0=;
        b=pPyoIIL/5O+XQ9ZV7nj+VBa3DQPwW26/QeYlKNqYOBQY/y4wnt+aNu+yj8D3Jr7uVi
         fGvsG3e/c4nwfmbg3ABssnnVdOHnxiRTB5co7Iu4oLOt00E0CveR/+C+We+UtS5APb5f
         Le+/z2morXDoWvIJP18shq3PdVB34hprRVTlHtki6zsJEYwulqrP7n/CZvBkkqiFELD4
         KubKZNHLv6o6xe/OYlKNRRVG2KaDquJc5zRqbLBL/cqZHKTL25kduK1jmG10xG7hKubk
         s+Pv/cGpVpYE3RvYA6JSptY7JIhipyKzqVToJsnA5CvTHk+e002bd6/9UMxlZCoAqGJs
         1iyA==
X-Gm-Message-State: AGRZ1gK64vRMR+wj8wqNDj9IWKjKuUO1AnrFyHaboWLmnYWqcqKboF3W
        UZ7u7glulJPf7brRyt2K2qoHqJbqMcjQAm1smKLbhw==
X-Google-Smtp-Source: AJdET5cv1EAUSvczWE36WEkFT3NHQt3+2T68RdT0bNb8GU4aW5t/OYD/92iuyx7D8eDj9ezJcEDxARW1CoNF9kqeMQg=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr8934008ioc.118.1540828461391;
 Mon, 29 Oct 2018 08:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is> <20181027084823.23382-1-pclouds@gmail.com>
 <87h8h4lwcv.fsf@evledraar.gmail.com>
In-Reply-To: <87h8h4lwcv.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 16:53:52 +0100
Message-ID: <CACsJy8CLHQ0mKhKXvTDAqy9TLwEFBSvHEu5UbPxHX4is2mK+Cg@mail.gmail.com>
Subject: Re: [PATCH] wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dana geier <dana@dana.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 2:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> This patch looks good to me, but I think it's a bad state of affairs to
> keep changing these semantics and not having something like a
> "gitwildmatch" doc were we document this matching syntax.

While we don't have a separate document for it, the behavior _is_
documented even if perhaps it wasn't as clear. There were even tests
for this corner case.

> Do you have any thoughts on how to proceed with getting this documented
> / into some stable state where we can specify it?

wildmatch has been used in git for a few years if I remember correctly
so to me it is stable. Granted there are corner cases like this, but I
can't prevent all bugs (especially this one which is more like design
mistake than bug per se). You are welcome to refactor gitignore.txt
and add gitwildmatch.txt.
--=20
Duy
