Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048DB1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 18:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeFGSDg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 14:03:36 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:34640 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGSDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 14:03:35 -0400
Received: by mail-ot0-f177.google.com with SMTP id i5-v6so12609342otf.1
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9xix0IUM9EPrLelyLVcdCiss5X8Wx4t9Zauqg4kSWdQ=;
        b=QJ8g6Tk7n1fXCrtPdAyd9Ig7gfZPp6oPX/kK7ybqFHcXbTPG0epFyBCSmmCiXtQj+1
         pNnIXK372h40Wepa66w/HFTm9eD7Q4i8zu4snSDigNjct0YB9hBDo+mjLT+W82YIeUlr
         fZlzKf1YRUOGvIuDE+WPHOPxVJVQDFlgBLdoP7B91OJ35tRBZ71LLzEnRRDP/ZS44xpb
         gK6mTJdc35rYUSLmaXrcUJ/Sirt8XZHCtgf+SeeHMv/GIef3170y91e6bu237sgJI35W
         RzdmwHaIhOSZXBk93kd8RUn5qFURgPbCwQzdfgjGwF+G475p5fR4tQFp6442kfkR82LL
         Txbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9xix0IUM9EPrLelyLVcdCiss5X8Wx4t9Zauqg4kSWdQ=;
        b=No7B8ZMGIo1DrwGr8bmXBHPrFmSrHEh2lqczgDqlOnCU9HTuNqWfYpwd+pBJ2h/c/6
         +XG7u2ss049dEK996UMn7dhpT3eJqDHVq3TE412Bb1CMz17oUoSuP3MkFTAaei+u4rq0
         4+oEg74wfIlmlyghu1Wx29oKij7YsP2kXNZxz+YCb+NkHfIksXfcCiDVqrYim+bnhxMO
         uDwq9jDv0p0chRia1mMOv/I0AyHj3ve/Fvx7rNWVTdGk8eYcur+pMz3nfB/7gb6boMcb
         4uCN7OzYfZI5X49ClHFB+tpOL0n7CltkIhQQxXqaRw9qyuXtG2bpOx/G/we38cMtHPY6
         dJhA==
X-Gm-Message-State: APt69E3328oWez1Z6pc1PlsaoDNS+ADZyT97+GnH5Wdp5sKMYLby8akn
        cg10P/nDUJu4bb2SUzU6+i550UNwDDT2rSZEVcI=
X-Google-Smtp-Source: ADUXVKKPt4hmE3Q51HDh5mzqHIwFSFP4E6VDcH3+wgmB1F0eT2B/ANXYinBDQ8peBLM5V+TRhJYNya/djWJNHwSjnT4=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr1772602otb.356.1528394614569;
 Thu, 07 Jun 2018 11:03:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:03:04 -0700 (PDT)
In-Reply-To: <20180607140338.32440-9-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-9-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 20:03:04 +0200
Message-ID: <CACsJy8BS1x2yqzongv7iPsBbQxxZ5fO4ZbwdX5BPrzePvpJB=Q@mail.gmail.com>
Subject: Re: [PATCH 08/23] midx: read packfiles from pack directory
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> @@ -114,14 +119,56 @@ int write_midx_file(const char *object_dir)
>                           midx_name);
>         }
>
> +       strbuf_addf(&pack_dir, "%s/pack", object_dir);
> +       dir = opendir(pack_dir.buf);
> +
> +       if (!dir) {
> +               error_errno("unable to open pack directory: %s",
> +                           pack_dir.buf);

_()

> +               strbuf_release(&pack_dir);
> +               return 1;
> +       }
> +
> +       strbuf_addch(&pack_dir, '/');
> +       pack_dir_len = pack_dir.len;
> +       ALLOC_ARRAY(packs, alloc_packs);
> +       while ((de = readdir(dir)) != NULL) {
> +               if (is_dot_or_dotdot(de->d_name))
> +                       continue;
> +
> +               if (ends_with(de->d_name, ".idx")) {
> +                       ALLOC_GROW(packs, nr_packs + 1, alloc_packs);
> +
> +                       strbuf_setlen(&pack_dir, pack_dir_len);
> +                       strbuf_addstr(&pack_dir, de->d_name);
> +
> +                       packs[nr_packs] = add_packed_git(pack_dir.buf,
> +                                                        pack_dir.len,
> +                                                        0);
> +                       if (!packs[nr_packs])
> +                               warning("failed to add packfile '%s'",
> +                                       pack_dir.buf);
> +                       else
> +                               nr_packs++;
> +               }
> +       }
> +       closedir(dir);
> +       strbuf_release(&pack_dir);

Can we refactor and share this scanning-for-packs code with
packfile.c? I'm pretty sure it does something similar in there.

> -       write_midx_header(f, num_chunks, num_packs);
> +       write_midx_header(f, num_chunks, nr_packs);

Hmm.. could have stuck to one name from the beginning...
-- 
Duy
