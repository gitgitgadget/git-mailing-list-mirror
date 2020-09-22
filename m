Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D0C4727D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBE82076E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 09:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJhZWO4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIVJfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVJfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 05:35:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2FC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 02:35:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so11924413pfk.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zr1DdhgcNBRq1kb5ivl8mRdf8sqIc0If0CiN0404pGI=;
        b=mJhZWO4K7fbYbxAsrQ5J1aIHx87agwFsd0ajfBkRxJfJEtKDhLGH8VYab9zRnIrqQx
         AgpLLjS7mjPOZGIyJ88+tyCH4xFFinGZHrGGtYH7tsBN5N++rNm0yfwesSfyjvx0T4O7
         R3aKkBuXO6c0F93bjG4C4lSSUL4/hMlUNvPk3+hJ2iNH6gO1N2+Ozjbk1apCaC2t2Dzn
         7OaRa/I6souLb/ChFQxRBZFs9LhJshzWdhrfrt9DJynDgLcRD1gGX9dLQp4PsDTxW8NH
         mnmgh7kvZvlc0IJ0JSU8oHSVsLuIcWidZPoDw8m/6NfVMfnN6w5imJb9FdUxm7w/OgGg
         ha8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zr1DdhgcNBRq1kb5ivl8mRdf8sqIc0If0CiN0404pGI=;
        b=YuI8+ht5xTKzjcNTTOzmL7DvjDXLYTFppAPmJEOI2jkVDMRgdrIa18CBeF+IFIbxjz
         5Z84gSewGG/U5ZR/Ioy58zaH5i+2UQMJISALZn+SHOb0kJ1wPdcNK9J3n80400417R5w
         lkk+Bt3TOgWD+hKtZn/ASFsjSEq5gSr5xU1DMZwlPocQebP2ZETLRuyIivDTxVnHcaWp
         YY5tZZA+OErdxJs7+OwX6NGk6FaaKAFb9IIWxfAxNmzTgJOnTz1pdfvHeVeT+hBuIRSD
         cnRdauK7tOmPo7n670nJjlZaQkU0I+QTLBO/WBhUIsPTcZMiRM9XCW2yWWAz12waV4Q9
         SjKg==
X-Gm-Message-State: AOAM530i5l+aOym59JTz4msAzdoTtnIFYl/YWcE7wXM9NstRxCTfWV9w
        z2vRWK/3/6fYyjZWr8yNq88YfkTVps0fPg==
X-Google-Smtp-Source: ABdhPJwWoeGpHgjMxC/Lsy+X241Np0zIOYxoYp0H7hBG+AFptDhIPurNo+gQj9iJlS4Kc0GLSs2Mcg==
X-Received: by 2002:a65:5bcf:: with SMTP id o15mr2794660pgr.126.1600767335372;
        Tue, 22 Sep 2020 02:35:35 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.85.248])
        by smtp.gmail.com with ESMTPSA id gb19sm1835329pjb.38.2020.09.22.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 02:35:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] Test case for checkout of added/deleted submodules in
 clones
To:     Luke Diamand <luke@diamand.org>
References: <20200921081537.15300-1-luke@diamand.org>
 <20200921081537.15300-2-luke@diamand.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Message-ID: <d1b6df73-e945-2ccf-129c-62add58e5747@gmail.com>
Date:   Tue, 22 Sep 2020 15:05:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921081537.15300-2-luke@diamand.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21-09-2020 13:45, Luke Diamand wrote:
> +
> +# Checkout the OLD tag inside the original repo. This works fine since all of
> +# the submodules are present in .git/modules.
> +test_expect_success 'checkout old inside original repo' '
> +	(cd super &&
> +		git config advice.detachedHead false &&
> +		git tag LATEST &&
> +		git checkout --recurse-submodules OLD &&
> +		git submodule update --checkout --remote --force &&
> +		test_path_is_file old/commit_old.t &&
> +		test_path_is_missing new/commit_new.t &&
> +		git checkout --recurse-submodules LATEST &&
> +		test_path_is_file new/commit_new.t
> +	)
> +'
> +

