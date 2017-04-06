Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D15E1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbdDFRY6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 13:24:58 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36638 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934049AbdDFRY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 13:24:57 -0400
Received: by mail-wr0-f170.google.com with SMTP id w11so66444255wrc.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kwAki6JakLOnLNRBwREpEdByqVuViY6pBGeC/xfjM6g=;
        b=c3jcSnwOCAVKkPiRPeNx3L3jVfmshIm6NkAQagjuh0lyYo7nYcY3hR6v0Dg8Xw4/eP
         ZK7jERdAUhL5FpTFf2l+EIuUb4nVBtW2uVEZh3ntolAu0SWNFyPACd/Yv6BVqAdDsCs0
         OtxuxlcjID9B5Vi7070OsMQ0QMc3WotaLNzfCrQcOxx057jMlBpzLMHQyZBku8y8rhah
         QdVwwtI4M/1GQJalLNp1ervsZLFJEvxhvUgF/wIqQyoCmgRFcjDD/vpwpnDAJBdxSoa7
         bEzhSTSJ6ZE6cBuzLbH+S6GpxxE3oZ/QyEAJaEUXQvlg1FYN+9ikO77mo21Pf5kn7RaF
         bytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kwAki6JakLOnLNRBwREpEdByqVuViY6pBGeC/xfjM6g=;
        b=OmUaOqD/4bKYtE8Wmah05dDLMSlAYmNSQXFq18tADGaAXiyrTMFp8fnnuUWjeHK7ix
         Hpc+IxxoZmixO8nXpU5DRkw5DNOZo3E0R2+vfVq/BmSFAtwfph0Gecy9OSYTQieJ5MF8
         EWq7wDZdiT+e63tpmdp3vRp0Kpo0vvsf3dx/6Ft3S/eouiJ54V1KZcueZpciUq2TkpGB
         9ClOnyGQAvDxR2pdnbXClCBSz2794g8pH47lm5zPhQ05AP3vSdxrTGXUm2f18T07M7bC
         jHJIjKs7aFc4Cip8Mo2LO3ydnGurxbvupHKiCTZnajC/7ENngsYAT2jJcaImGgELolG+
         U4lw==
X-Gm-Message-State: AFeK/H2YXlo08ygW2ZPjC3cjWrXfrIr7F8xKctcgUaN53WXNmBWn6upAPODrV1oxp22SlmkB04TzYuhJ0HF9Dg==
X-Received: by 10.28.220.212 with SMTP id t203mr25732791wmg.62.1491499495772;
 Thu, 06 Apr 2017 10:24:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.164.2 with HTTP; Thu, 6 Apr 2017 10:24:54 -0700 (PDT)
In-Reply-To: <20170404204031.geh72k6yuiky4wsw@sigill.intra.peff.net>
References: <20170331172631.12024-1-dturner@twosigma.com> <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
 <34d444b673c64310baa275f821037b3e@exmbdft7.ad.twosigma.com>
 <20170404020130.76thbl5rum2gxgtn@sigill.intra.peff.net> <6488d78232be49a69260436d1c6ed44f@exmbdft7.ad.twosigma.com>
 <20170404204031.geh72k6yuiky4wsw@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 6 Apr 2017 19:24:54 +0200
Message-ID: <CAP8UFD3r7C_OcQMmtOju636okqrTB-af6CDo2jw5vGsiWcLVrg@mail.gmail.com>
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
To:     Jeff King <peff@peff.net>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 10:40 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 04, 2017 at 06:42:23PM +0000, David Turner wrote:
>
>> > What does it look like when it fails? What does GIT_TRACE_CURL look like (or
>> > GIT_CURL_VERBOSE if your client is older, but remember to sanitize any auth
>> > lines)?
>>
>> Unfortunately, we've already worked around the problem by pushing over SSH,
>> so I no longer have a failing case to examine. Last time I tried, I actually did some
>> hackery to create a push smaller than 2GB, but it still failed (this time, with
>> "502 Bad Gateway").  So, something is clearly weird in GitLab land.
>>
>> I did see "Transfer-Encoding: chunked" in one of the responses from the server,
>>  but not in the request (not sure if that's normal). The smaller push had:
>> Content-Length: 1048908476
>
> The 502 makes me think it's a problem in the GitLab reverse-proxy layer
> (and also my experience debugging Git-over-HTTP weirdness on GitHub's reverse
> proxy layer, which had a number of pitfalls ;) ).

Yeah, maybe.

> You should be able to do a synthetic test like:
>
>   git init
>   dd if=/dev/urandom of=foo.rand bs=1k count=1024
>   git add .
>   git commit -m 'random megabyte'
>   GIT_TRACE_CURL=/tmp/foo.out \
>     git -c http.postbuffer=0 push https://...
>
> You should see two POSTs to /git-receive-pack, like this:
>
>   Send header: POST /peff/test.git/git-receive-pack HTTP/1.1
>   Send header: Host: github.com
>   Send header: Authorization: Basic <redacted>
>   Send header: User-Agent: git/2.12.2.952.g759391acc
>   Send header: Content-Type: application/x-git-receive-pack-request
>   Send header: Accept: application/x-git-receive-pack-result
>   Send header: Content-Length: 4
>
>   Send header: POST /peff/test.git/git-receive-pack HTTP/1.1
>   Send header: Host: github.com
>   Send header: Authorization: Basic <redacted>
>   Send header: User-Agent: git/2.12.2.952.g759391acc
>   Send header: Accept-Encoding: gzip
>   Send header: Content-Type: application/x-git-receive-pack-request
>   Send header: Accept: application/x-git-receive-pack-result
>   Send header: Transfer-Encoding: chunked
>
> The first is a probe to make sure we can hit the endpoint without
> sending the whole payload. And the second should pass up the 1MB
> packfile in chunks.
>
> That would at least tell you if the problem is the chunked encoding, or
> if it's related to the size.

The above commands work for me using gitlab.com and the log shows:

Send header, 0000000309 bytes (0x00000135)
Send header: POST
/chriscool/yet-another-test-project.git/git-receive-pack HTTP/1.1
Send header: Authorization: Basic <redacted>
Send header: User-Agent: git/2.12.2.625.g14da1346c9.dirty
Send header: Host: gitlab.com
Send header: Content-Type: application/x-git-receive-pack-request
Send header: Accept: application/x-git-receive-pack-result
Send header: Content-Length: 4

Send header, 0000000341 bytes (0x00000155)
Send header: POST
/chriscool/yet-another-test-project.git/git-receive-pack HTTP/1.1
Send header: Authorization: Basic <redacted>
Send header: User-Agent: git/2.12.2.625.g14da1346c9.dirty
Send header: Host: gitlab.com
Send header: Accept-Encoding: gzip
Send header: Content-Type: application/x-git-receive-pack-request
Send header: Accept: application/x-git-receive-pack-result
Send header: Transfer-Encoding: chunked

Maybe the reverse proxy doesn't like it when the push is really big.
