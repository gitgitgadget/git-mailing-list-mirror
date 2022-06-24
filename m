Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F91C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 07:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiFXH53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFXH52 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 03:57:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12769FA8
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 00:57:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d17so1872591pfq.9
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ng/ZgBDkNxyKfp/jXru4tw1OxTxWjKFJLpsCeBkd8lA=;
        b=H+awwLblKHCGC5bv8nzkkj7rxVilJleXpDoWh9Lif+25gIB2+y17TyN6vmwzJsx7Ze
         5kP99UtqZgHxNHHALZfbRDvINCK/9guTFzLLB5Qesn3DvBhVFVvvu1GWeM6AV1T/oqPw
         8mcg5VTDux1cpFUW9imMDVUvXNHtK8ieuBUy17TECOsaJAao0yDDomHsACZbz4VcreEo
         C3f8jgtJsYQBj2cUP9jAG0YSeqPJ5hQXY6OGoffudNwo6y3/3QXijAQ6zPCAhNMy/bpu
         OgWBY91JtNAyYJdRpkq0ABpFA3mal0QcQnz6FLr3VhY2j8vh3yA2KfhDyP9fhaqnfcFG
         A5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ng/ZgBDkNxyKfp/jXru4tw1OxTxWjKFJLpsCeBkd8lA=;
        b=eJefilzu0SLA/jgBG2b0Yl5OVgRrC6iFS/EQVvcgpWkgujy1dCDfUfANLNF4Do/GFQ
         3ssRQsWiRINyh6xsRzmuekH3rD+dwO6RIZ2TYbBW0+N/aSUcASoLozrQnJ9gRMNGlj85
         DJl/YRFGG/umB19JJ84YesSWsPBMWhj9M6jHF1EhbrU+szQoRCq7oCrAnCYclkkcxATu
         0CqxjtJLdGOAnf6QVh6g2N/ZjGg8Grg3OjoJUGMkSkp6ZUaWDd+nd2tKK56jzmU1bJ8l
         +SDmUIWsmYz/Z04Jh136M8W/IFA+xRrKYlBnhCNzhB2gWQzTUKQCotEYMe2Lia7qAGJW
         zz8Q==
X-Gm-Message-State: AJIora/rBkUCxwoipjobqlcAEvyhw57NIcUbEWdCN+84/kbALywO2Zqk
        /JTMe2LxhWTAl/BnEnUwuMx7HJiaWAap7A==
X-Google-Smtp-Source: AGRyM1t2Sdv3Y/yUFMqZ4WhlWQwdICKTClmhEMZM/eRikPZO5hSTayH95XLR2mC3beligNuL4cobtA==
X-Received: by 2002:a63:4f22:0:b0:403:7c60:adae with SMTP id d34-20020a634f22000000b004037c60adaemr10833754pgb.225.1656057447653;
        Fri, 24 Jun 2022 00:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id cj15-20020a056a00298f00b0052559bd12aasm978570pfb.61.2022.06.24.00.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 00:57:27 -0700 (PDT)
Message-ID: <a97eea15-00fe-dd33-2e4e-3ea91cb053f5@gmail.com>
Date:   Fri, 24 Jun 2022 15:57:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 7/7] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-8-shaoxuan.yuan02@gmail.com>
 <17a34570-f823-7908-1ea5-8e7bf8680b23@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <17a34570-f823-7908-1ea5-8e7bf8680b23@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 11:14 PM, Derrick Stolee wrote:
 > On 6/23/2022 7:41 AM, Shaoxuan Yuan wrote:
 >> Originally, moving a <source> directory which is not on-disk due
 >> to its existence outside of sparse-checkout cone, "giv mv" command
 >> errors out with "bad source".
 >>
 >> Add a helper check_dir_in_index() function to see if a directory
 >> name exists in the index. Also add a SKIP_WORKTREE_DIR bit to mark
 >> such directories.
 >>
 >> Change the checking logic, so that such <source> directory makes
 >> "giv mv" command warns with "advise_on_updating_sparse_paths()"
 >> instead of "bad source"; also user now can supply a "--sparse" flag so
 >> this operation can be carried out successfully.
 >>
 >> Helped-by: Victoria Dye <vdye@github.com>
 >> Helped-by: Derrick Stolee <derrickstolee@github.com>
 >> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
 >> ---
 >>  builtin/mv.c                  | 50 ++++++++++++++++++++++++++++++-----
 >>  t/t7002-mv-sparse-checkout.sh |  4 +--
 >>  2 files changed, 46 insertions(+), 8 deletions(-)
 >>
 >> diff --git a/builtin/mv.c b/builtin/mv.c
 >> index aa29da4337..b5d0d8ef4f 100644
 >> --- a/builtin/mv.c
 >> +++ b/builtin/mv.c
 >> @@ -25,6 +25,7 @@ enum update_mode {
 >>      WORKING_DIRECTORY = (1 << 1),
 >>      INDEX = (1 << 2),
 >>      SPARSE = (1 << 3),
 >> +    SKIP_WORKTREE_DIR = (1 << 4),
 >>  };
 >>
 >>  #define DUP_BASENAME 1
 >> @@ -123,6 +124,36 @@ static int index_range_of_same_dir(const char 
*src, int length,
 >>      return last - first;
 >>  }
 >>
 >> +/*
 >> + * Check if an out-of-cone directory should be in the index. 
Imagine this case
 >> + * that all the files under a directory are marked with 
'CE_SKIP_WORKTREE' bit
 >> + * and thus the directory is sparsified.
 >> + *
 >> + * Return 0 if such directory exist (i.e. with any of its contained 
files not
 >> + * marked with CE_SKIP_WORKTREE, the directory would be present in 
working tree).
 >> + * Return 1 otherwise.
 >> + */
 >
 > This description and the implementation seems like it will work
 > even if the path exists as a sparse directory in a sparse index.
 >
 > It would be good to consider testing this kind of move for a
 > directory on the sparse boundary (where it would be a sparse
 > directory in a sparse index) _and_ if it is deeper than the
 > boundary (so the sparse index would expand in the cache_name_pos()
 > method). These tests can be written now for correctness, but later
 > the first case can be updated to use the 'ensure_not_expanded'
 > helper in t1092.

I'm a bit confused here. Shouldn't we turn on the sparse-index
feature for 'mv' before adding sparse-index related tests? Since this
series does not go into sparse-index, I'm not sure how the tests can
pass. Perhaps we can test about this in the future sparse-index
integration series, no?

Thanks & Regards,
Shaoxuan

