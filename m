Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F77EC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116F26194C
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCUS6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 14:58:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCUS6D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 14:58:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CD11126A27;
        Sun, 21 Mar 2021 14:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eBp6MOAaITbJ
        ov1gDdE8rZ0WWjw=; b=L1aX4p46XxcvMrAx2LRTDvyhGo5nkoefSUzvWDL3LpSq
        GgXB0AYkr13GuhYnyzJqLJK0JSctQFWyBU7YfXibQkJIkDsZIowf0Dj7N8C22/S7
        d2s29B9p6AK8q5SZLzFEIXxh6GTFHKkaoVrDlCfezzu7P54OLuEjPp9kMU+Jgvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ek/8bI
        I8MUDUVD9L0uX6K9+LWfzkIWSeK7ugPK33h/z5pHA+TSzUygHaqGbxXT/LOzXcoh
        gPpBAoTurVMhea9ZmfDvd0etDYQZbGwhmE+eczB51PGdrk4KfXJhQaYmrGkEq6Y8
        p2ChN6LQ7LJjplGh7V/Gbc1VGGs03uh1TBChU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84DBB126A26;
        Sun, 21 Mar 2021 14:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3E09126A24;
        Sun, 21 Mar 2021 14:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v3] gitweb: redacted e-mail addresses feature.
References: <pull.910.v2.git.1616297564158.gitgitgadget@gmail.com>
        <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <xmqqzgyw9wn3.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 11:57:58 -0700
In-Reply-To: <xmqqzgyw9wn3.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        21 Mar 2021 11:42:08 -0700")
Message-ID: <xmqqo8fc9vwp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B0BFA0A-8A77-11EB-A22D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -8060,8 +8095,9 @@ sub git_commitdiff {
>>  		close $fd
>>  			or print "Reading git-diff-tree failed\n";
>>  	} elsif ($format eq 'patch') {
>> -		local $/ =3D undef;
>> -		print <$fd>;
>> +		while (my $line =3D <$fd>) {
>> +			print hide_mailaddr_if_private($line);
>> +		}
>
> And this is even worse.

And also =C3=86var is right.  The original just has a format-patch output
in $_ and prints it to the output stream in one go.  It won't make
any sense to attempt reading from that stream, which the original
code used to write to, at all.

In any case, I've already said that I do not think it is a good idea
to touch the 'patch' codepath at all, so this code won't do any
damage in the end by reading from the output pipe connected to
end-user's browser ;-)

Thanks.
