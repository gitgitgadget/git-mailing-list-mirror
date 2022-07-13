Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE3FC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 01:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiGMBjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 21:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiGMBjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 21:39:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C132ECA
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:39:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so11319918ejc.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v3Xg+cJUqNp9ie+vwT2eE/XQYGlzoR/5EnwbfnxRBjc=;
        b=WMjlTjWHRzAm8S1fqaYob0RBdx3sQ08lH+hDOSB46zcw0jswi768iiKw/stndxegA7
         eNVqJcjG4TGgSYzh1/9HcFEFJGu5OoT9STpp03sVPDDPChSAE2MxxRA2GouUoiZng+ID
         KDZKJj6tND2zmhkkzHXohpabIjLVUGUxHIQ4qBjpsE0ete3MyKIkXpfr9JEVaV3/vZpu
         455d2KZOX5fPdC5lA6EFEGWWida/RBuYhmNwEdkZoO72s5PPZEQ32lRuGO1t4wvzSlQG
         03wyCfv24tEXBB+xXr+xTlvvZS6JnXfQ+AaBxUSENuAv3rMVp8N/qJFQu9xecIKR3BJd
         rPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v3Xg+cJUqNp9ie+vwT2eE/XQYGlzoR/5EnwbfnxRBjc=;
        b=CwXCGmGAtBa7UsjqLodaNeYHfp89bW4DUWmcumk+iUQiHj/SHRkBegB+YC6GoO8WrP
         eRNHTtHEvuyWnp5S1KKayofOrLDLuSt9scwSj/N/57Muada4NOL9OYrOl96m/HiYdt2q
         Yq8e+GDRCKy+IHO+dyWxEFFC2tOXPWUyxiAWT2DazwRnVspTgywEZzTbSiDRlS4zgFgS
         pF71FkMBDLYrolu3FGWbK1aSMSkSG5PW6uYQLt0UyAj+/PP5WrkIUsmWEVKtLmobfo36
         JoDEwgAHGVnJiByuBupRDCJPB5PvzW+4r1kVSEvcvgmhXpxEXoRClu7iM3pIFtw4rr2x
         ktkg==
X-Gm-Message-State: AJIora8xc6TR0sEK9mwRKDDdB7cYJpMRXa2bQJr32BkhlWOFlP8iWTQz
        EpiUdztQW/+o7ibGUODfij+nEpmBRUeSEg==
X-Google-Smtp-Source: AGRyM1u84Xtv2ecI6ZxawGyFVGg8+z9MO/uLfY2qLK0bF2Y4oj79y4qz0KhrwIJR05zUYGwtoyd6rA==
X-Received: by 2002:a17:906:37c6:b0:70c:f9f:f0c5 with SMTP id o6-20020a17090637c600b0070c0f9ff0c5mr984265ejc.743.1657676351292;
        Tue, 12 Jul 2022 18:39:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906344d00b00722e7e48dfdsm1820398ejb.218.2022.07.12.18.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:39:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBRLJ-001dB5-Sv;
        Wed, 13 Jul 2022 03:39:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de, johncai86@gmail.com
Subject: Re: [PATCH v4 3/4] ident: rename commit_rewrite_person() to
 apply_mailmap_to_header()
Date:   Wed, 13 Jul 2022 03:25:40 +0200
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-1-siddharthasthana31@gmail.com>
 <20220712160634.213956-4-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220712160634.213956-4-siddharthasthana31@gmail.com>
Message-ID: <220713.86ilo14wqq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, Siddharth Asthana wrote:

> commit_rewrite_person() takes a commit buffer and replaces the idents
> in the header with their canonical versions using the mailmap mechanism.
> The name "commit_rewrite_person()" is misleading as it doesn't convey
> what kind of rewrite are we going to do to the buffer. It also doesn't
> clearly mention that the function will limit itself to the header part
> of the buffer. The new name, "apply_mailmap_to_header()", expresses the
> functionality of the function pretty clearly.
>
> We intend to use apply_mailmap_to_header() in git-cat-file to replace
> idents in the headers of commit and tag object buffers. So, we will be
> extending this function to take tag objects buffer as well and replace
> idents on the tagger header using the mailmap mechanism.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  cache.h    | 6 +++---
>  ident.c    | 2 +-
>  revision.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index c9dbe1c29a..9edb7fefd3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1689,10 +1689,10 @@ struct ident_split {
>  int split_ident_line(struct ident_split *, const char *, int);
>  
>  /*
> - * Given a commit object buffer and the commit headers, replaces the idents
> - * in the headers with their canonical versions using the mailmap mechanism.
> + * Given a commit or tag object buffer and the commit or tag headers, replaces
> + * the idents in the headers with their canonical versions using the mailmap mechanism.
>   */
> -void commit_rewrite_person(struct strbuf *buf, const char **commit_headers, struct string_list *mailmap);
> +void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap);
>  
>  /*
>   * Compare split idents for equality or strict ordering. Note that we
> diff --git a/ident.c b/ident.c
> index 9f4f6e9071..5f17bd607d 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -393,7 +393,7 @@ static ssize_t rewrite_ident_line(const char* person, struct strbuf *buf, struct
>  	return 0;
>  }
>  
> -void commit_rewrite_person(struct strbuf *buf, const char **headers, struct string_list *mailmap)
> +void apply_mailmap_to_header(struct strbuf *buf, const char **headers, struct string_list *mailmap)
>  {
>  	size_t buf_offset = 0;
>  
> diff --git a/revision.c b/revision.c
> index 14dca903b6..6ad3665204 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3792,7 +3792,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  		if (!buf.len)
>  			strbuf_addstr(&buf, message);
>  
> -		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
> +		apply_mailmap_to_header(&buf, commit_headers, opt->mailmap);
>  	}
>  
>  	/* Append "fake" message parts as needed */

I can live with this so far, but I really think this is cementing the
wrong approach into place here.

We only use commit_match() to feed a commit to grep.c, which if you look
at the "header_field" struct there we take this pre-formatted output and
parse this out *again*, i.e. find "author", "reflog", "committer" etc.,
and eventually point the regex engine at that buffer.

So we really don't need to get a strbuf here, and munge the whole thing
in place to feed it to grep.c, instead we can:

 1. Not munge it at all, pass it as-is
 2. Pass the mailmap along to grep.c itself
 3. It's already parsing out the headers, so at some point it will have
    "author foo <bar>\n"
 4. In that code, we can just consult the mailmap, and then map the "foo
   <bar>" bart to "Baz <bar>" or whatever
 5. Thean search that string.

So no need for any in-place rewriting, or no?

Even with this approach this seems a bit odd, e.g. isn't your
commit_rewrite_person() largely a re-invention of find_commit_header()
in commit.c, can't we use that function there?

The replace_idents_using_mailmap() in 4/4 seems like it could be
improved in a similar way.

I.e. can't we just loop over the the object, then as we find "author"
consult the mailmap, and potentially emit a replacement, otherwise the
existing content as-is up until the next \n etc.

We should be able to "stream" all of this, instead of in-place modifying
a potentially large commit buffer, which involves memmove() etc.
