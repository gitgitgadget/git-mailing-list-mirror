Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7131DC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 16:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbjDFQ4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDFQ4d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 12:56:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE752D7D
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 09:56:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-93df929479cso154642166b.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680800191; x=1683392191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PylI0t1CjHG3XCm7tmPKCV8UmvXYwAwKEYIAjYOcnN8=;
        b=aaESoH47FqtbQSAgBeSNgXJQ33QrqmA1wV0feQ/cIzdf8fgxr3Voa2sa22BDZdAQ/z
         fk7kQ+IJujNNDhdP5z24J/7otYxP8rHwgcOkY8xqJXTcGyfFl+rrbhrIt1SG/jxY96My
         fx1ZChVCB1AdwzZKOwcYLbdLrN44SpjFak+SY10OjnG53gTsA9ENiDG+W4++P4ag2yYE
         f8WWjBE3nt9nFbzJplwTNjlLhxEfQzFJO7XTdEWEb9AUk2n+zxNXiscXfVs0geYot+p/
         EF7us8q1rb3WG2x0ZPbRwqxcdcYsZts9XMjx/mio82uVD2n1spk0gEHd3fkxLQlpyv/R
         z30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800191; x=1683392191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PylI0t1CjHG3XCm7tmPKCV8UmvXYwAwKEYIAjYOcnN8=;
        b=mwctkmrqrYzniJ5GcQYROfxFeg2qIf1yYwbMkcbnN0BPEcKszYIb3iGvhTOuvQZUyS
         85to6GOZMHeGq4OS4/Xl+1NaRmwg28LxNbOqJtzvM7fzXJlH0lKwIiY+RCangUy+pnA8
         iimUYTJE3f0oRYpCeAs5OI0KtfNWIwugqt7zaAfM4D1ZpagY3el6Uzlwft4TCAC/HgsO
         pHfxkXa1Rc1dSS9BrhMT+c7o/rU0yPWxqeXpXasSdtqzWuirUYTw9nzWKA5BtuJZjpsG
         XLgUOgpUyG4rM0ve+nXkW25qpbCfjbPqXsn4SoADv1jDnFd+jBxHO4l1tBVqXSSTSG18
         44/A==
X-Gm-Message-State: AAQBX9fyor1RDmu5wbIXljMMcxrEM3C8ZtLxjZ1G61C0oIV3gAqmSe37
        fZ9zHS+Mlz4YDqiTDLmSejgs/wN26ebcKaZZq6c=
X-Google-Smtp-Source: AKy350buHTM//AbGBJLcizNAykE2l5BfUorDklt7FF401mROnwvfWIAtv2S7Pp2XJoJuWPIz120CwQalEe7opH/Ylv8=
X-Received: by 2002:a50:871b:0:b0:4fb:dc5e:6501 with SMTP id
 i27-20020a50871b000000b004fbdc5e6501mr139092edb.1.1680800190783; Thu, 06 Apr
 2023 09:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230330112133.4437-1-oystwa@gmail.com> <20230330112133.4437-3-oystwa@gmail.com>
 <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk> <xmqqjzywg7sg.fsf@gitster.g>
In-Reply-To: <xmqqjzywg7sg.fsf@gitster.g>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Thu, 6 Apr 2023 18:55:52 +0200
Message-ID: <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Mar 2023 at 19:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Do the empty lines in the output serve any useful purpose? If not then
> > it might be better just to suppress them unconditionally rather than
> > adding a new command line option.
>
> It's a nice egg of columbus.
>
> It however theoretically can break an existing use case where the
> user correlates the output with a list of refs they externally
> prepared (e.g. "for-each-ref --format... a b c" shows "A", "", and
> "C", and the user knows "b" produced "").  I do not know how likely
> such users complain, though, and if there is nobody who relies on
> the current behaviour, surely "unconditionally omit" is a very
> tempting approach to take.
>
> Thanks.

I actually instinctively expected for-each-ref to suppress empty lines, at
least by default. I don't see a good reason for them, except for something
along the lines of what you said.

We can of course make it a config option along with the flag, then after so=
me
time flip the default, and perhaps ultimately remove the config option agai=
n.
Perhaps in a v3 if there is enough interest; will send a v2 shortly. But I
must admit I am not very motivated to follow that up down the line.

=C3=98sse
