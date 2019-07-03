Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D83A1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 09:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGCJKf (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 05:10:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33595 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfGCJKf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 05:10:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so2435216wme.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEMEM6VsLExhlAJrUdogMHim5jS7wAxmL+xpSiL1JZA=;
        b=aUKGtUBF2CJbL4iJlVMgnLtjVEyam2SX4VaQ7wlBm+EdBj612yoj5SzdqLxN3YUG7d
         TpejmY2bKF+bMWgARrvz8Nva0VONQW0JF5NrqJwA13ubmqI3O47fBqwHoxwyBuTWjgPE
         GCfsdJE3uPLrFtw+Y0xmOMFe1uCu9BQOgfvyxRkrfh4zFLF29OzpTKWOUdRZy0Yl89fl
         1DqRMihczNvS2kEmfueHdZ1Q0FUxYpx1I3npqditYMOBJ64d/uOcP8L7Un/7e30V0YaA
         TxwYDYF3yGdBhnEAkueahOphlQQ3UeRvtdAqec/fR6bKqgbFVwb0ICitD/lGlxKrw3MU
         YsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEMEM6VsLExhlAJrUdogMHim5jS7wAxmL+xpSiL1JZA=;
        b=JyWMV8OXC7216nXgPFQRmbQyoJjEA2cHFGXQYZ+yl3cvRnU7FtePkOrSnV/cJiuvwu
         hD79QqjuNUNq92daZjC1uMv1Jqa4Tagk0vvlUkHG7H4VVUd0Fn+crUoSZRLWPouHqclT
         B8vzbQz9fJLOt9GMN5FyS6fDQ/t1LadxWaQxmUJ/w2sFdFxJcqAxRv13u8BJns+OaCHm
         kWcIjXa8ZiW6OZuH1g9StHObCaHp9ksnRvafJ1Q6e/JrdknNTE4MFWPnMTZ0GEklS5hj
         vhVI4An1xcdIUEkIp/Y5GvwVDHetuWdbhEQKiMAEog0kQ2KvisRuLpzTAfHUPVMeAwFV
         WA8g==
X-Gm-Message-State: APjAAAVzmSdYWIG72HWC1YxQsQGbn+KNmX1lO73K28EbIt/azY2PbFP2
        63bZ/dcigR2jK89CjOQnqcg=
X-Google-Smtp-Source: APXvYqzt4Bks3DPiZzSA6fFYtCflvAN/mM4YIS5xuXvDYw92BnzEvpmXs3LSEqs7mr98aQrmGnmJPQ==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr6871124wmg.69.1562145033333;
        Wed, 03 Jul 2019 02:10:33 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id g19sm1553396wmg.10.2019.07.03.02.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:10:32 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:10:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703091030.GP21574@szeder.dev>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 02, 2019 at 02:37:42PM -0700, Junio C Hamano wrote:
> > +test_expect_success 'push --atomic shows all failed refs' '
> > +	# Make up/master, up/allrefs
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
> > +	test_commit allrefs1 &&
> > +	test_commit allrefs2 &&
> > +	git branch allrefs &&
> > +	git push "$up" master allrefs &&
> > +	# Make master and allrefs incompatible with up/master, up/allrefs
> > +	git checkout allrefs &&
> > +	git reset --hard HEAD^ &&
> > +	git checkout master &&
> > +	git reset --hard HEAD^ &&
> > +	# --atomic should complain about both master and allrefs
> > +	test_must_fail git push --atomic "$up" master allrefs >&output &&
> 
> Don't rely on ">&output", which is an unnecessary bash-ism here.  It
> breaks test run under shells like dash.
> 
> 	>output 2>&1
> 
> should be OK.

'2>output' would be a tad better, because those refs should be printed
to stderr.

