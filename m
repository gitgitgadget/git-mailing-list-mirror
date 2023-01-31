Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C094C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 09:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjAaJQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 04:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjAaJOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 04:14:25 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C97C1725
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 01:12:07 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id u8so6217261ilq.13
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 01:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBXbdhA9Hhi+FYzS9loB1hRgLJNC6DlwsebtMLDJYpw=;
        b=Tgn8VIAJUqfcsE3wIQfyfw/eZL+Y6O9lBwyVKRkUKp9gg3nMiAxAUlre6ZooBXVVzf
         XajNtzWWGN4Ax7VdWC6Xz1GQQDOkmOly4JYbo6+LoLRyBH1h1/cfGuZ//nEGTKplt172
         FHeO6HYkTO3iqZ4Y3nuFe2AFimmYBrso6xOE2k5qInOtntbKwx9zBPq/dCVnfDu3p46c
         Qn+yEUwgnhY/9J5AcgYRcF6IFFfpe/WcarPD9kK5Bxhk9uT5mto1lhlGrhghQE+uffmE
         UoSA9ZC55GteFRs5lzqcr9xkRIaE97uuOllpQxKRh8SC+hmafMu869KZCxXS7DNB7ODO
         cpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBXbdhA9Hhi+FYzS9loB1hRgLJNC6DlwsebtMLDJYpw=;
        b=C/E/wIxXWEbjdFyQ9+RiIw0x7zg3bIDmBWhFwoWwI9o5EbXggb7nc/JjDKMVQUKXVB
         b8WY4ype0NUirKo96iLLrRkc1vvF1aXQ69/RPkGnIzBI3N6Hdk/fwpJ7vtMICCewJ56t
         AbrmkqcsFyK39NTVloDsqpfJ3VhGtMh+rITBz/UzXcVbkCI3AE3fDCWc9H5jvPfLuim+
         XzYpqI8RUv/PUjQgNlR8ZkKkvxL30oOSosnLY+LksiIgmbGrh1XwUu+2/Me1y8qPI7+c
         goI79goUjgfRaySSVZA+jTd5+Srck36tN9cComspk2OltjUwkNOyu6ieaaW5vRrfCiQE
         XfLQ==
X-Gm-Message-State: AO0yUKVV5cZucRqWuHggrTTeWZUFsDmiOz7JAIEemV+TtvZYKFTkYuK2
        DnpIVEqzICb8rtw4Abx1vr0=
X-Google-Smtp-Source: AK7set9SabuI9f8qOiVUHK9tWtlCIPwrK4LwEOltK5bxxY3+R7AWEBolCtTEl0V2EJ+YdiF/vkVbVg==
X-Received: by 2002:a92:7a05:0:b0:310:d7d2:548 with SMTP id v5-20020a927a05000000b00310d7d20548mr8333685ilc.31.1675156317049;
        Tue, 31 Jan 2023 01:11:57 -0800 (PST)
Received: from [192.168.1.72] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id i2-20020a026002000000b00375147442f3sm5599521jac.16.2023.01.31.01.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:11:56 -0800 (PST)
Message-ID: <fd39ed5f-cee4-0d60-c0c2-fae18246fb53@gmail.com>
Date:   Tue, 31 Jan 2023 04:11:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
Content-Language: en-US-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
From:   Eli Schwartz <eschwartz93@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quick response for now...

On 1/31/23 2:49 AM, Ævar Arnfjörð Bjarmason wrote:
> So first, aside from whatever the git project does about the default,
> have you tried running the newer git version with a
> tar.tgz.command='gzip -cn' and seeing if it's compatible with the old
> version?
> 
> It's unclear from the blog post's "we are reverting this change for now"
> whether that meant a revert of the git version (probably), or a revert
> back to using gzip(1).


I do not know which one Github internally did, but I can confirm that
the gzipped tarballs which github started shipping, when gunzipped,
produced an uncompressed tarball that was byte-identical to uncompressed
editions of the historic ones.

i.e. you could do this:

```
wget ${important_archive_release}

gzip -dc < ${important_archive_localfile} | gzip -cn >
${important_archive_localfile}.new
```

And:
- they have different checksums
- the .new file has reverted to the same checksum as historic versions
  from last year that are frozen into manifests

That was part of my original investigation, before I located the public
conversations.


-- 
Eli Schwartz
