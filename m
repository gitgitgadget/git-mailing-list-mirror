Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A5EC04A94
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjHARie (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHARic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:38:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D546E4E
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:38:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5229e0603edso1085a12.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690911509; x=1691516309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDnqT/Vx9brC47iQP7VCNGygAz9kCtvce0AYuXFUIHQ=;
        b=FTTomTn+T1KcuYrH6OtvUoau/dF9rwZM53/TMeBWjh9o+GcN3xkTzO3m3wXtaQ4oiR
         C/uVzeTyOTybGkihkxUuQCl94BUXXfjL4o0TlBP0hucKDmURwt0kqybgABngdzGWl2lv
         m35o0MAwqD8XDhgd7oHEcz6XnLcODsn5ZsMbfrXFYC2uVKRImg8nabwGlQNf22fyfN2q
         mJAElhJ8iH0+7qL+loqLJDL6dB+UZdR1uUn/eMB+Y2O7Fqw8sqH2nwYQqPQFDbx7l9Dz
         pv/iZJDE7E5Cr2iutYYBP31Vnvgrcoh4AbB9gJ/KYkcfTVZvvboEC1TVm5Ei9yHMY/jS
         Yt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911509; x=1691516309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDnqT/Vx9brC47iQP7VCNGygAz9kCtvce0AYuXFUIHQ=;
        b=QNvXCuj9rZZI5KFQYqmI62ln2vDtjc1LXYo2WTn60ocbNZW2vYpvcfIw1BxfmnCMfy
         +mhK6uHu+7mOoKwbDQg78VmZFq9j3fBxSWGMjrzxWDzvtkMeVdvzgCe2KIqdzW3MwPh3
         iBWH/QG3s+HudNq/0KD+3cwhSROWOuemg4jg7sbgYolFE6H9IZRSZzMPLRE3rBzYF2jL
         qT1ZVhdRo3SGNHFQdeXF8syTNOz30Pztu9ibAxxFojCg4pDtFJFA97bDhztygPDP+6Qd
         fkm1mzrb5OnglsxA5Pv+chlwS89V9PpOFf8qQbFJDfLcGYpaVNTa4qp6ms1Pa5UigIyk
         NY8Q==
X-Gm-Message-State: ABy/qLZIsSfO+qRCsm+TE0vvAc6RNkDpCROOsHfEYXnEBsqJNEnsJwZi
        oTxRA3AwRcgpetiXQEvAI8bZBg3Ik/zFnqF9N3oyXQ==
X-Google-Smtp-Source: APBJJlGhHFJXM1R6smjORHV0qSzZYD8JqsAkqSzunSIiN6+tNCqRYsToJDh5yWhE1k2NMt4eUSZcrBovIyg8gzKv544=
X-Received: by 2002:a50:9f84:0:b0:521:f642:7183 with SMTP id
 c4-20020a509f84000000b00521f6427183mr311445edf.1.1690911508798; Tue, 01 Aug
 2023 10:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmszcynem.fsf@gitster.g>
In-Reply-To: <xmqqmszcynem.fsf@gitster.g>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 1 Aug 2023 10:38:17 -0700
Message-ID: <CAJoAoZk1WiCSDqFXccG4FiwYhWUuWWmFz+ZqiXhacmfjZuE6FA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2023, #07; Mon, 31)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 10:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> * es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
>  . usage: clarify --recurse-submodules as a boolean
>
>  The "--[no-]recurse-submodules" option of "git checkout" and others
>  supported an undocumented syntax --recurse-submodules=3D<value> where
>  the value can spell a Boolean in various ways.  The support for the
>  syntax is being dropped.
>
>  Have been expecting a reroll for too long.
>  cf. <ZDSTFwMFO7vbj/du@google.com>
>  source: <ZDSTFwMFO7vbj/du@google.com>

Yeah, sorry about the annoying wait. It's not something I have time to
reroll soon - but it's on the short list for "up next" bugs for my
team to get a reroll. We still intend to reroll and push through, but
I don't have an ETA. I'll leave it up to you to decide whether to keep
it in seen or drop it with that information.

 - Emily
