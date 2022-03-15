Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E62C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 20:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbiCOUBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbiCOUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 16:01:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3592FFDE
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:00:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id jq9so400494qvb.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIt30AzFYn/SrlA2IGGQPoZFYE7Rs3DZp9M8BTj/zbQ=;
        b=hzGqag66ENzcxN4rwdTBUvKLpdycw1aeRqr7BnoZKse5vZzg3SwVmw5L0rKy2eRHah
         222ibe6zEPUoTlIOLodgjjiOgZif6xzNhp3NBD2y5coo5TqEVkgVaQkEFpUoSk+MbSFt
         s5P14sVn56cjrNyvyyT0tbHHTo1gi7fCu7avcSFbJB+nmuQ5uw0pzcex+Ph5tD4X/vtV
         gfcMCYyOgNMNa3QQ5yinq345zdjGNB96EZqJRQsCYqiZgpxddq/fNdPTF+Q2/ks9QRz6
         6WYFPDA/zyFpiFRKNxZbLhQ/txcLVTlnq47Ma3hx0zmZ8oM1xkYfCoHMykSo72DCT460
         mO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIt30AzFYn/SrlA2IGGQPoZFYE7Rs3DZp9M8BTj/zbQ=;
        b=zS54CHQBIkjFUnrnWTa2pMjz86Q6WTMq20yq1W12tvF6+OCnvj32pvfD80O2tqcY+0
         F3Wbym/sh31aJXpY9ilKUR+2eB7SdfFcsMEkqrhM7sDpa/gUQ8+Ix5eZXWFZ2sQFgXGm
         lgSiU8Pll007N2G4Novr5R2J05ZSbKEVeCW+GpdPJN8Gr3uPSrIQXIFs9q07ppsW5emp
         t0GpDyi7GuAsiH5U0ZsQTY5J2OxleRqrDpUXN014dKoT7PDFfsSIyswiVDUV5vqXDYjl
         z0aro40X0jGcqRae7Ew0mxJppAvZ+eeHHYEf2ezf1Gbho/1eToxMnS7M9P9q+5UOXvBk
         0ADQ==
X-Gm-Message-State: AOAM5311Lf3Xu8lhP+8dGiHoISZaO2FRzhPRNX9/Ic14xQWaRZm4vw/5
        I93DXY72nR25CNonHNLO00pP6ElfcKHvREJKChk=
X-Google-Smtp-Source: ABdhPJwcK8RZNTl02k9p5e2Y0YRyaOC7WxsnRp6ihUTwGafyW+IpIVYN+aZrrxPzQWBmj7+N512X8Umpvhu/cXkQ8SE=
X-Received: by 2002:a05:6214:2467:b0:435:6a0c:4e8a with SMTP id
 im7-20020a056214246700b004356a0c4e8amr23075198qvb.67.1647374419855; Tue, 15
 Mar 2022 13:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220313105031.1081110-1-gaurijove@gmail.com> <CAP8UFD0GeGr3ARkYycHNYU0r5vTC-PDdbLYrkYSohbtWBt9HSQ@mail.gmail.com>
 <CANsrJQd-E9JcFD0jtK=kMexm0Oc4Vc2HSXJ7nM2u3g4cN0zstA@mail.gmail.com>
In-Reply-To: <CANsrJQd-E9JcFD0jtK=kMexm0Oc4Vc2HSXJ7nM2u3g4cN0zstA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Mar 2022 21:00:08 +0100
Message-ID: <CAP8UFD2RhgrqxPzyTa+ak-c6hyHp+srnwKpgftz7ZScieXZL3Q@mail.gmail.com>
Subject: Re: [GSOC] [PATCH 1/1] t7403: Use helper function 'test_path_is_dir'
 to check if the path is a directory
To:     Jayati Shrivastava <gaurijove@gmail.com>
Cc:     Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 15, 2022 at 5:11 PM Jayati Shrivastava <gaurijove@gmail.com> wrote:

> I have modified the commit message as per your reviews. However,
> I am not sure why my patches are still not showing up on the mailing
> list despite passing the --to/--cc/--in-reply-to options correctly to
> git send-email. What do you think might be the reason?

I might take a look later, but this one made it through:

https://lore.kernel.org/git/pull.1177.git.1647373314457.gitgitgadget@gmail.com/
