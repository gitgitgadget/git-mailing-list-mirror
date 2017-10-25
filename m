Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B75203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdJYT3r (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 15:29:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:37102 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdJYT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 15:29:46 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2BCEA84585;
        Wed, 25 Oct 2017 15:29:46 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BA21F84584;
        Wed, 25 Oct 2017 15:29:45 -0400 (EDT)
Subject: Re: [PATCH 08/13] list-objects: add traverse_commit_list_filtered
 method
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171024185332.57261-1-git@jeffhostetler.com>
 <20171024185332.57261-9-git@jeffhostetler.com>
 <CAGf8dgLU_70vq8JNpr-cihgk9SbC_7GYcaEF6c9NgmJRXPAcmw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <39e85992-6e3b-2059-17a1-784c92072944@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 15:29:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGf8dgLU_70vq8JNpr-cihgk9SbC_7GYcaEF6c9NgmJRXPAcmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 12:24 AM, Jonathan Tan wrote:
> On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> +void traverse_commit_list_filtered(
>> +       struct list_objects_filter_options *filter_options,
>> +       struct rev_info *revs,
>> +       show_commit_fn show_commit,
>> +       show_object_fn show_object,
>> +       list_objects_filter_map_foreach_cb print_omitted_object,
>> +       void *show_data);
> 
> So the function call chain, if we wanted a filtered traversal, is:
> traverse_commit_list_filtered -> traverse_commit_list__sparse_path
> (and friends, and each algorithm is in its own file) ->
> traverse_commit_list_worker
> 
> This makes the implementation of each algorithm more easily understood
> (since they are all in their own files), but also increases the number
> of global functions and code files. I personally would combine the
> traverse_commit_list__* functions into one file
> (list-objects-filtered.c), make them static, and also put
> traverse_commit_list_filtered in there, but I understand that other
> people in the Git project may differ on this.
> 

I'll do a round of refactoring to include your suggestion of
a default null filter.  Then with that see what collapsing this
looks like.

Thanks,
Jeff
