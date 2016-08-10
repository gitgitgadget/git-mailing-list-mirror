Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213221F859
	for <e@80x24.org>; Wed, 10 Aug 2016 00:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcHJAx0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 20:53:26 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34837 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbcHJAxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 20:53:25 -0400
Received: by mail-io0-f180.google.com with SMTP id m101so27782336ioi.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 17:53:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SIW9qlnDj8rN85e4hhpRn99TRmZ4xH4Re6ZAFUOcbfg=;
        b=TUW49lEje3DlsAgp4NhnrVCf82o/G6vS84d85JxTy/SWmR3vMuZ3DFspzcZyXuyM1Y
         8WHYX+ZxtAkrZICG/TJujKySZL07oL+QvBs+hqHfr8pCqYrGXTOlYTu0vU9msqyFIQM3
         lyr1ZbyJzgWQ2IvKadHn8NPs07xP2unDo9STcCmNGacCLPbjHP6bH929JG78oAh8LDEn
         HtGvG/qRVYGXcwYu1R7ejdLPShIFmC+cCOW6mC8DW/R9L5ruDnK7w60EIqTKPfkN5hQH
         KQ1UZZBZBW1kcpdvP6O4NXn/o5w4DDtTUlluU3x//8G55Ci8FF3fTqvD8JEAKAidc4jW
         fxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SIW9qlnDj8rN85e4hhpRn99TRmZ4xH4Re6ZAFUOcbfg=;
        b=YI0BrJ0AxfHLdsQ5GlpdIeg0GAZTlmksqKJ+SRahFmiVQyWjU9LNj7MGXq4sq+9+FM
         6tCvA7km8Q/KYSgR9RGv+4X8y/ZXBGsS+mMIJ0xDng6/UsK4r3GGOO/UYiZ+AiGBi2hn
         lMLKn3nsKRkaCCg719QDAw2pIT0FNvHmkij41P3AVk5ERdzWDKHe1ogK7QB6BPnW1X0y
         YRtJI8PKyJ1Ndx82HAi1yHV5fJ23ZiGUQjQ7iyBnhoM/E3ZTtqG8T1eOBRP02SLtDnFI
         4oTYU1EIiMJxwwGkpo/OJW4PwGRIhsR0YYqBMctkZ0nTmv+yFR9vW84vOjM07oVKNG77
         O/dQ==
X-Gm-Message-State: AEkoouusCCNkGnTudnhNXuzkPxeF0q9YWAFEUb0qIjGaz8uoDxZjp1fZgcW1sp2ZDBPk5zDLV7SrQmEeMQlFzrrt
X-Received: by 10.107.178.129 with SMTP id b123mr2181204iof.83.1470790390904;
 Tue, 09 Aug 2016 17:53:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 17:53:10 -0700 (PDT)
In-Reply-To: <20160810002315.25236-1-jacob.e.keller@intel.com>
References: <20160810002315.25236-1-jacob.e.keller@intel.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 17:53:10 -0700
Message-ID: <CAGZ79kYLLJCq0OZANSyrYmuq1Mm6w3Ks8CHC-_0uicDps0srpg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] diff: add SUBMODULE_DIFF format to display
 submodule diff
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 5:23 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> +static int prepare_submodule_diff(struct strbuf *buf, const char *path,
> +               unsigned char one[20], unsigned char two[20])
> +{

This is not used any more, but the child is run directly below?

> +       strbuf_addf(&submodule_git_dir, "%s/.git", path);
> +       git_dir = read_gitfile(submodule_git_dir.buf);
> +       if (!git_dir)
> +               git_dir = submodule_git_dir.buf;
> +       if (!is_directory(git_dir)) {
> +               strbuf_reset(&submodule_git_dir);
> +               strbuf_addf(&submodule_git_dir, ".git/modules/%s", path);
> +               git_dir = submodule_git_dir.buf;
> +       }

This pattern seems familar, do we have a function for that?
(get a submodules git dir? As I was mainly working on the helper
I do not know off hand)

> +       if (start_command(&cp))
> +               die("Could not run 'git diff' command in submodule %s", path);
> +
> +       diff = fdopen(cp.out, "r");

diff is a FILE* pointer. cp.out is a standard int file descriptor

Maybe you'd want a similar thing as strbuf_getwholeline_fd()
just instead of adding it to the strbuf, adding it to `f` ?

(Which is what you have here? I just wonder about the buffer size,
as I think reading 1 by 1 is not beneficial)

> +
> +       c = fgetc(diff);
> +       while (c != EOF) {
> +               fputc(c, f);
> +               c = fgetc(diff);
> +       }
> +
