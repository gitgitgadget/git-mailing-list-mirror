Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0BE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 23:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeBFXLa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 18:11:30 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:44367 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753781AbeBFXL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 18:11:29 -0500
Received: by mail-yw0-f178.google.com with SMTP id x62so2590154ywg.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 15:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PezTHSYVAgCzrTaRBWghH0UXrIKAxRd7rgC8vc/jO50=;
        b=wO/gwxO4uZaB6UGN+lsWDYGOzM4yU7LFjI9cjZCsuFalObLINXDf3xdKYB3aICu+V9
         e25qtxmgG5+5uvyQbfPek2HL2oXXonCryVmLw3w8N3s+Sq/c+DmYUJ97DToWdQ/nKXol
         Nh3g/ZAJPyPIODFq4UlbphL4ykmkwfaXaZJ6uvvQRi11q0Ur6fsKsusTNDP8ck267Rrx
         c6z7TDDjefAySw5On7ikqOX+JwqQqE2r5tCHHSXdrCgDY5uOdi5gGLvLyFxeDXVBHmxm
         8thaSFKuHhab0z3oOxtjZX4lMxxnnd7GcJpRwv0TdAGBO/9BMH8aryf/hMPrENtU8dib
         9vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PezTHSYVAgCzrTaRBWghH0UXrIKAxRd7rgC8vc/jO50=;
        b=TppAyvgokbecG3R53AG42XaPTsspEOy1kPlRxX1tttISTOCq8mLO6wnIrhlU+o53Cc
         XTB2g2zrAeWBg6q+/EO6aUNaiVtB0kTmvvgmm0/oI2cGr5dumDXIu36sIWUAt1crTVVn
         akoDWtM+2UL+HEGYLKUR1dCgbL6OfBOdjqrHW1XmPVScgtgiQsQmCCw7+imaktxq4jN6
         fxy52mNQgAyQdKsemd2klzNoItBws/C4q5VzRNpviiEcYgo0IyRG0SlfCO+erTOqr4vU
         NjhsA5nG9D04IhvJZMbOshBjjCe07OVmmqt3/nM+OGnhJ/WxwtnYlmOLdsa49C7uvZqq
         7gBg==
X-Gm-Message-State: APf1xPCQv9oNGN4N08kk1e69kuxGmoefcpfZYXNvOB79H8fnBJLeyvQk
        99w75jVDLivQ5IWOUMW8Sqg+l7Wk6IOOcog8m/ABOpNf
X-Google-Smtp-Source: AH8x224rU9RTefB9jL3Yo+MRTjhhY6fPiAJs+AQWbw4afB1WpnA8fbUeswS6Vmvpr2wfEQ5pZHadpllTtJIGFtBx3GU=
X-Received: by 10.37.37.87 with SMTP id l84mr2670621ybl.386.1517958688336;
 Tue, 06 Feb 2018 15:11:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 15:11:27 -0800 (PST)
In-Reply-To: <20180206145406.b759164cead02cd3bb3fdce0@google.com>
References: <20180202045745.5076-1-pc44800@gmail.com> <20180202045745.5076-2-pc44800@gmail.com>
 <20180206145406.b759164cead02cd3bb3fdce0@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 15:11:27 -0800
Message-ID: <CAGZ79kZ-Z7jq7LZQKdyvgk6zUdsGc1dQERTKvGJ2S3=Sb9dFyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 2:54 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Fri,  2 Feb 2018 10:27:41 +0530
> Prathamesh Chavan <pc44800@gmail.com> wrote:
>
>> When running 'git submodule foreach' from a subdirectory of your
>
> Add "--recursive".
>
>> repository, nested submodules get a bogus value for $sm_path:
>
> Maybe call it $path for now, since $sm_path starts to be recommended
> only in patches after this one.
>
>> For a submodule 'sub' that contains a nested submodule 'nested',
>> running 'git -C dir submodule foreach echo $path' would report
>
> Add "from the root of the superproject", maybe?

This command is run from the root, though the
"-C dir" should indicate that the git command runs from the subdirectory.
Not sure how much slang this is, or if it can be made easier to understand
by writing

  cd dir && git submodule foreach --recursive echo $path

but adding the "from root" part sounds like a clarification nevertheless.

>> path='../nested' for the nested submodule. The first part '../' is
>> derived from the logic computing the relative path from $pwd to the
>> root of the superproject. The second part is the submodule path inside
>> the submodule. This value is of little use and is hard to document.
>>
>> There are two different possible solutions that have more value:
>> (a) The path value is documented as the path from the toplevel of the
>>     superproject to the mount point of the submodule.
>>     In this case we would want to have path='sub/nested'.
>>
>> (b) As Ramsay noticed the documented value is wrong. For the non-nested
>>     case the path is equal to the relative path from $pwd to the
>>     submodules working directory. When following this model,
>>     the expected value would be path='../sub/nested'.
>
> A third solution is to use "nested" - that is, the name of the submodule
> directory relative to its superproject. (It's currently documented as
> "the name of the submodule directory relative to the superproject".)
> Having said that, (b) is probably better.

Oh, so the nested would just report "nested/" as that is the path
from its superproject to its location. The value does not change depending
on where the command is invoked, or whether it is an actual nested or direct
submodule? The latter part sounds like a slight modification of (a), but the
former part sounds like a completely new version (c).
