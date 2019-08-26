Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB4D1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfHZP1n (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:27:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58227 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfHZP1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:27:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47FA86C2AD;
        Mon, 26 Aug 2019 11:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6vEt9ezPLODlJ56hSj+qJo3KbSw=; b=Lqhz7b
        Y7TbGNjQLP1x3fKp78HBitWIPuVVoUFkVef1Ohg6ONkqqKZlwz3OivaSZFBM7n73
        Od2blSckvjMGnJ/eKdzj+rQad69B8JUinFg69uj4n0jirgr0GoG2/luyGlCFb2+A
        1+1gT4swwn9Z75BsfEPjBZsMo/MBAA8HH3wdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tymnup4uYqKGoK6s07/qPqxSizV8QVUR
        eODpgyqN19hjNIgciQ4HfkITD2oZOJfl0+n8G1LSzfSIMwGO2uaFIkAWuf1c7oEg
        SqMMKvfOfiOOocIsCH9d4Nu7rxeQ9Ixkly8ldcuQqy0yk6wvYacyENsoP5NfPDVf
        KE/DPTzvj3E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FECE6C2AC;
        Mon, 26 Aug 2019 11:27:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38D2E6C2AB;
        Mon, 26 Aug 2019 11:27:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Albert Vaca Cintora'" <albertvaka@gmail.com>,
        "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
        <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
        <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
        <006201d55c1a$68180f50$38482df0$@nexbridge.com>
Date:   Mon, 26 Aug 2019 08:27:38 -0700
In-Reply-To: <006201d55c1a$68180f50$38482df0$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 26 Aug 2019 10:27:29 -0400")
Message-ID: <xmqqsgpoj6ad.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A7F96D4-C816-11E9-A479-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> Sometimes I clone a repo just to grep for an error string and then I don't
>> need it anymore, or I clone several repos until I find the one that contains
>> what I want and delete the rest. Sometimes I want to write a patch for some
>> software I don't develop regularly so I don't need to keep a clone of it.
>> 
>> In any case, it would be useful to know the reason those files are read-only in
>> the first place. Do you guys know who might know?
>
> Why don't you wrap your clone in a script that calls chmod -R u+w
> .git after the clone? This seems like a pretty trivial approach
> regardless of your workflow. This works in Linux, Mac, Windows
> (under cygwin-bash) and anything else POSIX-ish.

But on anything POSIX-ish, is it a problem for some files (but not
any directory) in .git is made read-only?



