Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A114C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 22:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLNWBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLNWBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 17:01:12 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7462DFDD
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 14:01:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A6BE75C0197;
        Wed, 14 Dec 2022 17:01:07 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Wed, 14 Dec 2022 17:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jpgrayson.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1671055267; x=1671141667; bh=Wg
        h5e23nLQWT1Dlq7lMLdIVTIzCD9hGin06dYmim2QE=; b=OE8AFWEgalKhRL6nmQ
        kgNKyQ/Xf+vtdC9sUA9XzWnQ/B4SNJeaUz3D9wNUVE7MWBUvVGPfdQExFo3kq349
        bGLeJbK9hgMtTabNkRUQNDWAFZkZTgPB2wUd8hSj0XDuOKyDaXs5jdGegRc4Lt6/
        cn6h8H2BxD/aPDYV8csNIYIAl+lBSF+4u+sohHN3KCWI/rYtaUGs9Ow5cgOuMt+D
        ZIIwfvorjs0rrRqATNz/BdXNzmJNeDu3tlsIUm0LXTltvmE8gBBhvTU5jHXdwfOl
        QxJERLw+oDeBsfywv76ItLtm/1cT3Njfuxs4rcvOiBvpb6wBpkT6z/ocdP9dGFlH
        znnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671055267; x=1671141667; bh=Wgh5e23nLQWT1Dlq7lMLdIVTIzCD
        9hGin06dYmim2QE=; b=vHmOHLwzW4JLRbFmkDZv9kmqqfSbTJu2Pwu68bgmQPHq
        AkCsY7qYwZi7xm5gIzWd09H8hnYXtBh0+GapjGPuAywPgplZlFu2tXnsXXebrCLC
        8EKRMf42soQL/wVwPz2Aq76MYDe3xdG2uVack2LmGqBGDuZ4elRksm7kMKkClku7
        WOI9xiLt4J+8sIeeZA7+4ZpFeqsv1dIk6Ur/Qko8SzPsanXwJqOQnKyOqVsiZqAn
        9ECEJuCU6GRbyyq2aaunuYJ94w66277RtAG0CT1ub4bDWjrQJgomkvLgtUMdX7de
        9Zu+tB1fXX1/srSnUVZpbYGaYf7iOEzrguTDsUa+Yg==
X-ME-Sender: <xms:o0eaY-06LZ8IALSyPh8G3mafeNXTCrtUb1uu9vJQcFGGk6J4L8A5XQ>
    <xme:o0eaYxEhpYmOnIGqsBCG87YecwaIalFpBZMUgdkrKgZxotf521U-QgYGDToeuzydH
    qtUERxhNZdq_-YAxQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfrvghtvghrucfirhgrhihsohhnfdcuoehpvghtvges
    jhhpghhrrgihshhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdfgteeljeelveeghf
    ettedtueehveetgfejkeejledtveeghffhlefhieefveehnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvsehjphhgrhgrhihsohhnrd
    hnvght
X-ME-Proxy: <xmx:o0eaY26yECjdXCu59YNnqTHEvJR0IYLjxPV-YuNy7DFNCY7Mq13qtw>
    <xmx:o0eaY_04tjXJUHL7hLq8yIfZDynoSEswFdypPC6sFDltTUiK_KwXLg>
    <xmx:o0eaYxFWScG8Zpv-FTDnFtMDoYAoQfF6ChIskjtDDqn5meseTYe00Q>
    <xmx:o0eaYwwFDBSzSB_y5kizImpIRCmU9daWM9WR46K0cmylPs7Ec9ao7g>
Feedback-ID: iefe944c0:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5FF3631A0063; Wed, 14 Dec 2022 17:01:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <71f44490-6ee9-4208-92a4-5932b524d719@app.fastmail.com>
In-Reply-To: <Y5pCHAWnNUUy6TW+@coredump.intra.peff.net>
References: <20221214174150.404821-1-pete@jpgrayson.net>
 <Y5pCHAWnNUUy6TW+@coredump.intra.peff.net>
Date:   Wed, 14 Dec 2022 17:01:06 -0500
From:   "Peter Grayson" <pete@jpgrayson.net>
To:     "Jeff King" <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] diff: fix regression with --stat and unmerged file
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022, at 4:37 PM, Jeff King wrote:
> On Wed, Dec 14, 2022 at 12:41:51PM -0500, Peter Grayson wrote:
>
>> A regression was introduced in
>> 
>> 12fc4ad89e (diff.c: use utf8_strwidth() to count display width, 2022-09-14)
>> 
>> that causes missing newlines after "Unmerged" entries in `git diff --cached
>> --stat` output.
>
> Oof, clearly we don't have good test coverage here. Thanks for catching
> it.
>
>> This patch adds the missing newline along with a new test to cover this
>> behavior.
>
> Both look good to me, but two quick comments:
>
>> diff --git a/diff.c b/diff.c
>> index 1054a4b732..85f035a9e8 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2801,7 +2801,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>>  		else if (file->is_unmerged) {
>>  			strbuf_addf(&out, " %s%s%*s | %*s",
>>  				    prefix, name, padding, "",
>> -				    number_width, "Unmerged");
>> +				    number_width, "Unmerged\n");
>>  			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
>>  					 out.buf, out.len, 0);
>>  			strbuf_reset(&out);
>
> Looking at the offending patch, it also touches "Bin". But that one
> handles its newline separately (since sometimes there is more data on
> the line). So this is the only spot that needs to be fixed.

Agreed.

>> diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
>> index 0ae0cd3a52..ffaf69335f 100755
>> --- a/t/t4046-diff-unmerged.sh
>> +++ b/t/t4046-diff-unmerged.sh
>> @@ -86,4 +86,14 @@ test_expect_success 'diff-files -3' '
>>  	test_cmp diff-files-3.expect diff-files-3.actual
>>  '
>>  
>> +test_expect_success 'diff --stat' '
>> +	for path in $paths
>> +	do
>> +		echo " $path | Unmerged" || return 1
>> +	done >diff-stat.expect &&
>> +	echo " 0 files changed" >>diff-stat.expect &&
>> +	git diff --cached --stat >diff-stat.actual &&
>> +	test_cmp diff-stat.expect diff-stat.actual
>> +'
>
> The rest of this script uses diff-files, but here we're using "diff
> --cached". It feels like it would be simple to use diff-files for
> consistency, but strangely it errors out, complaining that the blob
> can't be read.
>
> This has to do with the setup for the test, which uses "hash-object"
> without "-w", meaning our index mentions objects we don't actually have.
> I'm not sure if this is the test trying to cleverly assert that we don't
> look at the objects themselves, but regardless it seems weird to me that
> "diff-files" wants to look at the unmerged entries but "diff --cached"
> doesn't (it does seem like "diff --cached" is right here; diff-files
> would produce two lines).

I also noticed this when I originally wrote the test using diff-files,
but didn't dig deeper. Thanks for taking the next step with that. I
figure that the "diff" porcelain is a good vehicle to test this
particular behavior even if its a bit inconsistent with other cases
in this test module.

> So there may be another bug, but if so I don't think it's a recent one.
> And we are better off working around it for your regression fix, which
> we'd hope to see merged quickly.

I would also like to see this repair for the clear-and-present
regression merged sooner and independent of exploration of the
other potential problem with diff-files.

Thanks for taking the time to review this change. I appreciate it!

Pete
