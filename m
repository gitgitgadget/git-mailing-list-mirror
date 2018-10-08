Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8E51F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 23:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeJIGYx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 02:24:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35758 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIGYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 02:24:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id y19-v6so3343edd.2
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXr4iuuairMtVXcRyi6sxMVCwSYISUmr8neCpE/nfHU=;
        b=M1rUJVHoOPLPNvMa2GagwinDISXD5VdrwVTMfgzzBB2Phep29+N8moX+LpodOMdjcd
         fbkxhoUh8YbSRkj1zILWj88eQxLngFVc6A6HjOGGsB57FLduwtQdliMXgSVk0fV55j54
         nj0lZf4vI5xd0kSXlkJigp0rbkGij1B5MTGvCOCeIhvnLtq7nFwESRRhV5o7yBLQNfkg
         hNJOEriPhlZYW6eKxb0pvczExh+UUW9Knmqon7/5Jf6SCirHftmUDRZhbGzy9WnvAy7w
         l1iWNkX3WtjycPuITzSaPp0LPb309cYbvDvUq1u3C0Y8N0DocxBjLtqIpKP3S3YK1ZQW
         meew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXr4iuuairMtVXcRyi6sxMVCwSYISUmr8neCpE/nfHU=;
        b=SPMzjGX3N4TUSqRNwzVl0VQJnRspEuGV0f5mR8sp1PLSSwLsRlluxxbKDLBGIBBa0f
         ZxpFF8u6zbgyWKFLv9CeUSZw4gSLXipy7fnFIz8qpj/bXsFPn2FSrvpIJWIVcoUNNZjj
         t4Hp5/HH0MdRgeW2gLPDV5KFiQOhFM/uSP+EwBwCNCLbc2mlhG6FjoQtT0WupeVPukBb
         GfsBe0LMJSCxBef+E5Hen3NKMVrnD/SxudD040ErQ5NAkYfvZvII8A4dDW6sONlXxDsC
         5TkWfYP+gGolxVLFb8hom/ub4YRyX/XsiSH+jHKxmWMgicyFXwArAUPLTVl1LMDWZ4Hp
         sw/w==
X-Gm-Message-State: ABuFfoihepuHZZ1SSMPzJ7ggxbud4GxQSd359boUiOm7XZitZTSk/xuj
        Afz/sBmF4Pl2/lS6nvfwsOCXrdnj/l9FmSUslhOmPg==
X-Google-Smtp-Source: ACcGV61IvWbzNxrB3dFep0aewUBrFFnHvA5FybL4noLvnb/lonCujcepJAuZUY62HWWhKmGFZ01dWKzMKOFdelQdMRc=
X-Received: by 2002:aa7:c742:: with SMTP id c2-v6mr26876396eds.231.1539040247998;
 Mon, 08 Oct 2018 16:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net> <20181008215701.779099-14-sandals@crustytoothpaste.net>
In-Reply-To: <20181008215701.779099-14-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 16:10:37 -0700
Message-ID: <CAGZ79kbLqcvH9Zd5fH4NECvuES6FQ+jOFDcv713_5SXa-NvQ3g@mail.gmail.com>
Subject: Re: [PATCH 13/14] submodule: make zero-oid comparison hash function agnostic
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> With SHA-256, the length of the all-zeros object ID is longer.  Add a
> function to git-submodule.sh to check if a full hex object ID is the
> all-zeros value, and use it to check the output we're parsing from git
> diff-files or diff-index.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Nice!
