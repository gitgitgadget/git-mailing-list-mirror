Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4196CC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 19:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjB1TPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 14:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjB1TPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 14:15:35 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB53832E64
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 11:15:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z5so7003323ilq.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1677611722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ST6G7oDXIyPfJ0AC22WTfPmVEk9nzgSswFaAMbkDbYs=;
        b=oOe9T2Yi2IqxHUALFhigMDBay+DoB5jNL7eMR+T+7pZ9MKe6Mbw0FOEkqvcfeZ3PR4
         NcW4bFlGPMDf0tpgnOf8v/rQTYzEfLKKQLbTJ/K/Z7Z5QH6D3J80EpS/cH9l5paKjAPz
         8teiJsLyix7PAktgl6V9F2gM7hL9mVgpnnWKk0Rg/JKDDouxiZoO0+rLSoRGpAwWNlo0
         +zUCYK/U4hcV91RoZqdGULbfaqDjnDppg3r2SuN13QGEqYcMEflVg0rgh9t68Z8VFpkW
         Rpg2LL9NzPBg2UrFXbB0+7VrH+CWiKQc1B4/+fXKa6kqcfYHBVX6U/mGmno98INCpKR/
         JpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677611722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST6G7oDXIyPfJ0AC22WTfPmVEk9nzgSswFaAMbkDbYs=;
        b=A975XCDkzHEy4zZ2C7IR/RZE3NfzLCuB/1OBXZ+sD0E7YXQIUhmGS2TBOOf0VKcAxk
         1Q5M8T0STWIwcdqDEFrxsmMBqxa5bhI8ls6jSBmva/7LcT8z2LApxEN5YQ6kSVG3kxRo
         mhs4DZixW5bidzdXMP0MUCaL3WDoRGBAYKKnTnRJmZoRj7ZCUnguiEwCKVW6hgtUmWgH
         Bwc2bwzD0PqsAewTX2dhOrMyU3cCoIob/FEHfX4FyFLpOio7nRC+rmqO4rGB/xnB52D+
         jtI2dazlISVgBxusanWhRIHJtvuB/VR/Y2frANQ8KmwQKVtZqtDKmG0Y7NhkkaI8pwh8
         77Vw==
X-Gm-Message-State: AO0yUKXlVNqfOeRuEfz+ITWPulhSTDdh5JWSHL5hUZ0k0p0BF0UYl0n7
        l1fn9Lw/C0f0wmNBQ7evIFO3Oq6L6bjpcYSSxtc=
X-Google-Smtp-Source: AK7set8FmdUObB3kKHtr4SeEI07PhDNuSKGz9On9p9nTdgF4pOwkuFDYaYFZ+CeXjYVlP1qyxK9brA==
X-Received: by 2002:a05:6e02:12c9:b0:311:1168:b9b5 with SMTP id i9-20020a056e0212c900b003111168b9b5mr3759694ilm.23.1677611722032;
        Tue, 28 Feb 2023 11:15:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s2-20020a02c502000000b003c50d458389sm3273031jam.69.2023.02.28.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 11:15:21 -0800 (PST)
Date:   Tue, 28 Feb 2023 14:15:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Danny Smit <danny.smit.0@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: gitattributesLarge: .gitattributes too large to parse
Message-ID: <Y/5SyNUbVfKFMxsf@nand.local>
References: <CACoz=-x6kVGMq1oCq8-5k2Hb82DCqi94_EmX6w4_9uGXnwBLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACoz=-x6kVGMq1oCq8-5k2Hb82DCqi94_EmX6w4_9uGXnwBLaQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danny,

On Tue, Feb 28, 2023 at 05:09:01PM +0100, Danny Smit wrote:
> I couldn't find a lot of documentation about the size limitations of
> the .gitattributes file, but I did find the change that seems to have
> introduced it: https://github.com/git/git/commit/27ab4784d5c9e24345b9f5b443609cbe527c51f9
> The change describes that the file needs to be smaller than 100MB, which it is.

It's interesting that you can cause `fsck` to produce an error in the
bare repository but not in the non-bare one. Do you have
`fsck.gitattributesLarge` set to anything in the non-bare repository?
Are the affected objects in the `fsck.skipList`?

Looking at 27ab4784d5, the comment there says:

    if (!buf || size > ATTR_MAX_FILE_SIZE) {
      /*
       * A missing buffer here is a sign that the caller found the
       * blob too gigantic to load into memory. Let's just consider
       * that an error.
       */
      return report(options, oid, OBJ_BLOB,
                    FSCK_MSG_GITATTRIBUTES_LARGE,
                    ".gitattributes too large to parse");
    }

...so it's possible that the caller indeed found the blob too large to
load into memory, which would cause us to emit the ".gitattributes too
large to parse" fsck error without a .gitattributes file that actually
exceeds 100 MiB in size.

> The error seems to occur with git version 2.39.2 2.38.3, but not in
> 2.38.2.

Indeed, the change there 27ab4784d5 (fsck: implement checks for
gitattributes, 2022-12-01) exists in v2.38.3 and newer, as well as
v2.39.1 and newer. v2.38.2 was released before 27ab4784d5 existed.

> Is there a way to get rid of the message, without updating/deleting
> the file and having to rewrite the history in git?

You can suppress this message with:

    $ git config fsck.gitattributesLarge ignore

Thanks,
Taylor
