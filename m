Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7261F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfFXND2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34365 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfFXND1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so14375861qtu.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8X2BSJcVbPC/qXy/B6w2PeSlmlVMpB7+AZbRgJjA/EQ=;
        b=o8F58D473Z61xUZM7b9Hpf9BGawJ0h2ff7hm/dOldcHFDvug6Uvw0c+pyjQDhSruXu
         EFttNA4YOIAgQpfVmNs+Vyt9sbe7akxsPK4bQkD58hx+sAHt1tK+KcDnqfsniAUz7xGK
         XreLu0KPSSzu5lICIWS536AColP8mNRK2zfXSWQvAJB3hYJNaC/dk2dEzRF2qg1QZowT
         FCOJeYzvcj1kre6WRALBCFC+xNPyc0Byk7Fsx/h7da2n9I4UFCxHO3Fp853qgZH2uJ1q
         O2FXdoK4jDQSnr9nznPw4TyMAJ9u9o7cCNrN8HMLLoqOEycP0351U2jrR6XZtvyjARjR
         NTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8X2BSJcVbPC/qXy/B6w2PeSlmlVMpB7+AZbRgJjA/EQ=;
        b=RcC+DnqgnVi+MaFGyoVnL13aog2zGy/6mMUZP+PzG8rs9vBGlteHG8Ds66iylY5qxm
         nN+TYCy6gTVmQ6yF9orljwvUezIn8BXdJRWyMX/3c/1lZu7TIprgQcZolJhaGKkS40BU
         QsuH4eYlrDt2bEDRJ3LD2USvHDF3zEV/XzgOjcZvpZkhfJsi03B6c99PM2xxIu3t6kMz
         8gbBoV24zJlYLTL1X+k258JPY2xMxRXpYIq2jNDksXw8VI4YveaRR87trsnBmjOTBzZ5
         E+viwYQByReIJypo8iCE6t/qENHZVNr6jCiletl3SloWxEe7B41RVZzpV/EMDdVCRr8d
         CuIg==
X-Gm-Message-State: APjAAAVW3PaESSQdtET+B0rYI8z2ACxBZrXQMhC0e/caOnoOKyneC9Cn
        9hqn6GHIYsrX5iu48i7S0SQs01gC
X-Google-Smtp-Source: APXvYqz3fB2SoN4w8fTItBkM4/TFAYOOM16OgOZurnsBDsbR8BCnM1NwghQ9P9qpcTxE9ovQmkQD7Q==
X-Received: by 2002:ac8:f13:: with SMTP id e19mr127718682qtk.11.1561381406741;
        Mon, 24 Jun 2019 06:03:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1010:6e41:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id f5sm4649509qth.35.2019.06.24.06.03.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:26 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] repack: add --sparse and pass to pack-objects
To:     Nathaniel Filardo <nwf20@cl.cam.ac.uk>, git@vger.kernel.org
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
 <20190624120711.27744-4-nwf20@cl.cam.ac.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <25cd9bcb-9b8f-662c-75d2-a5b32d7febbc@gmail.com>
Date:   Mon, 24 Jun 2019 09:03:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624120711.27744-4-nwf20@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 8:07 AM, Nathaniel Filardo wrote:
> The sparse connectivity algorithm saves a whole lot of time when there
> are UNINTERESTING trees around.

Neat! Any chance for some example performance stats?

> ---

Looks like you forgot your Signed-off-by here.

> +# repack --sparse invokes pack-objects --sparse
> +test_expect_success 'repack --sparse and fsck' '
> +	git repack -a --sparse &&
> +	git fsck
> +'

This test may not be enough to properly test the sparse
algorithm, as it is only really enabled when the --revs
argument is given to the pack-objects process AND there
is a "NOT" ref (i.e. "!{oid}" over stdin). Using "-a" here
will not have any "NOT" references. OR maybe this already
is enough when you have the .keep packs. Is there a way
you could set up the packs in this test to explicitly be
in the situation you describe where the sparse option
speeds things up?

It's hard to check that the '--sparse' option is doing
anything in a test, but it is important that we run the
logic. One way to see if this test is doing anything is
to insert a die() somewhere. For example, this die()
statement will check if we ever needed to mark things
uninteresting in a workdir path with both UNINTERESTING
and INTERESTING trees:

diff --git a/revision.c b/revision.c
index eb8e51bc63..8835f8e7b1 100644
--- a/revision.c
+++ b/revision.c
@@ -227,6 +227,7 @@ void mark_trees_uninteresting_sparse(struct repository *r,
        if (!has_uninteresting || !has_interesting)
                return;

+       die("we exercised the logic!");
        paths_and_oids_init(&map);

        oidset_iter_init(trees, &iter);

The implementation of the argument looks straight-forward.
It appears we are passing the argument to the sub-process,
so the bitflag isn't used yet.

-Stolee

