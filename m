Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A4D81F461
	for <e@80x24.org>; Wed,  4 Sep 2019 23:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfIDXgb (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 19:36:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDXgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 19:36:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B697E8BBEB;
        Wed,  4 Sep 2019 19:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ghdv0avgCPjBkZVn6sePconA1o=; b=BdC8P2
        Vv4A5clOfvB6tbLLnZ33W5bqqKlvy/Jy/wZQSXwapWDuGp1yv/r578XYBMl6lLhe
        8enE0rcJ7PhH0MxYCVZBjI0ks+QbhtGDHFrkE6lHWbxV6UGHIxPgILhPW/SV2oEV
        KqumS5sQ7Ctf32QLC3Ljm2LZ6oSAoj9ZLNAPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uM9alLBJ38gwURf9g1XrUWqWVWFruWM6
        WeVg1VGVehvbwX16aiveTRBfGiyD1+KHE/a15YrjXeCOV5rX1c7DMEW3kfI7IQFR
        uYlarlfzYSeeZDXT7MoPzilrHh4nbuIQyRVmcA9rgNc2/r+G/UYLogzHMJN6JATp
        nnlnwwd/B5w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE04F8BBEA;
        Wed,  4 Sep 2019 19:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D36028BBE9;
        Wed,  4 Sep 2019 19:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] mingw: apply array.cocci rule
References: <cover.1567595331.git.liu.denton@gmail.com>
        <dcb92cffd7bd0643e7af68d825f7517d490dcf16.1567595331.git.liu.denton@gmail.com>
        <nycvar.QRO.7.76.6.1909042340520.5377@tvgsbejvaqbjf.bet>
Date:   Wed, 04 Sep 2019 16:36:25 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909042340520.5377@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 4 Sep 2019 23:41:24 +0200
        (CEST)")
Message-ID: <xmqq36hbskg6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0D897BA-CF6C-11E9-A344-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Denton,
>
> On Wed, 4 Sep 2019, Denton Liu wrote:
>
>> After running Coccinelle on all sources inside compat/ that were created
>> by us[1], it was found that compat/mingw.c violated an array.cocci rule
>> in two places and, thus, a patch was generated. Apply this patch so that
>> all compat/ sources created by us follows all cocci rules.
>>
>> [1]: Do not run Coccinelle on files that are taken from some upstream
>> because in case we need to pull updates from them, we would like to have
>> diverged as little as possible in order to make merging updates simpler.
>>
>> The following sources were determined to have been taken from some
>> upstream:
>>
>> * compat/regex/
>> * compat/inet_ntop.c
>> * compat/inet_pton.c
>> * compat/nedmalloc/
>> * compat/obstack.{c,h}
>> * compat/poll/
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>>  compat/mingw.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 738f0a826a..a3b1e9e3bb 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1265,7 +1265,7 @@ static wchar_t *make_environment_block(char **deltaenv)
>>  		}
>>
>>  		ALLOC_ARRAY(result, size);
>> -		memcpy(result, wenv, size * sizeof(*wenv));
>> +		COPY_ARRAY(result, wenv, size);
>>  		FreeEnvironmentStringsW(wenv);
>>  		return result;
>>  	}
>> @@ -1309,7 +1309,7 @@ static wchar_t *make_environment_block(char **deltaenv)
>>  			continue;
>>
>>  		size = wcslen(array[i]) + 1;
>> -		memcpy(p, array[i], size * sizeof(*p));
>> +		COPY_ARRAY(p, array[i], size);
>
> ACK!
>
> Thanks,
> Dscho

Yup, looks good.  Thanks both.
