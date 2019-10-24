Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A171F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbfJXXFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:05:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbfJXXFG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Oct 2019 19:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571958304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thvmpFcJgZy5zLhOc2vZCWkcNrjd5UyOcgUW7fbn+GI=;
        b=TauFSgb/tuT1iTr0bAdyPs1K2pXPZBC1y6oA0cWbDrr1WVz7+I5SwFg0uW58aZuxIesK3e
        Wfw1xYhlYgAcW7c4XTjy0qnzdAkxsp8pQkRy+aNXaNF0K/iCD1wSGwcWVa/budn9XP3JbE
        ZuXfzPGMrAAiQ7uonmXCtEl2DmNZsFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Vm2vVHExPP2fT3JWotv7nA-1; Thu, 24 Oct 2019 19:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71ED1800D6B;
        Thu, 24 Oct 2019 23:05:01 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1666B5C1B5;
        Thu, 24 Oct 2019 23:05:01 +0000 (UTC)
Subject: Re: [PATCH v2] pretty: add "%aL"|"%al|%cL|%cl" option to output
 local-part of email addresses
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
References: <20191024125332.29958-1-prarit@redhat.com>
 <20191024202947.GN4348@szeder.dev>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <5d9b8cbe-489e-b3eb-873c-4aee2e2015d0@redhat.com>
Date:   Thu, 24 Oct 2019 19:05:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191024202947.GN4348@szeder.dev>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Vm2vVHExPP2fT3JWotv7nA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/24/19 4:29 PM, SZEDER G=C3=A1bor wrote:
>=20
> Just a couple of test nits:
>=20
> On Thu, Oct 24, 2019 at 08:53:32AM -0400, Prarit Bhargava wrote:
>> +test_expect_success 'log pretty %an %ae %al %aN %aE %aL' '
>> +=09git checkout -b anaeal &&
>> +=09test_commit anaeal_test anaeal_test_file &&
>> +=09git log --pretty=3D"%an%n%ae%n%al%n%aN%n%aE%n%aL" -1 > actual &&
>=20
> Style: no space between redirection and filename, i.e. >actual
>=20
>> +=09{
>> +=09=09echo "${GIT_AUTHOR_NAME}" &&
>> +=09=09echo "${GIT_AUTHOR_EMAIL}" &&
>> +=09=09echo "${TEST_AUTHOR_LOCALNAME}"
>=20
> Broken &&-chain (though with just a bunch of echos it won't really
> make much of a difference)
>=20
>> +=09=09echo "${GIT_AUTHOR_NAME}" &&
>> +=09=09echo "${GIT_AUTHOR_EMAIL}" &&
>> +=09=09echo "${TEST_AUTHOR_LOCALNAME}"
>=20
> All these variables stand on their own, so the curly braces around
> them are unnecessary.

I've changed this code (based on Peff's suggestions) to other tests, howeve=
r,
AFAIK using braces around is considered "good practice".

It can't harm anything to have braces but if the preferred git coding style=
 is
to only use them when necessary I will remove them.

P.

>=20
>> +=09} > expect &&
>> +=09test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'log pretty %cn %ce %cl %cN %cE %cL' '
>> +=09git checkout -b cncecl &&
>> +=09test_commit cncecl_test cncecl_test_file &&
>> +=09git log --pretty=3D"%cn%n%ce%n%cl%n%cN%n%cE%n%cL" -1 > actual &&
>> +=09{
>> +=09=09echo "${GIT_COMMITTER_NAME}" &&
>> +=09=09echo "${GIT_COMMITTER_EMAIL}" &&
>> +=09=09echo "${TEST_COMMITTER_LOCALNAME}"
>> +=09=09echo "${GIT_COMMITTER_NAME}" &&
>> +=09=09echo "${GIT_COMMITTER_EMAIL}" &&
>> +=09=09echo "${TEST_COMMITTER_LOCALNAME}"
>> +=09} > expect &&
>> +=09test_cmp expect actual
>> +'
>> +

