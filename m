Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A60C83002
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 01:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB98420728
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 01:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKDo3Ri0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD1Bt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1Bt3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 21:49:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40658C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 18:49:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so9929154pfa.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Brb4pr54OiHg+MmxrZscq+2/RKKyaWavAD8TizN7nrU=;
        b=SKDo3Ri0QH3ZXIKzX6s13XoLe//NDVdvdcYBEtNz5Cei5cXKgkxrCLkTa1idtPFPXa
         CQwcd3gx3iPHthwcu+upaYWzgc9RwYJ+4PEzIoad/xtTlQTYDPoqXRUoyygx6Lw83pTE
         YJ5F4+6aILog8zwBR1elUBUnG0/hlxtvPkrZZY0DCxDAbuD2U1zhBqA2eFD2+sZEMG8/
         uKZnA9GutHiVfvyRBpqF9mjnw8Io9IHGe2vSlXe0khqIx1WnnjzUGCw4khWz1wB+VaCr
         3aqEyay6u6CjIr0u3rVqEPtmgmhnzcR63j981YxOMuX6OnCvj/ptAQ8UoRqU+UfN7bf2
         Q1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Brb4pr54OiHg+MmxrZscq+2/RKKyaWavAD8TizN7nrU=;
        b=gqN5DI99eb539N2n3MzGycJ8dmTduKMszVyYR1/i6W2kNMLWRbML8qLXGBrcXg9cEG
         zRd5KQX6bHb+HXTBJZtsALqRrgLS2rxHNCYbvbHpa4jk3hFtB2J845LaND5/luadLte9
         +PwccpCOQ9qsGNbcpdshmQjW4yrMh+NPib0+6GoPjd5pr6Ev/0fJbjkbLMFhzGEV5faZ
         jeLpByk4tfopfcPhp0jz5ZWF8uKxsX4Ez+73tnCnv7l4ILV/J8zszTgScvzBpTr4SjRx
         rsapuMqyCEnuhptgrLtjKrrYtZgLVuRQ8DUmHNfgedxYrOGBxzwnls8JFtbRBmrn2FOy
         cvaQ==
X-Gm-Message-State: AGi0PubEmWweOBEWM69LqW/RPE167qvTDfvvKHEPwt7Rgk/G30jO65cQ
        pHWlQoPoCPQUP9OJ28KaPeo=
X-Google-Smtp-Source: APiQypKuL5LEcafhve0Ip3w7H49t+lHKLsQ1oSDg8f6P3ZRmYKRKxUrRMnBYsYV7J273+3f+hYFrmA==
X-Received: by 2002:a63:5b5d:: with SMTP id l29mr25005289pgm.162.1588038568693;
        Mon, 27 Apr 2020 18:49:28 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id c4sm12166515pgg.17.2020.04.27.18.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 18:49:28 -0700 (PDT)
Date:   Mon, 27 Apr 2020 18:49:26 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428014926.GE61348@Carlos-MBP>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <de8523c6-b8f0-b12d-20e4-b2418bbc18eb@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de8523c6-b8f0-b12d-20e4-b2418bbc18eb@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 02:48:05PM +0100, Philip Oakley wrote:
> On 27/04/2020 13:59, Carlo Marcelo Arenas Belón wrote:
> > with the added checks for invalid URLs in credentials, any locally
> > modified store files which might have empty lines or even comments
> > were reported[1] failing to parse as valid credentials.
> >
> > using the store file in this manner wasn't intended by the original
> > code and it had latent issues which the new code dutifully prevented
> > but since the strings used wouldn't had been valid credentials anyway
> > we could instead detect them and skip the matching logic and therefore
> > formalize this "feature".
> >
> > trim all lines as they are being read from the store file and skip the
> 
> Does trimming affect any credentials that may have spaces either end?

all credentials are url encoded so the only spaces that are affected are
the ones that were added by careless editing of that file.

as Eric pointed out, any tabs will be silently "cleaned" as well.

> Should the trimming of leading/trailing spaces be mentioned?

I wanted to keep that as an undocumented "feature" as it is just meant
to help people to avoid a fatal error during the transition but didn't
want to encourage people thinking it is a supported part or even worse
encourage people to start editing their files to add tabs and spaces.

Junio's suggested documentation fix[1] makes that clearer that I could

> Also the git-credential page mentions that the credential must end with
> a blank line ("don't forget.."). Should that be mentioned here, or have
> I misunderstood?

that is for the protocol part of it (which is used between git and the
credential helper), the file format for this specific helper doesn't
require that.

Carlo

[1] https://lore.kernel.org/git/xmqqv9lk7j7p.fsf@gitster.c.googlers.com/
