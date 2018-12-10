Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B56A20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeLJV44 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 16:56:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39616 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeLJV44 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 16:56:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so6044491pfc.6
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNk5N8o6ZX5REJauOvA0PB2qFEwyp4uzUz09Qmvgxzs=;
        b=nQaV8pCuHy2xV6jBAFqFjLjfSDIQNmnbGjYAQrp2zVbivcQdSSKpn3T5IgvcX0OXzD
         sTDJ0x9sLkncAl1djx+ELhd68uhUrUHxLwB0LWkLTgic8ec5HegZTO0uWFRefxZkBLKB
         1CYGumPjTZ3w1TK85ncmakXi/5efTCicFDZXwdD6eYOAvgy7Zy9+XGTyCCdBwemdKf4f
         wZvgulVG1na+12JlkmWXEsXn/Ci01PKfl5zjKU2Q8NtPIZncSEEz1mzCGwFmf7QVkG1E
         TtSTl7A/wlTR7jK4suyCP8hopeAdnUKk/aHEX4wxa3ut7YGZMIRKIsGp555fxchQvyEp
         TQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gNk5N8o6ZX5REJauOvA0PB2qFEwyp4uzUz09Qmvgxzs=;
        b=Beq6jCb6amC7hLU9xoA5NvKQT0HjdiIxPHnW33k8ISUkQ00L6/LXpZy+56jbrITJO8
         mIIriZTVqQKbnypFJP4Tcxg/X3RPo4lqEH4/96cO7jvsBf1yu9yT0EtWGGiJPKVq4ah6
         Fenqjp1JhvspKipbv4VSmeEkVWoA6PrMABy8DuAsdUH8tUeAHTTCWt49wow8182Afk/P
         egJTOqRuhX/WDpIulj+cuHVV/5tyA2fwPYUwIkqRYtk2pVbYLlQPyL5rJjvc0DBosFYH
         tbmP8BT686+BO1mitNgFHUaQslVYxUXqRc24nAKDDF7fmDONyBoHueIE2rG+5pgsclfB
         9LDg==
X-Gm-Message-State: AA+aEWbehL1bVJDuOPupPR3x8rWELilO2tul1Q6RQ6vmL0nCXgV+34Y0
        X+oCD6cIhwunDySqVtu2qhx3zA==
X-Google-Smtp-Source: AFSGD/VEWLzuzKQXneeXPSBKZXDbqAtu+TMIhNyDyZPPWL2+ne78qOAkVzgc4VhftG8mOzFYJ8lP1A==
X-Received: by 2002:a63:e348:: with SMTP id o8mr12146077pgj.158.1544479014834;
        Mon, 10 Dec 2018 13:56:54 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id f20sm14977899pfn.177.2018.12.10.13.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:56:54 -0800 (PST)
Date:   Mon, 10 Dec 2018 13:56:49 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v3 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20181210215649.GC37614@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, peff@peff.net
References: <cover.1544127439.git.steadmon@google.com>
 <cover.1544221121.git.steadmon@google.com>
 <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
 <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.09 13:01, Junio C Hamano wrote:
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

Ack, thanks for the catch. I have a workaround for stat in the form of
"wc -c", and for truncate with a combination of dd and /dev/zero.
However, I'm finding conflicting information about whether or not
/dev/zero exists on macOS. At the least, it sounds like it might not
work on very old versions. Would this be acceptable, or should I add a
new test function to do this?

> > +	zero_pos=${4:-${orig_size}}
> >  	cd "$TRASH_DIRECTORY/full" &&
> >  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> >  	cp $objdir/info/commit-graph commit-graph-backup &&
> >  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> > +	truncate --size=$zero_pos $objdir/info/commit-graph &&
> > +	truncate --size=$orig_size $objdir/info/commit-graph &&
> >  	test_must_fail git commit-graph verify 2>test_err &&
> >  	grep -v "^+" test_err >err
> >  	test_i18ngrep "$grepstr" err
> >  }
> >  
> > +
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

Ack, will fix in V4. Thanks.

> > +		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
> > +'
> > +
> >  test_expect_success 'git fsck (checks commit-graph)' '
> >  	cd "$TRASH_DIRECTORY/full" &&
> >  	git fsck &&
