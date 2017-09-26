Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B85202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 05:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935374AbdIZFCD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 01:02:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37521 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935241AbdIZFCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 01:02:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id e69so4551231pfg.4
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E1y+shdVRSiEm6LYAzBU1uNJW0yO41EEzOefcBl6OHY=;
        b=cgWDVInIHm1ooCJQ5eo+qfNjN0EBctHSZ7myGPVjm7QD0OsRK15ET0dQIdO/lVK+bt
         o+UCiNSVVVLM5hWvzXIbKXTnu8hIsksCP/i3eFj0bw2YW+N8nqKq5mZ/gfMSqgBs35AD
         K7ikc6TMlEh3r9nKDFBCUjQ9DWGwc/BI/TTlbtY1SVKtCkk/NqXXjKJ+Rn7JrWfBquPR
         xojIUVO8rNj2jLU96+iZp26piq2TdIijXqNfNBA/KLU9qySmDLAmyyfil0ATIYpcpWFJ
         ICYRPTxKBWmX+SdVlx6/UJlXwKqbL2AiFkSg4dlHeyXvaXHKcOscwq4ljzM7PCWvLP/Z
         tWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E1y+shdVRSiEm6LYAzBU1uNJW0yO41EEzOefcBl6OHY=;
        b=IwYcUreCZdJ3s8vPYYurBdIKe9aymVcXvcz86ISvq/vpkGQcbD+k7mhKST0OUgBvEl
         Yym6dYGPQVZ8ntJQeENkNPe1kcX/ldwhqNB9Ug0OZolagyq4FSMZkGIlKgdh2NlkZtPe
         x3dGb+qUX1wJa1/wNaiiS0EH1KbkSzvJs1i4NXxY6T6trwzQQ5ZyEN4G9N4a5PVntGj/
         K2W5YxFKGYtpYDFApdgOK5HuRd5K3HW+YmhilDC2hC+GALpC25+HE5TAxK+m8Qxfpt7U
         i7lbsEAr0ihPY3K+0/Ej6dCa681GZEQpj5EwL1MMc01W1ap+O6Ans8BPxli7RH7ftWfx
         WGJw==
X-Gm-Message-State: AHPjjUiuE3drFMRCfdIZiKB+/uZYekz0gGe/oZ2EinE3OZPOQR5WvW3I
        yBSfjjb63ZNJIHAPOKkymf0=
X-Google-Smtp-Source: AOwi7QCiJtgdEPa6jbh6Vb1B/xkbTx+lKTdLHnHvDmWVOeTMSj6Gme/kMxbCmISZxTtijc6KAr/Osg==
X-Received: by 10.84.179.165 with SMTP id b34mr9525010plc.15.1506402121763;
        Mon, 25 Sep 2017 22:02:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id z9sm14421704pgc.85.2017.09.25.22.02.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 22:02:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com
Subject: Re: [PATCH 2/4] Clarify return value ownership of real_path and read_gitfile_gently
References: <20170925155927.32328-1-hanwen@google.com>
        <20170925155927.32328-3-hanwen@google.com>
Date:   Tue, 26 Sep 2017 14:01:59 +0900
In-Reply-To: <20170925155927.32328-3-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Mon, 25 Sep 2017 17:59:25 +0200")
Message-ID: <xmqqmv5iaw8o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>>Subject: Re: [PATCH 2/4] Clarify return value ownership of real_path and read_gitfile_gently

We try to make "shortlog --no-merges" output consistently say what
area the change is about, followed by a colon, followed by a short
description.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  abspath.c | 3 +++
>  setup.c   | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/abspath.c b/abspath.c
> index 708aff8d4..792a2d533 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -202,6 +202,9 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  	return retval;
>  }
>  
> +/* Resolve `path` into an absolute, cleaned-up path. The return value
> + * comes from a global shared buffer and should not be freed.
> + */
>  const char *real_path(const char *path)
>  {
>  	static struct strbuf realpath = STRBUF_INIT;

The part about "what it does" is a good thing to have here, but I do
not think the second sentence adds much if it stays here (if the
comment were in a header file far from implementation, then it is a
different matter).  Besides, "should not be freed" is not the only
important thing---it is already implied by the function returning
"const char *" (i.e. the caller/receiver does not own it).  It will
stay valid only until the next call, so the caller needs to xstrdup()
it if it wants to keep the value.  That is equally important.

But quite honestly, that pattern appears very often in our codebase
(all users of get_pathname() share the same characteristics) that
these details (i.e. do not free, expect the buffer to be recycled)
probaly is not worth it.  Mentioning that the returned value is in a
shared buffer for short-term use would be sufficient.

> diff --git a/setup.c b/setup.c
> index 6d8380acd..31853724c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -541,7 +541,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  
>  /*
>   * Try to read the location of the git directory from the .git file,
> - * return path to git directory if found.
> + * return path to git directory if found. The return value comes from
> + * a shared pool and should not be freed.

OK, the returned value comes from the return value of real_path(),
so the early half of the new warning is worth having.  "should not
be freed" is both extraneous (for those who are already aware of the
common pattern in our codebase) and insufficient (for those who are
not yet).

Thanks.

>   *
>   * On failure, if return_error_code is not NULL, return_error_code
>   * will be set to an error code and NULL will be returned. If
