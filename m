Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54643C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB50121D24
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iQbyosSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRNTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:19:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:60539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIRNTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 09:19:47 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 09:19:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600435186;
        bh=N2ZvWEZzFeEzcz4XZ6dVGRQs0OasDE54L5MF8f6Vww8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iQbyosSZFjg3Hl7a3DGcIpyRl2K5ZgHT207PqrS+wpKCZbhKTEg8petpPv3+1WN15
         BEffaRH9f0Sq+U7kQCVrYHOJ/FQf07wh6BBpT+RPHGgJbtdaInzV6u/a344dHzUHlW
         IO262veBnFAiP6Z0N+GRumeREoD0stJcxOj5pqBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.213.8]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1k519U2Yaa-00NA63; Fri, 18
 Sep 2020 15:14:36 +0200
Date:   Fri, 18 Sep 2020 15:14:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 00/11] Maintenance I: Command, gc and commit-graph
 tasks
In-Reply-To: <xmqqtuvwqmjg.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009181514000.5061@tvgsbejvaqbjf.bet>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com> <xmqqtuvwqmjg.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HUgZ5NIudaQO2ELyTIbkIJHSw/RBo+ICvqOa+i/Ma794y5duWN9
 D/X8fGFmxmatfmjQr30yKqy3oNj85ZFBH9sUp1r9Cx4hSwCHm0N58/a3mmXqT/BCYgfGmWj
 S2qYMT2oTCQyAWArsfFdx4DCS7zGqQgSN7HV8q5ai6uS4sF8d0uk7Xw7JKTScNJ/38Sw56y
 XyGOgBgzgLuQa4y4w4POQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e2cIuGUHl3g=:PKHcA9iLjUmc/2lEsiC2H0
 QdzGqpkz+KEHfgwXnbHWx+ylkgyIp4pJUu5LUqYBM1ST/Hw/0KdTqNr9VjVX1IXka3H9jrvq3
 GXCV+ovmP5nd6Pe1TiF1nNtFA91q3uKjZYEcFUQU+ov4lL4Dz+9u6Xzw6z2eNMBOLCy60lHef
 Az/5AeWhAnWJVFvEeHvAhIE6qfI2JCRoaU1J9LOZSqM+qdgRCcLQ+RAHbH+TztPY6Mi1EIh3+
 ArFANXWbO0i/mbeOCV0FNgK2Ze4yXpSVS+oEASXPfY9LtiFY2/WgzgnTjuKmjGpuWeiIE0q7C
 /K68Gyjr/+VZ0wqh+MPcrEEWkbUZoQwX9eSeiV8PomUmxgicTxEsuT6j0L/WwGYYHmYZhTaEG
 gXE3FlKPR6fmyuyv3XaZ7DOWxigbMMavvqt7vMqwH3mwjSkg+Hy+7EHmBY1iFmcqU+UosRWJS
 lFmNuGWDPP88CFwKQSCMAZ50uJikiJWgDYbFBZCtc/Fx+uLfss3RZSBWD8pSN4TaSUmU1Nk+b
 xZyJxKlIAu6zn1qX1s/jK87gBPJwYWkmwshHWKhbH0iYzGZ8bLdcyGDGRBUy0XAuaGYJ8Rxaa
 ZRGJsVv8Za6b+CGpn7tZZyxHbieYQhiWi1NTqrkgsSGsQF9dMPaozZOQ5vulRTjC/OPIhYF5b
 nI8qoJg9FDDaAjCFu1qN2GUGWUQMmDmNyajkDcgPw1M1p72sBwb/GImG0M7IimLDIFfVv0DqM
 7l8SJzBQ8a1kbHIwNoq3M7fpY8PVnK5DZRmG6wZqrZfoPoM1S2yl4OGKfOldieSmNEWem7AYR
 xEKIAc0CMut4xQ+zmkIOSZDzCjrT/e2SD9HXcTiRFaA3O3v2Uvrv1B7QKdx9Qeqq6HAN/jCQv
 HKOaNaI//rmZN7fLTvwM/UX7Bwy8JfUNaar85L6EOBOjaElPAydj2ud/Z4Eq2rMvVOzjswuii
 Z5eQp9XQbpmk01EK2I3PPy23inYs3ni0ofc0b9gM7t8q91jTE/dWH1EJ6QcTpmft0b+Oz/2q8
 QKKty330h46TcYRNcqnlUW6G29CNp7jtNFXSb/D0IpDwxVAHlfqTaC7okm9PoHLyDyfrAH1j5
 gOPFQ3l0i4mHT2RS0lad2rj/Oi3D8Um0jwsL5tynbZ+3ZlD38rZWTJBQiUBz6gEJTmWL3Mg/3
 cs2P3NSAGLFNbsjzZP5rPN9Q6+HAtXv3DHfqqAEZxFK0t7R0A1XYDhRsFXbrzRfpQXQB8HmTe
 6IhpQN1ie7fmj5+GqvRlrhDDiejjxbutb/BW/Dw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Sep 2020, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Update in v4
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > A segfault when running just "git maintenance" is fixed.
>
> The net change is just a single liner below, and is obviously
> correct.
>
> I propagated it through to part #2 and part #3 locally, and
> hopefully this makes part #1 ready to go.

Yay!

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c3bcdc1167..090959350e 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1027,7 +1027,8 @@ static const char builtin_maintenance_usage[] =3D =
N_("git maintenance run [<option
>
>  int cmd_maintenance(int argc, const char **argv, const char *prefix)
>  {
> -	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> +	if (argc < 2 ||
> +	    (argc =3D=3D 2 && !strcmp(argv[1], "-h")))
>  		usage(builtin_maintenance_usage);
>
>  	if (!strcmp(argv[1], "run"))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 4f6a04ddb1..53c883531e 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -10,7 +10,9 @@ test_expect_success 'help text' '
>  	test_expect_code 129 git maintenance -h 2>err &&
>  	test_i18ngrep "usage: git maintenance run" err &&
>  	test_expect_code 128 git maintenance barf 2>err &&
> -	test_i18ngrep "invalid subcommand: barf" err
> +	test_i18ngrep "invalid subcommand: barf" err &&
> +	test_expect_code 129 git maintenance 2>err &&
> +	test_i18ngrep "usage: git maintenance" err
>  '
>
>  test_expect_success 'run [--auto|--quiet]' '
>

Yep, that's how I read the range-diff, too.

Ciao,
Dscho
