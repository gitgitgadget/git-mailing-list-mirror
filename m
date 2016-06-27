Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524B82018A
	for <e@80x24.org>; Mon, 27 Jun 2016 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcF0PyO (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:54:14 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35660 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcF0PyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:54:13 -0400
Received: by mail-io0-f175.google.com with SMTP id f30so155896909ioj.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 08:54:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QOiAVMEGZvBQBxdxjJzqU0cg5MSoaBbbi9wKJtcjs+s=;
        b=EJzPircCfEVVwKhTeVtwmjduQy6rc1PwKmIGhFdHQGLTLq/0zyT3Ln6mGg3NOKyDox
         Nm56pFkqmqZ2ZwFd/Fj2fPeqVqA5LRxzBNGENnYTbmnYubXLc7QewGHRsDV4MlEWhm1/
         DgYY+Kmyhoti2TzP3pDSqv3e94rQd8nPPHM0OmucCDPwff0gibU9B4+qtGaJcsHIwwl0
         2tfh/jWZOfLbmvNyqDqNdT6nNIlg++ESlVhOS+VdycPDIeQWjiVUYdfaAC7CrswaN5u9
         McHfF6LEfL6/+5sQLnPDmKwtwzNr7UChgKbGhfCB+ZcH9Nzq+INOPj4Q7P/43Se1BUGb
         rWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QOiAVMEGZvBQBxdxjJzqU0cg5MSoaBbbi9wKJtcjs+s=;
        b=dykfl68DzomVo85cQFzizaAkWqQMVhQg3q/TpUzi7e8YR5SR62OMLwhuJT9R7jkni5
         aDl9h3nMIUpj56vu+Dzh2y/+n2MT9zb0MTIEWsY65T9HFbSIIBOtpAk1RjeX+5CQmXTB
         OFLTRbkWJrBGjP7cD/O0AqUDVfrC+X1rfcinUk16e/MheT1G39r743ckz8lt507loh2f
         S4gWyRIRZYNIlCna8tZSwiwwIp9r7cugwudfQnot0ql/T+ap/a/gCcyYNSXifG7ZIFKb
         u2uXdtPCj6UN33nlCoHQn6Dw1alLManFyOjLJPGuSzWbLoqxPWufEglq0p3+nFhk9ECP
         jAPA==
X-Gm-Message-State: ALyK8tIqcFmDcCEUjvbqOYwWvT97+QNUNxvDk4x/n6c7Oyt/O5tnJxtJFElH5bs+ma+7lzQmN4Ma5pG51c+ytg==
X-Received: by 10.107.8.220 with SMTP id h89mr1501459ioi.95.1467042839743;
 Mon, 27 Jun 2016 08:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 27 Jun 2016 08:53:30 -0700 (PDT)
In-Reply-To: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 17:53:30 +0200
Message-ID: <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com>
Subject: Re: [RFC] Native access to Git LFS cache
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
> ## Proposed solution
> Git LFS caches its objects under .git/lfs/objects. Most of the time Git
> LFS objects are already available in the cache (e.g. if you switch branches
> back and forth). I implemented these "cache hits" natively in Git.
> Please note that this implementation is just a quick and dirty proof of
> concept. If the Git community agrees that this kind of approach would be
> acceptable then I will start to work on a proper patch series with cross
> platform support and unit tests.

Would it be possible to move all this code to a separate daemon?
Instead of spawning a new process to do the filtering, you send a
command "convert this" over maybe unix socket and either receive the
whole result over the socket, or receive a path of the result.

I don't think hard coding "git-lfs" is a good way to go (if you keep
that in the final impl. of course). I guess the costly part is
spawning processes and going through the same process initialization
for every object. If we keep a daemon running, all that is gone. You
still have to pay for extra context switches and memory copy (unless
you send the path, but then it could be racy), but I think that's
negligible. And all smudge/clean filters can do caching and more if
they want to.
-- 
Duy
