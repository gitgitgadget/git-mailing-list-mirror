Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86101C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 15:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjCHP4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjCHP4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 10:56:06 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6DC6402
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 07:55:09 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i19so2131984ila.10
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678290906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUiQyczypb1v2vk4ssTumOOBCPZRV7UbKKIuoXoNJVA=;
        b=HQZ12rh6B5XuPVc7HaYCqmqgJJxRYjYR3Nct+KyWAk71mty+TI9X9juO795g11DmNq
         JWhOyjgHnKnKLpwatUtIxKfpERCyQAk9JmjV/jYazjY7pRe3low3GPJ8GRv7VfgFqDM3
         lyJ2+JS9kWLjFgca3KdUDsC0eBEafDbIocldfaNUMyBJOxoLtph0/IhXH0uV/kvP+pEz
         ZZMnT2JlchwGvHfQD1aNTa0ElsueRKqRFVjACCFo8XlQPicWzMOQNqPzxHVyDi5eEbzh
         dQOw3pwuTDJyyBmlwegkt98pCnrHWZudio/cbxSjm3ZEd0tWeehJw1bb6vDtJGFyOVfn
         vvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUiQyczypb1v2vk4ssTumOOBCPZRV7UbKKIuoXoNJVA=;
        b=EHM2nvilx0fzjDfIzugJNh4jhpyn5pm6eH8qRnuBK2VO8j87kvOTe6HYevDo7QkYP4
         WiwWlg1NTAPA8YVUfrMy+R5YEmxHY0kLRPRKIot09fG/LJm1VURKEJ77BA1QiTxrtZW3
         5upgSQ7DJRjxH1qOorPKqJ6yTRn8qW1+S9l5cWBi/UwtDwDlPlYE5eS9ehcMazlUVjA8
         Z5cvtGfRxSk27VBsJyB+11V/3VqAhQS8wv/YKKimgCZPultr1xaFdAGt0BHlN90gUkFR
         8veTlyYINeEODBtcnyIfsZkHky3V9V6K21bpgAxa/KDrIn0H3gSvu4ZBXryzusZBhRiu
         8ZYA==
X-Gm-Message-State: AO0yUKVaodnvt/M3D1sq7FB0bU1FsLUHCACgbMVrx9fs1gyiHyYz8po2
        UsVFG1HArQ0QTLZDJ4F+/P1Row==
X-Google-Smtp-Source: AK7set+zh9XPBKYLD4aBWXCKssmJ4QW4Tq0JK90UDiyFk7iyW2hoYis7B1kPXuFSWnpTYG7CcXtQfA==
X-Received: by 2002:a92:c566:0:b0:319:23c7:5553 with SMTP id b6-20020a92c566000000b0031923c75553mr19223379ilj.32.1678290906128;
        Wed, 08 Mar 2023 07:55:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a22-20020a029996000000b003c505bdf305sm5124026jal.141.2023.03.08.07.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:55:05 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:55:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
Message-ID: <ZAiv2I17+/IBF8pl@nand.local>
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
 <xmqqy1o97apj.fsf@gitster.g>
 <ZAaFQJm6UGYH4YIi@nand.local>
 <901299ac-e543-b7e5-0a1a-c90e667a947d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <901299ac-e543-b7e5-0a1a-c90e667a947d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 07, 2023 at 09:52:19AM -0500, Derrick Stolee wrote:
> On 3/6/2023 7:28 PM, Taylor Blau wrote:
> > On Mon, Mar 06, 2023 at 02:54:00PM -0800, Junio C Hamano wrote:
> >> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >>> @@ -1008,6 +1008,7 @@ void reprepare_packed_git(struct repository *r)
> >>>  	struct object_directory *odb;
> >>>
> >>>  	obj_read_lock();
> >>> +	reprepare_alt_odb(r);
> >>>  	for (odb = r->objects->odb; odb; odb = odb->next)
> >>>  		odb_clear_loose_cache(odb);
> >>
> >> Hmph, if there was an old alternate ODB from which we took some
> >> loose object from and cached, and if that ODB no longer is on the
> >> updated alternate list, would we now fail to clear the loose objects
> >> cache for the ODB?  Or are we only prepared for seeing "more"
> >> alternates and assume no existing alternates go away?
> >
> > Based on my understanding of the patch, we are only prepared to see
> > "more" alternates, rather than some existing alternate going away.
> >
> > That being said, I am not certain that is how it works. Perhaps an
> > alternate "goes away", but does not actually get removed from the list
> > of alternate ODBs. If that's the case, any object lookup in that
> > now-missing ODB would fail, but any subsequent ODBs which were added
> > after calling reprepare_alt_odb() would succeed on that object lookup.
> >
> > So, I don't know. I don't have the implementation details of the
> > alternates ODB mechanism paged in enough to say for sure. Hopefully
> > Stolee can point us in the right direction.
>
> The prepare_alt_odb() call only _adds_ to the linked odb list. It
> will not remove any existing ODBs. Adding this reprepare_*() method
> makes it such that we can use the union of the alternates available
> across the lifetime of the process.

Right, that matches my understanding. What I am asking is: since we only
add ODBs to the list, what happens if we can no longer access an
*existing* alternate at the time we call reprepare_alt_odb()?

It's clear that that now-inaccessible alternate remains in our list of
alternate ODBs, but do all object lookups hitting that ODB fail-over to
the new ODB? I believe so, but it isn't totally clear to me.

Thanks,
Taylor
