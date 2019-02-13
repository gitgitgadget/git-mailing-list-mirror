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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEC41F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfBMK4W (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:56:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39432 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfBMK4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:56:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id f16so1901148wmh.4
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 02:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O7M280Xtju+JYjcMarCtteOipB2FSJ/I5Jnf3D4o15I=;
        b=fuo3HMrSwKXhe3Y3i/tmwFjlxd9SaVtrvdT1P7BBupRuCE0CIq1RLyW5m7DlEPKfZ3
         L5DuIZRD55mq+njpiQGPT0EsQH5B4yDNrjQ4jJNtK9ePX4/xWLaM+haqroYn4SI2CT93
         06Pt6GNi0FNmhSTqYv++DnOFKETggddbECc3lPciZ1Z5MPL+y7jSYRWWOkV0IGuHuirM
         8di6aObOvQNaeGF98Z4i/kVPZhDqz9gozaaBTUApp4n1k1McHOXsNx/QwVfecIf8usmw
         Of7gCssfM9RqnrWUo+q+xVDE6z84tHiRrXgSKbFwCqWrqVDP1IRze8E799Slu6N/E5Si
         hamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O7M280Xtju+JYjcMarCtteOipB2FSJ/I5Jnf3D4o15I=;
        b=Vatq4SsxYNwmwOUbGDev1nl7RNMWpm1gxhApBqw/Z4aDbEmzl2aFhGbytyj1TEtYAq
         BrlQLqt56LRaK4QmxSOYiRmpwP0HAM1FVMN45i2r5A8MBAKDwwJij3qX89nd4zc+Y5Ja
         mO+8PPK4obFTRbdC+/sMEQX99FG1CilWaYEnrv4D61kX/InGZvc3fFRUWBE2RS7whjBC
         Vb6FQO3xih0LVI3l5bpeGPe6jFtXJS/z49H/5+WhgkoJFDLUHwyw47SMPm0I7CEApBbz
         wz9211XDWopc2LJLR03xRfNgxxWjePH5vIesQoC2MiaE3jGmm9/6OHhiMNByNQ20eRB7
         kgqQ==
X-Gm-Message-State: AHQUAubUzdPz62TPLoPuHrQU9Ncjygp8dyv9wE+TlyNMw44WH51Q9nWU
        F7ewnHeJHv86ee12swHLwlU=
X-Google-Smtp-Source: AHgI3IZlNOsBmYMZBOMLZzy234XBUVn0FZ9P/2mH3l+cOMqgosoKq/k7BcJ4Pb9EPvPLm32kyl6vfg==
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr2805204wmg.27.1550055379714;
        Wed, 13 Feb 2019 02:56:19 -0800 (PST)
Received: from szeder.dev (x4dbe07c0.dyn.telefonica.de. [77.190.7.192])
        by smtp.gmail.com with ESMTPSA id 62sm40094730wra.46.2019.02.13.02.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:56:18 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:56:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190213105616.GH1622@szeder.dev>
References: <20190130231359.23978-1-max@max630.net>
 <87lg2kj91a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg2kj91a.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 11:08:01AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jan 31 2019, Max Kirillov wrote:

> >  refs/packed-backend.c               | 15 +++++++++++++++
> >  t/t3212-pack-refs-broken-sorting.sh | 26 ++++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >  create mode 100755 t/t3212-pack-refs-broken-sorting.sh
> 
> This is not an area I'm very familiar with. So mostly commeting on
> cosmetic issues with the patch. 

Just two quick comments in addition to Ævar's:

> > @@ -1137,6 +1138,20 @@ static int write_with_updates(struct packed_ref_store *refs,
> >  		struct ref_update *update = NULL;
> >  		int cmp;
> >
> > +		if (iter)
> > +		{

According to our CodingGuidelines, the opening bracket should go on
the same line as the condition, i.e.

  if (iter) {

> > diff --git a/t/t3212-pack-refs-broken-sorting.sh b/t/t3212-pack-refs-broken-sorting.sh
> > new file mode 100755
> > index 0000000000..37a98a6fb1
> > --- /dev/null
> > +++ b/t/t3212-pack-refs-broken-sorting.sh
> > @@ -0,0 +1,26 @@
> > +#!/bin/sh
> > +
> > +test_description='tests for the falsely sorted refs'
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +	git commit --allow-empty -m commit &&
> 
> Looks like just "test_commit A" would do here.
> 
> > +	for num in $(test_seq 10)
> > +	do
> > +		git branch b$(printf "%02d" $num) || break
> > +	done &&
> 
> We can fail in these sorts of loops. There's a few ways to deal with
> that. Doing it like this with "break" will still silently hide errors:
> 
>     $ for i in $(seq 1 3); do if test $i = 2; then false || break; else echo $i; fi; done && echo success
>     1
>     success
> 
> One way to deal with that is to e.g. before the loop say "had_fail=",
> then set "had_fail=t" in that "||" case, and test for it after the loop.

No, you can simply do 'cmd1 && cmd2 || return 1' in the body of the
for loop; that's why we have a separate test_eval_inner() helper
function in test-lib.

