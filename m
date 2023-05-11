Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8052EC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbjEKTy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjEKTyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:54:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83233121
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:54:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a50cb65c92so65106185ad.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683834864; x=1686426864;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifqWgrNqDBTOVb3UFGjWLY+OWi+NsrG34hrl+74kuTU=;
        b=HKnsYN9xxkwUlvByAjzz9IiT/VhpZzTkoJ0NDmkN3z0JfM09OKx+4Byihc5emkahOG
         649ffxUYXhqQCczXgF7cfMjmemFdRqzbl0wDwSER6vEBUx62AWWAM1un50SB413KXOM8
         Vtq8bdurGxZbiV89BPRAtZ91pURCVd9RJuNW8HeLGUb56VoB3Em2kPBPiIJJyWkpCZZ3
         JJCDHSreDdyAseNrcHA89g3g7gMYWhuTxfQo+8n7aEb44KRTqzYamCOQ9+JOaZpUya1/
         vv1AbvNPB14SoFKK/KJxgO7JLwZUdoKoAuFKL+PyeEenVZgzmfKH5Uk39dog3f8K2KI1
         buyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834864; x=1686426864;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifqWgrNqDBTOVb3UFGjWLY+OWi+NsrG34hrl+74kuTU=;
        b=anDZFwt51eKJTVknTTnSP/HXVxhTcnz6pvx5RmaFBh4XoPd34UlcRNmE59ueXKzAlp
         0My+sx5Asxiar5CMgOv7FEqafRA26/vArCdHSMfv2QlZ6GqcyF02o7C90VRdN/RFRvUj
         EuVEDvVbxb47VI0qUErLWBkS3HJcHLZcrQeUYc+CSofIh5ycfLqODGuKyJreBA+04nIw
         JffXrSD4cL61Zr+pY2uTdWl5sTfnD6MBotAFqV7O8rBy8KKcowZiSJc4cSdB4tZopM2t
         2kJ0a+qI4M0R+mKP+VDiDns+QBwtJPgG8ZABvdyBa+fMWO1eTsFWa16Zhvt7pJxmqbNa
         hxCg==
X-Gm-Message-State: AC+VfDwU1Bnu0GtMcWrOnpQCRIF+7iazXB/Q93ZNVDwdX97jQ3ne91ti
        BuRxOs1mHLPOf9d/QI8WEso=
X-Google-Smtp-Source: ACHHUZ6DMiSR25XbJbofCxNl9QPjnNHKwApvf7DZTCCtQSkAMAHxR3bgR0K89dq9nv2sHlWBjLlKCg==
X-Received: by 2002:a17:902:e5ca:b0:1ac:4fb3:1693 with SMTP id u10-20020a170902e5ca00b001ac4fb31693mr25496669plf.52.1683834863744;
        Thu, 11 May 2023 12:54:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709027c9300b001a1b66af22fsm6310698pll.62.2023.05.11.12.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:54:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 3/4] revision: modify ref_exclusions to handle
 inclusions
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
        <0a0693ad612755e675861dfa5a660baf8d325ed0.1683828635.git.gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 12:54:23 -0700
In-Reply-To: <0a0693ad612755e675861dfa5a660baf8d325ed0.1683828635.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 11 May 2023 18:10:33
        +0000")
Message-ID: <xmqqfs82ve34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int ref_matched(const char *path,
> +		       const struct string_list *l,
> +		       const struct string_list *hidden_refs)
>  {
>  	const char *stripped_path = strip_namespace(path);
>  	struct string_list_item *item;
>  
> -	for_each_string_list_item(item, &exclusions->excluded_refs) {
> +	for_each_string_list_item(item, l) {
>  		if (!wildmatch(item->string, path, 0))
>  			return 1;
>  	}
>  
> -	if (ref_is_hidden(stripped_path, path, &exclusions->hidden_refs))
> +	if (ref_is_hidden(stripped_path, path, hidden_refs))
>  		return 1;
>  
>  	return 0;
>  }
>
> -void init_ref_exclusions(struct ref_exclusions *exclusions)
> +int ref_excluded(const struct ref_visibility *visibility, const char *path)
>  {
> -	struct ref_exclusions blank = REF_EXCLUSIONS_INIT;
> -	memcpy(exclusions, &blank, sizeof(*exclusions));
> +	return ref_matched(path, &visibility->excluded_refs, &visibility->hidden_refs);
>  }
>  
> -void clear_ref_exclusions(struct ref_exclusions *exclusions)
> +int ref_included(const struct ref_visibility *visibility, const char *path)
>  {
> -	string_list_clear(&exclusions->excluded_refs, 0);
> -	string_list_clear(&exclusions->hidden_refs, 0);
> -	exclusions->hidden_refs_configured = 0;
> +	return ref_matched(path, &visibility->included_refs, &visibility->hidden_refs);
>  }

It is unexpected that we do "hidden" inside ref_matched().  I would
have expected that no matter what exclusion or inclusion patterns
say, hidden things are to be kept hidden.  I.e.  I expected

 - ref_matched(), which takes a path and a list of patterns, checks
   if the path matches any of the given patterns;

 - ref_excluded(), whcih takes a path and a visibility, asks
   ref_matched() if the path matches visibility->excluded_refs and
   relays its answer to the caller.

 - ref_included(), which takes a path and a visibility, asks
   ref_matched() if the path matches visibility->included_refs and
   relays its answer to the caller.

 - ref_visibility(), which takes a path and a visibility, goes
   through the following sequence:

   - if ref_is_hidden() says that the path is hidden, it is not
     visible;

   - if ref_excluded() says the path is excluded, it is not visible;

   - if ref_included() says the path is included, it is visible;

   - if none of the above triggers, the fate of the path is
     determined by some default logic.

or something along that line.  That would also allow us to avoid
having to call ref_is_hidden() more than once when we need to check
both inclusion and exclusion list.

But perhaps I am missing some requirements to be taken into
account, so let me read on.

To be honest, I didn't expect the "exclusions can be extended",
which I alluded to as a future, possible, follow-on work, to be
included as a part of this topic.  I appreciate your going an extra
mile, but I am not sure if it was a good change in the context of
this series.  With this patch, it is not trivial to even validate
that there is no behaviour change to any users of "struct
ref_exclusions" when the included_refs list is empty, which is an
absolute must to avoid regressions.

