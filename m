Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC3220989
	for <e@80x24.org>; Wed, 12 Oct 2016 06:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbcJLGv7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 02:51:59 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36317 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbcJLGv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 02:51:57 -0400
Received: by mail-oi0-f44.google.com with SMTP id m72so50988280oik.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jmiTNHOKc2nkJ9K8H4jCbp2bZSKi96PVSBPFxjsRDfE=;
        b=a1efSwCf7On0wtSqTrTMGpJm/9sZC7/THZXfiakOuf2jDMhjP7S20kzKsV6U5/VXIM
         3wKOUWEfijRu6fWttW4aSXfXGy7lIjLfILX/HC/mAjAdL5ga2ECl333BMKgfsS2Lqyoh
         9scCIV2btEn4j5JWAbbnMlBY7+SiM5s+ge+1/J8vFqZr4rn7C4mFsLWiUZOudikbEHTK
         NTAVbWgsvmboG3CwtNJxohOaUwe/5074sloJLZIuP8sZ1mUiqu1/VyK50VZjtGVjbgeh
         M54PduWGsnRb2O5lJYCRE2TMQryZhfaH4IJ1A/V9+tR46jenkEzW5ml9gQk9tfVrEHbB
         319w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jmiTNHOKc2nkJ9K8H4jCbp2bZSKi96PVSBPFxjsRDfE=;
        b=XfgeLhdHkwJB+QNW+pTw80wkhPDVrQUCtSpDD8TlBf4SC5OLS071Ocmi3nTFfJ6fMr
         JCJdF8Tq08f1so+p4J4rQlOSFXhKGH80IiKkqda/WMaTczT4gOYvuNs91/Azf+XK9o3T
         2ifa9LsH5Ianb6dCAV8ewKSEgeWOnQ0x3077/MmLSsy+paGi1Q42KUatTS+JI6mUYFQH
         otjBQelE8AqyCdbhsWZgZlQEjj+nyyFsy1U5anwEDkogFWgj6Vi4tWMN71Oop2pTKD/3
         +D3LohcDUO47S8l2jjnPNLH4svlqBnkWCl1n6G822sjlETHeDITl6TpSwGWPW8/gIAnR
         +tgw==
X-Gm-Message-State: AA6/9RmuX1ma+FZZIKYu06OFq6ceIluI1Tk4lIW7iEtHWmbnN1PpjJuFivGFsXg0CgWJotiU1gwPQJWdmgNp9KVd
X-Received: by 10.202.244.20 with SMTP id s20mr3601493oih.143.1476255116707;
 Tue, 11 Oct 2016 23:51:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.250.67 with HTTP; Tue, 11 Oct 2016 23:51:56 -0700 (PDT)
In-Reply-To: <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
References: <20161011235951.8358-1-sbeller@google.com> <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 23:51:56 -0700
Message-ID: <CAGZ79kZrNSmPAQ6SmBzFDJtSmdCbqKcgQu4KDLfoYVkSXvo-og@mail.gmail.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I think this patch is the most interesting patch, so I'll refrain from
>> resending the other 27 patches, though I have adressed the review comments
>> locally. I'll resend everything once we are in agreement for this one.
>
> What is the primary purpose of this patch?  Is it to prepare callers
> so that the way they interact with the attr subsystem will not have to
> change when they become threaded and the attr subsystem becomes
> thread ready?
>
> I am not sure if the updates to the callers fulfill that purpose.
> For example, look at this hunk.
>
>> @@ -111,6 +111,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>       struct archiver_args *args = c->args;
>>       write_archive_entry_fn_t write_entry = c->write_entry;
>>       static struct git_attr_check *check;
>> +     static struct git_attr_result result;
>
> As we discussed, this caller, even when threaded, will always want
> to ask for a fixed two attributes, so "check" being static and
> shared across threads is perfectly fine.  But we do not want to see
> "result" shared, do we?

Well all of the hunks in the patch are not threaded, so they
don't follow a threading pattern, but the static pattern to not be
more expensive than needed.

>
>>       const char *path_without_prefix;
>>       int err;
>>
>> @@ -124,12 +125,15 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>               strbuf_addch(&path, '/');
>>       path_without_prefix = path.buf + args->baselen;
>>
>> -     if (!check)
>> -             check = git_attr_check_initl("export-ignore", "export-subst", NULL);
>> -     if (!git_check_attr(path_without_prefix, check)) {
>> -             if (ATTR_TRUE(check->check[0].value))
>> +     if (!check) {
>> +             git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
>> +             git_attr_result_init(&result, check);
>> +     }
>
> Are we assuming that storing and checking of a single pointer is
> atomic?  I would not expose that assumption to the callers.  On a
> platform where that assumption holds, "if check is not NULL,
> somebody must have done it already, so return without doing nothing"
> can be the first thing git_attr_check_initl()'s implementation does,
> though.  Or it may not hold anywhere without some barriers.  All
> that implementation details should be hidden inside _initl()'s
> implementation.  So this caller should instead just do an
> unconditional:
>
>         git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
>
> Also, as "result" should be per running thread, hence non-static,
> and because we do not want repeated heap allocations and releases
> but luckily most callers _know_ not just how many but what exact
> attributes they are interested in (I think there are only two
> callers that do not know it; check-all-attrs one, and your pathspec
> magic one that does not exist at this point in the series), I would
> think it is much more preferrable to allow the caller to prepare an
> on-stack array and call it "initialized already".
>
> In other words, ideally, I think this part of the patch should
> rather read like this:
>
>         static struct git_attr_check *check;
>         struct git_attr_result result[2];
>
>         ...
>         git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
>         if (!git_check_attr(path_without_prefix, check, result)) {
>                 ... use result[0] and result[1] ...
>
> For sanity checking, it is OK to add ARRAY_SIZE(result) as the final
> and extra parameter to git_check_attr() so that the function can
> make sure it matches (or exceeds) check->nr.

That seems tempting from a callers perspective; I'll look into that.
