Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA9E1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeH2BSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:18:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35437 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2BSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:18:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so3431103wmc.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ILwH/4XGMey2nTELTriw0GN95lHMxg8upfs69O4Y0UE=;
        b=MkPhvAY3JgmKFD5VFM17k/W/U2Zs7RKIvQ/cgDJzOIExzGuXaoCyQo2yCAsy5jMF0j
         bFDrJQDg/iEqzsxKIS6igdnGG5ZnuhNug217Htv5bm4CV7hhIqGjyzaXbUvngecR0t5V
         ZKHMLgOIjY//w0LfrNxxzIdvE7mpEQ0tM8vlZxYI4ODpnwikV7OKjanixOts1E0TKTLP
         qrpm7yqhDDfRwiNdGVbG5+TSsLTWAZi3pq9nFZpGCmwoVN2lheMk6AuK0rgbO0aSTMB6
         Wvn8PnAazEoigyEtcfDTcKpVBffD9jw4I+RA4nusZcYvyv/550e17tf0x7wxbHkPD3rR
         yr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ILwH/4XGMey2nTELTriw0GN95lHMxg8upfs69O4Y0UE=;
        b=gZQ1y9MTM1/00H64kwAFOexa2l6zfjs/p9bN4t9HpRHB+yvLzFqQ3m6X2iywmELnIO
         GY2fSLC+VSthcG1uSjsBN7jcmA8xqHmRp6NDXT8n8sQvMe/wPEtN8B3K34/EUk4DOidv
         S0z25cZ20mwCIKgIgf/UN9eYkR4wCK7O4TXzhNBIkWpaAlFG/jHVJouCIyOMkMWN7/hY
         YNLG16cF6fOAawBqHuvYHWhz5O25phLjwOSjIUdIh6X2LUw5FXm8n8pG6w484Qnfmum7
         tVEbQlJwmuDvU0O+RVI/Ue4vCJXGDYdpBYQ9hUHkz6xYp0Rd/0oKF2BLr7v3ulPgMwGv
         gxMg==
X-Gm-Message-State: APzg51ARzASeF1RDkcC6PAV1bibd57Hc4SPztBaqdMAqzdcU0srSyXXT
        oufsZe+R9XACVJkjcYzJ6Qo=
X-Google-Smtp-Source: ANB0VdZ4nCoDOfyHzzpLCAQLDyzenboKLPmDRAg69tUMP8BOCAwIf5GWlyebmsP2jEn/SCuhHQot7Q==
X-Received: by 2002:a1c:3a08:: with SMTP id h8-v6mr2583370wma.126.1535491491525;
        Tue, 28 Aug 2018 14:24:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 20-v6sm5070678wmu.21.2018.08.28.14.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:24:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, christian.couder@gmail.com,
        haraldnordgren@gmail.com, Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [PATCH v6] Implement --first-parent for git rev-list --bisect
References: <20180828123234.44582-1-tiagonbotelho@hotmail.com>
        <nycvar.QRO.7.76.6.1808281512240.73@tvgsbejvaqbjf.bet>
        <xmqqy3cqfi8c.fsf@gitster-ct.c.googlers.com>
        <xmqqbm9mfcf4.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 28 Aug 2018 14:24:50 -0700
In-Reply-To: <xmqqbm9mfcf4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 28 Aug 2018 13:45:19 -0700")
Message-ID: <xmqqwosadw0t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Something like the following, perhaps?

Having said all that.

> +# See the drawing near the top --- e4 is in the middle of the first parent chain
> +printf "%s\n" e4 |
> +test_output_expect_success '--bisect --first-parent' '
> +	git rev-list --bisect --first-parent E ^F
> +'
> +
> +printf "%s\n" E e1 e2 e3 e4 e5 e6 e7 e8 |
> +test_output_expect_success "--first-parent" '
> +	git rev-list --first-parent E ^F
> +'

The above two are probably not controversial.

> +test_output_expect_success '--bisect-vars --first-parent' '
> +	git rev-list --bisect-vars --first-parent E ^F
> +' <<-EOF
> +	bisect_rev='e5'
> +	bisect_nr=4
> +	bisect_good=4
> +	bisect_bad=3
> +	bisect_all=9
> +	bisect_steps=2
> +EOF

Perhaps this one isn't either.


> +test_expect_success '--bisect-all --first-parent' '
> +	cat >expect <<-EOF &&
> +	$(git rev-parse tags/e5) (dist=4)
> +	$(git rev-parse tags/e4) (dist=4)
> +	$(git rev-parse tags/e6) (dist=3)
> +	$(git rev-parse tags/e3) (dist=3)
> +	$(git rev-parse tags/e7) (dist=2)
> +	$(git rev-parse tags/e2) (dist=2)
> +	$(git rev-parse tags/e8) (dist=1)
> +	$(git rev-parse tags/e1) (dist=1)
> +	$(git rev-parse tags/E) (dist=0)
> +	EOF
> +
> +	# Make sure we have the same entries, nothing more, nothing less
> +	git rev-list --bisect-all --first-parent E ^F >actual &&
> +	sort actual >actual.sorted &&
> +	sort expect >expect.sorted &&
> +	test_cmp expect.sorted actual.sorted &&

By sorting both, we attempt allow them to come out in any random
order when sorting done by --bisect-all gets tiebroken differently
between commits with the same dist value.  As Johannes said, this is
a bit too strict to insist that E *must* get dist 0, when the only
thing we may care about are e2 and e7 get the same dist value, which
is larger than the dist value given to E, etc.  If we wanted to ease
the over-strictness, we could omit " (dist=N)" from the 'expect' file,
and then

	sed -e 's/ (dist=[0-9]*)$//' actual | sort >actual.sorted &&
	sort expect >expect.sorted &&
	test_cmp expect.sorted actual.sorted &&

to compare only the object names.

This over-strictness would have caught a bug in Git if we reverted
this new feature (i.e. "rev-list --first-parent --bisect-all" does
not refuse to work---it just does not do what we expect), which
gives distance of -1 in the output (!).  From that point of view, I
think it is also OK for the test to be spelling the values out like
the above.

> +	# Make sure the entries are sorted in the dist order
> +	sed -e "s/.*(dist=\([0-9]*\)).*/\1/" actual >actual.dists &&
> +	sort -r -n actual.dists >actual.dists.sorted &&

I forgot to mention but I added "-n" here to make sure we
numerically sort the list of distance values.  Also you had a bogus
regexp to catch digits inherited from "something like this" I showed
in an older discussion (I think it is sufficient to say [0-9]* here).

The above makes sure that commits that have larger distance number
are listed earlier in the output, and we do not care if which one of
e4 or e5, both of which have distant number 4, is shown first---we'd
be happy as long as all the ones at distance 4 are shown before the
others at smaller distance number.  So with this in place, I think
we can omit the exact distance number from the earlier part of this
test, but as I said, it would have caught the bug that produces a
negative distance value in the output, so I am still on the fence,
leaning a bit toward being stricter than necessary.

> +	test_cmp actual.dists.sorted actual.dists
> +'
> +
>  test_done
