Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8572020C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbdLHP5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:57:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754309AbdLHP4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:56:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C16DBA47F9;
        Fri,  8 Dec 2017 10:56:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uPPvIXIfH66dZLuGIg0ZUdMBvGI=; b=hF3r8j
        Xg80szexACHcniCKClT0AUN/bqVbIk3tpUmdmh9I4yZZdAB0UCicDvJuHwQt9ES1
        oj3D1m3vezda6oryl3DQijCIg0uVp9YT1xL6FlzSe7rUz+WhSAXhvYME3ERkCNRY
        o970gNOcqyo8tfNNrxtmzUtdtwalCLSgXlcP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GSTacny1jxzh1nnyOxmQQd7l4dc13t6e
        C8+Lp6v4gSy/XcQQ1nI0J1gGWj5w5goT6IWdU8YALcNhCd6bhSWGdLjsr1Fp8ipz
        S76yxVcIGVT+u6F4N1pa30y05E+EZtrRNLyGGSQD2DGxheC6cybTvllCIGYY3pZn
        KNrYkcYIcXI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA2FBA47F7;
        Fri,  8 Dec 2017 10:56:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34160A47F6;
        Fri,  8 Dec 2017 10:56:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1zDcwfMBWy5F0KAru9wWS8k6qmKtCRLTZBsN-jLXeysw@mail.gmail.com>
Date:   Fri, 08 Dec 2017 07:56:52 -0800
In-Reply-To: <CAP8UFD1zDcwfMBWy5F0KAru9wWS8k6qmKtCRLTZBsN-jLXeysw@mail.gmail.com>
        (Christian Couder's message of "Fri, 8 Dec 2017 16:36:13 +0100")
Message-ID: <xmqqshcl9prv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68C3B9E2-DC30-11E7-8BCC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Dec 7, 2017 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
>> * cc/skip-to-optional-val (2017-12-07) 7 commits
>>  - t4045: test 'diff --relative' for real
>>  - t4045: reindent to make helpers readable
>>  - diff: use skip-to-optional-val in parsing --relative
>>  - diff: use skip_to_optional_val_default()
>>  - diff: use skip_to_optional_val()
>>  - index-pack: use skip_to_optional_val()
>>  - git-compat-util: introduce skip_to_optional_val()
>>
>>  Introduce a helper to simplify code to parse a common pattern that
>>  expects either "--key" or "--key=<something>".
>>
>>  Even though I queued fixes for "diff --relative" on top, it may
>>  still want a final reroll to make it harder to misuse by allowing
>>  NULL at the valp part of the argument.
>
> Yeah, I already implemented that and it will be in the next v3 version.

Good.  I am hoping that you've followed the discussion on the tests,
where all of us agreed that the approach taken by Jacob's one is
preferrable over what is queued above?

>> Also s/_val/_arg/.
>
> I am not sure that is a good idea, because it could suggest that the
> functions are designed to parse only command option arguments, while
> they can be used to parse any "key=val" string where "key" is also
> allowed.
>
>>  cf. <xmqqh8t6o9me.fsf@gitster.mtv.corp.google.com>
>>  cf. <xmqqd13uo9d1.fsf@gitster.mtv.corp.google.com>
>
> It doesn't look like s/_val/_arg/ was discussed in the above messages.

It came from your statement that was made before the thread, where
you said you'll rename it to use arg after I said I suspect that arg
would make more sense than val.

https://public-inbox.org/git/CAP8UFD2OSsqzhyAL-QG1TOowB-xgbf=kC9wHre+FLc+0J1Xy+Q@mail.gmail.com/


Thanks.
