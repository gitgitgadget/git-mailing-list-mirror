Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA5EC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJQCSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJQCR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:17:59 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3499D13DEF
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:17:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D2699320046E;
        Sun, 16 Oct 2022 22:17:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 16 Oct 2022 22:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665973074; x=1666059474; bh=8ottowNuNA
        6aJ8CcE2gGnBmfacSvLe6IG9gpJM+7lbs=; b=UXjb0oVxYhqPufEwEP7EnA+ghT
        FfvqCvdKx4zPpfzXyEEPHe5mdZVPoaincCCZcnHEI4iAN4wgrLn2LWdN7XJVTk6p
        7rGKuTAuJkyon/DIbcUlrjZ0Oy5JyO4W8+07jxS56bbMOyptVSAIo6njTlMQjKPN
        9yQA/f+WePdic80x3tvLc0NrrRz30ig/wJ3jiR2GWaZsarafpIk8T2/LawCcEla4
        A4dnw4TobWXufnQY4PmTmxzIJUdQY/3NjT9qHYBq0C/9fnXsy+FlGGDdNGK1s0Cq
        w3+hOl7mt9Br2/+dNNkjbKuwJwhS6U7+qHvLK+4/fb7wl8h/E+T+8WqSd+4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665973074; x=1666059474; bh=8ottowNuNA6aJ8CcE2gGnBmfacSv
        Le6IG9gpJM+7lbs=; b=V8ldxBpeaRRD1jNGDLLbwBzGm+KKkl5Y8qHDDqou4JIA
        FxZivnwW+SeBR2ZqCmMwXUIUU5F4pbFVowJ5UzYLWXw+fGG9k4Ml2X/zlsOj0qmN
        iBzYupL0QeImvLPaWhYd1JXIWdN1AnKmXxSgmychHrI37wUQgSkgrbcYGbzXRAcM
        reSALasxoyPbZv8d5IRvDEsR0f/eWCsTnqDYa3CaCAB9yFFB3l2SzkXEy3zk4Cm6
        B7E58WJD8Pk6iWuQXYLOfkgr26XAC4TUUQ12bkhCwpRf+jlUO3YC1NniA8aVt8dT
        6O5DuXS35CZyQGHTWbIFwFgZwvCak/SjWnNXs/v05w==
X-ME-Sender: <xms:UrtMY5pqwU-gM-5fQsnkcdK-e75gtVl-fLAjP38b3oBMgvEYuexJ-A>
    <xme:UrtMY7rbDtXf0PDUDqKLksVTbbSaioKK1HtiVXbqkrKe0zXP4Sa5XZzSxFadYqQIH
    -5pqe71z-9WO3lIdtg>
X-ME-Received: <xmr:UrtMY2MCleP2HZNh1VOUtxrLlpcC1yTwfm2I18GIOtiqKCKZabO35-cHfqdj4igw10ee9jd2u9Ad7sCTpazN1x4msVuSSs3jDX9URW2FdrY6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefoihgthhgrvghlucfotgevlhhimhhonhcuoehmihgthhgr
    vghlsehmtggtlhhimhhonhdrohhrgheqnecuggftrfgrthhtvghrnhepueelledtheejfe
    eiuedtvdehgeetvefghfekfffguefgkeetiedukeekheefledtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhrggvlhesmhgttghlih
    hmohhnrdhorhhg
X-ME-Proxy: <xmx:UrtMY05ivhhML2G1HW23P-1XDaukYxQ-VwXKsQtth9nIp13Qj-NvoA>
    <xmx:UrtMY46zjRXZ70BXF0v3Orzcm66TL_xW9bh2Mi_FOVix60YacYBAOA>
    <xmx:UrtMY8ijdah1ekKWnRbwNvDRc-_nTptHYw07lCttbSVq0q3vuRxUOg>
    <xmx:UrtMY9joTOBOHMdc-4tdVwcEaqyDoNu3kK22ycZdnhR8w5yc2yVBwA>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Oct 2022 22:17:54 -0400 (EDT)
Date:   Sun, 16 Oct 2022 22:17:53 -0400
From:   Michael McClimon <michael@mcclimon.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Git.pm: add semicolon after catch statement
Message-ID: <Y0y7UdLf3qd7RgVQ@newk>
References: <20221016212236.12453-1-michael@mcclimon.org>
 <20221016212236.12453-2-michael@mcclimon.org>
 <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0yRStZ6gM+H8/Bf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Curiously this works as expected for me, both before and after your
> patch. I wonder if it depends on perl version. Mine is 5.34.

Hm, curious indeed! It reliably fails without my patch and passes with it on
all the versions I had lying around (5.8, 5.18, 5.24, 5.26, 5.28, 5.30, 5.34,
and 5.36).

> I've never used Error.pm's try/catch before, so I don't know what's
> normal. Regular if/unless doesn't need it, but certainly an earlier
> catch uses a semicolon. So it seems like a reasonable fix.

Ha, well Perl is...let's say special. try/catch is not a language construct
(until 5.34, where it is experimental), and so it's always implemented by
subroutines. One upshot of this is that try/catch needs a semicolon, because
it's sugar for try(sub { ... }), and statements need semicolons separating
them. 

Compare these two examples: -MO=Deparse,-p tells perl to deparse the program
and print it with parentheses:

    $ perl -MError -MO=Deparse,-p -e 'try { die "bad" } catch Pkg with { warn "caught" }; print "after"'
    do {
        die('bad')
    }->try('Pkg'->catch(do {
        warn('caught')
    }->with));
    print('after');
    -e syntax OK

    $ perl -MError -MO=Deparse,-p -e 'try { die "bad" } catch Pkg with { warn "caught" } print "after"'
    do {
        die('bad')
    }->try('Pkg'->catch(do {
        warn('caught')
    }->with(print('after'))));
    -e syntax OK

The first here is the good case case (with semicolon), and you can see that
print('after') is its own statement. The bad case, with no semicolon, passes
it as an argument to with(), which is what's causing the error here: something
called by with() is trying to use it as a hash reference, and it's a string.

> I'd assume t9700 passes for you, since I don't think we cover this case.
> Maybe it's worth squashing this in:
> 
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index e046f7db76..5bd3687f37 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -30,6 +30,12 @@ sub adjust_dirsep {
>  # set up
>  our $abs_repo_dir = cwd();
>  ok(our $r = Git->repository(Directory => "."), "open repository");
> +{
> +	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
> +	my $failed = eval { Git->repository(Directory => ".") };
> +	ok(!$failed, "reject unsafe repository");
> +	like($@, qr/not a git repository/i, "unsafe error message");
> +}
>  
>  # config
>  is($r->config("test.string"), "value", "config scalar: string");

Curiously, t9700 passes for me with this suggestion both with and without my
patch. You'd only see this bug in bare repositories, though, and the one set
up in t9700 is not bare. I can see about trying to make it do so, but I'll
need to do a bit more reading of how even the tests are set up and run first.
Thanks!

-- 
Michael McClimon
michael@mcclimon.org
