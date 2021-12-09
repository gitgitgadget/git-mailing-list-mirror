Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85859C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhLIWtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhLIWtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:49:07 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E0C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:45:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 137so6422412pgg.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oNTT3J/jwsiYKlaU7HRu5yySZdu4SHZbGs3iUB5tyYA=;
        b=HQRWcxC7yPogFqypE2zpF0e1vLAkUcZTbVLafgsLf6qh3IZdW2BEy7UJrrlgE0qXSj
         sTExQ636mIDMKPzWo9MaJSijUgrRpD8IyOQIoBuWt0PsiENwv3Wf9G61KQcdcpYlYQMB
         LxfAYDfe8PU5D2JAUnl5qrL2IOlxwhU9LWbdmn0srFGbma9hOI0Ef/Pt1Q/gIkxWin7Y
         FxwA3NjXUiz9XOkHTRjesyaD6IaOVGgpUeigyEFEJevT554Yns1d9yNJZaxluLEMda1C
         Fa/g5De0VESHPRdoyLYl9p8+LRZ7UgA36I+fliGEa3f4zf//p5BuOsa8y2TCxg4HhJ77
         Oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=oNTT3J/jwsiYKlaU7HRu5yySZdu4SHZbGs3iUB5tyYA=;
        b=JeULo2xWB8PLVkSUazlEy/4EbDHP7zxkwI1bM86LdL5Y72cSqfckfJepo3Qq1TULTl
         VRSHA2cq2TSs5bebDSeRkKjxa9onVNL+NqLuJm7IlhK+n8E0zY2W+kWBI08vvTnFckfr
         qi21Iu0ISDis8yE+WbQgUV2jw17i8LYd3HTE6QwOdOxiPCuFNSk5NwE4g7EQEyh+MNnL
         7/ig8uK+ke5IGT3Co4He6F1ozjeqoMk4JbKoW1RE9kuz6NzarOjXogUrpIaZ5dVzFpWO
         h1uNklPVgnjWzK2d4oi2UEf2L7GB2PBQ3JunpnLTTVWDsY2JX77RPDFnv4XvKMlFDzoN
         GKhQ==
X-Gm-Message-State: AOAM533a6uHElt+oGVEHcEZKBjrVV9Klw8nQRKkr3PuEk4fF0O3jsJxo
        0Prh0ed35l9tpa+CxFMYk8zd5w==
X-Google-Smtp-Source: ABdhPJyFdQZ62kineI6HBPIXOF8jWNoBUgFpgyd+yE01IZTeLXdBhazdDveUT3PQ2tXa4MAVVFKOLQ==
X-Received: by 2002:a05:6a00:248f:b0:4a0:1e25:3155 with SMTP id c15-20020a056a00248f00b004a01e253155mr14548790pfv.21.1639089933326;
        Thu, 09 Dec 2021 14:45:33 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f4c9:bc3f:d5d6:ed2e])
        by smtp.gmail.com with ESMTPSA id o16sm729335pfu.72.2021.12.09.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:45:32 -0800 (PST)
Date:   Thu, 9 Dec 2021 14:45:26 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Message-ID: <YbKHBsl7w1uNhLb6@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kl6llf0war1x.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.07 16:17, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  
> >  	strbuf_reset(&key);
> >  	strbuf_addf(&key, "branch.%s.merge", local);
> > -	if (git_config_set_gently(key.buf, remote) < 0)
> > +	/*
> > +	 * We want to overwrite any existing config with all the branches in
> > +	 * "remotes". Override any existing config with the first branch, but if
> > +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> > +	 * we've written so far.
> > +	 */
> > +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
> >  		goto out_err;
> > +	for (i = 1; i < remotes->nr; i++)
> > +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, CONFIG_REGEX_NONE, 0) < 0)
> > +			goto out_err;
> 
> I think that instead of overriding all config with the first value and
> then appending every value after that, it'll be more obvious to readers
> if we first unset all of the config, then write every value (then the
> comment wouldn't have to justify why we make two calls and iteration
> starts at 1).
> 
> I believe that unsetting all values for a key is supported by
> git_config_set_multivar_gently() with value == NULL, i.e.
> 
>   /*
>    * unset with value = NULL, not sure how this interacts with
>    * CONFIG_REGEX_NONE
>    */
>   if (git_config_set_multivar_gently(key.buf, NULL,
>     CONFIG_REGEX_NONE, 0))
>     goto out_err;
> 
>   for_each_string_list_item(item, remotes) {
>     git_config_set_multivar_gently(key.buf, item, CONFIG_REGEX_NONE, 0);
>   }

Fixed in V6, thanks for the suggestion.


> > @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *local, const char *origin, const
> >  	advise(_(tracking_advice),
> >  	       origin ? origin : "",
> >  	       origin ? "/" : "",
> > -	       shortname ? shortname : remote);
> > +	       remotes->items[0].string);
> >  
> >  	return -1;
> >  }
> 
> When there is more than one item in remotes->items, this advice is
> _technically_ incorrect because --set-upstream-to only takes a single
> upstream branch. I think that supporting multiple upstreams in
> --set-upstream-to is a fairly niche use case and is out of scope of this
> series, so let's not pursue that option.
> 
> Another option would be to replace the mention of --set-upstream-to with
> "git config add", but that's unfriendly to the >90% of the user
> population that doesn't want multiple merge entries.
> 
> If we leave the advice as-is, even though it is misleading, a user who
> is sophisticated enough to set up multiple merge entries should also
> know that --set-upstream-to won't solve their problems, and would
> probably be able to fix their problems by mucking around with
> .git/config or git config.
> 
> So I think it is ok to not change the advice and to only mention the
> first merge item. However, it might be worth marking this as NEEDSWORK
> so that subsequent readers of this file understand that this advice is
> overly-simplistic and might be worth fixing.

Sounds like we should just have separate advice strings for single vs.
multiple merge configs?


> >  
> > +int install_branch_config(int flag, const char *local, const char *origin, const char *remote) {
> > +	struct string_list remotes = STRING_LIST_INIT_DUP;
> > +	string_list_append(&remotes, remote);
> > +	return install_branch_config_multiple_remotes(flag, local, origin, &remotes);
> > +	string_list_clear(&remotes, 0);
> > +}
> 
> string_list_clear() is being called after `return`.

That's an embarrassing bug, thank you for catching it.


> Ævar and Junio have commented on i18n, but I'm unfamiliar with that, so
> I won't comment on that :)
