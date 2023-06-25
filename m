Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294FEB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 11:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjFYL3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 07:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjFYL3E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 07:29:04 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C369F9
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 04:29:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-630019ff99bso20863626d6.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687692542; x=1690284542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUsxaUbWJek+vb871ym0K3LVocfUxjguhNphmvSHcw4=;
        b=FHMARaIPW9w1fM5njIWt2V44C8gNp7Lmxo+I9oysvTPwEFw2wBI1dKFfAHcPkOti5z
         QGETo7FLFxRD2Qp+H5O+qd3ClvnIq7lEzuI58lGLCK+XhnZr3z5ibVFmcrpAmA+yKOea
         er0bsJLYBe2XXEkZ7pHc4lb7hzHigSUfppRPqNmwrd9h8pDPHjrprU37UeN+OYZ4b3+2
         KTlOf8UbvoTi1b1CvGWexhbcU5G5LHOOEk4KPTN/VhueCe71lt2rNAui+M/REXGBiaCP
         xXtkc8i9ebyYWGhVHX/A31T092JDSnI66lTJQ+t7Gmh9A8f2ZM4XZeL/YLpgEGZHOZ8X
         KHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687692542; x=1690284542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUsxaUbWJek+vb871ym0K3LVocfUxjguhNphmvSHcw4=;
        b=IlRh2DpapWsSgNSl+u4HkJ57YWGBGbXPonY8Hkt9CBMN60/tyDvH9yEH2NgE2sKUpD
         t92R3kMGKpCVsBQEYSNK9ar+h8KZUwbDv5ukHEdk8/EboE7/O37vxkSjG6NaK5CJAlbV
         P5raIr6jHAmJuJCCY/yFILfXWQpqjxuYjZXECT14VfAvI/rcbAFeAClft2qCbHit+dou
         YlyworChtGkcIp4bZVgwzKOXkZPzXH0hT6MmwhmlpdrukvAenhvJvwq7H2bsnpNKijpk
         KgaMzGTY/5JXeIVa3Xg1Xp8DvJFMU7FjwsxXeQZIaeqUL8HF9PSd27ppkfT0u3xJIm3U
         OHHg==
X-Gm-Message-State: AC+VfDysiBGRm/N44z1vGyL5Ko2NfrCmIh/EQ2TM2lHqTqHL5q9jA14z
        qqThYuq7Uw5+0Kyyfm4Xx84=
X-Google-Smtp-Source: ACHHUZ6iX2FRAZKpWm62uh0fp9UnboqWB0F10NYe4h2vh+cu5vDsKNDm8JW6SYL0iyQMj7VnkAudbg==
X-Received: by 2002:a05:6214:c27:b0:62f:f467:ecd2 with SMTP id a7-20020a0562140c2700b0062ff467ecd2mr29177389qvd.0.1687692542250;
        Sun, 25 Jun 2023 04:29:02 -0700 (PDT)
Received: from ?IPV6:2600:4040:266e:4d00::387? ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id c20-20020a05620a135400b0075cfe5c69cfsm1569329qkl.79.2023.06.25.04.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 04:29:02 -0700 (PDT)
Message-ID: <dd3d50fa-6c48-459a-bf24-9e902696e2d0@gmail.com>
Date:   Sun, 25 Jun 2023 07:29:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 2/4] git-gui - remove obsolete Cygwin specific code
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230624212347.179656-3-mlevedahl@gmail.com>
 <CAPig+cTQcN9um=Pmtze9wyM_kBezpFQ4tJ-LsC-Jh37L=93Bpw@mail.gmail.com>
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <CAPig+cTQcN9um=Pmtze9wyM_kBezpFQ4tJ-LsC-Jh37L=93Bpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/24/23 22:56, Eric Sunshine wrote:
> On Sat, Jun 24, 2023 at 5:35 PM Mark Levedahl <mlevedahl@gmail.com> wrote:
>> In the current git release, git-gui runs on Cygwin without enabling any
>> of git-gui's Cygwin specific code.  This happens as the Cygwin specific
>> code in git-gui was (mostly) written in 2007-2008 to work with Cygwin's
>> then supplied Tcl/Tk which was an incompletely ported variant of the
>> 8.4.1 Windows Tcl/Tk code.  In March, 2012, that 8.4.1 package was
>> replaced with a full port based upon the upstream unix/X11 code,
>> since maintained up to date. The two Tcl/Tk packages are completely
>> incompatible, and have different sygnatures.
> Given the context, an understandable typo perhaps: s/sygnatures/signatures/
>
>> When Cygwin's Tcl/Tk signature changed in 2012, git-gui no longer
>> detected Cygwin, so did not enable Cygwin specific code, and the POSIX
>> environment provided by Cygwin since 2012 supported git-gui as a generic
>> unix. Thus, no-one apparently noticed the existence of incompatible
>> Cygwin specific code.
>>
>> However, since commit c5766eae6f2b002396b6cd4f85b62317b707174e in
>> upstream git-gui, the is_Cygwin funcion does detect current Cygwin.  The
>> Cygwin specific code is enabled, causing use of Windows rather than unix
>> pathnames, and enabling incorrect warnings about environment variables
>> that are not relevant for the fully functional unix/X11 Tcl/Tk. The end
>> result is that git-gui is now incommpatible with Cygwin.
> s/incommpatible/incompatible/
>
>> So, delete all Cygwin specific code (code protected by "if is_Cygwin"),
>> thus restoring the post-2012 behaviour. Note that Cygwin specific code
>> is required to enable file browsing and shortcut creation (supported
>> before 2012), but is not addressed in this patch.
>>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>


Thanks, will fix both (and a few other typos ...)

Mark

