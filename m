Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FD11F461
	for <e@80x24.org>; Mon, 15 Jul 2019 17:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfGORZk (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 13:25:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57948 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbfGORZk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 13:25:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 014B3166E83;
        Mon, 15 Jul 2019 13:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=90V5R0R1Tl1yb3DpSbF1l4IaPdk=; b=iYPHZW
        DoJ9KibM+JvS7Es01htrVhpc8Ak+syL0TtqulUBAYD+kLZE5WcugsU11TFGmG1xE
        r+XsWel6qPH8fw4flB5iPQ23vy2+V/urllYMlcJcSYsJ12BdDJv3eYJfFh6raP3i
        mnXkl2iBFlxy8fjLW7AJhGW3BDBKUrdVldOsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=At2yeKv3cEqD81bQWdnckm4GDZ30k2W5
        n0qzOOV20h3sST/JpwjwFLeEHtfFewNXWFsRsNRNZ1J6BDtIHlZ/bKpDTxRn3z+9
        uyR4ONUZODOA1scgSDy9VhtaJa+ddMnamkYpD4dwUzfhjy8kZwPoSb+L6jEuUE8p
        IVgSRKm8WJg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EABF2166E82;
        Mon, 15 Jul 2019 13:25:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D290166E80;
        Mon, 15 Jul 2019 13:25:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #03; Fri, 12)
References: <xmqq8st3otj7.fsf@gitster-ct.c.googlers.com>
        <20190714231558.GA24609@comcast.net>
Date:   Mon, 15 Jul 2019 10:25:32 -0700
In-Reply-To: <20190714231558.GA24609@comcast.net> (Matthew DeVore's message of
        "Sun, 14 Jul 2019 16:15:58 -0700")
Message-ID: <xmqqpnmb43cj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D094986-A725-11E9-B303-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> On Fri, Jul 12, 2019 at 02:02:52PM -0700, Junio C Hamano wrote:
>> * md/list-objects-filter-combo (2019-06-28) 10 commits
>>  - list-objects-filter-options: make parser void
>>  - list-objects-filter-options: clean up use of ALLOC_GROW
>>  - list-objects-filter-options: allow mult. --filter
>>  - strbuf: give URL-encoding API a char predicate fn
>>  - list-objects-filter-options: make filter_spec a string_list
>>  - list-objects-filter-options: move error check up
>>  - list-objects-filter: implement composite filters
>>  - list-objects-filter-options: always supply *errbuf
>>  - list-objects-filter: put omits set in filter struct
>>  - list-objects-filter: encapsulate filter components
>> 
>>  The list-objects-filter API (used to create a sparse/lazy clone)
>>  learned to take a combined filter specification.
>> 
>>  There is a bit of interaction with cc/multi-promisor topic, whose
>>  conflict resolution I have no confidence in X-<.  Extra sets of
>>  eyes are appreciated.
>> 
>
> Sorry for the delay. I was on vacation and then catching up for a week after I
> got back. I uploaded a merged commit here:
>
> https://github.com/matvore/git/tree/filts
>
> And the merged file itself (only this one had conflicts) is here:
>
> https://github.com/matvore/git/blob/filts/list-objects-filter.c

Thanks.  I fetched the 'filts' branch and found:

 (1) master..filts~1 matches the copy I have above exactly (modulo
     my sign-off and committer identity, of course);

 (2) if I merge cc/multi-promisor on top of filts~1 using the machinery
     I use to rebuild 'pu' every day, I get more-or-less the same result
     as your 'filt' branch (modulo formatting and minor comments).

So it does look like the conflict resolution I have been carrying is
something you would agree on, which is a good news ;-)  Thanks.

> I'll comment on the conflicts:
> ...
> md/list-objects-filter-combo changed the contract of this function such that an
> attempt to combine filter specs will terminate with BUG rather than return an
> error. All the callers already check filter_options.choice, so this is still
> fine (it particular, I double-checked partial_clone_get_default_filter_spec and
> its call site at builtin/fetch.c:1524)

OK, thanks for being careful.

>
>>   	/*
>>   	 * Record the initial filter-spec in the config as
>>   	 * the default for subsequent fetches from this remote.
>>   	 */
>> ++<<<<<<< md/list-objects-filter-combo
>>  +	core_partial_clone_filter_default =
>>  +		xstrdup(expand_list_objects_filter_spec(filter_options));
>>  +	git_config_set("core.partialclonefilter",
>>  +		       core_partial_clone_filter_default);
>> ++||||||| merged common ancestors
>> ++	core_partial_clone_filter_default =
>> ++		xstrdup(filter_options->filter_spec);
>> ++	git_config_set("core.partialclonefilter",
>> ++		       core_partial_clone_filter_default);
>> ++=======
>> + 	filter_name = xstrfmt("remote.%s.partialclonefilter", remote);
>> + 	git_config_set(filter_name, filter_options->filter_spec);
>> + 	free(filter_name);
>> + 
>> + 	/* Make sure the config info are reset */
>> + 	promisor_remote_reinit();
>> ++>>>>>>> cc/multi-promisor
>>   }
>>   
>>   void partial_clone_get_default_filter_spec(
>
> md/list-objects-filter-combo used the expand_list_objects_filter_spec function
> to expand the filter spec string rather than get it directly. So the merged
> result simply applies that alteration to cc/multi-promisor.
>
> I checked whether callers to this function (partial_clone_register) would ever
> give a null filter_options (or a non-null with a NULL filter_spec) and both
> calls are guarded by "if (filter_options.choice)" so filter_options.filter_spec
> should also be set.

Good.  This was the part I was most unsure about.

Thanks.




