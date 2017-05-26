Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F21209FD
	for <e@80x24.org>; Fri, 26 May 2017 00:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762884AbdEZA6i (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 20:58:38 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35810 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752975AbdEZA6g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 20:58:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id n23so182077041pfb.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s1ZvRi5XD2ijP8PGarhRkq3dJwkW75P8VnntESv8cVw=;
        b=YXjBRECeHRLd2jhkdrK0KlC49lPcDGqNCtnFdsQC71RCptdNxMxV+td2BGYI0/svgU
         5zTHbBpiO0GLYeyCkdpF501xw70Q/UqT0qxvmIN4C0zIF8nv48sx4D694ZeqWJ5yDJvM
         cKWHK18F2NJx34vqAOpoP+RW51+sa77q3gmi4TFfGUEPkU4HrBIzk2eXNGgs/styy21c
         qrqofTRLr3DtQpFQWojSO9XUM198PRMv3YcpNq6WBtFc2voyGXX2DrKJVp2WJVlHG1Eg
         hwVQMJ96xk+m63lm44BqJtmNAOVz785mIlJCFV3Bx4pGI20zCezb0MIEP6NuRXnYmr+z
         kdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=s1ZvRi5XD2ijP8PGarhRkq3dJwkW75P8VnntESv8cVw=;
        b=sHHnru9Tz8Wqll6fas1Ya7DsBm67k0CbgbxGdaC7Sola6z/tFHcTV6zjdIz9yGlEWu
         S4d9lVIJLju5UkNmwp+DjQHRmxVLEBKycTMZZC9FHZiVfDJnlFtlQx7lZdhBle/7Pvna
         dr8OfPriko2OGuhcaJtisyE6euV1Q1QXQeuEkvvQwCWbudVQZ6r2ok1NYPS5d5GD/aL/
         FMf50vnPBLcfwnF76+/SVwBES1IbxJ1jy8Vik0I1mEbm9vYOKsZc8zLa2VoqrRheK45k
         UaiUWW329HQMr665EFAfUYMfsTIv1vGy8wOwcA7B04eQ4dMr0jWZbLrO6IhuopIaL3Uf
         5zEg==
X-Gm-Message-State: AODbwcAtdbkl9Y66NcVcScDUvvoNsHs+8gtusr+OXH8cCoUBlZeDZosK
        myx7bWMBBEyCOA==
X-Received: by 10.84.233.205 with SMTP id m13mr53796669pln.72.1495760315722;
        Thu, 25 May 2017 17:58:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id s4sm2505759pgr.10.2017.05.25.17.58.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 17:58:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 1/7] grep: don't redundantly compile throwaway patterns under threading
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-2-avarab@gmail.com>
        <xmqqvaoqhnlw.fsf@gitster.mtv.corp.google.com>
        <CACBZZX51hmq-jCkwyDt6QWfLJ+qxziUV-Bef+yVDoViLNhC4dw@mail.gmail.com>
Date:   Fri, 26 May 2017 09:58:32 +0900
In-Reply-To: <CACBZZX51hmq-jCkwyDt6QWfLJ+qxziUV-Bef+yVDoViLNhC4dw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 25 May
 2017 12:33:32
        +0200")
Message-ID: <xmqqlgpkcu2v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think it's a pointless distraction to start speculating in this
> commit message what we're going to do with --debug it if it ever
> starts emitting some debugging information at pattern execution time.

OK.

> As an aside, I'd very much like to remove both --debug and the
> --and/--or/--all-match, gives some very rough edges in the UI and how
> easy it is to make that feature error or segfault, I suspect you might
> be the only one using it.

I agree that rewriting "grep -e A -e B" to "grep -e A|B" as an
optimization is an interesting possibility to look into, and I can
understand that having to support "--and" and "--not" would
make such an optimization harder to implement. "-e A --and -e B"
must become "-e A.*B|B.*A" and as you get more terms your unified
pattern will grow combinatorial, at which point you would be better
off matching N patterns and combining the result.

Ever saw a user run "ps | grep rogue | grep -v grep" to find a rogue
process to kill?  That would not work if the rogue process's command
line has a word "grep".  Because "git grep" is often run on files in
order to find the location the patterns appear in, "git grep -e
pattern | grep -v unwanted" shares the same issue--the unwanted
pattern may appear in the filename, and the downstream "grep -v" may
filter out a valid hit.  This is why "--not" exists [*1*].  I agree
that emulating it within the same "concatenate patterns into one"
optimization you are envisioning may be hard.

Attempting to optimize "--all-match" would share similar difficulty
with "--and", but your matching now must be done with the entire
buffer and not go line-by-line.  It was meant to make it possible to
say "find commits that avarab@ talks about both regex and log", i.e.

	$ git log --author=avarab@ --all-match --grep=log --grep=regex

This is not something you can emulate by piping an output of grep to
another grep.

But none of the above means you have to give up optimizing.  

You can choose not to combine them into a single pattern if certain
constructions are hard, and do only the easy ones.  If you think
that harder combinations are not used very often, the result would
be faster for many cases while not losing useful features, which is
what we want.


[Footnote]

*1* For human consumption, lack of "--not" may not hurt in the sense
    that there are workarounds (i.e. you can do without "| grep -v
    unwanted" and filter irrelevant ones by eyeballing).  But it is
    essential while scripting and trying to be precise.
