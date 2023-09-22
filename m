Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D8CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 21:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIVVbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIVVbk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 17:31:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E72199B
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:31:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50337b43ee6so4647749e87.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695418265; x=1696023065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrhCFcW/GaEUaMvoR4tqQygbfsB9HddLfdIeQiF5UQk=;
        b=aaynuEsgpUr4YCw6OV05t5SCM0N1ixRryvAn8Uvt6uz1U2vamCXd1UoxpiPyOrNLh/
         ykMMFgHXxHtZetty6wYC0a28EsRnTuHnmJmcfhh/H9+VUe2wmXqxFQZislqx/f9oOOBS
         PZFb1TK7ZAeWAM5cRhQ4/seYFlJ5iuFkk6AWYI8Tyw/81Vwfrio/NTQV8z7Zmkobmpaw
         Mw657/4NusEU9a0U7KErfo+xy21j/4IR9AmZjHIyg3DsvVsAKogZARVfDTxq5SkELUGq
         IzWU16IhGQISTDEibiGkH33tQkOVYSrofl3zVixKVoLR6x2XnWCtwhHkpIjlFiTsB2R4
         UpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695418265; x=1696023065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrhCFcW/GaEUaMvoR4tqQygbfsB9HddLfdIeQiF5UQk=;
        b=jiIJ4dXjbWXUtYYjRQGxcy8wzebQsgFxMCPyBd33t3zfaoc1NDKpqy19F+7LSD7D5n
         wff8jVlNPO0MkRrGuxryODhDT9p6hDXuWoHgEM13n/PDDm0z4ncreue8KHL1wG7TEjPP
         pY2q6ekTPmuGz3pFAgcmJSKaU5vWqOOTIaLyfj2Wp2QYxJIsQ7/Kz3L2vFj+ZCpR/FCH
         C6Wtcln5Piwou7YU4OwUtn6vOSFoBa+bN6kvhZs6Am3RJcIc0iv7pBhYKvVb4LSJrlTA
         YpI4Eufbuy9ZJCJqQ4s+OxN8HyPJCLK1zT5/iT6Sbq27x4saSuZS/SelDzKzL9Jitijl
         2BnA==
X-Gm-Message-State: AOJu0YzMDAI1xBvhMVuTulwB2d98djwnPRV3Se1U5hvTkEIK/6Y0APq/
        Q/nj1IHo5EHg8sW7IBznxC5ifMPOd6BhLYAUDJ0=
X-Google-Smtp-Source: AGHT+IFTGFicdoOgTFRflOvlTpzxG9wUJgM1aKppx2p0jxMOCWJOJxmMe0NBPk0Ozf8IiJx8uNIcf5RNl2iIfs1Fxz4=
X-Received: by 2002:ac2:4da8:0:b0:4f8:7781:9870 with SMTP id
 h8-20020ac24da8000000b004f877819870mr399923lfe.60.1695418264969; Fri, 22 Sep
 2023 14:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
 <CAPig+cRc49GCr+z+LA65VFS8RTaOEkKe8KszQOUhFPxZGQ_QmQ@mail.gmail.com>
In-Reply-To: <CAPig+cRc49GCr+z+LA65VFS8RTaOEkKe8KszQOUhFPxZGQ_QmQ@mail.gmail.com>
From:   Josh Soref <jsoref@gmail.com>
Date:   Fri, 22 Sep 2023 17:30:53 -0400
Message-ID: <CACZqfqC_UwSPfn0f9L4TfkYDGU64t_en6=7wYMsnxA9fB2rSjw@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: update links to current pages
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> > doc: update links to current pages
> > @@ -4,7 +4,7 @@
> > - * [2] http://json.org/
> > + * [2] https://www.json.org/
>
> Not sure why this change is needed considering that the simpler
> s/http/https/ seems sufficient.

This is because that's their preference:

```sh
% curl -s http://json.org/|grep REFRESH
<meta HTTP-EQUIV="REFRESH" content="0;
url=https://www.JSON.org/json-en.html"></head>
```

It's somewhat traditional to respect sites' self-identification.
