Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703E72021E
	for <e@80x24.org>; Mon, 31 Oct 2016 23:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947975AbcJaXec (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 19:34:32 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35449 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947944AbcJaXeb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 19:34:31 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so180545931qkc.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y8zzFHXKcwMuGH123klWsgZG/lXkeOJlqPq4PDoTuWU=;
        b=mWte54MmsWIRp7AQ5AJPjzALShIYThWh3c1Bt2ZT86DPvCKCR1gY/zK2ZMLtjGluu7
         08u/ebuxprMZsOz2qeLEqAdHCRqiv5xYICBhybqY1I00fggyFvbaSuiTvh+uvhW6CDTL
         JJ1IK2og9AfTsuw0XTTRUMLCwWbHu8l32/Ps/KGkKqL17w9EmnGyCyFgiozG9QcjAaml
         n8z9m8+nO116nP4AdN9MzM4IAjylvH5stMJXKWpqVPMlvKLxUxyALxQNBmcVi4qav3Pj
         Abd/tG+2VqC1eZG5oqKsH1UmtZWfKeh5pCVEQ4whLNPw2sXEh8D1KRK6qOTlwFq4SGiA
         egsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y8zzFHXKcwMuGH123klWsgZG/lXkeOJlqPq4PDoTuWU=;
        b=ghN4qG8BQhvntm3bmex5t+j41p1P6oPE54GMMdqR9Q82s9GwKeeXj3tjbr0FnqB1VS
         Ct7+H6v8WLCvkFef7unqXiA2nfIr4UFu31aVoNNpfHkJCihKc6/dmSEbeLGf8iFWC96F
         lZhIHRqPIJBteAAaLjX1aBe9ghybNFFBOPBmRHDS2rjDxLHfefXvl/NnHYb8yJFTlBac
         MqJu5g//B44i7H3D5SWHUAZm8yJh/FF7A3pd9dfZTctj2Q7j62Ahdha76KcXjYvcJL1j
         sDPS0F/VDJTLW1mgI6Tr32C7SGftCzdT8bbqS1VOzWHFBVl4bcyhW532IawlgCQ0YkYf
         r6Cg==
X-Gm-Message-State: ABUngvfJPpnhaBv8teI59fAwjZ0TRxP5Smh6YdB5XMrMHqNcapxyl/mMQ7FFKj/gq3jjEEOvXkcnjcbDpgFCBjq6
X-Received: by 10.55.20.164 with SMTP id 36mr25691373qku.86.1477956870678;
 Mon, 31 Oct 2016 16:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 31 Oct 2016 16:34:30 -0700 (PDT)
In-Reply-To: <1477953496-103596-2-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com> <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-2-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Oct 2016 16:34:30 -0700
Message-ID: <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:
> +int is_submodule_checked_out(const char *path)
> +{
> +       int ret = 0;
> +       struct strbuf buf = STRBUF_INIT;
> +
> +       strbuf_addf(&buf, "%s/.git", path);
> +       ret = file_exists(buf.buf);

I think we can be more tight here; instead of checking
if the file or directory exists, we should be checking if
it is a valid git directory, i.e. s/file_exists/resolve_gitdir/
which returns a path to the actual git dir (in case of a .gitlink)
or NULL when nothing is found that looks like a git directory or
pointer to it.


> +
> +       strbuf_release(&buf);
> +       return ret;
> +}
> +
>  int parse_submodule_update_strategy(const char *value,
>                 struct submodule_update_strategy *dst)
>  {
> diff --git a/submodule.h b/submodule.h
> index d9e197a..bd039ca 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -37,6 +37,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>                 const char *path);
>  int submodule_config(const char *var, const char *value, void *cb);
>  void gitmodules_config(void);
> +extern int is_submodule_initialized(const char *path);
> +extern int is_submodule_checked_out(const char *path);

no need to put extern for function names. (no other functions in this
header are extern. so local consistency maybe? I'd also claim that
all other extern functions in headers ought to be declared without
being extern)

Also naming: I'd go with

    is_submodule_populated ;)

as it will tell whether this function will tell you if there is a valid
submodule (and not just an empty dir as a place holder).

You don't have to run "git checkout" to arrive in that state,
but a plumbing command such as read_tree may have been used.
