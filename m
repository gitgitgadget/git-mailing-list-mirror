Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E061F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBHUbv (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:31:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55812 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHUbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:31:51 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Feb 2019 15:31:51 EST
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78F6D63DDD;
        Fri,  8 Feb 2019 15:25:11 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=bXtSO9W8+fD7K
        4W22NcdMc7nIfg=; b=FC6Rmat9kRqeEHI7IpFt6KGwEZdPBD1FRohiI7UZ/mEpr
        OrnFGkHgOugegbd/mjYkmQX+OB2Rt/sqYm1vXO+Rw0XPz5xQuUfbxBZluHh7xOSr
        7k6mjn2HR8RPGD48phxXDqqHmJ2K+gFpYQ3LD4qCH23MUDNX5Irpu76Pjhr4Yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=JEw3OYi
        9WW3SUpIE78eiFtO97uzHRISYr6XOB0pSJjxH2zBaHkxPRkAcbJCoOae6Uejc2IO
        Wv+4OXpXmSxadDp/14jJ056s0qgVuaIUA+tCyuOVUZJ42As3+tjN72kmSa7Ojd1T
        Y4RiBKGozO6N6AZpynAMGMl5JMMJUeae6r/Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 706AE63DDC;
        Fri,  8 Feb 2019 15:25:11 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31DEB63DD9;
        Fri,  8 Feb 2019 15:25:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Fri, 8 Feb 2019 15:25:05 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt
Message-ID: <20190208202505.GE30548@zaya.teonanacatl.net>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190208031746.22683-2-tmz@pobox.com>
 <20190208201105.GA10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190208201105.GA10587@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: A0B0A540-2BDF-11E9-8BD1-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor wrote:
> On Thu, Feb 07, 2019 at 10:17:45PM -0500, Todd Zullinger wrote:
>> When gpgsm is installed, lib-gpg.sh attempts to update trustlist.txt t=
o
>> relax the checking of some root certificate requirements.  The path to
>> "${GNUPGHOME}" contains spaces which cause an "ambiguous redirect"
>> warning when bash is used to run the tests:
>=20
> s/error/warning/

Did you mean s/warning/error/ so the sentence reads:

    The path to "${GNUPGHOME}" contains spaces which cause
    an "ambiguous redirect" error when bash is used to run
    the tests

?

Is it worth a resend before Junio queues it?

>>   $ bash t7030-verify-tag.sh
>>   /git/t/lib-gpg.sh: line 66: ${GNUPGHOME}/trustlist.txt: ambiguous re=
direct
>>   ok 1 - create signed tags
>>   ok 2 # skip create signed tags x509  (missing GPGSM)
>>   ...
>>=20
>> No warning is issued when using bash called as /bin/sh, dash, or mksh.
>=20
> Likewise.
>=20
> POSIX says that no field splitting should be performed on the result
> of a parameter expansion that is used as the target of a redirection,
> but Bash doesn't conform in this respect (unless in POSIX mode).

I wish I'd remembered reading your detailed explanation of
this=B9 when I was testing and writing the commit message. :)

=B9 https://public-inbox.org/git/20180926121107.GH27036@localhost/

--=20
Todd
