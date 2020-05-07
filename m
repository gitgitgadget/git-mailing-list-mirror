Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DA7C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 06:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB642075E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 06:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDd7WueO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGGKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGKd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 02:10:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D43C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 23:10:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so3443067pjz.1
        for <git@vger.kernel.org>; Wed, 06 May 2020 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=26GLvIqYQZYd2TQA4aIFjs/LBAdZqoe00csKNi9zx1I=;
        b=FDd7WueOkZFr5lNgGf4ZOpG6KpnNr99srruyMt4VAe4eerQIRXR2AcTQEZfEjKBgC2
         QG+Q3cU7hjaoKQ1x8+czpGeryqsn9EfC9EGsSH4z8sUSSh76/CqQaQ8sZ03HXvGT6MEw
         zzbPhYHsL4QNcRI+3mxuG6ieG+Nfq8jRVxPGd9Tj3qIisc05QP5001lcKKcbzk77xyFq
         9fp7YGM3SHUKrx+5i/KSE046v6iJ09rPUc25nFGNC3ipvyVwjrSNjGpaP4OmH0zhJRty
         MXkscnKjSwkiS6CIBuBPcRD+nI4YBII4//+ZfhUJpNT7o58OGQ0L4dFbIS6Zu1PneN9i
         zYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=26GLvIqYQZYd2TQA4aIFjs/LBAdZqoe00csKNi9zx1I=;
        b=KygQGqibDWEmQC6sUm+mGnPES3gB+sXmVIgfu5aFZ6tT2frTbaV9Lh7QS6cSOLUXxo
         2opdUx+1kqXqmfHEfJ7WeUgtC2A5o+VYtZwqKtpL2OTLLtZGPYSxZ3K40MLn3yWbE0M+
         7xomkdXP7MvKknBRMQfLuSd29wWCovea3S6t+hBNy0TsWf0GMuokwTAoXy/9GxFhrJ/4
         2gfpUO2TqvyHeOYSe1iEtbP842814/A/T2qdRvV7Wje6Ikwr6esblnHoTRz11zVadYdA
         bSCK3Ad4T4gZbuC9EXitKaIvocaFSGgynMQSvzHVi4jhlXIxd6R7qjWxlbEqPSqCHXP2
         zzoA==
X-Gm-Message-State: AGi0PuZP8qzU2dc0zur+JxSwZ7l7wgVwHEs1wSZ9bBHF0VtNHaOUzl86
        fhKb6nzxte3SjwDyVtuUIDg=
X-Google-Smtp-Source: APiQypKEdFNXjsRjMXHHRoWCxUArM+htMPFl0AyMrobt5wMWZwl0r+ioQ/NVsmnHA71W5w/veBvtog==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr13668456pjy.136.1588831832360;
        Wed, 06 May 2020 23:10:32 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y21sm3670081pfn.148.2020.05.06.23.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:10:31 -0700 (PDT)
Date:   Wed, 6 May 2020 23:10:29 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200507061029.GA83231@Carlos-MBP>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <20200504174636.GG86805@Carlos-MBP>
 <20200504232511.GB29599@danh.dev>
 <xmqqlfm7cj7s.fsf@gitster.c.googlers.com>
 <20200506073045.GA52959@Carlos-MBP>
 <nycvar.QRO.7.76.6.2005061447010.56@tvgsbejvaqbjf.bet>
 <20200506134659.GA75901@Carlos-MBP>
 <nycvar.QRO.7.76.6.2005061624050.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2005061624050.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 04:33:47PM +0200, Johannes Schindelin wrote:
