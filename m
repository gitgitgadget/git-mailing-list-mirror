Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB47C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B5B207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY4Bl3+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgHDRDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgHDRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 13:02:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181CC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 10:02:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so20779864pfu.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bHCYNUaBrU7WRV5iy6pMNOqIGCR1+6wa6TbQZoNMRxM=;
        b=VY4Bl3+XB6LViXpsGLUXtxtOyg4o+k/QOqqrmkc64LhnNqi3LiVIkS2nDpOc12o7Dc
         Khz6/SS5dYkv/3iJA9VAy4M2qFjh/xu80DQubgWAdSvGwP7Tpyx/ujsU8HPeq3VXYvpq
         RUxLHpDIgD0ZJs1KSJ1nMKm26FNlujIXe/sgDaA3aGzfFBETafGjqVbrvwlIN/qKNE0u
         lKKiAS1LoquX1pJH6kqOybUmwwKTfvS376+BKnRZV7azBKO8yVSIChHAhcHMbbbdbO0/
         b8nB/twqAIymLaC3WlDLMhmYnbMC8cqjZieOy6Jby0d3bhhkTqEYbT0Py1wHEOGDEl+e
         g+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHCYNUaBrU7WRV5iy6pMNOqIGCR1+6wa6TbQZoNMRxM=;
        b=JKomJR35s2seLbqFx0cz95AdpbKvPSMdwxTbbecMkQsZdxHJCqvMOBu8K2b8IVeDnK
         3j2OENAOBHK5ybNBte6DK0fUP2ylsdtYVEbMeQIuuJLSrVHzMwBEIwQ2itHf/67HPFEY
         4VkUS2WEd2GQ+qD0sKQzu32nluF7QOANihkiD2ESWfbuLg4vXc3Y+OkescwmPA2ztxtF
         TfDNAPpsc20gPmM/yvMtE6rs02wE7GoRX8IU07PIm+3WnIDwCCCqhNr2HAbmOiuwQJ66
         +ti3zN97hqJpRcWw5iTRXgkxQrGNDu0lNSDe4SXkNcbUau2kzMzEIdUIY3y+7yk2H1Qo
         U9GA==
X-Gm-Message-State: AOAM530bj+1AeCmu1KHFnyIKqfOHsvohifsnrAsM9mHJY/63KijKQwil
        QW/FRjq+OkOiRPFCdevcQ2c=
X-Google-Smtp-Source: ABdhPJygGtdjGNDQ4rLm9CIN2+b7B9fOgHhflDWx9+jdjIdAojtBoUVWm6xPjhGq7hitYT8K3ya1Aw==
X-Received: by 2002:a65:4808:: with SMTP id h8mr12878839pgs.113.1596560543509;
        Tue, 04 Aug 2020 10:02:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id g15sm16951375pfh.70.2020.08.04.10.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 10:02:22 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:02:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200804170220.GB227292@google.com>
References: <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
 <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com>
 <20200803230814.GA73765@syl.lan>
 <20200803231745.GB58587@google.com>
 <aac90dbd-e885-f366-1056-0824b8b8b8fe@gmail.com>
 <20200804144208.GA227292@google.com>
 <2b6da345-d004-1d83-78cd-3f1ceaf278d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6da345-d004-1d83-78cd-3f1ceaf278d9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> Here is my attempt so far:
[...]
> 	test_subcommand_called "gc" run-no-auto.txt &&
> 	test_subcommand_not_called "gc --auto" run-auto.txt &&
> 	test_subcommand_called "gc --quiet" run-quiet.txt

I like it.  Some tweaks:
- can simplify by using 'printf' instead of sed
- passing the trace in stdin
- following the convention that helpers like test_i18ngrep use of
  accepting ! as a parameter to negate the exit code

That would make (untested)

# Check that the given command was invoked as part of the
# trace2-format trace on stdin.
#
#	test_subcommand_called [!] <command> <args>... < <trace>
#
# For example, to look for an invocation of "git upload-pack
# /path/to/repo"
#
#	GIT_TRACE2_EVENT=event.log git fetch ... &&
#	test_subcommand_called git upload-pack "$PATH" <event.log
#
# If the first parameter passed is !, this instead checks that
# the given command was not called.
#
test_subcommand_called () {
	local negate=
	if test "$1" = "!"
	then
		negate=t
		shift
	fi

	local expr=$(printf '"%s",' "$@")
	expr="${expr%,}"

	if test -n "$negate"
	then
		! grep "\[$expr\]"
	else
		grep "\[$expr\]"
	fi
}
