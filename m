Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16517C433FE
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 05:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiAOFRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 00:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiAOFRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 00:17:38 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220FC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 21:17:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id k15so41458911edk.13
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZArvW2eiLuVBfMgt2P0SzI86NAxrqnvONKCyidoDgA=;
        b=YISX6iOLyD/AZZW5px/lX+a/iIPMlXI9MFz2bHxx+wUARK24F67H2tEG5/O4lR5AMo
         mMNXqDc+3OxzU9dE6oLKEVa0Q8HvKTyuLhPC5YB+Zs1RwBlOU3x8mAWKrQnrgAmCgiGV
         4FJ2UrHD5Q1zzqvyf5zs0w/eIo0wKmirB2CNqJOIRixdguGmvLzTZGrKDbDFgEvbrmhi
         1sAiW5GRheDr4L7iZLjMQEw0ydkZsioER5HDVjbsKZBEOSkEtuMgxTe/A9Fj3cqU/PGY
         34kPjU+OKpMYhaT5keHfp8HmnLdtyETAjo68Nzt9/tPig0PP6VWAHUsOIhVJempzQ97+
         rfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZArvW2eiLuVBfMgt2P0SzI86NAxrqnvONKCyidoDgA=;
        b=AN92WH2N0bAaqlTmSpCE1J7QjEg9uKMyEg8LvOjtwn1+ijRpKJDjNvQHyFw5XqO4X8
         O2NIzWbc+QO3AHlazb4Ul/22muLoDTRNQEHscIHl6lOzjdO8M6n7UdWmBLaD91sNUhCY
         REZ0J/gk9TGyPKR9v4jNpnbZYvI7OIRj3CiQEqzLOmAz446GGJLEyez2iWxgwo2y/+c1
         AioqRP+vaqQzggYul+Ieg9ocl0KOGaZSfYIGF0EEV6RWhXbnwBgQuC0r00d6YBbHv0Q9
         8GVyWRf/+pbksgBNRetKvAH9sGTwDrGRUH89fWlknS3eolQRKh4nts0aywrvOxxL96xR
         5F6Q==
X-Gm-Message-State: AOAM533HFzXFquvhQj4hYywFSEwbYOH9ANbsug7TG9VWhoVF7a8CMWye
        L8TIor2iLUhfdQNCemzumY1oLfBN3nI/I/vxqM8=
X-Google-Smtp-Source: ABdhPJxKZgtbLzDRCpnS/mL9yCOeBjjHF+1k1t4YYrdIVxdxLVECllPRv+Bwt2zNajuKLeo2Oz/ApiCtwKc/A0BdZwM=
X-Received: by 2002:a17:906:175b:: with SMTP id d27mr9833505eje.476.1642223856498;
 Fri, 14 Jan 2022 21:17:36 -0800 (PST)
MIME-Version: 1.0
References: <11860e44-beff-39e6-2efc-53324223caee@gmail.com>
In-Reply-To: <11860e44-beff-39e6-2efc-53324223caee@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Jan 2022 21:17:25 -0800
Message-ID: <CABPp-BFY2issEqOj1Oj71k=494vc8E563CndxPZfXYrteFoNhw@mail.gmail.com>
Subject: Re: A new feature command request `cmd_ignore`
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 3:03 PM Jaydeep Das <jaydeepjd.8914@gmail.com> wrote:
>
> Generally, To ignore files from a repository, we just have to add the
> file name in `.gitignore`. But this task becomes a bit
> tedious when there are a lot of unstaged files which you want to ignore.

'unstaged' implies the file is tracked (i.e. previously added), but
has local changes.  I think you mean 'untracked' here.

> `git ignore [file names]`
>
> would add that file to `.gitignore`

If there are lots of untracked files, why is it less tedious to type
all of them on the command line, then to type all of them in the
.gitignore file?  I don't see what effort is being saved.

> and other parameters like `--force`
> could be added which would delete that file cache if that
> file was already committed.

I don't understand what you mean by this.
