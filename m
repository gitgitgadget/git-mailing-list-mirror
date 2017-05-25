Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FFB63381B
	for <e@80x24.org>; Thu, 25 May 2017 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968495AbdEYGos (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 02:44:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35038 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965526AbdEYGor (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 02:44:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so37255948pfd.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rTpvhMvfk09Ag/kkHpZak4Kp4GJIcFQkO+1olbm/vbg=;
        b=Npad89mvw67rIsYZlZZvXPcmbMOwaxDHUyKCqWEDeQx7vJu/khWuQ2i0KtRZ3IkQK2
         uIMT4paAPQQXQDKiKjsjrxzhnkZqARm7TKNtUdvgq8TMDTHoPauGHZ/kjOT24n/Aiqes
         HU3I5y+XbaSoq762DLTafKAfpIrvtHF2XNnZMczcrxjI7eNTCBGRNdC80wyU/3Zdt+FV
         YSAfGTaXPfG7KUEeDMM1J6/frPKbfISUqhCxTPf/mlb0bXGaLl6H1bg9jedow4CJjoUp
         sj1pRFoaWlf17W9Yb/3Pj8LC5+sbTX0gye5s/Qep0EXAm487DCfx/bC1Mh8fOqe/eNOK
         voHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rTpvhMvfk09Ag/kkHpZak4Kp4GJIcFQkO+1olbm/vbg=;
        b=HG5jkVgtDom2W1cm6ysPJV37F/J/3VBGmJHI2WUUQsHOzITqHWWJgM8wwiDrsRD6e5
         pmdmH6xLIFWaA8He05WPmZo3IzOhFlw1fMRRnDe0zhKA5PGaVTrBvcJCWYNIdVNU2SMM
         iBJ452Ip8HMwQ5poGr2pauCTZJEIc+Yf/NUGJGwfNFcBjFsR4pIgiubJRHDdzY4GZHpX
         3YYt/Jyv8exbVOH4a3ozrQGIgLRp+SCfSwkrxjHKr/PW/K6qxAT3qP72FVL2YFmgGJN3
         QKf4B4+TL9OeNB46DOVxsakP5yHI+gvwvo68qae3OatWbzc5sl/gCeU8UE7ZxUHLErYn
         hTqg==
X-Gm-Message-State: AODbwcCR/vAJ979Y/3coan+2l9q3aPsoy9jvx5Oq5RBcfFQ/OpDnEon2
        r8LjnaS6eQbqlA==
X-Received: by 10.84.215.212 with SMTP id g20mr7141572plj.43.1495694686618;
        Wed, 24 May 2017 23:44:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id d185sm1776813pgc.39.2017.05.24.23.44.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 23:44:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv5 00/17] Diff machine: highlight moved lines.
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
Date:   Thu, 25 May 2017 15:44:45 +0900
In-Reply-To: <20170524214036.29623-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 24 May 2017 14:40:19 -0700")
Message-ID: <xmqq7f15e8pu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to see how this is useful in code moving change, with
this command line:

$ git -c color.moved diff js/blame-lib~6 js/blame-lib blame.c blame.h builtin/blame.c

Some random observations:

 * You do not seem to have any command line option yet.  I guess
   that is OK while the series is still in RFC state, but when we
   are ready to seriously start considering this for 'next', we'd
   need something like --color-moved that can be used across "diff",
   "log -p" and "show".

 * As configuration variable names go, "color.moved" is probably in
   a wrong section.  Perhaps "diff.colorMoved" or something?

 * The fact that I am using

     [diff "color"] 
	old = red reverse
	whitespace = blue reverse

   on a "black ink on white paper" terminal might have an effect on
   this, but lines printed in either bold green and on green
   background (i.e. not new ones but are the ones moved from
   elsewhere) stood out a lot more prominently than lines printed in
   green (i.e. truly new additions), and I felt that this is totally
   backwards from what I needed for this exercise.  That is, while
   reviewing a code moving change, I want to be able to concentrate
   primarily of three things:

   - What are the new lines that are *not* moved from elsewhere?
     Did the submitter try to sneak in unrelated changes?

   - What are the changes that are truly lost, not moved to
     elsewhere?

   - Do the lines moved from elsewhere form a coherent whole?  Where
     is the boundary between blocks of text that are copied?  Do
     adjacent two blocks of moved text come from the same old place
     next to each other?

   Using colors that stand out more prominently than for the regular
   new/old lines is counter-productive for all of these, especially
   for the first two purposes.  I may suggest using cyan (or any
   color that is very close to the background) so that the presense
   of moved lines are merely felt without being distracting.  IOW,
   while reviewing code moving patch, moved parts want to be dimmed,
   not highlighted.

