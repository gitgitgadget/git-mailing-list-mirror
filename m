Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E405C1F462
	for <e@80x24.org>; Wed, 22 May 2019 05:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfEVFtu (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 01:49:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44709 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfEVFtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 01:49:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so718649wru.11
        for <git@vger.kernel.org>; Tue, 21 May 2019 22:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4Q//LnO6iFc58/FswF2aZkzvKXqYaySXzwIH7mplyE=;
        b=bT6yL6MEIlCr9MabQEjqAPnExP8fP3ckTXRIeqGlI9xR9pH1W8P53d1GCbNwp1E/O/
         pYhofhoK3Jx4efTIrRmevFJ1PDGU2fATKYERCI6wcdkM/vUjPcIo3J1c444362JKsgNe
         7B8CPrr+cnlZNv67wZu4Vf7X+ZdAlZCuatzHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4Q//LnO6iFc58/FswF2aZkzvKXqYaySXzwIH7mplyE=;
        b=AUCxSPhf4EKkhboTlYXPN+oIz897eqtWeq5DjTbKVcUwkwUfy9Nz+o0BZm6+fiXEb2
         x+iukh0Bq6AQYPVSdgcLfjrzJw4CZZdW883P6fH6VM89YxOS0xKGjwIb4V//t0ldsml/
         68K7BXIq7QIbE03k2LTglEOSxmACbTTMqroYARTwG5bRavpbLzchcoBdAWrhbZKNGqhn
         anZh9W4w5wk/1IUePv1pPdMxZlU0Yh9pAQdnCs3h6YwFmZcM3X31Y5d2c3Q3l3vFQkKE
         6sUaSyqVVvOw9uLA61HGYN2xcuTJrRcBZ9vmYsPWe+QICzPo74U+vZF+qNF5+h+6rS+a
         RLmw==
X-Gm-Message-State: APjAAAUf729JWU7+liTv+qwJu1obnabh4jcccb+qVegSlB21oSHp8Zlq
        ECIXG0LDAkUeFRnmuJYzv9cLNk+HIxh16RI4fMi8oA==
X-Google-Smtp-Source: APXvYqwR7oG6AFhCRwpqdjHAmoeruNHcBc6RbQvjIdZQXk3nH890wop0qj67CZSYdaiIf/mV0XceWA3yBEtoOXAVjTo=
X-Received: by 2002:adf:eb91:: with SMTP id t17mr34642037wrn.203.1558504188220;
 Tue, 21 May 2019 22:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190521225016.GA32526@buzz.no-dns-yet.org.uk>
In-Reply-To: <20190521225016.GA32526@buzz.no-dns-yet.org.uk>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 22 May 2019 06:49:38 +0100
Message-ID: <CAE5ih7_FMCY9ZLyYoY2XmmaaSTQAiXSMMwC_j+kLzdKY4M=hRw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Allow unshelving of branched files
To:     Simon Williams <simon@no-dns-yet.org.uk>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 May 2019 at 23:50, Simon Williams <simon@no-dns-yet.org.uk> wrote:
>
> When unshelving a changelist, git-p4 tries to work out the appropriate
> parent commit in a given branch (default: HEAD).  To do this, it looks
> at the state of any pre-existing files in the target Perforce branch,
> omiting files added in the shelved changelist.  Currently, only files
> added (or move targets) are classed as new.  However, files integrated
> from other branches (i.e. a 'branch' action) also need to be considered
> as added, for this purpose.

Looks good to me!

"omiting" in the comment should perhaps be "omitting".

>
> Signed-off-by: Simon Williams <simon@no-dns-yet.org.uk>
> ---
>  git-p4.py           | 2 +-
>  t/t9832-unshelve.sh | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 5b79920f46..81a525858b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1309,7 +1309,7 @@ def processContent(self, git_mode, relPath, contents):
>
>  class Command:
>      delete_actions = ( "delete", "move/delete", "purge" )
> -    add_actions = ( "add", "move/add" )
> +    add_actions = ( "add", "branch", "move/add" )
>
>      def __init__(self):
>          self.usage = "usage: %prog [options]"
> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> index 41c09f11f4..cde9f86cd6 100755
> --- a/t/t9832-unshelve.sh
> +++ b/t/t9832-unshelve.sh
> @@ -22,7 +22,10 @@ test_expect_success 'init depot' '
>                 : >file_to_move &&
>                 p4 add file_to_delete &&
>                 p4 add file_to_move &&
> -               p4 submit -d "add files to delete"
> +               p4 submit -d "add files to delete" &&
> +               echo file_to_integrate >file_to_integrate &&
> +               p4 add file_to_integrate &&
> +               p4 submit -d "add file to integrate"
>         )
>  '
>
> @@ -40,6 +43,7 @@ test_expect_success 'create shelved changelist' '
>                 p4 delete file_to_delete &&
>                 p4 edit file_to_move &&
>                 p4 move file_to_move moved_file &&
> +               p4 integrate file_to_integrate integrated_file &&
>                 p4 opened &&
>                 p4 shelve -i <<EOF
>  Change: new
> @@ -53,6 +57,7 @@ Files:
>         //depot/file_to_delete
>         //depot/file_to_move
>         //depot/moved_file
> +       //depot/integrated_file
>  EOF
>
>         ) &&
> @@ -65,6 +70,7 @@ EOF
>                 test_path_is_file file2 &&
>                 test_cmp file1 "$cli"/file1 &&
>                 test_cmp file2 "$cli"/file2 &&
> +               test_cmp file_to_integrate "$cli"/integrated_file &&
>                 test_path_is_missing file_to_delete &&
>                 test_path_is_missing file_to_move &&
>                 test_path_is_file moved_file
> --
> 2.17.1
>
>
> --
> Simon Williams <simon@no-dns-yet.org.uk>
> PGP Key ID: 0xF4A23C69
>
