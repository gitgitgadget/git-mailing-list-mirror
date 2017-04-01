Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210E11FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754963AbdDAAwC (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:52:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36149 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754289AbdDAAwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:52:01 -0400
Received: by mail-it0-f65.google.com with SMTP id 190so3527049itm.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FMDMpgByDXccTG0Pzvj7eY9l7cXxe8k96YVvmL/flUc=;
        b=LzREOTJaFXLv3u1tOi/9kG9hiXdr4jnGPD1eXlIfhui8rRbFLzNHbyi/E4c3F5oMp7
         t5UGAqWudubX5Gq6hv6wJ8RxvkBgeW01I27uJKkunCXG5NrL4p1qChYS/QTefpVE7DY9
         icBB9+zbVGVxc3lLyAB1p6bJX5yVNof1LShtDmdjMWuTBZSkfHyhOc2nCFpYX2e03E11
         rM6cb2COj2Hlm7BIvyjW9l0+okGQXS3PdXUufbkfxueRgudf2qDH2ztnZw4g5XJp+0Y0
         2aloHeNn8Cg6jUHXj1jkYdZDxLEUSOznOffyxo7JC9r7rrApHuKQUWSLiqs57n94Umtw
         dGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FMDMpgByDXccTG0Pzvj7eY9l7cXxe8k96YVvmL/flUc=;
        b=qLcfNS6a14642IeNYKNo1VI0I5mr14PnI388A2KKKNHUalLGRYOTrR+pgoPQTlK6/g
         1FXTS5ldS5uyZmQDmndCxbEdpQu5qZDkHSwlwiXYwxGIy9g00o4v4d6LJ/eXmOc332VR
         TTM4ikP1u82q/G6OOUgWEyRgQeOyuBXL9eLY0/Z9aw8mNy44WixqNrj3Rjg1NyLZ/xf1
         wwaGgc5jfnN5vfhn8qzJdTPL+FWcC1HpjHVQv21vQXeAMLtkjq9zwVB9fhMGTrFWpq7/
         XXrj8pRnKFZgkWxZrTv19igKNr4UtPNkfJyfSwgphdFNgb6r5QXz+ZXbNaJS2NJ/uMX/
         k8yw==
X-Gm-Message-State: AFeK/H3J/tSmjo5aQm0GeV3QZs1bnVX+DkqirfBloLXT58xady8Y62wB8fBq+1Ukd3tWvy3YjLeEJzitirYo1Q==
X-Received: by 10.36.204.137 with SMTP id x131mr661330itf.35.1491007921170;
 Fri, 31 Mar 2017 17:52:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Fri, 31 Mar 2017 17:52:00 -0700 (PDT)
In-Reply-To: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Mar 2017 17:52:00 -0700
X-Google-Sender-Auth: MM5guFOC4tg8rCkWbL7A55nNsNo
Message-ID: <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
Subject: Re: Bug in "git am" when the body starts with spaces
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, did a bisect, and this bisects to commit 6b4b013f1884 ("mailinfo:
handle in-body header continuations").

The continuation logic is oddly complex, and I can't follow the logic.
But it is completely broken in how it thinks empty lines are somehow
"continuations".

Jonathan?

                     Linus

On Fri, Mar 31, 2017 at 5:24 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think the reason is that the "header continuation line" logic kicks
> in because the lines in the body start with spaces, but that's
> entirely incorrect, since
>
>  (a) we're not in an email header
>
>  (b) there's an empty line in between anyway, so no way are those body
> lines continuation lines.
>
> I didn't check how far back this goes, I guess I'll do that next. But
> I thought I'd report it here first in case somebody else goes "ahhh".
