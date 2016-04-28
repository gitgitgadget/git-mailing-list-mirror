From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pull: make --rebase --verify-signatures illegal
Date: Thu, 28 Apr 2016 10:12:05 -0700
Message-ID: <CAGZ79kbGOsPQYykWMJoAMcBGzxgQa_5H_RdR=ZXMokiFipWE_w@mail.gmail.com>
References: <20160428095254.GA5205@netblarch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: "Alexander 'z33ky' Hirsch" <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:12:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpUB-0007OM-5h
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbcD1RMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:12:09 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36352 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbcD1RMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:12:07 -0400
Received: by mail-io0-f175.google.com with SMTP id u185so96365512iod.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=an7d4bAJBQJiJnYkIaqkISS7n9rBw5RxPn5I0z9o/OQ=;
        b=alH6sue/Q7rQ3OIZe58u6iKA1i4gDH/VwEUZEI8ZJRLaWr0HBm0XB5VE9mkqR+ejjL
         DmPvrXcEXIgUKMDcTsY1+u61sn41eYl62tZ4FNPE58bBuX94PBOCmJtmHVnWm70O2pYD
         BARqNU0YUQH/Q2yO9PjqybCdpg4TNf37eQtC5kKWdlCALKqhUHP7I8txxJu0DJkT2j7i
         dGcTC+iQki2XES69Pa9pswGmxGZ5s/+j08gWylVRlw32d0rMxTx1JaC6hqTKIz7RVuz/
         qp+CM0DMJn9tS0fgriFJz3DY+PpDaJeOPLTFgbC8Cee7JCEvzeokM4fwbjkjI8u1+GIA
         MUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=an7d4bAJBQJiJnYkIaqkISS7n9rBw5RxPn5I0z9o/OQ=;
        b=aolW8RjKus5t3mSiZiddoByqNpVx5QmGVEYxrcJNdwoA4Cqu8aswrKH5Po7qIuX9HB
         zTUOYqnQw3PnMCEv7Yeds7rrhkKnWJFwNGdMBzkl58VmDY1S2cjnRB1DNbWP3beuPxJY
         M02urbuS4glelyxAya8xfWrGjkzxZ11v9qfKchMMyhgls8DUk2xDWmcsA0Sa2afVuKu6
         P6ddKRTV4i81AQ6U6n7ZpLSySPV8CVQxJEv7VhpQOpES5As5tZBkbcaSTvVsTvqfyhyL
         yv3K9zxIIFWejBZ4fjbNr8iLVAGzsoTFXo3yH/gWDKGyPTOsAFRF3f1a0IxxVS4mmn1K
         uDHA==
X-Gm-Message-State: AOPr4FUIRtDG40uHxUmL8ilao6rR1YVr2t/Sd9XkQKm9OgsqVaSMhmVzNE5LTWMuuWbhl+cK7CE7HxkFdUJ54ffW
X-Received: by 10.107.160.137 with SMTP id j131mr21659731ioe.171.1461863525941;
 Thu, 28 Apr 2016 10:12:05 -0700 (PDT)
Received: by 10.107.128.102 with HTTP; Thu, 28 Apr 2016 10:12:05 -0700 (PDT)
In-Reply-To: <20160428095254.GA5205@netblarch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292923>

On Thu, Apr 28, 2016 at 2:52 AM, Alexander 'z33ky' Hirsch
<1zeeky@gmail.com> wrote:
> Previously git-pull would silently ignore the --verify-signatures
> option.
>
> Signed-off-by: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
> ---
>
> We had some discussion back in December about a patch that added
> --verify-signatures to git-pull, that was declined.
> I proposed making git-pull --rebase --verify-signatures illegal then,
> although it still remained open whether to just warn or make it an
> error.
>
> In this patch I opted into making it an error, which breaks the
> previously accepted git pull --rebase --verify-signatures of course,
> albeit I'd argue that it probably didn't do what the user expected
> anyways.
> I don't know if there are compatibility concerns with this though.
>
>  builtin/pull.c  |  2 ++
>  t/t5520-pull.sh | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index d98f481..b6e1507 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -809,6 +809,8 @@ static int run_rebase(const unsigned char *curr_head,
>                 argv_array_push(&args, "--no-autostash");
>         else if (opt_autostash == 1)
>                 argv_array_push(&args, "--autostash");
> +       if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)
> +               die(_("The --verify-signatures option does not work for --rebase."));

Can you explain why it doesn't work (In the commit message)?

>
>         argv_array_push(&args, "--onto");
>         argv_array_push(&args, sha1_to_hex(merge_head));
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 739c089..cb8f741 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -341,6 +341,20 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>         test new = "$(git show HEAD:file2)"
>  '
>
> +test_expect_success "pull --rebase --verify-signatures is illegal" '
> +       git reset --hard before-rebase &&
> +       test_must_fail git pull --rebase --verify-signatures . copy 2>err &&
> +       test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
> +       test_i18ngrep "The --verify-signatures option does not work for --rebase." err
> +'
> +
> +test_expect_success "pull --rebase --no-verify-signatures" '
> +       git reset --hard before-rebase &&
> +       git pull --rebase --no-verify-signatures . copy &&
> +       test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
> +       test new = "$(git show HEAD:file2)"
> +'
> +
>  # add a feature branch, keep-merge, that is merged into master, so the
>  # test can try preserving the merge commit (or not) with various
>  # --rebase flags/pull.rebase settings.
> --
> 2.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
