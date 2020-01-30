Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6507BC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD382083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbrnJQxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA3W2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:28:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33834 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgA3W2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:28:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so1902820plt.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ieCLFiUN68zEQYZpzXZfL64YNWKy/Zgl3rp588qi5Y=;
        b=nbrnJQxsHYqp7v11jGYSfuXmW4jrnoU7Toll2x8ji0NiOoXUyRzo+tHkTM4eMfWKNr
         YsEW76XF5Vbr5pbQFzy78AO1HMmA44DgQUlZPtmtfVB7We+da0HvoBRx8BNf/epigVW3
         sSvEyOa3n0QeE32WhcQZA5Qa4ms0c3F5IgTRi1QbDXOpER6/XbF+PjrDjsxQ9xagJIrj
         rjRWVGmgoA3xXcUyvx8/kPt+/0SpuPUCzON6lMcdxyMIlMj+6KTPCT4oPDhKL+i0dwE2
         AdvaBgMF4+uxe8RmpuBhsl8RBu5iSPOFxq+PcuIDjYl+IU6xgrxda4cQal4Pte/B57cN
         Z2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ieCLFiUN68zEQYZpzXZfL64YNWKy/Zgl3rp588qi5Y=;
        b=kDzT1N1DsXoNkeRs6mKdr4NEQ6aZIb9tx+hL7bEZcw1vFmxmAXcDQEvlDD73NGRNEd
         OECpE2Zt5cMF88CS6x3VDUqPx1VZNJj0IIb4k72wJRAr5eWPMZzefZgvgJy5ptaKTyvu
         Kms7OTZPBtJ7tv1UnK8gz1s25MV130kztM9JjDarRxCllk9hLZdldWSc9j6ootjRCdxu
         pr4yOuGucbwYBDw46PzNXSxWSGpRhsgUNl0Uifxkdb3iXmx7ju7iMz8BEI7d3+oF4O9n
         qgl12jxy3PQ1fSwn0ulSp0c5KWKMKcJclm0KOZ1y3+ae5SOmoDsFrK5g0nFpZK8h/QQu
         tZ2Q==
X-Gm-Message-State: APjAAAWxXRl48Qz3F0YNU3psf7WeLdTM8CfdwOZNRfrc5rX7h0gRt+9n
        9Sv7Q/juq+ZQYF6v/unL9qppue4ui+BRQ5ufJ03LjQ==
X-Google-Smtp-Source: APXvYqzHjXxmb0Fl2yeYIZvfQUY0bxGyUxFQ41rvOqSUsATSS98Cj0BeWg4pQHi+KgoFMwd1l/iOcIysbNZFIBhmHRw=
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr5378407pjq.108.1580423331670;
 Thu, 30 Jan 2020 14:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-9-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-9-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:28:40 +0100
Message-ID: <CAN0heSq9AdF_WPmSkxDA3cPzOQBAbuw4oa+8azvLtjbP-jQfKw@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] bugreport: include user interactive shell
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:41, <emilyshaffer@google.com> wrote:
> +       char *shell = NULL;

(Unnecessary initialization.)

> +       shell = getenv("SHELL");
> +       strbuf_addf(sys_info, "$SHELL (typically, interactive shell): %s\n",
> +                   shell ? shell : "(NULL)");

Thanks for avoiding a classic pitfall. :-)

"<unused>" instead of "(NULL)"? "NULL" is mostly an implementation
detail.


Martin
