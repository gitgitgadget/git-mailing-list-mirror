Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6531FD4F
	for <e@80x24.org>; Fri, 25 May 2018 23:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030834AbeEYXgo (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 19:36:44 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35411 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030683AbeEYXgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 19:36:43 -0400
Received: by mail-qt0-f175.google.com with SMTP id j1-v6so8585993qtp.2
        for <git@vger.kernel.org>; Fri, 25 May 2018 16:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I+vJTrVqkv0ts0Kom7O8VOR5db2YtH0sj97Wb+j+XfQ=;
        b=M2ws32H6MDehiLCJPEgzrw2SEVhMw7itSbCipe3Uum/CRLhRBzZ6X1AYvn2T/Qirmo
         HbZyFSd3Evd4VJzxdNygCo7+AvOlTTupuSyrqLPXJkUfRGhq5/+OHW5TGM3qcUiJmAlu
         El1cLUaXyI5MMIxtO9BAk2Ar0HdffI99ALAFcZguCIa9Y9vkOWBkVEr33H7ayFrqawHY
         eptX05VnTBfX0P2RA9MUFjDKXkXwy3YCRIQ5M7erZ4/ofuGkVgKvspXkZc9yfkEuReHW
         eN2XQLLryy+7goa91ILgW90tXNATNfFsgfOh5n47l2Lg2pQfnSlT7ML1FfsmyRAMxpR0
         86ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I+vJTrVqkv0ts0Kom7O8VOR5db2YtH0sj97Wb+j+XfQ=;
        b=Kl+Ukj82CsmHp5gXARNSlH31CsVxG3gvVS5xTLD+8AscjlFGbG1311wsc+S2dGHSXB
         KOSqQ6gNUaRMlekad7/udevB209hr3klWs96msBWf+277890tON8UVsUv5YxE9vVL2aH
         C4FtoUmCkp6BinUrdYRE4Aegv9FRbNuMAvP5T5WBis3Bb6oqSFt71OhRhpiktGTUXc42
         BncHt/CndwtW5aUaWfSfKe5SNBElpzgLVbfOiGcyXkfMIPF0eahmuDU8ccSNYtJHFnjE
         P3GvMsfAZEe6MLQ+DWhdsQNvjbnKIQhJvO3gE1BVScZ4cG3Tr1xTU4L2N9dVbYrJB2t9
         I/9Q==
X-Gm-Message-State: ALKqPwc2VRMNTB1dHd4WXwPkgwagl9KYgefOB6XFAR2mDmtkx9ZfEHSx
        CLkf6quRJpqmreIRpUgmliMolW/4p97sQpiqn/M=
X-Google-Smtp-Source: ADUXVKLlgPqi1hGYgX5NFjNeuZkTzBvHnYmhxmheuvKil1+YdxsukwXnGlNzNh3UMoQ9r07i/UIO82LGB5y53yoH6zI=
X-Received: by 2002:a0c:9e5a:: with SMTP id z26-v6mr4312079qve.109.1527291403010;
 Fri, 25 May 2018 16:36:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 25 May 2018 16:36:42
 -0700 (PDT)
In-Reply-To: <20180525231713.23047-1-lintonrjeremy@gmail.com>
References: <20180525231713.23047-1-lintonrjeremy@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 May 2018 19:36:42 -0400
X-Google-Sender-Auth: mf3FPTNSCpgKdMomCpDWcxXvpSc
Message-ID: <CAPig+cS=7EbGviDYoNFNF-CrMfCY4mySQoWX3JtJBhbNf105sw@mail.gmail.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
To:     Jeremy Linton <lintonrjeremy@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 7:17 PM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
> The buffer being passed to zlib includes a null terminator that
> git needs to keep in place. unpack_compressed_entry() attempts to
> detect the case that the source buffer hasn't been fully consumed
> by checking to see if the destination buffer has been over consumed.
>
> This yields two problems, first a single byte overrun won't be detected
> properly because the Z_STREAM_END will then be set, but the null
> terminator will have been overwritten. The other problem is that
> more recent zlib patches have been poisoning the unconsumed portions
> of the buffers which also overwrites the null, while correctly
> returning length and status.
>
> Lets rely on the fact that the source buffer will only be fully

s/Lets/Let's/

> consumed when the when the destination buffer is inflated to the

s/when the when the/when the/

> correct size. We can do this by passing zlib the correct buffer size
> and properly checking the return status. The latter check actually
> already exists if the buffer size is correct.
>
> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
