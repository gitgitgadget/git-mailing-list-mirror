Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1954C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A19E22527
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 20:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgLUUmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 15:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUUmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 15:42:07 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4DC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:41:27 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id q25so9990097otn.10
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 12:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=n9A9QM+RaQcKLgjdM4cGJP5NyF8lyZDomvSm1Z9R4AE=;
        b=E+y/R1Dx1LUp81cLuslWaF6WnI3XHaQX8KUuhMcXPAGMDvRzWO7AUXjf3c4IrNlK+f
         nxjPbrTjcxEAx5XjzT6hXRhbJ52g0kMlw5njU6LK2zNarOY+yagPjo6zwFt7WOU1G2Aq
         hWvDXHYD+gZvfxkQkR1264Sil8zP0ItCF1RjvhLkwfBb7oLfrzQadfsbn2pIZ2wp2jhG
         8F4OBeewa5j2tong7bAe16fIEhTNkYMFXjraQV27Wpe1po0sjNr19JQEvDrg8kT8BOkJ
         ZtBnH7kJw14gP735qItsS2l1nAJkkQz5LKRkDmvSWlbOmsYT9tVuZwGgMO73v0IWiRfh
         ClTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=n9A9QM+RaQcKLgjdM4cGJP5NyF8lyZDomvSm1Z9R4AE=;
        b=qUyQsppWJw6wjnNmVoPeqPE3w+3nJxPpyLeVj20YXmWRg3JidarNQ0qGoHwKhol6rU
         gv+km7jyvUwccSk0pdFlS3HaZzvC8+mlGuUr+QzogbuQV5lIYkVtaqC9RiWWchTZerxO
         YYjlVrtx1S+940cIFGTgA5ovibU5zXq7vzkg0WOsljA2g8XXezsuW8kySJWKaAiUt/IF
         01mv/AVN0UTQulWd+BaAdpqoKi7RzP644er34+KqD3EeBgW45iQk+pO1jcXYT/eluKBZ
         vbOTq4ureMT92+MmPYN2ChSkN8reAlsI8dFvy4gu3Sj7T+5EwU7umvFjaIxTCXoxg177
         B2rA==
X-Gm-Message-State: AOAM533KYiU4yfYf/2iiAO7x70oy3dWD56S1L5soUh5YrNLxNRghpkF5
        2onDsMismux6+46zlA5//rM=
X-Google-Smtp-Source: ABdhPJz7gcUwZqigrKtPJYW5CFLMiiCw3063eS4+hfVSk1r/85+ijAC70HsYLWBg1rXqsfF2PODsFA==
X-Received: by 2002:a9d:136:: with SMTP id 51mr13192263otu.92.1608583286828;
        Mon, 21 Dec 2020 12:41:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j10sm4144179otn.63.2020.12.21.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:41:26 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:41:25 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <5fe108752910_f93820887@natae.notmuch>
In-Reply-To: <003e01d6d7ce$ccc648f0$6652dad0$@nexbridge.com>
References: <002001d6d7bd$d03d7e10$70b87a30$@nexbridge.com>
 <xmqqeejjm2ek.fsf@gitster.c.googlers.com>
 <003e01d6d7ce$ccc648f0$6652dad0$@nexbridge.com>
Subject: RE: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in libcurl
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> git is the only product my group builds that uses libcurl. There is a
> less functional version of libcurl that comes with the operating
> system that we ignore. We are not linking with that version. The
> version of curl we have, we built but not since 2.29.2.
> So  I'm confused.

Could be: b990f02fd8 (config.mak.uname: remove unused NEEDS_SSL_WITH_CURL flag, 2020-11-11)

It seems it was attempting to only remove NEEDS_SSL_WITH_CURL, which
indeed wasn't used anymore, but it also removed:

  #NO_CURL = YesPlease

I've no idea about these systems, but a quick search makes me wonder if
perhaps this was not intended.

-- 
Felipe Contreras
