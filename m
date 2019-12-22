Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC96C2D0C3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36FF206D3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 00:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="EPvsSh5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLVAoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 19:44:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56028 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLVAoX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 19:44:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so5804435pjz.5
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 16:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=BKLth09zHfdxlRA983Q9p2YuncyVHShDzkuavgvvDEQ=;
        b=EPvsSh5N2+kcl+a6U92eympJHn9Sbo43OGgSslTbck7fBcw85ODl3PUTgPiUlX1Tut
         PR3EwNffRJl+XMXkDWf21eZ2JKCIT+XZ5ym0sD8vtOrsaAVd71moS1PcCIqlLfNBlWqd
         MCyrUY3MX5ug29rG4+ZDuDf4DtSSocD1W0E7Uz/VaEaJ+PLkuMAONrXxpctfAhn52v+D
         ftMXBeq2ghmfp3GqZbWdeko7p/Q07jE1j+vfz5FJY4RhaPpWAiMYbSY+kXlqoXQfM3qX
         EZaZZULmsSn/btkgrI5pBjbMg/abN8OIKlJu9LxIblGViWxIcrlYgwitWSLpNKIe2pIs
         9ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BKLth09zHfdxlRA983Q9p2YuncyVHShDzkuavgvvDEQ=;
        b=DtyLLHBY72mj+e3gdFMcMV/4wc5MY3i3GNha+i6kfT4qxvjTfvW2C7Z+UqgY0E4Jgu
         F+Gv31bO/Wr+ywrLePHcZyfmCvOb1PHGdafU/tS+1GHRu3qIGWG1My30gY0npBztHo5C
         aBEw4kUIUijw3IZ/Kt4DvT9zGD76TmMESowiPCQTYJDUxY4xx6TDOBEqByHu8vqhmqEH
         uBuTbrnSgFU4fCCTQeMqriTJlR7Uiw44tU474eznOfWzwgDjP5DsLaadyH2WrEmacxHS
         MLMlqyzbKLG025nfidYD3kMJzyRbLpH1dHm+aYZvmHuro817Nk3tQ0RbeUrggXZ8ftLh
         ULPA==
X-Gm-Message-State: APjAAAU5I2fjjXpiSSSGas2o/yaYLgjEPY5V8KIp+hayc7lsu62RDD9O
        L0KMSAwliQOleJT9ByO2HrkuL3+r+Xw=
X-Google-Smtp-Source: APXvYqylW9Hq9yQBLuzJYxyPTfIGDJi+wJEBGj1TEthscxfPJMZWJ6pJv9JHQWXxnQFqPgmIqA+xJA==
X-Received: by 2002:a17:902:ac90:: with SMTP id h16mr22220486plr.164.1576975462710;
        Sat, 21 Dec 2019 16:44:22 -0800 (PST)
Received: from localhost ([203.144.80.234])
        by smtp.gmail.com with ESMTPSA id u18sm17229301pgn.9.2019.12.21.16.44.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 16:44:22 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] gpg-interface: add minTrustLevel as a configuration option
In-Reply-To: <20191222003123.10555-1-hji@dyntopia.com>
References: <20191219000140.9056-1-hji@dyntopia.com> <20191222003123.10555-1-hji@dyntopia.com>
Date:   Sun, 22 Dec 2019 00:44:15 +0000
Message-ID: <87lfr5kx40.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 22 2019, Hans Jerry Illikainen wrote:
> Changes since v1:
> * Fixed compatibility with gpg1 in parse_gpg_output().  One significant
>   difference between gpg1 and gpg2 is that the trust levels above
>   TRUST_NEVER are written without any additional space-separated
>   information in gpg1 [3].  This broke the logic in the previous
>   iterations, because the end of the TRUST_ string were searched for by
>   looking for a space character.  Now a new-line is used as a fallback.

[3] https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS;h=de0f21ccba60c3037c2a155156202df1cd098507;hb=refs/heads/STABLE-BRANCH-1-4#l286

(missed reference in the cover letter)

-- 
hji
