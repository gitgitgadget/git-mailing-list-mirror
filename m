Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA631FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 15:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbdFPPrt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 11:47:49 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36545 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdFPPrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 11:47:48 -0400
Received: by mail-pg0-f45.google.com with SMTP id u62so2773788pgb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=89vSxFxVYWlwO6pme371su+e/jKUNp7I6dcOZrmX5sY=;
        b=EU7N15f/Ee31poHZExriPboyMoEEj9Ik0Ewk3u/BmZP1a8YZnIk4w6OMW6cGXkWpAY
         NlgjDJZxW/hioFaZ7d6Lx78qJU8jVpB4Q0mXoBdn6JAEDkGzonkcOzYtlVdvTZbxCLBN
         PHvokHCRbWSjEXksA66a2NlfNWRv25CExsfO4J+RgYHXR5pPNljKddKOxYlnQyprp2Ky
         Mxrz8dS8GFneN3Lw/LNfiftfR+2ZXgtDXYuUidjAmONBjn+9uCQ5XEx2lfHdz82fT/h1
         qhMVkwddobGlpSn3dHiJ8p2xo6nZFgnURrdQxkXG7eHVKUWV83jg/Sva6XMfMVxXMaaM
         ZqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=89vSxFxVYWlwO6pme371su+e/jKUNp7I6dcOZrmX5sY=;
        b=GZVPxQ7p7CivhOGlMA0m4xljY5PYwjj+yFrqSz9/g0mt5esBVFPUpVbdkJHs7h1nMy
         OoY0pbSlFabf26u7772cZVnzWbbUExwDkLj3n5WQx+Me64i3tPNXyeg+7cCt6jz7QdVe
         TD1oees43aWfjvV4anOZTFhTundAAEzUNhUcahKxLdjlSNus2g22P4bUXy0VngKWDWs6
         7Aheijqf2xWl1GJWaWF6qEvfGOR6qiq7safdi4vAL8KSH5Or8QxlyH+OgsQsy1YAHePq
         w4xZGDs3LqZvot/QRJHFdGQNktvcIND0ySWsslgAFusIPpAYGnhNJnnJ4UcK4vT++FZI
         EvBQ==
X-Gm-Message-State: AKS2vOyx8CRfoD6Zf+325LwACD0gMc4u1ipTzfPwVQyYL98bFWxoMg1X
        6glzI/tncOAO8T1bdNg6yT+znn5UVxJQ
X-Received: by 10.101.76.201 with SMTP id n9mr12144764pgt.40.1497628067767;
 Fri, 16 Jun 2017 08:47:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Fri, 16 Jun 2017 08:47:47 -0700 (PDT)
In-Reply-To: <db616bc6-4d31-6f7c-4862-9161f4bb36ce@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <f9c4c47e52c076c42896d22d89591a93163afda3.1497534157.git.mhagger@alum.mit.edu>
 <CAGZ79kbeJk5PmJVdLva-VauLPa4MbQdNRWfQmyHtVqVa3JDL+A@mail.gmail.com> <db616bc6-4d31-6f7c-4862-9161f4bb36ce@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 16 Jun 2017 08:47:47 -0700
Message-ID: <CAGZ79kb=eq88VR5nQggnLQJX-gTZ37uhm3PhuhC4oX8dw8vG5w@mail.gmail.com>
Subject: Re: [PATCH 15/28] packed_peel_ref(): new function, extracted from `files_peel_ref()`
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 11:46 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/16/2017 07:42 AM, Stefan Beller wrote:
>> On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> This will later become a method of `packed_ref_store`.
>>
>> Also while touching it, maybe rename sha1 to object_hash
>> (not saying object_id as that would be confusing with the actual
>> oid struct), maybe?
>
> Hmmm, my impression was that most of the `unsigned char *` hashes are
> still called sha1, and they are renamed to `oid` at the moment that they
> are converted to `struct object_id *`. I only see two instances of the
> string "object_hash" in the code:
>
> $ git grep object_hash
> object.c:static void grow_object_hash(void)
> object.c:               grow_object_hash();
>
> Michael

Yeah maybe we can just defer it to the proper conversion series.
I just jumped the gun here.
