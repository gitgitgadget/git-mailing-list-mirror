Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664511F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 01:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfJ1B1b (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 21:27:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63596 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfJ1B1b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 21:27:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2A3396C0B;
        Sun, 27 Oct 2019 21:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IfBYqb16mNYDAc9DOEBiLRWPafg=; b=PGjq4J
        NZv6TaBRZjGFqIgdLZ9LC0RBoFR27dSyEpqSuKBKvGLMUOwajN+DoyL0VvJAN+Ze
        Z9POV6Ocjn1IMd31X77RTJyRrubUAg9mVeRYheVuqmGJO8w6ipQBJ7ZHJGeWoWWo
        91DVocLOL6SGnmK3uykI8hkKJbJ/OUlZp0tAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MOnDtXwskTR+EKBP5k+eI2CLyLaB4Cmt
        0tYEpfn1K5U+bb8BtQzWbOXbRRA2RXKMHad4v505UsVLChSWiN6XF+RKa1OCcwC7
        hpYfD5za7Gcj9W3NtWuar3+Oo2LOowHkvtXI8MkQch7UJ+pMWPfJ+/yOMXVmUTiy
        lAAtJVzzU2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB5BD96C0A;
        Sun, 27 Oct 2019 21:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DFADF96C09;
        Sun, 27 Oct 2019 21:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] myfirstcontrib: add dependency installation step
References: <20191026005159.98405-1-emilyshaffer@google.com>
        <20191026005159.98405-3-emilyshaffer@google.com>
        <20191026011250.GB39574@google.com>
Date:   Mon, 28 Oct 2019 10:27:25 +0900
In-Reply-To: <20191026011250.GB39574@google.com> (Jonathan Nieder's message of
        "Fri, 25 Oct 2019 18:12:51 -0700")
Message-ID: <xmqqimo9bqwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A706630-F922-11E9-964D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Emily Shaffer wrote:
>
>> Indicate that the user needs some dependencies before the build will run
>> happily on their machine; this dependency list doesn't seem to be made
>> clear anywhere else in the project documentation.
>
> In theory, this info should be in INSTALL.  I wouldn't be surprised if
> it's missing some info, though.
>
> [...]
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -38,6 +38,30 @@ $ git clone https://github.com/git/git git
>>  $ cd git
>>  ----
>>  
>> +[[dependencies]]
>> +=== Installing Dependencies
>> +
>> +To build Git from source, you need to have a handful of dependencies installed
>> +on your system. For a hint of what's needed, you can take a look at
>> +`ci/install-dependencies.sh`.
>> +
>> +To install the dependencies needed for a basic build on Linux, run something
>> +like this (or replace `apt` with your distribution's package manager of choice):
>
> pedantic nit: s/or replace/replacing/ ("or" would mean rpm is an
> alternative to what came before, but "something like" in the phrase
> before has rpm already included)

This section, as you hinted at the beginning, should be a single
sentence, i.e. just "follow INSTALL".  Any clarifications should 
be made as a patch to the INSTALL file.

Thanks.
