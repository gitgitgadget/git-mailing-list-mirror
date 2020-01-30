Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF4C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3FA2083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbqEGMkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA3W15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:27:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34745 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgA3W15 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:27:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so2236925pfc.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKnUv1bvq83ZNn5v1zEGY7PEZic2JVyFi8StOUJM63o=;
        b=CbqEGMkSMiK8Zf1tkOuY+lP/Zyus1FnYG2qIxIFh5/DqeIVnEkmEyy6R6hpbThbdGz
         zOsmX6L8VjvgSbrREsGmV/DEs5BZR01l8CDvkr57yVzaSBMHEzT6w75lIqsxg0JAmhHq
         DpVzhUlML5kDRmqNSdheBFnIceBY8A0p3EklyykI/wZEs8sJMJUykVHrup58qNWQ2T5v
         XTpHnC/2GIInEYTS0G8SFj7bwKlDSJWPfQKnDVwL7euXyYZeUy8DsEm+FVneoQ904DCT
         0byXuq9ZlQVXDh4qVKhWumuyd5ywePyZdlHRjN+sDxSzFkJNE5s9wYUO3I0ICu5N+m4W
         5rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKnUv1bvq83ZNn5v1zEGY7PEZic2JVyFi8StOUJM63o=;
        b=id9wZl99QCpYVMrMmDtZxgS6Dc2Zw9shcF0XQeHM5TOxjWito+m01C5Wvl4x9z/xHQ
         O1A5X0nPT+uJ3iqwPD+tWjTMyiIV4New037KsBeldY8a9DAwAKhFT6d+B6Ip2STKHi6C
         6kFsDkQiu7IyA15GGRhdkMQQRa41FUGAIQdPiRB7v85MtMuGULZMuxnipNC6vKtKXAGl
         Cha2OU/jGLVHdUrYn9mVR/VxIWtmgKKW5tWoBY4v+r+CTMILhVquHKiqTtm9yIOiejYu
         KZmDvArBadfB7jychbH4+R+wikyZA/AjSSRSf76t0DbqVPlfP3gSZzUoJ623lMlZqjqI
         C90A==
X-Gm-Message-State: APjAAAWoEvx729TQ8rDdWj3wIWFUnsW8zEz+Dn8f7fCDXJFD+9SgFUjp
        mGnoieQjANLdgaJqo6OxzdXYi1KUJxbDnDnDeMrqtQ==
X-Google-Smtp-Source: APXvYqzfOwXf2FiI8ilai2jKqmiPftoCQkWr/p9DwIXsmU4vVeg6CJq+n6bLUbQvavXIXujRY1VpVQKMBuiGx1WDZHs=
X-Received: by 2002:a62:b607:: with SMTP id j7mr7174679pff.45.1580423276488;
 Thu, 30 Jan 2020 14:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-8-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-8-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:27:45 +0100
Message-ID: <CAN0heSqiMvMopqpMrnOffsO-nZ6UPWbuHQdB9VxLhWhm-d95rA@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] bugreport: add curl version
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:41, <emilyshaffer@google.com> wrote:
> +static void get_curl_version_info(struct strbuf *curl_info)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +
> +       argv_array_push(&cp.args, "git");
> +       argv_array_push(&cp.args, "remote-https");
> +       argv_array_push(&cp.args, "--build-info");
> +       if (capture_command(&cp, curl_info, 0))
> +           strbuf_addstr(curl_info, "'git-remote-https --build-info' not supported\n");
> +}
>
>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -31,6 +43,10 @@ static void get_system_info(struct strbuf *sys_info)
>         strbuf_addstr(sys_info, "compiler info: ");
>         get_compiler_info(sys_info);
>         strbuf_complete_line(sys_info);
> +
> +       strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
> +       get_curl_version_info(sys_info);

The header here looks a lot like an implementation detail of
`get_curl_version_info()`. Or put differently, these risk getting out of
sync. Maybe frame the header a bit more human readable: "curl version".
But is this "curl version", or more like "git-remote-https version"?
There's some discrepancy here.

> +       strbuf_complete_line(sys_info);
>  }


Martin
