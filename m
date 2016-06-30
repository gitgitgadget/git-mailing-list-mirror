Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E8A1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbcF3TPd (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 15:15:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34200 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcF3TPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 15:15:32 -0400
Received: by mail-io0-f193.google.com with SMTP id 100so9274212ioh.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 12:15:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tybjx48eCVxd3nBXIN0Iq4XhJPdGjMRnGwtc2NlOR6w=;
        b=zsUxXQ3qfmE9jU3YtsTBLr6BWrDaY9BrZCn1CL7CLyCwZOeB0aaoPGDTlpc5XQQ3cz
         R4Ve52liA1jRPWvIzLTcZYDdEj0HHeLWxS4Ok9ZbdoJ2+dM+cJkiOgso5RMmJh45Qi2N
         ami2NGhZ1RgUORys7vtr5eo9mcBJQp584wftsyjq/jnbFDTMeBEbcfq8zSS7CPpwCOto
         QMaMOlIXpJ9ypm3ItkrVmwPgSQmYC48yuHauOHasVw6O8YHpCB3X+BhCIa7ndRZITtN5
         9NBHcknwJgr1617MIs3oGpzKGC4VOQqj+68QcjJNL6R5mWCytCrcoofPRMpD+veYXDse
         h70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tybjx48eCVxd3nBXIN0Iq4XhJPdGjMRnGwtc2NlOR6w=;
        b=dZTQfJtJsgw3+Q3LnjPtb/hcxC429YVBpHrP4NDujj5KU6KoYCHrYl1B5fpXF2pjdt
         SaeVquIn5FOacLiqCzK3ZlzUnaFbCdpkZkUufLJjEECzUWCr6FbOGtOMG3lX12arZuQ9
         l2zDdxfoiLn2IqTmfR5NINT0E4MxnzueHXgO3RYKYpLEvcdm9u0xIex0YBL6DH+iziSS
         bkKky1G998rhzfWgs6i7wY15gA27U5TlLGAxygKN/wdx0bC8IrRMCUkSJMMizUvpL8Iv
         oUBMI0KWLv3CiB7Ms3IXl4t0YXIlbrt9lXdXWcMOgjMgdUeoMFm+sPeaCOVEqLhhsB/z
         AFTw==
X-Gm-Message-State: ALyK8tJz8aKHBYH1SjuMrYatOF0laZ+OHU8OPgnD4v2KyBIkUTY+cWYFHdEoDi1N2KJK4EKXtfUrbB3VIxHTzw==
X-Received: by 10.107.159.16 with SMTP id i16mr15581744ioe.29.1467314114292;
 Thu, 30 Jun 2016 12:15:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 30 Jun 2016 12:14:44 -0700 (PDT)
In-Reply-To: <loom.20160630T192750-125@post.gmane.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-11-git-send-email-novalis@novalis.org> <loom.20160630T192750-125@post.gmane.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 30 Jun 2016 21:14:44 +0200
Message-ID: <CACsJy8DjYLQCBRc9CzFSWNqkVnhbAfnxd1mnQh4oEfJwKjPd1A@mail.gmail.com>
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
To:	Ben Peart <peartben@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 7:55 PM, Ben Peart <peartben@gmail.com> wrote:
> David Turner <novalis <at> novalis.org> writes:
>
>>
>> Hiding watchman behind index-helper means you need both daemons. You
>> can't run watchman alone. Not so good. But on the other hand, 'git'
>> binary is not linked to watchman/json libraries, which is good for
>> packaging. Core git package will run fine without watchman-related
>> packages. If they need watchman, they can install git-index-helper and
>> dependencies.
>>
>
> Have you considered splitting index-helper and watchman apart?  Using
> Watchman to not lstat unchanged entries is a huge perf win with very
> large repos.

On large repos (i.e. lots of files/dirs on worktree), the cost of
reading index will increase proportionally. Yes lstat costs, but I
suspect index reading (integrity verification actually) may cost more,
especially on platforms with cheap lstat like linux. On these repos
you really want to enable all four: index-helper (with watchman),
split-index (I still need to work out pruning on split-index) and
untracked cache. There's still a lot more to make git run fast on
large repos though.

> It would also be interesting to make the Watchman backend replaceable by
> using an extensible API.  This has the benefit of not having to link the
> 'git' binary to the watchman/json libraries.

'git' binary is not linked to watchman libraries. git-index-helper is
a separate binary, by design. In theory you can create a
'git-index-helper' replacement binary with something other than
watchman. I think David documented the protocol well (it may change in
the future though and we are not prepared for capability progression)

> Is there any pattern already in git for accomplishing this?
-- 
Duy
