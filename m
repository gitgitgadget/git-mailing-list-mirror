Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAD1C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351666AbiCXQ0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351675AbiCXQ0D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:26:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26C6D841
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:24:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yy13so10252004ejb.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9HfZ/iAiIDDGlObHugsKHGKMHvvHcLwxDWKj7tA0mEA=;
        b=bjeUDXDtRq/GclVoREyJuDF7E8jELkHaoXtx0VXshnysAXM2tgacsL4YE4wRDXHFjj
         Pbcz+5ZrhOS8HmIJ16L+V74z3+G57zQuM9T2HXDzLw3oPAM+32jYXZoEsrWlBKUR3MFE
         ANSNTKJVs0SJ8QVBfIaN8cmMX4rKEBI3ZJbgcgO9jX5fEA54FUI15uw1AIE6v2Ds68He
         aJvePGTGL7R8pO3Jn06lTwvtk1O6OMlAZ6wZ7UcVcjml/bD6f5mDxK66IaClAFpVGZDL
         zE6Osi9tfFFiafaJPoBNh6qvhsIwBg/Ij0nYx9Ju/7LWZ9VZ7Ynv42kbT6ueddOjRu06
         RcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9HfZ/iAiIDDGlObHugsKHGKMHvvHcLwxDWKj7tA0mEA=;
        b=lcAIrv1HGz3fC7NgSouMcLRSi5c1G3sD+nKL/+bbGsYBMmnlDJCYbe2b1QP8w/nQyh
         uyPX+DwFCyNef6X4XaouMUPBTNps27iPxnA8G0Mln2rIIdfBCMWeWkGWIun5+TqYjbzs
         jTrXznebEOLCfY9w18t0HDO84tIl8XXD7cFrLhMBskLSz+SZekvBi/uDtli97QHMU5Gc
         X1A11xd4yNVvHlQEviA/q5nGTQxb6GxkMyxlEZgg5FQxcUGmkSP7xXg2bLz1ACLGxvs9
         zpWQHaph0XSjuvYcfD7rQiwqnNgW1FvoLpHUYz/YhpRLNv0yBXZHE32190/7m3z4d/lT
         Tyqg==
X-Gm-Message-State: AOAM533oWlJODCV6eSI5RZGx7JvXPkfEyUWPdfgrD0z4TFoHnziikNrO
        08ljkvkQWH48yaFLApzc7M6BL6L7ajtaBg==
X-Google-Smtp-Source: ABdhPJxSJV4rFOcZ6aJdI2kcoISyoSbIc0EKrm/psNVjr6LvSb5LWs18KYqtLvPr6F6hGwtWSlQfnA==
X-Received: by 2002:a17:907:9602:b0:6df:e82c:f84 with SMTP id gb2-20020a170907960200b006dfe82c0f84mr6642522ejc.590.1648139068371;
        Thu, 24 Mar 2022 09:24:28 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm1634428edm.90.2022.03.24.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:24:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQGB-001hlu-B8;
        Thu, 24 Mar 2022 17:24:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 01/11] bulk-checkin: rebrand plug/unplug APIs as 'odb
 transactions'
Date:   Thu, 24 Mar 2022 17:10:24 +0100
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <53261f0099d53524155464fe79d10f9605fe93aa.1648097906.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <53261f0099d53524155464fe79d10f9605fe93aa.1648097906.git.gitgitgadget@gmail.com>
Message-ID: <220324.86y20zmi84.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Make it clearer in the naming and documentation of the plug_bulk_checkin
> and unplug_bulk_checkin APIs that they can be thought of as
> a "transaction" to optimize operations on the object database.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  builtin/add.c  |  4 ++--
>  bulk-checkin.c |  4 ++--
>  bulk-checkin.h | 14 ++++++++++++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 3ffb86a4338..9bf37ceae8e 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -670,7 +670,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		string_list_clear(&only_match_skip_worktree, 0);
>  	}
>  
> -	plug_bulk_checkin();
> +	begin_odb_transaction();
>  
>  	if (add_renormalize)
>  		exit_status |= renormalize_tracked_files(&pathspec, flags);
> @@ -682,7 +682,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  
>  	if (chmod_arg && pathspec.nr)
>  		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
> -	unplug_bulk_checkin();
> +	end_odb_transaction();

Aside from anything else we've (dis)agreed on, I found this part really
odd when hacking on my RFC-on-top, i.e. originally I (wrongly) thought
the plug_bulk_checkin() was something that originated with this series
which adds the "bulk" mode.

But no, on second inspection it's a thing Junio added a long time ago so
that in this case we "stream to N pack" where we'd otherwise add N loose
objects.

Which, and I think Junio brought this up in an earlier round, but I
didn't fully understand that at the time makes this whole thing quite
odd to me.

So first, shouldn't we add this begin_odb_transaction() as a new thing?
I.e. surely wanting to do that object target redirection within a given
begin/end "scope" should be orthagonal to how fsync() happens within
that "scope", though in this case that happens to correspond.

And secondly, per the commit message and comment when it was added in
(568508e7657 (bulk-checkin: replace fast-import based implementation,
2011-10-28)) is it something we need *for that purpose* with the series
to unpack-objects without malloc()ing the size of the blob[1].

And, if so and orthagonal to that: If we know how to either stream N
objects to a PACK (as fast-import does), *and* we now (or SOON) know how
to stream loose objects without using size(blob) amounts of memory,
doesn't the "optimize fsync()" rather want to make use of the
stream-to-pack approach?

I.e. have you tried for the caseses where we create say 1k objects for
"git stash" tried to stream those to a pack? How does that compare (both
with/without the fsync changes).

I.e. I do worry (also per [2]) that while the whole "bulk fsync" is neat
(and I think can use it in either case, to defer object syncs until the
"index" or "ref" sync, as my RFC does) I worry that we're adding a bunch
of configuration and complexity for something that:

 1. Ultimately isn't all that important, as already for part of it we
    can mostly configure it away. I.e. "git-unpack-objects" v.s. writing
    a pack, cf. transfer.unpackLimit)
 2. We don't have #1 for "add" and "update-index", but if we stream to
    packs there is there any remaining benefit in practice?

1. https://lore.kernel.org/git/cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com/
2. https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.com/
