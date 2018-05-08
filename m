Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D341200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeEHDul (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:50:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54687 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeEHDui (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:50:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id f6so16444137wmc.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VDys++9nPAXJ/IeTA0qkibvdlA55VU7W2NnVaB4XA3A=;
        b=fUXKYIAtygHCvLghDu/70yw9iO5IWHtzaqSkUhOCeqn6UGw4E5/fVlDMvoFRCS+osA
         +8hsTuI90LFe1M3pVMiZOA8LfZLVgltssAbUD5h2LgsUZ00RV4vC1u/AByZlVg+lwuwK
         V3S8m3cBJxoLGXtzWUGrx9jCy4no4jrI79wyBnkNOnoeVhfwNU2EenO2HuXZETSD5mZx
         yYA5mrQC3uCRXWZ7XLBfWhSQTeYJ5QzLi4eKssLmWRONCYCTejN7+ub1OWXzxkKBnGqA
         qsB162v87yn6cptjR9mhm+ySKfeTFPoShR5z6vjUhXjiW+T1QZ5F8Q/Kr+s/79/ufE7/
         coCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VDys++9nPAXJ/IeTA0qkibvdlA55VU7W2NnVaB4XA3A=;
        b=SvyAAHA5A/bbYKk//mtl30Ptoe5pqqMzHYeJzW6moi1mono5B/gPUVwY8m5u6eXxhz
         n9czZ8jo+34v6keQ4orvugpr/x0pN4QQew13ap84G8fGYEu4S/ni89rUU2/83Td7UKNg
         A278Eu1g8fEVODUqR2HV88jd3VoZHgsvgjp9SKiSV2WyemxLP+8UZIetywIQfNfvzGKc
         9Ui/bjR8pSIoBV9KnUI/wPplNMF4OMSTvMtZtX73kR5ZMEtLCs2Xw5SgdFYGmG90Kz+p
         XZElJi3queyrcb72ydn4PoPV75q01fYDSTRIT5ZO240L01nsRuXQE1Z0HAfLj6Z1Y7tk
         WpbA==
X-Gm-Message-State: ALKqPweaeCwR+1P5Unr8aWzRh9H8qAtwKCPa4X8c4qsp7qbEjAIp1w/C
        dCi/WpxAJHa8NDSxpgY8OJ0=
X-Google-Smtp-Source: AB8JxZoM7W00l4XjEkrvXaLNBzVJJBqd9HfOeX9AUOY2dEG5qw2uu4YnE/7nCyRvyIcm4U5cLdWjKQ==
X-Received: by 10.28.11.78 with SMTP id 75mr2058067wml.32.1525751436936;
        Mon, 07 May 2018 20:50:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m64sm13190023wmb.12.2018.05.07.20.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 20:50:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v6 05/13] git.c: convert --list-* to --list-cmds=*
References: <20180429181844.21325-1-pclouds@gmail.com>
        <20180507175222.12114-1-pclouds@gmail.com>
        <20180507175222.12114-6-pclouds@gmail.com>
Date:   Tue, 08 May 2018 12:50:35 +0900
In-Reply-To: <20180507175222.12114-6-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 7 May 2018 19:52:14 +0200")
Message-ID: <xmqqin7yn6us.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Even if these are hidden options, let's make them a bit more generic
> since we're introducing more listing types shortly. The code is
> structured to allow combining multiple listing types together because
> we will soon add more types the 'builtins'.
>
> 'parseopt' remains separate because it has separate (SPC) to match
> git-completion.bash needs and will not combine with others.
> ---

Missing sign-off.

> +static int list_cmds(const char *spec)
> +{
> +	while (*spec) {
> +		const char *sep = strchrnul(spec, ',');
> +		int len = sep - spec;
> +
> +		if (len == 8 && !strncmp(spec, "builtins", 8))
> +			list_builtins(0, '\n');

This is the origin of ugliness we see in later steps that follow the
same

	if (len == strlen(constS) && !strncmp(spec, constS, strlen(constS))

pattern added here.  Could we have a small helper that takes len,
spec, and constS to abstract "8" away?
