Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9D720437
	for <e@80x24.org>; Fri, 13 Oct 2017 15:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758215AbdJMPhy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 11:37:54 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:49210 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758205AbdJMPhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 11:37:53 -0400
Received: by mail-qk0-f176.google.com with SMTP id q83so2403029qke.6
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UY4AxdNcCy+noo1wn0m/P3w3v3L69R/U5fwR6DmnGWA=;
        b=ExkPdJDigY4DBP81JYXHZQGQ561FIQ8F2yhJ0LlHLGaNKDAcMmRDWraP4+O6Hz3Q8S
         7rCEGhx8rOYCuJ58DT/z1n8Bx5+m8dvLkhJg1aU4mnqeMGF7GChCJvuelqzZPeFxYNce
         P88KId4tlxs6aWtroY79myhKcq7Rv8kdM9PE50mocdHVqiRGXRdsIyt+ps7r0LxAhAu1
         slHiJXWxskaOxXWSDCdN0r7vbzBjH/ayu/1qfJi93OCpdmmXf+jlmquJWZp4fTdANBFV
         KhtgkucmtbAPrUk/kohJxW2HmTXmBu1wLLulmcVXMmt/cIGN8aS2l6P8/VqHGbelIsTz
         jRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UY4AxdNcCy+noo1wn0m/P3w3v3L69R/U5fwR6DmnGWA=;
        b=JBJWXif0/ghoWiFGq+yHGuJXiuvYUTNd8Bm6bT+S0zdAKHuv/oklAiMuzIVhb4lXqn
         ApfQjGPGWe+TGv5DF4ah+vuxNnQ2KX6HmkZEtcdtEk62WKy2ONlwFAAwxVmH98z0jrxj
         bTSDurkAMFFcs3BKmJeIZouw5gsW+lNqfAzyoV59VJdcVG6+aTJx7uvJS/yba/6QlVDM
         1v5f3J9neJC7BjkZ3K8176lNAKKH8ybh79Ur51+0Y9Kborb2MvJrfv5rqCggu+YiFZ4N
         nYR8xkileoIyYbWFi1fz0KoE4YjdDmDus7RqFHsLX49L5EokKb3+cSKDcoBsXXflODnn
         UB9Q==
X-Gm-Message-State: AMCzsaXt3JLj/wJSDwtlJvjsulye+xv5I1TfHgFPOONgI7szx702D6pa
        DBRLpz+VPw6ybz0sEppVmTIfBthu
X-Google-Smtp-Source: ABhQp+TlxYXpGDk3rSmp1PI9SNGOvhAhv5lWmenJ7K3Di2ICpn78f2buxBE87Zv2Unh02GLZqRd1Zw==
X-Received: by 10.55.214.9 with SMTP id t9mr2141771qki.65.1507909072581;
        Fri, 13 Oct 2017 08:37:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id b131sm697378qkg.18.2017.10.13.08.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 08:37:52 -0700 (PDT)
Subject: Re: [PATCH] revision: quit pruning diff more quickly when possible
To:     Jeff King <peff@peff.net>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
References: <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
 <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
 <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
 <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
 <20171013152745.cgqt3qgvcngyr5ew@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e2db8086-29af-a8bc-1e12-8642e430fcb3@gmail.com>
