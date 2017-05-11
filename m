Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C87D20188
	for <e@80x24.org>; Thu, 11 May 2017 01:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbdEKBsE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 21:48:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35445 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdEKBsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 21:48:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so1378015pfd.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 18:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iSeSmdFwulqq4+QmkpYSX+YSLePXEoJnOSYkXjUEG1k=;
        b=EB4N5/J1bW88grZT+jRsPSG9dLLSpwmaWWD2M8SS3VPR84S9/vQqv9rJ832L1OSbDe
         LyM+ebrfdmRQJgFaohVRL4j0gu9YsBM90yyJNKOixD+DqWEaSQhRSUu9DSuSGdd4XHLS
         XJ4uJTHV/wLrXF0TMjUNS0NBnvDJF8jHeheqyzt6jxezP/5+xQHkCSFf/N3SfP31sGht
         KudToYWe2M/S+OMH+TVspCPyoGWCEJmUFnCAhtVjefhO9PCbxmAhZL5jQmt4lTbR9cgU
         SOiCBdAupYBpeGGbMF91iUKS92Ik8jwreyzYiBSbk2n55enCoQJd46w9Hzn74r5vDGEQ
         tV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iSeSmdFwulqq4+QmkpYSX+YSLePXEoJnOSYkXjUEG1k=;
        b=JRLHXhkpUsvZebhvnraK8HuYCZeHpvOMxbqIiO5cJMx1mrsQQTMD51lIpOJ4nUzDH9
         2YsP1+lsxszLkpYlo9KYpUG73xKj5+COSDwnoUdKIFScNPwAVDyKhij4nTLVZtwfDvLP
         LR9xPlnjQYbWE8oklG3boMnWooaDjHc0EJklr+GugrLoWJPZXEfetH0t+9F+vCjYM3la
         XchGUyVIrz0t/ygPKWviLbMF3M3fJ/j+yXkeeWuxwzYe2RO+JZNkx75tX6Kt4+nXKDPD
         3CTgqj1DTXIVo8StRFJhFxYH8xjk5knuTVU6zixP28Ypg/NlkPcuM1URs0zGp2XQumJk
         ok9Q==
X-Gm-Message-State: AODbwcCyDt9YRjmpNJ2crvHD5XjazRB6RDkhACxnHjF0tGkkZ46wJvI9
        jfsi/G4ca53WPLuZhPg=
X-Received: by 10.98.68.197 with SMTP id m66mr9483458pfi.80.1494467282525;
        Wed, 10 May 2017 18:48:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id 66sm272892pgd.47.2017.05.10.18.48.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 18:48:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-9-bmwill@google.com>
        <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
        <20170510170226.GB41649@google.com>
Date:   Thu, 11 May 2017 10:48:00 +0900
In-Reply-To: <20170510170226.GB41649@google.com> (Brandon Williams's message
        of "Wed, 10 May 2017 10:02:26 -0700")
Message-ID: <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ls-files is the only command (that I know of) which does cache pruning
> based on the common prefix of all pathspecs given.  If there is a
> submodule named 'sub' and you provided a pathspec 'sub/', the matching
> logic can handle this but the cache pruning logic would prune all
> entries from the index which don't have a leading 'sub/' which is the
> common prefix of all pathspecs (if you didn't strip off the slash).
> Meaning you'd prune the submodule 'sub' when  you really didn't want to.
> This could probably be fixed to have the cache pruning logic to prune by
> ignoring the trailing slash always.
>
> So there's another option here if you don't feel quite right about
> piping through an index into parse_pathspec just yet.

Oh, don't get me wrong---I do not think passing an index_state
instance throughout the callchain (and perhaps later we may pass an
instance of "repository" instead) is a wrong move in the longer term
for various APIs.  I was just wondering if we have callers that can
benefit from this change immediately---manipulators like "commit" do
already use multiple instances of index_state structure.

But perhaps you are right---it may be wrong for the contents of the
current index (or any index) to affect how a pathspec element is
parsed in the first place.  If the current code (before this series)
uses the_index only for error checking, we may want to separate that
out of the parse_pathspec() callchain, so that it does not even look
at any index (not just the_index).  And that may be a better change
overall.

Thanks.

