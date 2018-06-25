Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640821F516
	for <e@80x24.org>; Mon, 25 Jun 2018 17:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965098AbeFYRpS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 13:45:18 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:55222 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755502AbeFYRpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 13:45:16 -0400
Received: by mail-io0-f201.google.com with SMTP id p12-v6so12257010iog.21
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+1dKZkGrgcWLnDHe4h4KE3IiU0W73UZ3IN7EYYdXfd4=;
        b=JRitpmIfOLVvZ+5FpISDvODA9PeU4EOrA9M0twnL6Je9tjDM4EomTKrqN/XUsvBnVF
         BsTGNjHf3vYhmvZWYbIABGz8Z8Og5QyicrtOHwVSuPbBhqcHInNtEifT2smn6jq21Uei
         8Q/3tLob91iZyiR/nptNYDUBi1i3FRDO0q7h8jaKT1eQaHV4+juxESqQq140OWXDoUh8
         Gtw+Bg9Rz/Vu3KgbsQCFpHlK6FgEIOoJi+QL11p2qz61DLaFHzVCY6JeBhg6OcYbXCzx
         8W0IYCQi05NCZNQCjF899NmlzELBo6DRL3S39ELlz+NXgkZOFUE5v0CAlHJcmGxPzJ3q
         N/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+1dKZkGrgcWLnDHe4h4KE3IiU0W73UZ3IN7EYYdXfd4=;
        b=mKOVhWZZy+hhxKjTxWoggq0eznhhw7Sc/WtuuR9F2sZ/Q9ADI59+Nodo7feVQRvwpk
         Ip4Pn5ctHd/3Z3B7X7q8yTNZVDEKxQuIw1+BfAnQhFcCpBVwbrUfNdWqyxppxYPpwTcH
         XrATFOvcqQjWuSvIGX0rvn6ZgsNWheGVetX7/4slKjkV2wPL/OR1VjPrg8MhYI/6a+wN
         nzz76gtRw6ByWeRvJRcBpE3QKdX+RQtflT6icmaUf3OBVPOIZk85ULhCW5IGKT+VzpAL
         Cob/orkDPAmj22IDrOBsm69UqaYOr8cLT6E0dAzbCmSSe2y0HPNOMX3i4bPt8Slct2ed
         o7uA==
X-Gm-Message-State: APt69E2G+3f5kT4ZyJp+S62zxzYHvXMPLf4TBP5bGxpo14n29ZRnFJ58
        QfnILKdOuShVo8JTRRk6QvPAd6qC0WhxvWkwH75y
X-Google-Smtp-Source: AAOMgpcaJ9Pufqq8057Zeo8U8ANodWl78JeaJpHHOltnDKPBK5WCZnyYGY2Zf8/bXQDG2BPTSWpQVwh89DRjQfSWkV3+
MIME-Version: 1.0
X-Received: by 2002:a24:a141:: with SMTP id n1-v6mr826525iti.35.1529948715914;
 Mon, 25 Jun 2018 10:45:15 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:45:11 -0700
In-Reply-To: <20180620213235.10952-5-bmwill@google.com>
Message-Id: <20180625174511.53903-1-jonathantanmy@google.com>
References: <20180620213235.10952-5-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v3 4/8] fetch: refactor the population of peer ref OIDs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Populate peer ref OIDs in get_ref_map instead of do_fetch. Besides
> tightening scopes of variables in the code, this also prepares for
> get_ref_map being able to be called multiple times within do_fetch.

get_ref_map() is only called in one place in builtin/fetch.c, and that
place is in do_fetch(), so moving functionality from do_fetch() to
get_ref_map() is perfectly fine, and also allows tightening of the scope
of the existing_refs variable.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
