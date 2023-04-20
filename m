Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E610C7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjDTVdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 17:33:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5230D2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 14:33:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a50cb65c92so14282635ad.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682026397; x=1684618397;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln1d2Bohtw6iovttYofcABggfXYol8WvsZIasHEMcWo=;
        b=GESlbDiUMO+9IyaIhXaoVkSmoBLzSiIuadunOiGxt1Ar5rZBvsYstOpnPUHfbQK1MH
         vVDyHfo1DDRtNTzm64NCXG0LiU/GS6Yqc4wWBqdbJvWtKIVB8KUNM5al2ks9W7l5m6BA
         I7U+qe6KmE4XLKJV1tnVZMuBN956H21BvqT17VMb7kZguOXmFxMfZkg7hMzkyO4mR5iQ
         qqTNtfL6CbPNVE4b0MCOLqW0pTGtA4OFdOZuJrMVaCwkMk20iYmH+dS53TmkMz/CKNvh
         yA9YdomOE9v2j70KTQjUNZ41vO6XOzSpz+kQdi8J9E9LaFcJQXwDFJEDtAQjiGyoK1zY
         a9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682026397; x=1684618397;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln1d2Bohtw6iovttYofcABggfXYol8WvsZIasHEMcWo=;
        b=daiE/57ettdv93Mps+5HW0QKxf9ftHbRVitQudbMncTZ1iESyj/Oav0qiV5ZzCrDAo
         UzYKUyjzibLAZKioa2bV8KIbwAYWKkbww+zdzUmaX+Iqha9RTk60DEaBXKsNihEqK3SO
         61oW8fZU7gXtDvwqFvq3iOYtFU0/zHenhdDoYJWOMGeNKYrPNfothxWIRvITMzQK/hD2
         qT+nQ3zDoxM7HnYlxS3M+NwMNZwzQti9SYwRa8BdOKlpJkECvFEkcixnfEbAwoENyhH4
         46JgpfO+pEZZX5wFSMKeMYg/WGxGpAV1SnR2wx31TVqXY071X3xxt/tYtKUzqaatcIME
         Ft7g==
X-Gm-Message-State: AAQBX9f5TUsCTFsRFtUjVFHoeYlb4fjRUo1motEi9Ykzp+lcD3wFjnEV
        UMdszUNZZ0zhDQMpaRrrMCgPe26WcK0=
X-Google-Smtp-Source: AKy350b0JcAhIw/VhLircPLmfFJxgyFpQp8M/7pLTiQVVl5fITxJ2w7amYkLxVd0rZggZ2/Uto883Q==
X-Received: by 2002:a17:902:f105:b0:19e:7a2c:78a7 with SMTP id e5-20020a170902f10500b0019e7a2c78a7mr2434686plb.57.1682026397464;
        Thu, 20 Apr 2023 14:33:17 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b001a6d781eda6sm1557813pla.120.2023.04.20.14.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 14:33:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] gittutorial: wrap literal examples in backticks
References: <cover.1681579244.git.martin.agren@gmail.com>
        <280c7d18b99e7cfc882d0dad0de536d4f40d4338.1681579244.git.martin.agren@gmail.com>
Date:   Thu, 20 Apr 2023 14:33:16 -0700
In-Reply-To: <280c7d18b99e7cfc882d0dad0de536d4f40d4338.1681579244.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 15 Apr 2023 19:29:11
 +0200")
Message-ID: <xmqqedoexmqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> Our coding guidelines prefer literal examples to be wrapped in
> `backticks` to typeset them in monospace.

True.

Everything I saw in this patch looked reasonable.  Except for one
minor thing that I found a bit iffy.

>  ------------------------------------------------
>  alice$ cd /home/alice/project
>  alice$ git pull /home/bob/myrepo master
>  ------------------------------------------------
>  
> -This merges the changes from Bob's "master" branch into Alice's
> +This merges the changes from Bob's `master` branch into Alice's
>  current branch.  If Alice has made her own changes in the meantime,
>  then she may need to manually fix any conflicts.
>  
> -The "pull" command thus performs two operations: it fetches changes
> +The `pull` command thus performs two operations: it fetches changes
>  from a remote branch, then merges them into the current branch.

We use the name of an operation (e.g. "pull", "fetch", ...)  to
refer to a specific command name and also as a general concept.  The
former should be in `pair of backticks`, but not the latter.
Unfortunately, there is no bright line between the two.

It is OK to say that this "pull" refers to the command line we see
above, i.e. "git pull", but ...

>  Note that in general, Alice would want her local changes committed before
> -initiating this "pull".  If Bob's work conflicts with what Alice did since
> +initiating this `pull`.  If Bob's work conflicts with what Alice did since

... it is unclear if this one should be taken as a "literal
example".  It may flow more naturally if we take it as the name of
general concept of one operation, as ...

>  their histories forked, Alice will use her working tree and the index to
>  resolve conflicts, and existing local changes will interfere with the
>  conflict resolution process (Git will still perform the fetch but will
>  refuse to merge -- Alice will have to get rid of her local changes in

... it contrasts with the "fetch" operation and the "merge"
operation referred to here a bit better, it seems.  The same for the
reference of `fetch` in the next paragraph.

>  some way and pull again when this happens).
>  
> -Alice can peek at what Bob did without merging first, using the "fetch"
> +Alice can peek at what Bob did without merging first, using the `fetch`
>  command; this allows Alice to inspect what Bob did, using a special
> -symbol "FETCH_HEAD", in order to determine if he has anything worth
> +symbol `FETCH_HEAD`, in order to determine if he has anything worth
>  pulling, like this:

But as I said, it is quite minor and I am not even convinced it is
wrong, so let's take the whole thing as is and merge it down.

Thanks.
