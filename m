Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7DF1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeCZOd5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:33:57 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36131 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeCZOd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:33:56 -0400
Received: by mail-yw0-f173.google.com with SMTP id y64so6193563ywa.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WSdflkwVT87KkXsX1Kj49GXwYR/d1x9QR2hnH7cqD2c=;
        b=n6wzmqNwwGet5SFxvFv/hBDpY9cERbK93BeiHdA5i58uRWWFUyB8ikVpZGOSDe+bMf
         gOKmGuPwvi19zk8tuc2CJF/1GHLwAontANt6WDLuarbNVOSex8UIed5qhgVg/umXavQX
         el36V/PHO5/OVYXjnfnxT65mCGUu1kzI4Z3RC4iv3N9UzJtvOsmpZ5ud70Y5cznobGJF
         ukh95v29bAglhkE8NnryPTbrLIYjJF9CysSi+9D5luby72AaBEOb57y/HkmZC4zk8z/4
         Jop+SCEDmL+C9J1MiwF8UNbbazYM3JKP3LBmnERq0bhpXWYJaJW+kH2u3dSGeB8BjuWM
         le5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WSdflkwVT87KkXsX1Kj49GXwYR/d1x9QR2hnH7cqD2c=;
        b=iuUuvgI71DGPQw6l3182/OEmhSHDg0W+588xWqwkZAxfX92dELLixiXfOVTehesNjF
         QNzFI6QfanB6wApMxXAxftIpw0HnTsn+RC+EBdB9s2D8DyeIQSCiYGvmy8V38NkkOtfL
         GHk/I6vWsy1aSJ8QwlcvNmXYZarr0Le3na1HBgiLXgURF5dN8kezTCNe5aJjjlgIU8P2
         HKZU2nlLhGiSugQs6iAmD7TLM3E2lKkd6ymzRnT2LoNM44ECGAp97eW2RJjUzYbJFBLO
         PhgQB6ensjcQgty6nW9/n5wIl51mpUJ8bUBqLAhLOi2IfL4Qw6gHMBSTPlJya6fXYlDl
         WSDA==
X-Gm-Message-State: AElRT7EnNL4txQHnNt3Dr78A5naZauNo0307MRSPILE7UO4yBgzqnofs
        gfdwmai+Q91hXHpZpBiMFpVNoIT8OpbU6KKml+J0KX3hP4o=
X-Google-Smtp-Source: AIpwx49hUTJ75ZnGd3q6f730aVqIpq9FpOJ9jTfsPEOMA04gZ4HLQfZHJklDhdV+hw9qoCvvexZ53N1Xwg+or59DyzA=
X-Received: by 10.13.238.133 with SMTP id x127mr2334387ywe.131.1522074835337;
 Mon, 26 Mar 2018 07:33:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:4707:0:0:0:0:0 with HTTP; Mon, 26 Mar 2018 07:33:54
 -0700 (PDT)
In-Reply-To: <f8d0f3b6-69b3-ba42-c39c-551814caf335@gmail.com>
References: <cover.1522062649.git.mhagger@alum.mit.edu> <f8d0f3b6-69b3-ba42-c39c-551814caf335@gmail.com>
From:   Edward Thomson <ethomson@edwardthomson.com>
Date:   Mon, 26 Mar 2018 15:33:54 +0100
Message-ID: <CA+WKDT1LMuwuXar9i-1RJ15+o5Rxp013FL9fqfAfMydZJ9cQ6g@mail.gmail.com>
Subject: Re: [RFC 0/1] Tolerate broken headers in `packed-refs` files
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 2:08 PM, Derrick Stolee <stolee@gmail.com> wrote:
> Since most heavily-used tools that didn't spawn Git processes use
> LibGit2 to interact with Git repos, I added Ed Thomson to CC to see
> if libgit2 could ever write these bad header comments.

We added the `sorted` capability to our `packed-refs` header relatively
recently (approximately two months ago, v0.27.0 will be the first release
to include it as of today).  So, at the moment, libgit2 writes:

  "# pack-refs with: peeled fully-peeled sorted "

Prior to this change, libgit2's header was stable for the last five years
as:

  "# pack-refs with: peeled fully-peeled "

And prior to that, we advertised only `peeled`:

  "# pack-refs with: peeled "

Thanks for thinking of us!

-ed
