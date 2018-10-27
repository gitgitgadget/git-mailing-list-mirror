Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CFF1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJ0QG4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:06:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40245 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0QG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:06:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id i17-v6so3368783wre.7
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7v0cKVukJpRMIfcm0930DXFWvzthwnjxw0W2vZXwMno=;
        b=gwLrU0iQPVZPq7UwLDLdBE8zQ6Cxw4tf6l07ttaTUUZx79/OVLKRR/p6pYepiWlrEZ
         rQow++8lqjNPyNAxInlZL65qUUO2aerCl+6hvwI9+xkzo+pHClExAF8uHQxQNYPdNfzK
         iIGirK4evrk1ZCDNTZVgrt1SJgX7/4KBiov2o6D4EWbs/r5V9YdV8BBBho7icz4Dqm18
         LFn15RB3Eu2tvOyPE6aU02rVXop3xQ0K8HqZsFfE4KlNgzDiIfzVWc61MAwWYoCVNEdS
         +PBlkFeZsRalPaw+YDQhyJk1dNS2soHKsv3lgYYy60TccPIPJrUgtLs/gb30L32RO5iI
         0WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7v0cKVukJpRMIfcm0930DXFWvzthwnjxw0W2vZXwMno=;
        b=mExdi7ZSjcYO3QWb/6NOY/J/U6NXFv2sojguunoGFgczQpHg+L0BmBmtofq94T+G1c
         OaaKeMO58ze5wkAmvvbqk85AKMzahZ5lg9k+39D3S/pyYnnG2ac6zRGSaW048vyt+5UO
         DaOWk9lphAHvqNBHzcOTXigwMa+XYxRUQyk9wT1iYwXgjgFBKvnO3zaM42mI3pxq0CCQ
         h6kBPg1sen9wc1ePj1TB938SartGFcwc/rn2JUUdjcLo7+C7LfMn9LZu0sZbK/IdMpXt
         AQoLymodWGkUoWoylwTaUc3vvUIC2hCbI11MwmoxKH/Rm+s7QE5nRdlmY6IIMDlIsTKg
         ZgTQ==
X-Gm-Message-State: AGRZ1gIk4aOyvFps1Q/4CwOAzHmpcdyL5pyAXkutpim9ksuPk8uG0Qy3
        +OlkTOZtLxAEumJMAJhITDFAQJkC13A=
X-Google-Smtp-Source: AJdET5dOV/Z06QdO9nuN8a/bKtNix1c0NuD+NOSaL6DrPskhcdFSstF3CVYSrDtKC7jBx2wkj1DH1A==
X-Received: by 2002:a5d:4b91:: with SMTP id b17-v6mr8441442wrt.168.1540625212602;
        Sat, 27 Oct 2018 00:26:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 12-v6sm2314808wmu.39.2018.10.27.00.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 00:26:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Jansen\, Geert" <gerardu@amazon.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
        <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
        <87o9bgl9yl.fsf@evledraar.gmail.com>
Date:   Sat, 27 Oct 2018 16:26:50 +0900
In-Reply-To: <87o9bgl9yl.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 26 Oct 2018 22:38:42 +0200")
Message-ID: <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But as Junio notes the devil's in the details, another one I thought of
> is:
>
>     GIT_OBJECT_DIRECTORY=/some/other/repository git clone ...
>
> It seems to me that ...

Actually I take all of that back ;-)

For the purpose of this patch, use of existing .cloning field in the
transport is fine, as the sole existing user of the field wants the
field to mean "Are we starting with an empty object store?", and not
"Are we running the command whose name is 'git clone'?".

Now, the logic used to set the field to true may have room to be
improved.  We should do that as a separte and orthogonal effort so
that the two cases I mentioned plus the new one(s) you brought up
would also be taken into account, so that we can set the .cloning
field more accurately to suite the two callers' needs---one caller
is the age-old one added by beea4152 ("clone: support remote shallow
repository", 2013-12-05), and the other one is what Geert is adding
in this thread.

We _may_ want to rename that transport.cloning field to better
reflect what it truly means (it is not "are we cloning?" but "are
there any objects in the repo to worry about?") as a preparatory
step before Geert's patch, but I do not think we should make it a
requirement to take the "let's skip collision check" patch to
improve the logic used to set that .cloning field.

