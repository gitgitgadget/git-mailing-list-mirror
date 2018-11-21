Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F791F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 03:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeKUNpj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 08:45:39 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36559 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKUNpj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 08:45:39 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so3026417ioh.3
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 19:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTWhDPuuCwYKBX9JfNJPOhkycywcOm75okbLV8i6F0U=;
        b=iUx0BRO2iaO9VR84m/B3Xz/iuDpciSxeyueAGtGUxciUfZXaf0/soRyDS7K09UDS+l
         VN92jQzWRw0zOvqtu0bsX6P1JX4TgnaPRPt2VstdgBxnnQzvQ5s6u8GNnicDAdCWlVVd
         90enQZVCS/QGPLi/H4ZLCRKH7TUmtzy2KZothOyLL4sCGTQr0aM6RktJkT7h7O5mZxpc
         FacjWrNtXc16hXpuqLzY7CPrbWnMUa/YLx4syGF4tWCuQ+PAJgVvYKsS4MqrUC/JPURT
         0jBUqxrrExErX+MdRl9j2R7vVM46QgXGlvvmc8KOpl4mLwd7IMMmwOCHFHL+Ycp4kJy1
         PwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTWhDPuuCwYKBX9JfNJPOhkycywcOm75okbLV8i6F0U=;
        b=E9OUsukVyuoAcu00US+nz7rtH/oxQeGBDyusUrHnCxFZww1siLToOMSZgmZWQ2Er7X
         lzzBkk6f74SCuHiLxR2Fi5XiXVIi8F6/BWarM2MpSf/x1NJIIiBVMZ2wc7lEUcGtCsw3
         NajwJBq3Ty9yNI+bPQkEiANGL7dxHF7Mq/5jjibD+CNWzzhacxdeVkzaTrohqCA8j68F
         DokF0jLRvF9w68QKRy0mDxFb7AbdT4XXtOCkAc9Nf5KD6YOg2kc0uDpyfijVvtfpP6YW
         2LZEGVH7UdHNU719SdlCxq0RtfiQGaem8NaEzrUIHfXyWKeHcB5lkGl6Sf1IXG9FPXQm
         Oluw==
X-Gm-Message-State: AA+aEWatACAYrWb8ZKTR78x96HM1GFmwNyOQd/cWHKIcSeG3c+dNzqEj
        vHFa3W5VTDwcHBz/azDax7VqPQ5x
X-Google-Smtp-Source: AFSGD/WlFn+va54jUsX171iQiaXv1r/lmD7x0puSkBENV30MpzAxYBxKAvn1zKZ+Hf566JcpuVY+gA==
X-Received: by 2002:a5e:d514:: with SMTP id e20mr3918659iom.291.1542769990402;
        Tue, 20 Nov 2018 19:13:10 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id x79sm13327496ita.34.2018.11.20.19.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 19:13:09 -0800 (PST)
Date:   Tue, 20 Nov 2018 22:13:07 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 0/2] Fix scissors bug during merge conflict
Message-ID: <cover.1542768902.git.liu.denton@gmail.com>
References: <cover.1542496915.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542496915.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for catching that, Szeder. I tested this revised patch under
GETTEXT_POISON and it should be passing tests now.

Changes since V1:
	* Only check MERGE_MSG for a scissors line instead of all prepended
	  files
	* Make a variable static in merge where appropriate
	* Add passthrough options in pull
	* Add documentation for the new option
	* Add tests to ensure desired behaviour

Changes since V2:
	* Merge both patches into one patch
	* Fix bug in help message printing logic

Changes since V3:
	* Add patch to cleanup 'merge --squash c3 with c7' test in t7600
	* Use test_i18ncmp instead of test_cmp to pass GETTEXT_POISON tests

Denton Liu (2):
  t7600: clean up 'merge --squash c3 with c7' test
  merge: add scissors line on merge conflict

 Documentation/merge-options.txt |  6 ++++
 builtin/commit.c                | 20 +++++++++----
 builtin/merge.c                 | 16 ++++++++++
 builtin/pull.c                  |  6 ++++
 t/t7600-merge.sh                | 53 ++++++++++++++++++++++++++++++---
 5 files changed, 92 insertions(+), 9 deletions(-)

-- 
2.19.1

