Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8C91F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeAEURA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:17:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65053 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeAEUQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:16:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0900BC74B0;
        Fri,  5 Jan 2018 15:16:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Wq0NYBcj374w
        HHcYpp84raOP1Kc=; b=gY7cT0nc7SxMZtuwZegBFuUOLn9wK2rp+r2tQJ0vxj05
        0j7COCIdcnK5+gBMVw95a70PJG3la3fonMEw8+qQTdbeTqVTwWZml+qTXEo4aoi3
        iVfwqTdhvrSirg2AkNI7gLc6husNYvVBBtjRJjQE1ag58neRTTRDWOxjCPpXSB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lhQ4f2
        KpmO+1nmw7dbMitch1D8U5Lwrom4P4UeEMrFkPeWBldiedbS33z1c125OIL9RnOb
        0oqrrc3aLsNpfMHBRd70ya/4Kn4DJbB14i/yq7nsb2nqVr3cLTdKW00xJ63U5Gdq
        Sw/7+lohuSyCnp+HzwaxOwZKYnnQejugsZn8A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0E80C74AF;
        Fri,  5 Jan 2018 15:16:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61C49C74AA;
        Fri,  5 Jan 2018 15:16:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org
Subject: Re: [PATCH] send-email: add test for Linux's get_maintainer.pl
References: <q7h9wp0wod8y.fsf@orange.lip.ens-lyon.fr>
        <1515147109-8077-1-git-send-email-git@matthieu-moy.fr>
        <87o9m8d09u.fsf@linaro.org> <q7h9h8s0o7vj.fsf@orange.lip.ens-lyon.fr>
Date:   Fri, 05 Jan 2018 12:16:57 -0800
In-Reply-To: <q7h9h8s0o7vj.fsf@orange.lip.ens-lyon.fr> (Matthieu Moy's message
        of "Fri, 05 Jan 2018 12:36:00 +0100")
Message-ID: <xmqqzi5sawna.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61BF5166-F255-11E7-B831-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> I think you need to apply Eric's suggestions from:
>>
>>   From: Eric Sunshine <sunshine@sunshineco.com>
>>   Date: Sat, 18 Nov 2017 21:54:46 -0500
>>   Message-ID: <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mai=
l.gmail.com>
>
> Indeed. I'm squashing this into the patch:
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index f126177..d13d8c3 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -173,8 +173,7 @@ test_expect_success $PREREQ 'cc trailer with variou=
s syntax' '
>  '
> =20
>  test_expect_success $PREREQ 'setup fake get_maintainer.pl script for c=
c trailer' "
> -	cat >expected-cc-script.sh <<-EOF &&
> -	#!/bin/sh
> +	write_script expected-cc-script.sh <<-EOF &&
>  	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
>  	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
>  	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/=
bar))'

Please do not forget to lose "chmod +x", which becomes unneeded when
you use write_script.

> @@ -186,7 +185,6 @@ test_expect_success $PREREQ 'setup fake get_maintai=
ner.pl script for cc trailer'
>  "
> =20
>  test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output'=
 '
> -	test_commit cc-trailer-getmaint &&
>  	clean_fake_sendmail &&
>  	git send-email -1 --to=3Drecipient@example.com \
>  		--cc-cmd=3D"./expected-cc-script.sh" \
