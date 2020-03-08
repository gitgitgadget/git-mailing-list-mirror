Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B53DC10DCE
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 21:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E5220684
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 21:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+682SmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCHViP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:38:15 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:45903 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHViO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 17:38:14 -0400
Received: by mail-ua1-f42.google.com with SMTP id q17so2597794uao.12
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mHBq2DQdoOLeDF3kop0lrw720NyiLOvtoWfXAEMGiLY=;
        b=e+682SmJw86QyB0EcHTYj+jHCdGfYH50pTsNNu0CW84/a6Ww614w0F/2lVtLRh0bs7
         DAogJDjCQFzLJrCIjFsjnrSdthTzHaW5wffcvuKWl6HEAoAXFl3pVnf/u+YhbexV5jCh
         odFdJud/BZ0m6m0m6kuVNXnYPZCXQgTKG14zKGEoKxYORD5A7nR0kPoDgdLuSwYsBJUO
         4qOksOXFOC4m2NYWYucYY7U8b2qYYgQMRy/OOgeXkEbNmmHI+/f4jKmYUJPoaVyzXEaF
         joMFaGqynQK7QiEEtYb6Zkcd7TvbuhU9Y5lzbYMimzfJvsmxnBPaOxrjBPlDZ+DXANxZ
         LlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mHBq2DQdoOLeDF3kop0lrw720NyiLOvtoWfXAEMGiLY=;
        b=HmACkMpBioeEv+NbWVI9/vbpx/+/vysYi32OzcfJfIacYbibGoSmonlgNnDN8oet8D
         qpdCjZwn0uKqbvX6JlV1ge6EsxZOiwLM+KrE1B3lyyyYgFsdkAb8QDp5n0fG84JxOdtm
         56ZcW9Q+BxiMikKPc5JtI5lPwCW+uFD5Bn/MSkFY+oFFTH7XfSwdcsTZ6ozMb5CxxXBw
         i+s3qXZx/WBo26+yRkgw/c2lTQBz7ca64imkcU56rW0YUMpJ785G8iqDRKgK242vhjSV
         LIpXUoOJ3Go6RQvRQN2JBtsdn22ubz45OmOZBTmshUyd6PS8kYrJUNf7ZXPF1HEp93b3
         UuZA==
X-Gm-Message-State: ANhLgQ3HtGuRsQG6jRgq7+6Lvudtj3J7C+uidJvS7BeI5ghoZscWbkXV
        PCBCei2cUE5RV1Sb2ZPckXBJDHvc0DmB87lGGuiv7cih
X-Google-Smtp-Source: ADFU+vsgbYjoxYh14kmiMXqwuzOA+27rre4UNKyHRwxyKNmZ87gwz+hQYPYJA127AhmATJZflst9xn3SwbaWEMj/Pao=
X-Received: by 2002:ab0:c06:: with SMTP id a6mr6865624uak.119.1583703493287;
 Sun, 08 Mar 2020 14:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACDhn-QHqGFhZw+3K61v+Qtmm5y35nARWJaBkZ_YyZevJu8HBQ@mail.gmail.com>
In-Reply-To: <CACDhn-QHqGFhZw+3K61v+Qtmm5y35nARWJaBkZ_YyZevJu8HBQ@mail.gmail.com>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCi0YDQtdGC0YzRj9C6?= 
        <alextretyak2@gmail.com>
Date:   Mon, 9 Mar 2020 07:37:56 +1000
Message-ID: <CACDhn-R6ZKvgMxJdxP7NpsAViY97PfC7aM8xTJgaQK_GLJRyvQ@mail.gmail.com>
Subject: Re: Feature request: number of added and deleted lines for UTF-16 files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some source files in MSVC (e.g. resource.h) are encoded in UTF-16 (LE)
with Byte Order Mark (i.e. signature: FF FE for little-endian and FE
FF for big-endian), and `git diff --numstat` shows `-` in place of
number of added/removed lines, e.g.:
-       -       clientapp/resource.h

Can you auto detect UTF-16 by reading first 2 bytes of the file, and
correctly show number of lines added/removed?
