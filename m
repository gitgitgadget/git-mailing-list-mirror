Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB01C3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLGBJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLGBJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:09:12 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753065B4
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:09:12 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q190so5813729iod.10
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MV+McKJS4blP1f5tdGjuvysEK3ck/qVf3BetLHeD6o=;
        b=TerTqEYiepw3dUvbbIQLSDPd98uZk4NLo7UhxOU9vcaAXzAQxmAvGBOn96XBN+lbxv
         QEHgEYdUre/Q/OO4J5Y+1Ct4XVsCGODCsx0xhvGsFfufKxJ82skvEyw4Sk41ZMjcFit/
         NEJ4/yVVr7kA90KtJQ1C3htlAQ8bbc/MITj4E04ObqY82Fbiod2/mJO9+iEpIpRIRRhl
         mswcxpWCnTKTZw3pjYJ81YcxnDnEDoNUG753Ww2GIBH4IVJONd4U3Qu0bhsZ9vcxoxHG
         C3VHkVhTXxhy88cC4m/L/QHLu1ec+zb7tJHEVkj4UzyPxzXb6l/pidCO7L8aCluIWDz+
         +FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MV+McKJS4blP1f5tdGjuvysEK3ck/qVf3BetLHeD6o=;
        b=kgVbyvdytnvU2mz6I5hoWV3w95kzx36V7saQirxWltQWeusSPSElJZLy72xRB+rL79
         N0fHXvv/xA1sjVmZCgHF3cJiCNBDYrh/OLGA6bl5bxFg95Gb2I6QUY1dsa28SbsMjBl9
         irR+88i/c2W1gveHe10RrsTTwBLR5CbO11FZTGYJG+EelYSk66hl1FpB27catW1uOTgx
         4AKglOnU06OHpfne82jLXF4Bb1t4AunqrZ2hCjj31tWD3q4n1Xx+zt9hy641xIjtWGdI
         DgbgnW4eCaM/tmIlV4/D7a0EE+ULb1Gq0JKU8neAWQZaMCm59jqX6ds2Z2vtSTRo9gPg
         hArA==
X-Gm-Message-State: ANoB5pl7sDJKKFAtlmKMfsgughErVa/7BK+QQUltOkDTcEbgoNWnm3j/
        1KIjWsakoTpIQtP2B4PbFlvsWA==
X-Google-Smtp-Source: AA0mqf4cNSNqS4+q0HmsGflOAmBfIM6kd93zd84iugaVSahmC5rkqozdu9On6XNxpyg3qoWUHxNxQg==
X-Received: by 2002:a5d:954c:0:b0:6e0:17f6:4c2a with SMTP id a12-20020a5d954c000000b006e017f64c2amr4193590ios.129.1670375351323;
        Tue, 06 Dec 2022 17:09:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d74-20020a02624d000000b00363e4730a41sm7314027jac.175.2022.12.06.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:09:10 -0800 (PST)
Date:   Tue, 6 Dec 2022 20:09:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH 0/2] check-attr: add support to work with revisions
Message-ID: <Y4/ntYotGKz2dx0E@nand.local>
References: <20221206103736.53909-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206103736.53909-1-karthik.188@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 11:37:34AM +0100, Karthik Nayak wrote:
> This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
> allows us to read gitattributes from the specified revision.

I haven't looked at the patches below yet, so take my $.02 with a grain
of salt, but I have definitely wished for something like this in the
past.

When scripting around to figure out which files at a given revision are
affected by a given attribute, I will often have to resort to writing
something like this when working in a bare repository:

  for repo in $LIST_OF_REPOS
  do
    export GIT_DIR="$repo"

    index="$(mktemp ...)"
		git read-tree --index-output="$index" HEAD 2>/dev/null || continue

    git ls-tree -rz --name-only HEAD |
    GIT_INDEX_FILE="$index" git check-attr --cached --stdin -z $attr |
    ruby -e '
      print $stdin.readlines.join.split("\0").
        each_slice(3).
        select { |path, _, val| val != "unspecified" && val != "unset" }.
        map(&:first).join("\0")
    '
  done

Which is just kind of gross.

I had at one point when writing the above script wished for a '--blob'
source option to check-attr. That might be sensible, but I think being
able to read from an arbitrary revision (looking at all of the relevant
.gitattributes file(s) recursively throughout the tree) is even more
useful, since it allows you to accurately construct the attributes state
in its entirety.

Anyway, my point is that I think that this is a useful feature, and one
that I (and I suspect other users, too) have wished for frequently in
the past.

Thanks,
Taylor
