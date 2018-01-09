Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC631F406
	for <e@80x24.org>; Tue,  9 Jan 2018 23:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755211AbeAIXzV (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 18:55:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53707 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbeAIXzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 18:55:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FE67C2CC0;
        Tue,  9 Jan 2018 18:55:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XCtzm/stD9oidi65B5OhWrJBPy8=; b=hJ3RMC
        U/KQpNk+mjYB4wEc3t7h9weVsY2p+P+oZ+/x40mzYQgVnAUqZMApdBQhCNDQ4PAA
        ImhpKQu0haNmgu8FBmqol77rxQDk0MiTkvipuAttdXZdlgrguj7MtsRVNJK/9ev5
        QZPL6aP7fOLbw7MlSV9HuGdnAIVlrSXFzTnzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RVg7AEOLX0mCf0nV8RDJvEPbzKv0yHrR
        mvj8IeW7hjkKiFaK5bOVgz/qTjBSTlpkzH+Hek3VyYIAncVvOmhv1nx6NS2/MdF4
        JLHgmY42e5iPUD3Y94lBXya9tmpsJl9ItmXogubXJi1qew3tw2AszaVgi5VvIehJ
        6Arma8vi5Ww=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36F90C2CBE;
        Tue,  9 Jan 2018 18:55:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B105BC2CBD;
        Tue,  9 Jan 2018 18:55:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 09 Jan 2018 15:55:17 -0800
In-Reply-To: <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 09 Jan 2018 13:42:57 -0800")
Message-ID: <xmqq608a37ve.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BCD430A-F598-11E7-B1C3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
>> index f1678851de9..470107248eb 100644
>> --- a/t/t0021/rot13-filter.pl
>> +++ b/t/t0021/rot13-filter.pl
>> @@ -31,7 +31,22 @@
>>  #
>>  
>>  use 5.008;
>> -use lib (split(/:/, $ENV{GITPERLLIB}));
>> +sub gitperllib {
>> +...
>> +	if ($ENV{GITPERLLIB} =~ /;/) {
>> +		return split(/;/, $ENV{GITPERLLIB});
>> +	}
>> +	return split(/:/, $ENV{GITPERLLIB});
>> +}
>
> This cannot be the whole story for a few reasons.
>
>  - In t/test-lib.sh we see this:
>
>    GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
>    export GITPERLLIB
>
>    If this part wants to split with ';', then the joining needs to
>    be done with ';' to match, no?
>
>  - In addition to t0021, there are similar split with colon in 0202,
>    9000 and 9700, yet I am getting the feeling that you observed the
>    issue only in0021, to which I do not think of a good explanation
>    why.

This somehow vaguely rang a bell, and I dug this thing up from the
archive, [*1*] which ended like so:

    >> In our C code, we have "#define PATH_SEP ';'", and encourage
    >> our code to be careful and use it.  Is there something
    >> similar for Perl scripts, I wonder.
    >>
    > We probably should find a better solution to allow this to
    > work with windows style paths...? I know that python provides
    > os.pathsep, but I haven't seen an equivalent for perl yet.
    >
    > The Env[1] core modules suggests using
    > $Config::Config{path_sep}[2]..  maybe we should be using this?

    I was testing this recently on the Perl included with Git for
    Windows and it returns : for the path separator even though it's
    on Windows, so I don't think that would work. The Perl in Git
    for Windows seems to want UNIX-style inputs (something Dscho
    seemed to allude to in his response earlier.). I'm not sure why
    it's that way, but he probably knows.

Your initial response in this thread made it sound as if -rc1 is the
only thing that changed, but looking at the differences between -rc0
and -rc1, which does not touch t0021 or any other instances of
"split(/:/, $ENV{GITPERLLIB})", I am wondering if it is possible
that perhaps the way Perl is built for GfW has been changed recently
and we can safely and sanely use $Config::Config{path_sep} (contrary
to what was found in late Oct in the message quoted above) now?

In any case, I'd prefer this issue to be resolved properly before
-rc2; a patch to t0021/rot13-filter.pl alone does not smell like a
"proper solution" that is based on the understanding of the root
cause (and that is why I spent time digging the list archive).

Thanks.


[Reference]

*1* https://public-inbox.org/git/CAGyf7-EjKaHgwkN9trO4mFvba9odbWCzA9Jh0Pk6ZE6FOskOYg@mail.gmail.com/