Philippe pointed out the reason behind this behavriour [1] for this in
another thread.

> +# Clone the repo, and then checkout the OLD tag inside the clone.
> +# The `old` submodule does not get updated. Instead we get:
> +#
> +# fatal: not a git repository: ../.git/modules/old
> +# fatal: could not reset submodule index
> +#
> +# That's because `old` is missing from .git/modules since it
> +# was not cloned originally and `checkout` does not know how to
> +# fetch the remote submodules, whereas `submodule update --remote` does.
> +
> +test_expect_failure 'checkout old with --recurse-submodules' '
> +	test_when_finished "rm -fr super-clone" &&
> +	git clone --recurse-submodules super super-clone &&
> +	(cd super-clone &&
> +		git config advice.detachedHead false &&
> +		test_path_is_file commit3.t &&
> +		test_path_is_file commit2.t &&
> +		test_path_is_missing old &&
> +		test_path_is_file new/commit_new.t &&
> +		git checkout --recurse-submodules OLD &&
> +		git submodule update --checkout --remote --force &&
> +		test_path_is_file commit2.t &&
> +		test_path_is_missing commit3.t &&
> +		test_path_is_dir old &&
> +		test_path_is_file old/commit_old.t
> +	)
> +'
> +
> +# As above, but this time, instead of using "checkout --recurse-submodules" we just
> +# use "checkout" to avoid the missing submodule error.
> +#
> +# The checkout of `old` now works fine, but instead `new` is left lying
> +# around with seemingly no way to clean it up. Even a later invocation of
> +# `git checkout --recurse-submodules` does not get rid of it.
> +
> +test_expect_failure 'checkout old without --recurse-submodules' '
> +	test_when_finished "rm -fr super-clone" &&
> +	git clone --recurse-submodules super super-clone &&
> +	(cd super-clone &&
> +		git config advice.detachedHead false &&
> +		test_path_is_file new/commit_new.t &&
> +		git checkout OLD &&
> +		git submodule update --checkout --remote --force &&
> +		git checkout --recurse-submodules OLD &&
> +		test_path_is_file commit2.t &&
> +		test_path_is_missing commit3.t &&
> +		test_path_is_dir old &&
> +		test_path_is_file old/commit_old.t &&
> +		test_path_is_missing new/commit_new.t
> +	)
> +'
> +
> +test_done
> 

I think this isn't the complete story. The submodule removal is done
properly if `git checkout --recurse-submodules` is called when the
revision is not checked out (modulo the checkout failing issue detailed
in the previous test case). For some reason, it doesn't work when the
revisions is already checked out. i.e., the following passes

  test_expect_success 'checkout old without --recurse-submodules' '
        test_when_finished "rm -fr super-clone" &&
        git clone --recurse-submodules super super-clone &&
        (cd super-clone &&
                git config advice.detachedHead false &&
                test_path_is_file new/commit_new.t &&
                git checkout OLD &&
                git submodule update --checkout --remote --force &&
                git checkout --recurse-submodules LATEST &&
                test_path_is_file commit2.t &&
                test_path_is_file commit3.t &&
                test_path_is_missing old &&
                test_path_is_missing old/commit_old.t &&
                test_path_is_file new/commit_new.t
        )
  '

Also, this is the exact case that seems to be explained in commit
bbad9f9314 (rm: better document side effects when removing a submodule,
2014-01-07) which adds the following BUGS part to the documentation.

    BUGS
    ----
    Each time a superproject update removes a populated submodule
    e.g. when switching between commits before and after the removal) a
    stale submodule checkout will remain in the old location. Removing
    the old directory is only safe when it uses a gitfile, as otherwise
    the history of the submodule will be deleted too. This step will be
    obsolete when recursive submodule update has been implemented.

As Phillipe points out in [2], I do wonder if this part has now become
stale.

[ References ]

[1]:
https://lore.kernel.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/T/#u

[2]:
https://public-inbox.org/git/0B191753-C1AD-499C-B8B2-122F49CF6F14@gmail.com/

-- 
Sivaraam
