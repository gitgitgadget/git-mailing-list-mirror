Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E588C1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGJS6p (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:58:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56769 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGJS6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:58:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95152169608;
        Wed, 10 Jul 2019 14:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dl4A+s0dH68yuxhSMd/fbgAwtMI=; b=lAKBTV
        ocIEkTMHlacE7ouJ53D9HYgWdIVuHTxBj+gcYJeedn5INhw6H2u4g1dIxTVTAD6A
        lvhWPiTGG4JiYnKK1CLYaENrKAu5QgBrK+X+RbJBeQ+oLXGJdCjjvJlLwsZJthg/
        72rV17D72jV7wtlhxrJCSt0Gg/14YQufrTYB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ss/wg9h2ci1Go2osb8Ek0qF+pB1vsBYg
        OV1UcigXM/H/z14EtjnUZUkGZymjw2QIueDrFcx2kAB68/sCqWaS+uNFOnY9sXUL
        ok1C/irHyT+wqRJSNZi9aY+JuhtLE1rlH7B9oXiXDNQvAZ4U2X3UttlRn85N3wkz
        wpoC+xQjMzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E18C169607;
        Wed, 10 Jul 2019 14:58:43 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07FCF169606;
        Wed, 10 Jul 2019 14:58:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #02; Tue, 9)
References: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907102050100.46@tvgsbejvaqbjf.bet>
Date:   Wed, 10 Jul 2019 11:58:41 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907102050100.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 10 Jul 2019 20:51:37 +0200 (CEST)")
Message-ID: <xmqq5zo9u36m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCB34DCE-A344-11E9-8D37-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 9 Jul 2019, Junio C Hamano wrote:
>
>> * mt/dir-iterator-updates (2019-06-25) 10 commits
>>  - clone: replace strcmp by fspathcmp
>>  - clone: use dir-iterator to avoid explicit dir traversal
>>  - clone: extract function from copy_or_link_directory
>>  - clone: copy hidden paths at local clone
>>  - dir-iterator: add flags parameter to dir_iterator_begin
>>  - dir-iterator: refactor state machine model
>>  - dir-iterator: use warning_errno when possible
>>  - dir-iterator: add tests for dir-iterator API
>>  - clone: better handle symlinked files at .git/objects/
>>  - clone: test for our behavior on odd objects/* content
>>
>>  Adjust the dir-iterator API and apply it to the local clone
>>  optimization codepath.
>>
>>  Is this ready for 'next'?
>
> I am afraid that still, just like I said in response to the previous
> "What's cooking" mail, this is not ready (which is unsurprising, given
> that it has not changed): it breaks 1,384 test cases.

Let's kick it out of 'pu' for now to help ci runs on Windows, which
would be swamped with failures from this.  Thanks for reminding me.


