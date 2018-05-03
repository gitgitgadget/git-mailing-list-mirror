Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB78200B9
	for <e@80x24.org>; Thu,  3 May 2018 05:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeECFNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 01:13:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36026 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeECFNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 01:13:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id f2-v6so4318951wrm.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 22:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=okBbvuJ5iZKmD46UQtzNtWhU5NFishMZtOgabtRezrk=;
        b=q3vXCwrB1E4dlEOLYlqUe5P+LaVTG8HS8QFaL3a/Nf14/4bTqKL/R/NHkVIv+DAhhU
         KbBDzxd8+TNiXXaOlC3uEpLq2h0MIIkeOnnrhhV4MO2trfZDUnppuSypklaFNiGEUzhc
         ATaNqEnUBGVbUmbu7SuN2MUL8wD7s1HqhKNtoA21t1ajMV2roq0F6NoYC7kk5vWqc+aO
         Cy9iWg14mWyclYhbPnkl2B72KahVCWFcsLqMRd9NAtfuThdeOqQwy+435nJIP8KSMJrs
         u5g25pOB17ZNt6/5ViaMwEEgBYBsjtTMdkSXIdkeqdkH0vZ99IJq3LOWNFQxouulN+jm
         hMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=okBbvuJ5iZKmD46UQtzNtWhU5NFishMZtOgabtRezrk=;
        b=PAhk7S1l5HyM3CixOvDmSo/zGGnirQzu+j29L3kcUeZVgwRoe5BRB3qhB/2XqbwEOK
         yHgYxuCgBG4OXzDi7tg9C4tkgH6ndIsUEHqYjoUOgKZ5k3aobpW71RFbUD+t+DFN8VK4
         dSuF6YO+/opJbauZL9GpwttgBpwmrya+MNu7SwLYWa4M9MlsbZP3wOSWfG4aBPS+Z2Kb
         syBBpbZgAulyE8l7o/1cE0O8Iw0i7Sbiq9v++OV/jnHnWAhxeeY+4438tGSJQncpApn9
         ime1v6CHFYEjdNpl+/G1EaQLbXwZ8Ow4qERyibxl4V6XNu50bLbG6PJ5C0zibWFDFF6x
         SONQ==
X-Gm-Message-State: ALQs6tCIg+NOD9TQuGSnzzwtlYlVV2B3T8bJDokgcBL3vfg9uHH3O8lR
        aXaevJ1fA9pMRUzgnbGLCsQ=
X-Google-Smtp-Source: AB8JxZoOpcBreIObFqSxjxl5b+eDsvUTnwfJui1vppcHX0bYQVz1ODeTZj3h+42pQR/t/ZxaW5T3zg==
X-Received: by 2002:adf:dfca:: with SMTP id q10-v6mr18201763wrn.49.1525324384783;
        Wed, 02 May 2018 22:13:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q138sm18434927wmd.1.2018.05.02.22.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 22:13:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 06/12] get_short_oid: sort ambiguous objects by type, then SHA-1
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-7-avarab@gmail.com>
Date:   Thu, 03 May 2018 14:13:03 +0900
In-Reply-To: <20180501184016.15061-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 1 May 2018 18:40:10 +0000")
Message-ID: <xmqq4ljpuxsw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +	/*
> +	 * Between object types show tags, then commits, and finally
> +	 * trees and blobs.
> +	 *
> +	 * The object_type enum is commit, tree, blob, tag, but we
> +	 * want tag, commit, tree blob. Cleverly (perhaps too

The missing comma between "tree blob"  on the second line made me
read this comment twice, which made me notice the lack of "and"
before "tag" on the previous line.

Assignment is "commit, tree, blob, and then tag" but we want "tag,
commit, tree and then blob", perhaps?
