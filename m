Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADDB20450
	for <e@80x24.org>; Fri,  3 Nov 2017 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbdKCPCO (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 11:02:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751370AbdKCPCN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 11:02:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E9A6A1BFE;
        Fri,  3 Nov 2017 11:02:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0WVE3non4mK2JY8SvxPI/WxTtLE=; b=ng4klY
        nldkzaN59TWkJJGNv79REjP5ep42gkmFYBq6rpqed1YnXzEZQB/SFKrD1h4Zdj7s
        U11JpG4RG4VlbQxStnyqGpYM/FkGDRi8KtnxZh0V+EDHqN3t7+D/Ko7coJXTRc2Y
        HTWPqka1xhqHo4uMATUtI8eItOaZnihk48wCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M+JIjTNd6DqXyuZrakbNz8SYrZx+wNbg
        0eGYtbFbXlLepN9RZYXmzMyPHAUg6a31on3PJV5tiOvZU8gLbv+sOotDGLg5aHJo
        RT7L5uykC+GABzF/1oTPwIeC6NtC7ofYGE4sX0O65Uxcc0CjljwHyq9r7xvmONqp
        fpeLombewtM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62F7AA1BFD;
        Fri,  3 Nov 2017 11:02:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8AEBA1BFC;
        Fri,  3 Nov 2017 11:02:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-7-sbeller@google.com>
        <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
        <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
        <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com>
        <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
        <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
        <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
        <CA+P7+xqw9zKNUkn9P-qA57ADSB5G_7Sd0JCc6SaK6bBf9-Jhtg@mail.gmail.com>
        <xmqqtvycos7z.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrRgzGLFMZ+iaomQifOUXqANKD0v9XGoR+==0kVmyVL5Q@mail.gmail.com>
Date:   Sat, 04 Nov 2017 00:02:10 +0900
In-Reply-To: <CA+P7+xrRgzGLFMZ+iaomQifOUXqANKD0v9XGoR+==0kVmyVL5Q@mail.gmail.com>
        (Jacob Keller's message of "Thu, 2 Nov 2017 23:55:32 -0700")
Message-ID: <xmqqbmkjpfrh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F871EDEC-C0A7-11E7-B8C3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Nov 2, 2017 at 10:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> It is easy to imagine that we can restrict "git log" traversal with
>> a "--blobchange=<blob>" option instead of (or in addition to) the
>> limitation <pathspec> gives us.  Instead of treating a commit whose
>> diff against its parent commit has any filepair that is different
>> within <pathspec> as "!TREESAME", we can treat a commit whose diff
>> against its parent commit has a filepair that has the <blob> on
>> either side of the filepair as "!TREESAME" (in other words, we
>> ignore a transition that is not about introducing or forgetting the
>> <blob> we are looking for as an "interesting change").  That would
>> give you a commit history graph in which only (and all) such commits
>> that either adds or removes the <blob> in it.
>>
>> Hmm?
>
> This seems quite useful in the context of figuring out how a file got
> to such a state. This is useful to me, since if I know the state of a
> file (ie: it's exact contents) I can determine the blob name, and then
> use that to lookup where it was introduced.

This is probably a bit harder than an average #leftoverbits, but if
somebody wants to get their hands dirty, it should be reasonably
straightforward.  The needed changes would roughly go like so:

 - Add "struct oid *blob_change;" to diff_options, initialized to
   NULL.

 - Teach diff_opt_parse() a new option "--blobchange=<blob>".
   Allocate a struct oid when you parse this option and point at it
   with the blob_change field above.

 - Write diffcore-blobchange.c, modeled after diffcore-pickaxe.c,
   but this should be a lot simpler (as there is no need for an
   equivalent for "pickaxe-all" option).  It would

   - prepare an empty diff_queue_struct "outq";
   - iterate over the given diff_queue "q", and 
     - a filepair p whose p->one is blob_change and p->two is not,
       (or the other way around) is added to outq with diff_q()
     - a filepair whose p->one/p->two do not involve blob_change
       is freed with diff_free_filepair().
   - replace "q" with "outq".

 - Add a call to diffcore_blobchange() early in diffcore_std(),
   probably immediately after skip-stat-unmatch, when blob_change
   field is not NULL.

 - Arrange that blob_change is propagated to revs->pruning in
   setup_revisions().

