Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F9C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 22:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHJWgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHJWgK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 18:36:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54BD273D
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:36:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-267f61da571so1884771a91.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691706968; x=1692311768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiB+09FwTKNm5GFgrJmb8PUywn+ZqhvnPLj/8SmKDHY=;
        b=NUCTOHpzjauZq483L/di8GPmZTahtbQo9iwwC4U6+e6y4xnMdQ2ZUXUM3fDhpSUb/C
         CHyX3Bk+T1wEObgjH2HP5rxfq6z3b7/WyY6KLNyM5HX//js/ApvYCjRxN0HfWcjFiUiv
         tVhTbgKL+84wbEcQERwDqsRdfqKLkDaeqyvVXeMpxwOCPdTO8PqTP+sXfgN8uipKPWYV
         wVGwBiFIlDKVd3dSPdAq1yKrdL5ppHS2JbbHGPmhb3yJUoMXKic9HFtb21FxNKi61v++
         u0VSTxh4ReUuYYxHvTCNNn34fkjK5S6TcZPN0BisKq7qRRxNfxGE5YDu7SYQfqPgxxev
         Jr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706968; x=1692311768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiB+09FwTKNm5GFgrJmb8PUywn+ZqhvnPLj/8SmKDHY=;
        b=K+7EvOMySbPnTjnz46zjdLtzfgI8rOaH2LdKS2VFziWFtHtpI/xePgyOsixzBFCLS+
         0Wmmo7GkpyzfDsCbd5FLHCcHmiO5MgwPACmdVaXPk4dS0tK74R1h4R+8mr2a3r+lGYPp
         Ws/JFSrvxitG3duBMtmU3CfuK3i0pY7wgzNrmq8An3lLjLG6DFitE1rNI3Zmlcg3ytSY
         U/N3mApB1eXAHJadA3gMmLqdZRAhekUhKuYklUolfPJX+ka4TJGpcbKZ6EDOnMycXcsX
         LuNE2MvfQgUNq+uyKfQRi0EGrjS5+PYB9PKRxKLDt2VpK1s6g7drUQSdSHzy5bcqjVq2
         wXCQ==
X-Gm-Message-State: AOJu0Yy91uoEjOKMouUvhp5PInpEC+rVcmS3qcBAQhXM5I/vz7PUJjKD
        mZrPODSCH6bk/4ypGkLW4OWxkt+8ggtRXg==
X-Google-Smtp-Source: AGHT+IGXCozmjdfTQjjtAa/fDCyxcbaL1burHGhXwYxH0UT8GkWj1MrcX9pl/SrR9DKoWz7r9CXDDTWioJ5TVw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ea87:b0:268:b599:92ff with SMTP
 id h7-20020a17090aea8700b00268b59992ffmr858258pjz.1.1691706968453; Thu, 10
 Aug 2023 15:36:08 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:36:06 -0700
In-Reply-To: <20230810163654.275023-2-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com> <20230810163654.275023-2-calvinwan@google.com>
Message-ID: <kl6ljzu28qzt.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2 2/7] object: move function to object.c
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> While remove_or_warn() is a simple ternary operator to call two other
> wrapper functions, it creates an unnecessary dependency to object.h in
> wrapper.c. Therefore move the function to object.[ch] where the concept
> of GITLINKs is first defined.

As Junio mentioned elsewhere, I think we need to establish that
wrapper.c should be free of Git-specific internals.

> diff --git a/object.c b/object.c
> index 60f954194f..cb29fcc304 100644
> --- a/object.c
> +++ b/object.c
> @@ -617,3 +617,8 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
>  	FREE_AND_NULL(o->object_state);
>  	FREE_AND_NULL(o->shallow_stat);
>  }
> +
> +int remove_or_warn(unsigned int mode, const char *file)
> +{
> +	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
> +}

Since this function really needs S_ISGITLINK (I tried to see if we could
just replace it with S_ISDIR and get the same behavior, but we can't),
this really is a Git-specific thing, so yes, this should be moved out of
wrapper.c.

Minor point: I think a better home might be entry.[ch], because those
files care about performing changes on the worktree based on the
Git-specific file modes in the index, whereas object.[ch] seems more
concerned about the format of objects.
