Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A33BC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 19:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBUTgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUTgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 14:36:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9775305F4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 11:36:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l12so5381807qtr.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5duZIeZPW/JPp6vGd5HNCJBTcRe4M8QIaaEazDeFks=;
        b=Yzx5ZqEZmYCqgR1926MkWT2EuVGOCvsd3AtQCl5uoj5HkHYdzIdUywDz2b/o+vGA/I
         CaXsW1KPUWsmoTdUA3WLRKmW2/ucgEShPfrmRFAZI9DjiuDiAdBwaHCk+AfLSPQVLTNu
         CMSAyGk7ZyZMpUClXt9YRLGlWnBzByrk1b16eYDA/iaCiezTqP2Jp79p/EDi22OZ/vau
         i98sYOwQW2Vy5J5fjuUiganfphKQbZVkJSzxqdFbitqixr8aoYjN2iFbHti+7g1D0YCW
         oyl8fk1foChz3N495Fm5F0efErcCx6iKlMBOTfmWOuOmNWM8WTaxRJaoP2vneBmVdlLQ
         T9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5duZIeZPW/JPp6vGd5HNCJBTcRe4M8QIaaEazDeFks=;
        b=qE9pbN7AkiwOoXtU+3F75HxeUACOij55XNpSEQFNwsV/kaqjyTVw0OPGvJNDip4x2s
         VOkQTK291hpGVB4T0iNgEUKSmLVhZpPwlPxdRYPX+mOBAdgDg42yl0fw/qPyBTsbPOZp
         gPd1hJC3bk11Z8tzb0gwCR79Ms8v2/wOzIrHCuZX1wtp8TUEr3f72+k2BKIXa2mzwO/v
         CoMgf6K3MMbxIWAvvhbSjmEvGBGLrrfAFeECWClVzZk1zALZTro0GQeR5YDpWoyUrWRW
         ywzjBZgaJbXTJV4PBHiz2TPqBGyS+YJyWzIsE64XQOiAdvXYN82raZAP5IS3dF+1FoTn
         XyFg==
X-Gm-Message-State: AO0yUKWBXWxmeIW6w5ohSFnb+GEtmH1UBpRM5TQzeTKsqM1lytOu1Eco
        d3fNJCtq1DHQXU15JtE+6Mk=
X-Google-Smtp-Source: AK7set9eHagcmHwIy/Vo/RvuJkzoDBuqCvNv9tIFpq2HBWc8M3oIZkPCgXCCHJh9MA9u7qrb66TDrQ==
X-Received: by 2002:a05:622a:1387:b0:3b6:8ece:cab9 with SMTP id o7-20020a05622a138700b003b68ececab9mr12660555qtk.2.1677008174764;
        Tue, 21 Feb 2023 11:36:14 -0800 (PST)
Received: from [192.168.1.160] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id 18-20020a370312000000b0071b1fe18746sm11588615qkd.63.2023.02.21.11.36.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2023 11:36:14 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/2] Teach diff to honor diff algorithms set through git attributes
Date:   Tue, 21 Feb 2023 14:36:12 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <3F1016EE-07BD-4F7C-9C75-6995A1EB211F@gmail.com>
In-Reply-To: <xmqq1qmig8c4.fsf@gitster.g>
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com>
 <xmqq5ybuhqhc.fsf@gitster.g>
 <CABPp-BEAB6jKXeo=DHiimQUDj=5i7U5MQPXTEsAagLVAuk7FOQ@mail.gmail.com>
 <xmqq1qmig8c4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21 Feb 2023, at 13:51, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
>> I'll leave that up to you and John, but are we risking merging code
>> that could go unused or that we need to fundamentally change?  I don't
>> see how to handle the issues over at
>> https://lore.kernel.org/git/647D3D49-B85B-4B66-A857-695CFF9685EE@gmail.com/
>
> If this is useful enough for desktop users already, then that is a
> good enough reason to take it, I would say.
>
> GitLab can easily add WebUI that says "You can define what diff
> algorithm is used for files with which suffix" to allow you to
> configure a table like this:
>
> 	json | histogram
> 	c    | patience
> 	*    | myers
>
> and populate the server-side equivalent of .git/info/attributes and
> .git/config based on that, and without anything further than the
> posted patches, the result should just work, no?

Yes, that is my thinking too. The goal was to make this user friendly for
everyone on the Git command line, and then GitLab can hook into this accordingly
to make it ussable with the GitLab UI.

thanks
John
