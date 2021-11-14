Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723CC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA63360F42
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhKNTgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 14:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhKNTgm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 14:36:42 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DDC061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 11:33:43 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id az37so30311157uab.13
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=511qZtGGZCfs5FKQYqDLhYai8vrFrUepcP6RKX/PRso=;
        b=CsMTmbJqE5F7+R3I23W1btBBZZ0nlzAQGpUtciHmhmG54di2E5oISUdCKEYxVEMDuL
         PK2jk5tMf50gCcxStrTqU7f+VeGllbUx2Uu+Va7aTlJa8D+6G2PJcnEnGmtKSK4o0n2r
         kQWyDqUCxx+3exxMrfHjSCSfJN6I8pdHk67P0rxZy64FT52Ii3WnUfy6o6R+viwNtIjg
         ihspX/VzpjHwn2g8TqEW2Vxo7WqYkCP0OdKxtXkN9QavTAPxeL4zmlPzJj89gAoqapyP
         BnhnfN5ElUzoHpJXWTc5nH8I6q/n4JCHfIiEmrcExi6oebkC6g7EuGz75XR7g0rAA9NI
         o9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=511qZtGGZCfs5FKQYqDLhYai8vrFrUepcP6RKX/PRso=;
        b=vegCGuwHYplY4Uq3JZyq2Hw+wNRINmQI+VlA9HwMHf2iKtqwOmOLBuUtjHSiYUTD7l
         P46lCWzvYmHjbrdWGrG7tKVykACOktx+UQa9Up8q80SLbQpzhSUfwDGltAjZj41fzFdP
         TsevCURrUfaomWa6GO3EcY2zDbegPuNrCWbe0eVtPYwKozrgmQv3w2sxOg4kYjkzRPrI
         XJuHbcHWqvvUufSpHs6sEGMlM7PbhCRhFbo+zaXZsBLDSO9m4hiSXxkFK/pAHG3L7ygr
         nk+qPTFx/tc2QrJJXag8pdnu2IoXjbVUZgmYp+zWSpngDA3gnd3PxIxE3q3N6kQCfeTz
         qPVQ==
X-Gm-Message-State: AOAM533v0AfcpS8LoSaIq4yE/BoQOvvocpaX0XCxKJjjbxc9X+HohOeY
        3QTLZ9zg0t9dUi9ehQXuuzHcLVeAwPuL8eGPzik=
X-Google-Smtp-Source: ABdhPJxEdib51rjvdhQu75p9dBsEOqAtmNPG+wMDkBvtevwCVyuPVuyAj6OSSppeN4ZuoiJwpadtC82bzAOFkQLfpqc=
X-Received: by 2002:ab0:66cd:: with SMTP id d13mr50088309uaq.140.1636918422432;
 Sun, 14 Nov 2021 11:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com> <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g> <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g> <211114.86zgq6si94.gmgdl@evledraar.gmail.com> <YZFa3YDe1/a6uZod@camp.crustytoothpaste.net>
In-Reply-To: <YZFa3YDe1/a6uZod@camp.crustytoothpaste.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 14 Nov 2021 11:33:31 -0800
Message-ID: <CAPUEspgLU2oeh3dG0TeF6OJR9o8Q3HAXRBJSxE6-aUa_u1upxw@mail.gmail.com>
Subject: Re: Is 'for (int i = [...]' bad for C STD compliance reasons?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 14, 2021 at 11:08 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> MSVC recently learned C11, but I haven't fooled around with our CI
> enough recently to see if I can get it to use C11.  I'll try to play
> around some more.

The last 2 releases support C17, but I think that is only using the
universal crt which is not what git for windows link with and might
not be available by default (10 or later feature) in all windows
versions they target as well.

Carlo

PS. no Windows expert at all, and I am sure more authoritative answers
will come along, just wanted to let you know to probably avoid wasting
your time with the CI
