Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD4BC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjEHTcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHTcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:32:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07668448F
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:32:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643a6f993a7so2474588b3a.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683574332; x=1686166332;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbyRjJDvrTuvz9ka/y68Dnt0MVF0j4ZSlWVvI7NjsH4=;
        b=NzllTEodWLgh9SLzbwAiU5rRxOkqJ1W552QKA9SGN/Go268tCcUu/+2ruZ5vuWudEk
         JXC283XvAd9mmgMIv8WxGc4xDQGd2DM13oUBXOp/x1gzfoqFjxF6Ejlzp6pfekwLvLbB
         o/O7xcoACZadZRoyTYbjEr3i+kymDKmJsApz/TDJMTQ/Z/Sh2Z0peDQL1bhwywSIhcFn
         CNvAnwyLbVEBCedZQ3ZgEpoiX/5IruS9Qm+pct1dXG6c+ix1UDxioDUQRluWhpgWMRBb
         uqD5qqwlyBtlRziqocv1HnvwAmbLn8f29R6zkncADk2takix+n6FDWxO3FixE27OOCOI
         38kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574332; x=1686166332;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbyRjJDvrTuvz9ka/y68Dnt0MVF0j4ZSlWVvI7NjsH4=;
        b=bvuZUt9AiZ0VJPa22FD2/PsP+R3GWm8HVDodQhOzhkp7Al2Ib9/C1kPSKecYotgx9i
         JRrm6oVJ4ThC9Y8vEVozu7ELm6d5Wp92daSjJ8fTqoHOFCFPVdirX9WSJ8eo/Ef85dWN
         giiIL9wUAqQ10Zw0cWliCHahTHONV0cHu29oawjomJPr9aUmIGwT29QIgbnwHyJwN7j9
         Kvq7jvbA2VDyH+QHoTEgCYY8zp3xhyH4aZxkuthRDSw8b0GLWdeZ9zPt1tKYYv6bmBmk
         ILtTUzvy33gtJBNrQyg6Zui0zLHsEq5vEaqMXcZ9+JYPNCZu8sY7TfVo6zNgdFqGFxJW
         piRw==
X-Gm-Message-State: AC+VfDwq2xo7v61OHjUHGlXtZdPbH+yNKq4fv9j67eYuApwf3zfdmgDm
        hyD/GudjNVo52esZqdoF1bM=
X-Google-Smtp-Source: ACHHUZ4W2GGqPTKbPuUJtKRA4mxvquszEkoggAw4Vofk6GkU4yYwNoz+TSbxiAmqfjkdmZPYAiFAaw==
X-Received: by 2002:a05:6a00:885:b0:63d:3595:26db with SMTP id q5-20020a056a00088500b0063d359526dbmr14630492pfj.23.1683574332361;
        Mon, 08 May 2023 12:32:12 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id w20-20020aa78594000000b00642ea56f070sm354979pfn.30.2023.05.08.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:32:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 03/11] doc: trailer: --no-divider: more precise language
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <ad2d669eb0a6ba1f98af064089ef981c50546958.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:32:11 -0700
In-Reply-To: <ad2d669eb0a6ba1f98af064089ef981c50546958.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:42
        +0000")
Message-ID: <xmqqednqoc04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This uses the phrase "commit message part" instead of "commit message".

That much anybody can see from the patch.  The question is, is the
updated phrasing "more precise"?

To me (a non native English speaker), both the original and the
updated text say mostly the same thing, but the added word "part"
actually made my reading hiccup a bit.

It may be because for the word "part" to sit well, it is not clear
enough what "your input" consists of in the updated text.  If it
were somehow clear to readers that "your input" consists of "commit
message part", "some other message part", and "yet another message
part", divided with a three-dash lines, then "commit message part"
might become a good phrasing.  An email can have any garbage in it,
a format-patfch output has commit message and patch text.  So "only
the commit message" or "just the commit message" without "itself"
may be an improvement in clarity, in the same sense that 01/11 made
a sentence say the same sense with a fewer words, but personally I
do not find the posted patch as-is that much of an improvement.

I dunno.

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 593bc1a1f4e..3e60a6eaabc 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -131,7 +131,7 @@ OPTIONS
>  
>  --no-divider::
>  	Do not treat `---` as the end of the commit message. Use this
> -	when you know your input contains just the commit message itself
> +	when you know your input contains only the commit message part
>  	(and not an email or the output of `git format-patch`).
>  
>  CONFIGURATION VARIABLES
