Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EFCC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 15:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D50D60EFF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 15:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhJ0PNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhJ0PNs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 11:13:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685FC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 08:11:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 188so5257521ljj.4
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ChtHg/lQBZtaIGOWkOj0x+iHctfZFE4eMH+U1yb/+Mo=;
        b=Jo2Kjxpvkgz6ilrB6lPNftYZIlhQ5lz11AQUq7rV29O4xlmAKFCX1h4YFLul1Yt9SW
         TCORrTwguCZPb8HBgJ5wDkObrd98UuOgsWSCsKnvb10PTlw+lI5vOwX7tNpCYLojIKIt
         W3H1JVPnzjhpwqkmmm9VXX7CVzxULX9PAYmWgoPnleE0yuJOAk4/TQeIduL+c+zzEnPR
         VCEY6nHVS6AhBgj8n5PKwaA3tFeiQqQ9djGpjoavez7o3nB70TpI/mkQEOkxVWfhYFaP
         MkVwdwq5PbKzgt21ioA2r8x+cO7edRKeQPkrxj4HB9TiO1CXCnDJY5saycSjh7SgjnPa
         WieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ChtHg/lQBZtaIGOWkOj0x+iHctfZFE4eMH+U1yb/+Mo=;
        b=EUuRQwcvBGJf8WTMlKQfc57NQ0G/4eXYTNzYLolBCkrHw7zLKFPtVojbvt2nqJdZ1+
         7l5mWCIDd2CeHTjfpiO/89BLR8dTp0nYN83rvykssbWb36cJp1nGnlK46nQaQuYqjYsS
         6HJ+MhMUyke9meXaI3sWacsrdgw0KKKtNG2rnJ5LynOhlSRveZ0Q7ZZPEy7lA8CTg5e4
         hJarGzu6d7/ULdYzb0wcSf/joOdymdWvHPARyWQE+3gHc6hm/h4V+Ok6kYNAMTCXvTCX
         zzRegDe+pSCGcaL0nodABorSHS4ceL7ZeYROf7iUynEOPuqkEMJ2+DVXXETKZMUrdWNF
         y/xA==
X-Gm-Message-State: AOAM532j+jCQYnxPsDrqNLB9C8AwHEyb27cqEmAmEWK9iUj4SVI0Em4z
        KfB8IcnqC4/7FNJEnOnnvrxauJe0NOY=
X-Google-Smtp-Source: ABdhPJxxH4MoXLd8UKelUBTg++OLYObTWTeIvmPR34YvZN3wNmMO/myFWIWkovYzaQy9W54XzB6/hw==
X-Received: by 2002:a05:651c:1583:: with SMTP id h3mr5225045ljq.98.1635347481007;
        Wed, 27 Oct 2021 08:11:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y19sm23392lfa.123.2021.10.27.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 08:11:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <87pms2mi1p.fsf_-_@osv.gnss.ru>
        <YXeMkC/jPxjzNgWF@coredump.intra.peff.net>
Date:   Wed, 27 Oct 2021 18:11:19 +0300
In-Reply-To: <YXeMkC/jPxjzNgWF@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Oct 2021 01:05:20 -0400")
Message-ID: <8735ombizs.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 18, 2021 at 07:09:06PM +0300, Sergey Organov wrote:
>
>> +static int stash_staged(struct stash_info *info, const struct pathspec *ps,
>> +			struct strbuf *out_patch, int quiet)
>> +{
>> +	int ret = 0;
>> +	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
>> +	struct index_state istate = { NULL };
>> +
>> + if (write_index_as_tree(&info->w_tree, &istate,
>> the_repository->index_file,
>> +				0, NULL)) {
>> +		ret = -1;
>> +		goto done;
>> +	}
>> +
>> +	cp_diff_tree.git_cmd = 1;
>> +	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
>> +		     oid_to_hex(&info->w_tree), "--", NULL);
>> +	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
>> +		ret = -1;
>> +		goto done;
>> +	}
>> +
>> +	if (!out_patch->len) {
>> +		if (!quiet)
>> +			fprintf_ln(stderr, _("No staged changes"));
>> +		ret = 1;
>> +	}
>> +
>> +done:
>> +	discard_index(&istate);
>> +	return ret;
>> +}
>
> This function doesn't look at its "struct pathspec" parameter at all.
> I'm not sure if that's a bug (i.e., it should be restricting the diff
> here) or if it was just pulled unnecessarily over from stash_patch().

Yep, it's a remnant from copy-paste of stash_patch(). I'm used to
getting a warning from compiler for such cases and didn't pay enough
attention. The warning belongs to -Wextra though and is not turned on
for Git compilation.

Thanks for catching!

-- Sergey Organov
