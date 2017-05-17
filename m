Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E1E2023D
	for <e@80x24.org>; Wed, 17 May 2017 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdEQGXc (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 02:23:32 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34548 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdEQGXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 02:23:31 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so2262173pfj.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6L+B5jcr8VEVFvyyuNtmYdgb6zvRNBtVbFB9ikiQ+uI=;
        b=CUsPLI+Jb+Mayc3WueXse8+x2C0YOTQguvlr4ELG0uhaO+qq9mAksFIUwVsTGt39oO
         kTFN3ZGhqJoRGPL2XKqGdf5UBUJ9LCPxwyEEgMMBH7kvovRHv/xkaWgh8hywEdQ7AZJH
         OcnGPzH9ITT4d7X+FDJwp8atet1VKyLGM3Af7HriuxkHb311KSadKOTm1SjWzGNZSYSV
         BTpSIrmoDGnTK4NlxPSIVbNLrw6yi+aoTO82hDvrqhQFjvm3B8O1Y8rUY9d4cXXD690Q
         dlAEYk4MhnteagRcw5y0lDYsCogugmOdE7PJXiPtiMA4jU2W7bIFLSzWBsIFweIpQgOI
         gvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6L+B5jcr8VEVFvyyuNtmYdgb6zvRNBtVbFB9ikiQ+uI=;
        b=qp+inKlEbsQXo5tA0CnfjDSqLGTYwXsIowfCOqz1TYZ3scrJhqaOVOAR+cZSnFis9X
         nv8J04YU5RONNI9YdMPein7F12qZ9jG1e1VwE/r4jraBWrXp3EjC/bY5VT8FUg99gME5
         /Tzk9gvcbYav7HazE9kwtKZqhLXTrm/FfWQxEAoLMu4pUQqg7EZVqauV3FUCkpt688VJ
         /vqlcghvixZEQ79whzRHR3CD37F5XNFnTlAZZU8qRL6ukASXveeH7g4ctSYU2htcuJfF
         3DNyknJxGFJT5gwtU+aWUds3qNIhpFLHmDA33n7XcaRnUi7aQx3y/LcP3scsYJOVE4sa
         hLDg==
X-Gm-Message-State: AODbwcCTy/+hmMO5jLJbaC4TS+44AA9oZ9MVIZnn/Ibe6uRe04B/Ijuc
        zXPpUqit/65lsQ==
X-Received: by 10.99.3.208 with SMTP id 199mr2020599pgd.43.1495002210912;
        Tue, 16 May 2017 23:23:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id n5sm1724913pfa.78.2017.05.16.23.23.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 23:23:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/8] dir: recurse into untracked dirs for ignored files
References: <20170516073423.25762-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <20170516073423.25762-4-sxlijin@gmail.com>
Date:   Wed, 17 May 2017 15:23:29 +0900
In-Reply-To: <20170516073423.25762-4-sxlijin@gmail.com> (Samuel Lijin's
        message of "Tue, 16 May 2017 03:34:18 -0400")
Message-ID: <xmqqy3twvw66.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> We consider directories containing only untracked and ignored files to
> be themselves untracked, which in the usual case means we don't have to
> search these directories. This is problematic when we want to collect
> ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
> read_directory_recursive() to recurse into untracked directories to find
> the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
> has the side effect of also collecting all untracked files in untracked
> directories as well.
>
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
>  dir.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index f451bfa48..6bd0350e9 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1784,7 +1784,12 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  			dir_state = state;
>  
>  		/* recurse into subdir if instructed by treat_path */
> -		if (state == path_recurse) {
> +		if ((state == path_recurse) ||
> +				((get_dtype(cdir.de, path.buf, path.len) == DT_DIR) &&

I see a conditional in treat_path() that is prepared to deal with a
NULL in cdir.de; do we know cdir.de is always non-NULL at this point
in the code, or is get_dtype() prepared to see NULL as its first
parameter?

	... goes and looks ...

Yes, it falls back to the usual lstat() dance in such a case, so
we'd be OK here.

> +				 (state == path_untracked) &&
> +				 (dir->flags & DIR_SHOW_IGNORED_TOO))

If we are told to SHOW_IGNORED_TOO, we'd recurse into an untracked
thing if it is a directory.  No other behaviour change.

Isn't get_dtype() potentially slower than other two checks if it
triggers?  I am wondering if these three conditions in &&-chain
should be reordered to call get_dtype() the last, i.e.

                if ((state == path_recurse) ||
                    ((dir->flags & DIR_SHOW_IGNORED_TOO)) &&
                     (state == path_untracked) &&
                     (get_dtype(cdir.de, path.buf, path.len) == DT_DIR)) {

> +				)
> +		{

It may be just a style, but these new lines are indented overly too
deep.  We don't use a lone "{" on a line to open a block, either.

>  			struct untracked_cache_dir *ud;
>  			ud = lookup_untracked(dir->untracked, untracked,
>  					      path.buf + baselen,