Date:   Fri, 13 Oct 2017 11:37:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171013152745.cgqt3qgvcngyr5ew@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2017 11:27 AM, Jeff King wrote:
> On Fri, Oct 13, 2017 at 10:26:46AM -0400, Jeff King wrote:
>
>> On Fri, Oct 13, 2017 at 10:25:10AM -0400, Derrick Stolee wrote:
>>
>>> This does appear to be the problem. The missing DIFF_OPT_HAS_CHANGES is
>>> causing diff_can_quit_early() to return false. Due to the corner-case of the
>>> bug it seems it will not be a huge performance improvement in most cases.
>>> Still worth fixing and I'm looking at your suggestions to try and learn this
>>> area better.
>> Yeah, I just timed some pathspec limits on linux.git, and it makes at
>> best a fraction of a percent improvement (but any improvement is well
>> within run-to-run noise). Which is not surprising.
>>
>> I agree it's worth fixing, though.
> Here it is cleaned up and with a commit message. There's another case
> that can be optimized, too: --remove-empty with an all-deletions commit.
> That's probably even more obscure and pathological, but it was easy to
> cover in the same breath.
>
> I didn't bother making a perf script, since this really isn't indicative
> of real-world performance. If we wanted to do perf regression tests
> here, I think the best path forward would be:
>
>    1. Make sure there the perf tests cover pathspecs (maybe in p0001?).
>
>    2. Make it easy to run the whole perf suite against a "bomb" repo.
>       This surely isn't the only slow thing of interest.
>
> -- >8 --
> Subject: revision: quit pruning diff more quickly when possible
>
> When the revision traversal machinery is given a pathspec,
> we must compute the parent-diff for each commit to determine
> which ones are TREESAME. We set the QUICK diff flag to avoid
> looking at more entries than we need; we really just care
> whether there are any changes at all.
>
> But there is one case where we want to know a bit more: if
> --remove-empty is set, we care about finding cases where the
> change consists only of added entries (in which case we may
> prune the parent in try_to_simplify_commit()). To cover that
> case, our file_add_remove() callback does not quit the diff
> upon seeing an added entry; it keeps looking for other types
> of entries.
>
> But this means when --remove-empty is not set (and it is not
> by default), we compute more of the diff than is necessary.
> You can see this in a pathological case where a commit adds
> a very large number of entries, and we limit based on a
> broad pathspec. E.g.:
>
>    perl -e '
>      chomp(my $blob = `git hash-object -w --stdin </dev/null`);
>      for my $a (1..1000) {
>        for my $b (1..1000) {
>          print "100644 $blob\t$a/$b\n";
>        }
>      }
>    ' | git update-index --index-info
>    git commit -qm add
>
>    git rev-list HEAD -- .
>
> This case takes about 100ms now, but after this patch only
> needs 6ms. That's not a huge improvement, but it's easy to
> get and it protects us against even more pathological cases
> (e.g., going from 1 million to 10 million files would take
> ten times as long with the current code, but not increase at
> all after this patch).
>
> This is reported to minorly speed-up pathspec limiting in
> real world repositories (like the 100-million-file Windows
> repository), but probably won't make a noticeable difference
> outside of pathological setups.
>
> This patch actually covers the case without --remove-empty,
> and the case where we see only deletions. See the in-code
> comment for details.
>
> Note that we have to add a new member to the diff_options
> struct so that our callback can see the value of
> revs->remove_empty_trees. This callback parameter could be
> passed to the "add_remove" and "change" callbacks, but
> there's not much point. They already receive the
> diff_options struct, and doing it this way avoids having to
> update the function signature of the other callbacks
> (arguably the format_callback and output_prefix functions
> could benefit from the same simplification).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   diff.h     |  1 +
>   revision.c | 16 +++++++++++++---
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/diff.h b/diff.h
> index 7dcfcfbef7..4a34d256f1 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -180,6 +180,7 @@ struct diff_options {
>   	pathchange_fn_t pathchange;
>   	change_fn_t change;
>   	add_remove_fn_t add_remove;
> +	void *change_fn_data;
>   	diff_format_fn_t format_callback;
>   	void *format_callback_data;
>   	diff_prefix_fn_t output_prefix;
> diff --git a/revision.c b/revision.c
> index 8fd222f3bf..a3f245e2cc 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -399,8 +399,16 @@ static struct commit *one_relevant_parent(const struct rev_info *revs,
>    * if the whole diff is removal of old data, and otherwise
>    * REV_TREE_DIFFERENT (of course if the trees are the same we
>    * want REV_TREE_SAME).
> - * That means that once we get to REV_TREE_DIFFERENT, we do not
> - * have to look any further.
> + *
> + * The only time we care about the distinction is when
> + * remove_empty_trees is in effect, in which case we care only about
> + * whether the whole change is REV_TREE_NEW, or if there's another type
> + * of change. Which means we can stop the diff early in either of these
> + * cases:
> + *
> + *   1. We're not using remove_empty_trees at all.
> + *
> + *   2. We saw anything except REV_TREE_NEW.
>    */
>   static int tree_difference = REV_TREE_SAME;
>   
> @@ -411,9 +419,10 @@ static void file_add_remove(struct diff_options *options,
>   		    const char *fullpath, unsigned dirty_submodule)
>   {
>   	int diff = addremove == '+' ? REV_TREE_NEW : REV_TREE_OLD;
> +	struct rev_info *revs = options->change_fn_data;
>   
>   	tree_difference |= diff;
> -	if (tree_difference == REV_TREE_DIFFERENT)
> +	if (!revs->remove_empty_trees || tree_difference != REV_TREE_NEW)
>   		DIFF_OPT_SET(options, HAS_CHANGES);
>   }
>   
> @@ -1351,6 +1360,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
>   	DIFF_OPT_SET(&revs->pruning, QUICK);
>   	revs->pruning.add_remove = file_add_remove;
>   	revs->pruning.change = file_change;
> +	revs->pruning.change_fn_data = revs;
>   	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
>   	revs->dense = 1;
>   	revs->prefix = prefix;

Thanks, Peff. This patch looks good to me.

I tried a few other things like adding a flag DIFF_OPT_HAS_ANY_CHANGE 
next to DIFF_OPT_HAS_CHANGES that we could check in 
diff_can_quit_early() but it had side-effects that broke existing tests. 
From this exploration, it does seem necessary to be aware of 
'remove_empty_trees'.

Thanks,
-Stolee
