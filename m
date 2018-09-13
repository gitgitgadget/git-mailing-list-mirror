Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB30B1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 19:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeINANT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 20:13:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34792 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeINANT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 20:13:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so5510160eds.1
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TPBIC274X/X+sZFEIyWTXbHXqSJyWPF0vjIaxh0xcNA=;
        b=tqgpTZuTjEn58pYEJlcZj6xQ5GFpnXZlSDtvnyvQWxYt0sldZJZGisxKGYrq5gaFmF
         HXuNV4/BzcPz2aBi0DxiE6v052bgBXucXI/g80TTVmLnKymHicz2xzOSxylbbvcfmfL0
         W+QPgD0IDefWXE9FCbAhATCcOdmmB4mnAcYGI3kQU/jCmOGnfuZjt1pdx+lwvQ3lOB45
         ndCf5Wrr7hipmdrWPq6Zqa6EAsfHbURWIshGq7lQMhg2xDSNPyTsZ2YkNobqqOkiUuqD
         edn2Z4pEtSufGyavGLld6YNzNZ+wJCr88fi1dYRgv5cghHOWKb4IiS9vOSRRTgoKCNJW
         6VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TPBIC274X/X+sZFEIyWTXbHXqSJyWPF0vjIaxh0xcNA=;
        b=MM+e4ii2PJhuMNO7VVjlyHQbXn6s3WvrABbJJod3bqY2AmvVaSgTmtvsBgawT8Cl29
         2UH7sofj1p1HQtLNZiokYdvqFP+K7hdvFkl4rcZpnrAoKS6uge44Q5MH1OdgXYUvwhXJ
         lQkqf82kTFAWgmXU6R1ch7GFE41ki/QA7n8j23LU7G9WLx8bur1Gtb64Q0oJ5i2UjGD5
         YLqbefg7M8X/+ppyAuPVn468yDEVQiAMrjTzmewRSehFUUSAQzitEikXwWX0OQTlxkBb
         dV379Ic4yhBfxXyCINuaY9rZ8XUYlZ4VW9pNTHzQhZgUmU3PYFob/mSlNLPCc35zasQ3
         kDcA==
X-Gm-Message-State: APzg51BAmk2oqn6GRzk+RMjziwASrXrDoqe7RxmZSQ4hkKjYTRd/Zim4
        l8H4QITLQt3EG6JAFM9TV9A=
X-Google-Smtp-Source: ANB0VdZC5HOn2SOtR99NIs403Wb/36JSxa9fhvOIYuVjeTeAVttnNw+fdU8K05rbyN8eHB2Ryspb2Q==
X-Received: by 2002:a50:fd84:: with SMTP id o4-v6mr12794560edt.116.1536865350749;
        Thu, 13 Sep 2018 12:02:30 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id w41-v6sm2363391edd.92.2018.09.13.12.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 12:02:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 10/11] multi-pack-index: report progress during 'verify'
References: <pull.34.git.gitgitgadget@gmail.com> <pull.34.v2.git.gitgitgadget@gmail.com> <29ebc1716123a953663c43064d73b98cf2fe0cbd.1536861730.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <29ebc1716123a953663c43064d73b98cf2fe0cbd.1536861730.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Sep 2018 21:02:28 +0200
Message-ID: <87ftydkypn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 13 2018, Derrick Stolee via GitGitGadget wrote:

> +	progress = start_progress(_("Verifying object offsets"), m->num_objects);

I think in the spirit of my "commit-graph {write,verify}: add progress
output" it would be better to say:

    "Verifying multi-pack-index object offsets"

I.e. both to make it clearer what's actually going on (without much
added verbosity), and also so that when the user turns on this feature
it's clear what gc / fsck etc. are doing for that feature in particular,
as with the commit-graph.
