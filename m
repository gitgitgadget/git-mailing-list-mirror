Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FDC20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 04:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeLJE2s (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 23:28:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37154 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeLJE2s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 23:28:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so9025919wru.4
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 20:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5i8pKW7nlXFfYB6qxKeqKMkpzoYUvniGQcp+PmRuz0U=;
        b=rytzNAugvgAY0x5N6D0Ri30GyR4AZfpkQ+r4ECD9mRV/WH812w82uy816JC+lSwruD
         YWp3dqss2RkkNkb0KSBg6+gYJDEt6VS/18dihaO1OiBYM2C5Cnb59bmMdJgN8hHl2+BN
         XE2diCFGBHDnqHoq6/iT0/KpTlbzKtxveiob34ZuPoxfguVmGGugLY9mz3J2wJXmOm51
         4d9LbrWjpZIezhKBHnQ9UgksgLevJxMtaJq1X2L5ETHZMMVdT0iUzRm6p6fVJECi6NyJ
         RCk3Dauk5gvUf4ObT1AsJQ09H/wy77bUkVKpQV8pyYGvz7EccJSul0zH84X+1mdRwU0A
         sLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5i8pKW7nlXFfYB6qxKeqKMkpzoYUvniGQcp+PmRuz0U=;
        b=oDwgjPNN7fwYtNuWzbvHkr0ZJ+Y9vK/9jsPKMFCeI3ESCMecsz24beIyPp5WeKgMQi
         jKcCULM0/1xG2JeBxLJcVMpHehIqb2OU9VAdSEoKH581AVnN6ggNxXbQ2Umvn/okke50
         GPB0zsKpjBBBCRqfF+alCUJ+z+GZXWqmuwaBiZXD+FIRtsOK2B5q0nMeQt6ok4A0DnVN
         KG9viQaJ0v1qjVcVQSx7tx+HkUnA00as7+MW4A0Vv/q3WuITKJXs+dbZFbQNTuGx3cv+
         1Xw8AFtgjH+WJYR1du4qmpYoqzKyYcRmcIG7/uxargsZwZjLuw/OWYMyz5z/zUvC3n3c
         RMbw==
X-Gm-Message-State: AA+aEWZoK0KHAfjPrXjusHDV5K+/ZcQQM9BdEHPE2AHPT88PhMWpNcr3
        qsJnACV8/S5khfOPmgFEy50=
X-Google-Smtp-Source: AFSGD/XebgdsmILet/zfxzzZBswOyremM1of0a6uqq8C+6OVG1sxQy+6b/9ah4xttsOfpoccxYkCcg==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr8452952wro.29.1544416126610;
        Sun, 09 Dec 2018 20:28:46 -0800 (PST)
Received: from szeder.dev (x4dbd2199.dyn.telefonica.de. [77.189.33.153])
        by smtp.gmail.com with ESMTPSA id l20sm29156738wrb.93.2018.12.09.20.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 20:28:45 -0800 (PST)
Date:   Mon, 10 Dec 2018 05:28:43 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20181210042843.GQ30222@szeder.dev>
References: <cover.1544127439.git.steadmon@google.com>
 <cover.1544221121.git.steadmon@google.com>
 <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
 <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 09, 2018 at 01:01:29PM +0900, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index 5fe21db99f..5b6b44b78e 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -366,24 +366,30 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
> >  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
> >  GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
> >  
> > -# usage: corrupt_graph_and_verify <position> <data> <string>
> > +# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
> >  # Manipulates the commit-graph file at the position
> > -# by inserting the data, then runs 'git commit-graph verify'
> > +# by inserting the data, optionally zeroing the file
> > +# starting at <zero_pos>, then runs 'git commit-graph verify'
> >  # and places the output in the file 'err'. Test 'err' for
> >  # the given string.
> >  corrupt_graph_and_verify() {
> >  	pos=$1
> >  	data="${2:-\0}"
> >  	grepstr=$3
> > +	orig_size=$(stat --format=%s $objdir/info/commit-graph)
> 
> "stat(1)" is not so portable, so you'll get complaints from minority
> platform users later.  So is "truncate(1)".

I complain: this patch breaks on macOS (on Travis CI), but in a
curious way.  First, 'stat' in the above line errors out with:

  +++stat --format=%s .git/objects/info/commit-graph
  stat: illegal option -- -
  usage: stat [-FlLnqrsx] [-f format] [-t timefmt] [file ...]

Alas, this doesn't immediately fail the test, because it's not part of
the &&-chain.

> > +	zero_pos=${4:-${orig_size}}

No && here, either.

> >  	cd "$TRASH_DIRECTORY/full" &&
> >  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> >  	cp $objdir/info/commit-graph commit-graph-backup &&
> >  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> > +	truncate --size=$zero_pos $objdir/info/commit-graph &&

  ++truncate --size= .git/objects/info/commit-graph
  t5318-commit-graph.sh: line 385: truncate: command not found

Note that even if 'truncate' were available, it would most likely
complain about the empty '--size=' argument resulting from the 'stat'
error above.

Alas, this doesn't fail the test, either, because ...

> > +	truncate --size=$orig_size $objdir/info/commit-graph &&
> >  	test_must_fail git commit-graph verify 2>test_err &&
> >  	grep -v "^+" test_err >err

... here the &&-chain was broken already before this patch.  However,
since this above command was not executed due to the missing
'truncate', it didn't have a chance to create the 'err' file, ...

> >  	test_i18ngrep "$grepstr" err

... so 'test_i18ngrep' can't find the file, which triggers its linting
error, finally aborting the whole test script.

> >  }
> >  
> > +

Stray newline.

> >  test_expect_success 'detect bad signature' '
> >  	corrupt_graph_and_verify 0 "\0" \
> >  		"graph signature"
> > @@ -484,6 +490,11 @@ test_expect_success 'detect invalid checksum hash' '
> >  		"incorrect checksum"
> >  '
> >  
> > +test_expect_success 'detect incorrect chunk count' '
> > +	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
> 
> Implementations of printf(1) may not grok "\xff" as a valid
> representation of "\377".  The shell built-in of dash(1) for example
> would not work with this.
> 
> > +		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
> > +'
> > +
> >  test_expect_success 'git fsck (checks commit-graph)' '
> >  	cd "$TRASH_DIRECTORY/full" &&
> >  	git fsck &&