> On Wed, 6 May 2020, Carlo Marcelo Arenas Belón wrote:
> > On Wed, May 06, 2020 at 02:54:38PM +0200, Johannes Schindelin wrote:
> > > On Wed, 6 May 2020, Carlo Marcelo Arenas Belón wrote:
> > > > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > > > index 1b221951a8..a8f8e4106b 100644
> > > > --- a/t/test-lib.sh
> > > > +++ b/t/test-lib.sh
> > > > @@ -676,15 +676,9 @@ die () {
> > > >  }
> > > >
> > > >  file_lineno () {
> > > > -	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> > > > -	local i
> > > > -	for i in ${!BASH_SOURCE[*]}
> > > > -	do
> > > > -		case $i,"${BASH_SOURCE[$i]##*/}" in
> > > > -		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
> > > > -		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
> > > > -		esac
> > > > -	done
> > > > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" || return 0
> > > > +
> > > > +	echo "$0:$LINENO: ${1+$1: }"
> > >
> > > That suppresses the error all right.
> > >
> > > Unfortunately, it completely breaks the feature. At that point, `$LINENO`
> > > is either unset (e.g. in `dash`) or it contains the number of the line
> > > _containing the `echo`. That is totally useless information at this point,
> > > we want the line number of the caller.
> >
> > that seems like a bug in dash, which NetBSD sh doesn't have, as LINENO
> > wouldn't be unset.
> 
> And your patch makes this a real problem as you no longer skip the `echo`
> in the non-Bash case.

FWIW, at least NetBSD's dash (0.5.10.2) always sets LINENO

> > > Try this, for example:
> > >
> > > ```
> > > #!/bin/sh
> > >
> > > file_lineno () {
> > > 	echo "$0:$LINENO: hello"
> > > }
> > >
> > > file_lineno
> > > ```
> > >
> > > When you run this, it will print `4`. What we want is `7`.
> >
> > so you need instead :
> >
> > ```
> > #!/bin/sh
> >
> > file_lineno () {
> > 	echo "$0:$1: hello"
> > }
> >
> > file_lineno $LINENO
> 
> No.
> 
> Please understand what the intention of the current (Bash-specific) code
> is: in case that there is a failure, it needs to print out the file and
> line number of the actual statement that caused that problem.

that is what I got from the commmit message but then I was puzzled not
to find the line inside the test case that faile but instead the one
where the last test function was located.

eitherway, I was careless to send the previous version without checking
more deeply; indeed the use of LINENO in the original code was part of
that confusion and is therefore gone in this new one.

> Take this example:
> 
> 	test_expect_success 'For Carlo' '
> 		false
> 	'
> 
> Obviously, this will fail, and it will print out an error message. What we
> want here is that the file that contains that `test_expect_success` and
> the actual line number of this call are printed.
> 
> Your suggestion would be to clutter each and every such call with
> `$LINENO`, like so:
> 
> 	test_expect_success $LINENO 'For Carlo' '
> 
> I don't think that is sensible an idea.
> 
> Besides, it would _still_ not work, for parameterized functions that call
> `test_expect_success` and that are defined in `lib-<whatever>.sh`.
> 
> Example:
> 
> 	# in t/lib-whatever.sh
> 	super_repetitive_test () {
> 		test_expect_success "first $1" '
> 			...
> 		'
> 
> 		test_expect_success "second $1" '
> 			...
> 		'
> 
> 		...
> 
> 		test_expect_success "gazillionth $1" '
> 			...
> 		'
> 	}
> 
> 	# in t/t1234-actual-caller.sh
> 	. lib-whatever.sh
> 
> 	super_repetitive_test hello
> 	super_repetitive_test world
> 	super_repetitive_test good-bye
> 	super_repetitive_test dreams
> 
> We will not want to print out the line number of the call in
> t/lib-whatever.sh. That is what your proposal would amount to, unless you
> want to clutter even the `super_repetitive_test` calles, which would fly
> even less.

that was very useful to understand better the constrain that was referred
in the commit message and that forced to build a bash specific solution.

I have to admit too, I was confused by the code, but with the clear guidance
you provided I think the new proposed[1] version is also clearer, and goes
away with the problem that triggered this whole discussion.

Carlo

[1] https://lore.kernel.org/git/20200507055118.69971-1-carenas@gmail.com/
