Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526242095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbdCUT11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:27:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52841 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933640AbdCUT1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:27:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A82C6F73A;
        Tue, 21 Mar 2017 15:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D6R7NVHvOgUT
        /2iQ0QckekBU0Zk=; b=PGTi15yTV306EYRGd5Sq3NJYaiqJ/zuHyA5//OnSerxY
        hb65bWp/eQpvW4iJase0nYJnGit46PfFS+DgSnHMl6FviLLgcJoCk25vsUOW12bG
        XcwPe6Hv+MFTjTQ1wF06xzyqABB/xXwcljKrdHE2wqtlml/jjt9LXHdk4a/PSV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lNmIri
        oBZXKzug6MSl4buTVwFiSjY0F4dgW2xP4XK6LXIG3jL/dc0pDpj+0XyL718tJe7H
        NgSZ2JKMwQBr9xOcW31Fe2dGdCb4JyrZV8JMhIADhUKnIb3Vktg3ud9m3wrzk9n9
        HrEA3AXN7b1+AauLzGSnYFQfwLVDyCqtEP2JQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91E1E6F739;
        Tue, 21 Mar 2017 15:26:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB40E6F738;
        Tue, 21 Mar 2017 15:26:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
References: <20170318223409.13441-1-avarab@gmail.com>
        <CACBZZX6g694p9WkiK75+HJCLUPwjpdQhjBrAU713KahAKm53hA@mail.gmail.com>
Date:   Tue, 21 Mar 2017 12:26:19 -0700
In-Reply-To: <CACBZZX6g694p9WkiK75+HJCLUPwjpdQhjBrAU713KahAKm53hA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 21 Mar
 2017 20:19:34
        +0100")
Message-ID: <xmqqpohao2hw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 43860CA8-0E6C-11E7-95F4-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Mar 18, 2017 at 11:34 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> <avarab@gmail.com> wrote:
>
>> The new starts_with_case() function is a copy of the existing adjacent
>> starts_with(), just with a tolower() in the "else if".
>> [...]
>> +int starts_with_case(const char *str, const char *prefix)
>> +{
>> +       for (; ; str++, prefix++)
>> +               if (!*prefix)
>> +                       return 1;
>> +               else if (tolower(*str) !=3D tolower(*prefix))
>> +                       return 0;
>> +}
>> +
>>  /*
>
> One thing I'd like feedback on is whether I should be adding this to
> strbuf.c. There are >300 uses of starts_with(), but sha1_name.c will
> be the only one using this modified starts_with_case() function.
> Wouldn't it be better to just add it to sha1_name.c rather than
> expanding the strbuf API with something that'll likely be used by
> nothing else for a while?

Yeah, static inside sha1_name.c is OK; people with newer needs can
move it later if necessary.

I'd have called starts_with_icase(), though.

