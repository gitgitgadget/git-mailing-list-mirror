Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B57205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 09:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966638AbdADJLi (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 04:11:38 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33807 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965344AbdADJLf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 04:11:35 -0500
Received: by mail-qt0-f196.google.com with SMTP id j29so2169173qtc.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 01:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x292wMpVRwG6H1RUyI85BugqgF+V9cJoDD76eBfU9/E=;
        b=dvL1kcUH+MkRYru7iEMJXDtBxX7NvldFEnLwOGUmaHvpLvu2nfczx42tx6LqXen5py
         m9dMs+MOY+d6QcgLx18p2j91u+V8B3KxtxBGSnbukpfhgO78Ui2ewx6aWrQPAsQPzJa8
         DvWqHyqaAbUO1pAwZh5r5qXzgAa0ezq5fTeSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x292wMpVRwG6H1RUyI85BugqgF+V9cJoDD76eBfU9/E=;
        b=ZFX6xUz49/9cymRu7Ixqyujc/fNApb1N74Y4ll41nl1skyM2tgNcDjEaYGC9Nz05AM
         AUs61wivjVPsSFbCkQjjT06vSgsQJ/UnxKUSo6pamJM4ZvzSNLdXlQrUQDoTmzekq13f
         VAqmVTZMTycu1UpiKvsQ9nkCX4DXJZ+OU7zeOrytPgO4dHHAxTMLrBM4hJeIeZ97LShP
         Il0fcfugbNegOboE63aOohhNAlOeBmbVHUf51v95OuQBJNWGFAIVsDC7qB6/RQZWYz1V
         qoSVmqRvzGYHlGbIkTv3dhuQ2uTykGF2Rsvf1+hil3yoOd7CZcC5XnXHrg0oddJNPmcZ
         PBYQ==
X-Gm-Message-State: AIkVDXIpcwJJvhrlXWmRrzajaRNtevzJMLko5WjehDd9mB/+Ecv5ye9uzIFhiZnN0eBpaFxrQvl6NGPhTyPtbQ==
X-Received: by 10.237.60.101 with SMTP id u34mr68373358qte.53.1483521094282;
 Wed, 04 Jan 2017 01:11:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.62.179 with HTTP; Wed, 4 Jan 2017 01:11:33 -0800 (PST)
In-Reply-To: <20170103195708.15157-2-pranit.bauva@gmail.com>
References: <20170102184536.10488-1-pranit.bauva@gmail.com>
 <20170103195708.15157-1-pranit.bauva@gmail.com> <20170103195708.15157-2-pranit.bauva@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 4 Jan 2017 09:11:33 +0000
Message-ID: <CAE5ih78vLwDubesnAxD=g3TzsbN0sQZae3McdFcwDAZfYYhXSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t9813: avoid using pipes
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 January 2017 at 19:57, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> The exit code of the upstream in a pipe is ignored thus we should avoid
> using it. By writing out the output of the git command to a file, we can
> test the exit codes of both the commands.

Do we also need to fix t9814-git-p4-rename.sh ?

>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t9813-git-p4-preserve-users.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
> index 798bf2b67..2133b21ae 100755
> --- a/t/t9813-git-p4-preserve-users.sh
> +++ b/t/t9813-git-p4-preserve-users.sh
> @@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
>                 make_change_by_user usernamefile3 Derek derek@example.com &&
>                 P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
>                 export P4EDITOR P4USER P4PASSWD &&
> -               git p4 commit |\
> -               grep "git author derek@example.com does not match" &&
> +               git p4 commit >actual &&
> +               grep "git author derek@example.com does not match" actual &&
>
>                 make_change_by_user usernamefile3 Charlie charlie@example.com &&
> -               git p4 commit |\
> -               grep "git author charlie@example.com does not match" &&
> +               git p4 commit >actual &&
> +               grep "git author charlie@example.com does not match" actual &&
>
>                 make_change_by_user usernamefile3 alice alice@example.com &&
>                 git p4 commit >actual 2>&1 &&
> --
> 2.11.0
>
