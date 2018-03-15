Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B654D1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCOUKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 16:10:03 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37953 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeCOUKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 16:10:02 -0400
Received: by mail-wm0-f45.google.com with SMTP id z9so12794595wmb.3
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qM3fEUjKb29fOfT2oqTypcqg+fXBgEX4aykT711h7jo=;
        b=OkB0bQw1tsWXCeZk5RJ04tsPlJGVUnkG4c07gYdzRYo+bdlZUfMH7V4luhFhcRWmRq
         LpfD11vr5SfZCI+AMTOLtF62hBpwpwEQQEnCgagTq3T5UxfszRPBEyfUL39IQiw+JCPv
         S2K72+iVayWeMIM0v5M9ZSeMunWfA1tQvpnWubepUcmu3HzAnmTBViEkgjK5h4Bx5G3g
         SwYEp7OFpkdrT6uK+xtvdrf32PAAx7kaGQUltQorTu9+wcZjHKKjArnrPOggmYqMqWdW
         /N/XLqMTdecVbHw6Yw5AJSX7/EuX8dgihGirChfqn31mXK86mwatCTSGHHRcANf+Aza4
         ULOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qM3fEUjKb29fOfT2oqTypcqg+fXBgEX4aykT711h7jo=;
        b=CJgcUwNl9Yf/gH0XooL0gi+6h9uSGb0fWj1LSygyNuJiF5PaltTO2HnONt8HNBSCX1
         /ociYKUTaSDHC+OZzjV1U8LljQxnBl0RmwfPtZA6lWdbnmCMTMObauMVuUJbeq8Y6x+/
         Z7d8/3K4Ahfq0AltbD9NISFskMVJGeN1eekYLQOIrJmETRSi//4RUHByBczxuJuj/sk2
         WKSZ1gbnHfBlamdD6ro56DSWqUkoRHq/Aj15zxiu9o0j3wDGeDPlXNWA1apozlRjk59B
         kQjxnuLHS9dMC38CEeaStE9ysxJfK8DUmeSWk1UDntQ55+/CoP95c178j1lVsV+Y1O1r
         zTFg==
X-Gm-Message-State: AElRT7EZ7JpS7dfUTxeVNBy1Mldnq5OtHEARF4jLLDIpSpnvGsy38foe
        LBhGLR88wrTj7gixvhEMhrA=
X-Google-Smtp-Source: AG47ELvIN5GAuZrCVdOIrBDP2mYX10FcW237uOvoC3Ev8OqxEk0Fu/wWpxFAR9xSWoQtcdvGvRCTQA==
X-Received: by 10.28.17.210 with SMTP id 201mr6201768wmr.58.1521144600498;
        Thu, 15 Mar 2018 13:10:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3sm5455322wme.3.2018.03.15.13.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 13:09:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v2 2/2] stash push -u: don't create empty stash
References: <20180310111215.GA14732@hank>
        <20180314214642.22185-1-t.gummerer@gmail.com>
        <20180314214642.22185-2-t.gummerer@gmail.com>
Date:   Thu, 15 Mar 2018 13:09:58 -0700
In-Reply-To: <20180314214642.22185-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 14 Mar 2018 21:46:42 +0000")
Message-ID: <xmqqtvth3xt5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>  no_changes () {
>  	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
>  	git diff-files --quiet --ignore-submodules -- "$@" &&
> -	(test -z "$untracked" || test -z "$(untracked_files)")
> +	(test -z "$untracked" || test -z "$(untracked_files $@)")

Don't you need a pair of double-quotes around that $@?
