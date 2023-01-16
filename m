Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20829C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjAPR6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjAPR57 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:57:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621474B195
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:38:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d2so8081661wrp.8
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clr76bgJkjKoAJdpwImlvKo3OFUza5idCm5ioZoHiwk=;
        b=c+wmtOi/W5vw98r14V/3XuiAAj5kB318pevALrfXwZKoe1rGfvpe9tkySWzyzh6+IV
         D7DwH3WdLoov4y4ilUmK3QkecbuXv2/2Qa5VUpTg/6jRZSfchU6jSycRmWMwriecqMdT
         m7vhBA9EjJe7sSzhm0m5nJl9CKOXXeJmA92+79NneiEIoQMx3t6BajAJiEYFO3A1CuEr
         tq7OMF9WSFdLMM/RVMtEr99v/hyxvaxP4121Z2jAbRYW4M916vP5x1BGQ4F1847ybOgi
         +pNZNcXUzBaavvNzTLgQ7D8B9R2slt942qdRijyh80WJ1tPkIy5siY+Mll6qvIVsKWKf
         3cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clr76bgJkjKoAJdpwImlvKo3OFUza5idCm5ioZoHiwk=;
        b=M13DRccGnF9L5rkaITTybHtZF6mM2FEzRZnWAXOuYnN+o1iLrnIPyJat2ce+oAJ4ql
         je2YYNmTwuDWxMT3dJplVjS5Zw8Uee+tH7iW5yoWzMG9w/MVw5yu9OS8gI9lndDOKVud
         VDTFWMZP9hdm4iEPWzi/zWlpQ43wj0w4ROCo4Iy4CKJskj+WsfGiVyFfHhpNV/Vga6zg
         yoMGDv7+ZHJ3HlebLT8jc73BtW7bJcXSl1eeQRUnW2nWelHvPOsinurCR7Lb4AuX7Z36
         6cR68VO3ToThZROQnmvL0IrlbbV4KM6TvZh9z3aq5hVzor3t0LDmK849Tw8H+O87iU4H
         PSxg==
X-Gm-Message-State: AFqh2koPS9jD//TYxyJ/eT/jPclO+Y3WJJ1QPj2VQKUSqL/1ntmpIneY
        Nblgv+Dk1gLZ5+Av77MOY9Marapbvn0bgQ==
X-Google-Smtp-Source: AMrXdXtYqD208+y5BpdiBPPeFr/m04IcM07ZZpw9uAKpDSDVUMRZpG71lkJns54G9Qx/ASQkmbTzKw==
X-Received: by 2002:a5d:428e:0:b0:2bc:8339:1fcc with SMTP id k14-20020a5d428e000000b002bc83391fccmr245322wrq.58.1673890711530;
        Mon, 16 Jan 2023 09:38:31 -0800 (PST)
Received: from wilber4c.. ([197.239.4.129])
        by smtp.gmail.com with ESMTPSA id q18-20020adfdfd2000000b002bdc129c8f6sm15343245wrn.43.2023.01.16.09.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:38:31 -0800 (PST)
From:   Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
To:     git@vger.kernel.org
Cc:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH v4 0/1] ref-filter: add new "signature" atom
Date:   Mon, 16 Jan 2023 12:38:13 -0500
Message-Id: <20230116173814.11338-1-nsengiyumvawilberforce@gmail.com>
X-Mailer: git-send-email 2.39.0.138.gb334f1a8b9
In-Reply-To: <20230110005251.10539-2-nsengiyumvawilberforce@gmail.com>
References: <20230110005251.10539-2-nsengiyumvawilberforce@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is not different from previous version(3), this is because
the previous version(3) could not show the difference from version(2)
of the patch. I will explain every change from the first version
<https://public-inbox.org/git/pull.1452.git.1672102523902.gitgitgadget@gmail.com/> 
to version 3
<https://public-inbox.org/git/20230110005251.10539-1-nsengiyumvawilberforce@gmail.com/>
because I first had a big trouble in transitioning from gitgitgadget
to using git send-mail

***THE FOLLOWING ARE THE CHANGES***
a) From the first version to version 2
<https://public-inbox.org/git/pull.1428.git.git.1673254961028.gitgitgadget@gmail.com/>
Version 2 addresses all Junio's comments for version 1, the comments are
here.
<https://public-inbox.org/git/xmqqo7rpvb83.fsf@gitster.g/>
->summary of the changes
i) I changed the commit message to detail more about the feature I am
introducing.
ii) Introduced a new helper function in ref-filter.c called
parse_signature_option() and handled !arg case first.
iii) Used the above helper function to eliminate the repetition that
was in grab_signature() for checking different signature option.
iv) I also moved check_commit_signature(commit, &sigc) out of the
to avoid running GPG twice.still this change is in grab_signature()
in ref-filter.c.
v) add a new test in t6300 to test bare signature atom(%(signature))
since I had missed it

NB: I did not change the parser function name as he suggested, I
think my commit message was misleading.

b) from version 2 to version 3
<https://public-inbox.org/git/20230110005251.10539-2-nsengiyumvawilberforce@gmail.com/>

->summary of changes
i) Got rid of test for bare signature atom. This is because the test was
passing for some CI tests(different machines) and some others were
failing.

Best Regards,
Wilberforce

Nsengiyumva Wilberforce (1):
  ref-filter: add new "signature" atom

 Documentation/git-for-each-ref.txt |  27 +++++++
 ref-filter.c                       | 101 +++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 116 +++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)

Range-diff against v3:
1:  ce51d8e79e = 1:  ce51d8e79e ref-filter: add new "signature" atom
-- 
2.39.0.138.gb334f1a8b9

