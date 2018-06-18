Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5AE1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 16:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbeFRQuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:50:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752835AbeFRQuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:50:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1463F3C0E;
        Mon, 18 Jun 2018 12:50:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=dY0SzlME7YZ3ALsqSj7INDKohZs=; b=QKCmK8p
        c5SCf/tUsl8SuIRvsXKuRkroGbndV1XsKPCgNgCT9UjnOXtJ2xXjJq+J2x6zrJaV
        9d8vO+xJdd5N9qBqafmuDGT3lP/wVkhXDoEmroNxwChfAvkkCb4hFEekDbZ9KGcg
        OEbdBrgd3CalAPDcEviJWzfP9uYcItt1jhPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=XCY8Ox1V9HH2DrmPOfAJEP2sn/IYT5+AP
        qIQkkPy9Ve3FkWm8E97oo7e6cq0fe9wt3wpofR+D7IMEFTzmGdluoSSnE0g85Tpz
        ihw9NmGSJPoFy300BVkCVgiDE3Vpde+NUJqsXBBGOX/6+RcOGzeMaf+y2xZ2Sn5C
        CwXqKlzthQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 803BEF3C0C;
        Mon, 18 Jun 2018 12:50:00 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0420F3C09;
        Mon, 18 Jun 2018 12:49:59 -0400 (EDT)
Date:   Mon, 18 Jun 2018 12:49:58 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] rebase --root: demonstrate a bug while amending
 rootcommit messages
Message-ID: <20180618164958.GO11827@zaya.teonanacatl.net>
References: <pull.3.git.gitgitgadget@gmail.com>
 <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
 <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: A37B38DE-7317-11E8-B2B2-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood wrote:
> On 15/06/18 05:31, Johannes Schindelin via GitGitGadget wrote:
>> 
>> From: Todd Zullinger <tmz@pobox.com>
>>  
>> +test_expect_failure 'rebase -i --root reword root commit' '
>> +	test_when_finished "test_might_fail git rebase --abort" &&
>> +	git checkout -b reword-root-branch master &&
>> +	set_fake_editor &&
>> +	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
>> +	git rebase -i --root &&
>> +	git show HEAD^ | grep "A changed"
> 
> I wonder if it should also check that HEAD^ is the root commit, to make
> sure that the squash-onto commit that's created and then amended has
> been squashed onto.

Hmm, is that something which other tests don't cover or an
issue that could affect 'rebase -i --root' with reword
differently than other 'rebase -i' commands?

I admit I'm not well-versed in the rebase -i tests and I
focused only on creating a test which demonstrated the bug I
noticed.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The average woman would rather be beautiful than smart because the
average man can see better than he can think.

