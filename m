Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88088C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6612361159
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 01:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhIVBZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 21:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhIVBZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 21:25:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4225C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:24:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p29so4960972lfa.11
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 18:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lz3Q4N/CEy7vA3nmWK2eBwiFMgULN/3/gtR8JB/jYYs=;
        b=iD7Tdy7p0FAIJJ69ydAypl/YBYvvbZtSwLpB5nxclx6I+79/TLgg2QA2xo+02FnLRc
         +sg+WgzyAWFBkpFazXKMQ7aDL0R6avdTxXdx6E8OC0stCL9m/Rd3cKuqlNPyCL2IHurA
         lyald5ptcXam6wtPgUAf5NEAPw4BqL7+7PkS/fE8bxxydB2yiVcJ64FLR1iJNnZeNwyy
         kdoUwhndD6rvQh5hfrbkEGyEw+ZgcpshuMTB62UK7DWVcxO8omc2CYGMv5EtUU/DkXKA
         hKoXubu+tP18lWsef+9HeSy26ZChO2LcRhfo8ZTwN1i6m/JfkRIBfVaqEl1ODgZtLlFF
         6OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lz3Q4N/CEy7vA3nmWK2eBwiFMgULN/3/gtR8JB/jYYs=;
        b=adbqqCqQyJDYtq3/L+/wEDT6bN3YOi40bs5TS/vVkxPkrY+g6XrpceH517IXR2Xlv7
         Q9BgQ2MWWe1Fsiqqf4SbYqkwq5OaGFD+pszfTSmQdXF4DfqlmKD9Bli0rCsTbaomy0iF
         NP+8Xu+t03EVUC3qRv5E8xM4q1EK2qEOwo+zaCgrlmfgr85BXthIGW3YNX9286PVtRVw
         TaoCkjGk2IO0v8ZA6jZx0ceegjqWCfnKv2h7HlPJvayk/8oT9RzogbG7XaLxvW57sBWH
         GVt99ML+hDjWJSbUqHoK/DZYYmfEvQ03jVbHC4iofosivvn5rNg0Eu4VFQeTPl2H5roq
         /ycw==
X-Gm-Message-State: AOAM531SbojK2fSRzlUoG5IaC2Hw1JKrWCyeE7/Dc1tShQQDK0CvyfFq
        yPiblqW26TzreKlDOLlYmGfIdV27QLRHR2g3KyQ=
X-Google-Smtp-Source: ABdhPJxc1Xn3MLBm8DaOGZB9efFa7mWv7ZmOfVEE5ILS4uPy3m5RcIOClbWnUXroLRVEabPdfxUBLdI3DvrqzXW06yI=
X-Received: by 2002:a05:651c:170c:: with SMTP id be12mr6071368ljb.230.1632273839257;
 Tue, 21 Sep 2021 18:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com> <a5b3e21b76208fba130e3313a3e70df45ab392af.1632176111.git.gitgitgadget@gmail.com>
 <87ilyt8per.fsf@evledraar.gmail.com>
In-Reply-To: <87ilyt8per.fsf@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 21 Sep 2021 18:23:48 -0700
Message-ID: <CANQDOddiQHsVOwdCgW_r13FD5zaBwo1JJ+FbEip-F6AAcCdnMQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] core.fsyncobjectfiles: add windows support for
 batch mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 4:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:
>
> > +int win32_fsync_no_flush(int fd)
> > +{
> > +       IO_STATUS_BLOCK io_status;
> > +
> > +#define FLUSH_FLAGS_FILE_DATA_ONLY 1
> > +
> > +       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
> > +                      HANDLE FileHandle, ULONG Flags, PVOID Parameters=
, ULONG ParameterSize,
> > +                      PIO_STATUS_BLOCK IoStatusBlock);
> > +
> > +       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
> > +             errno =3D ENOSYS;
> > +             return -1;
> > +       }
> > +
> > +       /* See https://docs.microsoft.com/en-us/windows-hardware/driver=
s/ddi/ntifs/nf-ntifs-ntflushbuffersfileex */
> > +       memset(&io_status, 0, sizeof(io_status));
>
> See just an informative link to the API docs, or is the comemnt on the
> memset() in particular. This comment seems like it's just doing a
> Google/Bing search for you, so maybe better without it?

Will remove. Just wanted to make sure everyone knows taht this is
documented somewhere :).
