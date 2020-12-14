Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE20C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D003122581
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440863AbgLNTCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440684AbgLNTBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:01:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF3C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:00:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b9so24081792ejy.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=/JQjxTyRJhqcVOxx/Q8kcUNxlBTL8XpXHzicN9iykgk=;
        b=BwDBRB1ua4WxDC3D9kgcbC3Qlx278BzvP1hg6oi6riqUgC2BiCKg4u92ZEzxMIwIkD
         i/z4aqVCz++YmeU9DncZOhQT7nVK3rOD8f2GrmhUIx9sdK1rUgkz4I5jHHl8TsEBl7WA
         pDhofCcvZD/unEm5FQc48zN/iJ95S8LTTfHOxCuO9X1HRi/LTqW168D2vVN5P09vqCDO
         puuvhnpgllx9urPVPSH9IpImr31tnkKRY36dPONolE7AoQl+hEAC4WA4dGfoP/9DZ25l
         bwH9gXpxyrsa8JFqhf5c0/XXS8GfU/B03Ddga32k3OEXzskqDnBZJEMobpXoALm/Vxjn
         tZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=/JQjxTyRJhqcVOxx/Q8kcUNxlBTL8XpXHzicN9iykgk=;
        b=aBUwcYnvKPK9gN8e4JkLit0N3I3YHAOdxPmchhg1JIFjWhpBdiZSdp6IsG+/wR9FiL
         /J7xQOHiZTEFaUUNFTjvtqCQMoQT5VGE9CwyMWKOqNJc8NWezElAQn8cGh+FcuzMg8qL
         9Zvyga5AZrGu22IUTpI+5bhkmKB/QI/TvRxhIEEz05AH56R4cUVuJJ0k6a45Qz4oj891
         /ygAZ7zjBYr1fKQFU+2C7XTdJyKZ3EaeOnthJab5Qln3zEyFZH43/Bt4Jy0KP5xglvE+
         Egbp1xZ7sWzKNS1m+2i3dW+bZoFcrSpFbibDsvlUYT69Vx4x14pWnizeEVtOrNvhct7D
         bK+A==
X-Gm-Message-State: AOAM530KIKluAnIPdSIW011UVhiO3fHxwRdyC5sxrDSnbcixCDCweTH2
        h0aii19IBLhMKPp9XKECa6hhACeh2qM=
X-Google-Smtp-Source: ABdhPJwUmgIzXVWpKdo+cUA+RT8Iftp41iA3rtCa9yEqMZ8HCD1bpIJGx8JkZW+P5l8FPi2/ti6O8A==
X-Received: by 2002:a17:906:d0c2:: with SMTP id bq2mr23776185ejb.1.1607972457402;
        Mon, 14 Dec 2020 11:00:57 -0800 (PST)
Received: from gmail.com (194-166-85-7.adsl.highway.telekom.at. [194.166.85.7])
        by smtp.gmail.com with ESMTPSA id u23sm14359327ejy.87.2020.12.14.11.00.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:00:56 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:00:54 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Subject: Unexpected behavior on diff -I<regex> --name-only
Message-ID: <20201214190054.lrdllbpf6jfrz573@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2.28.0-2-g296d4a94e7 (diff: add -I<regex> that ignores matching changes)
diff -I<regex> can be used to suppress hunks of only matching lines.
This interacts in a surprising way with --name-only, which lists
all changed files, regardless of whether they are filtered out by -I<regex>:

	git diff HEAD~ -I ''			# always empty
	git diff HEAD~ -I '' --name-only	# not empty, "-I" does nothing

It could be nice to only show names of files with matching hunks
(or reject this combination of options?).
