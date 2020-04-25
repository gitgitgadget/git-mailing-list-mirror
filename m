Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D8C55186
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479DE20724
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aeGRJ1yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDYKnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:43:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:32799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYKnj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 06:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587811402;
        bh=ZFoiNIeKPKqFZpCSf0vZbArcBdT5tt4iiu+06v6gOeg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aeGRJ1yFvNF1lL2rFyS7DnFVXwnT9mWPVnU6EZnCN8BevAfGiPitKZOop5iox81tx
         To47/Z3KEuRDplQTBd3fmxpbsspxKJDfrj6RBhX8cF0k19Tqyj96C62+/JXgkofAdT
         TjHrbOmTW4jzgcYZElTaBzfRhv/575frBSmU2iu0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M6Db0-1jYsvB3Lr6-006jSd; Sat, 25 Apr 2020 12:43:21 +0200
Date:   Sat, 25 Apr 2020 12:43:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <20200424152307.GA85188@Carlos-MBP>
Message-ID: <nycvar.QRO.7.76.6.2004251238590.18039@tvgsbejvaqbjf.bet>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com> <pull.615.v3.git.1587728992.gitgitgadget@gmail.com> <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com> <20200424152307.GA85188@Carlos-MBP>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-952375376-1587811402=:18039"
X-Provags-ID: V03:K1:3PcX3ultUtTQjNgD+V8DPBm1HwtkbuvaAxIIukpd8fRHmv/9+Op
 snn1A/XpjZOxVLMY8SEbZyL0xR383I3yV9VhrLuSbn1zHi21Q188Ug5lcHL/FQqUjSR9+WG
 Xt758NcM+SWD+9J9nHroBmR/Y9p6hKtq2fdb6fnixus5AG5yRJVadkTKomnV1nJAbOnVIKK
 KQQeBGEnPIvjH/bXhclNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d5U6j6fix/Q=:QUczxJ+5TLkdJalt9MEy9/
 CUJK4bP4zj9uh/KhElEMnM3WjOxuDVrhYoVch9u0FSlXRP4IainEnXvOv0XvOo6kE3Cye6y9q
 EmJirON9kXR3GOvZ0bZLly04FaKnLHXMQlGQhf2hQ0Ij/lSA9ZpDFK1+xVwhkg1c6N8HQSg/b
 0H2liZW1Q4PZBCXCjlXqSmH8rFYjuDT9ZroMi0UJiglItlkhhBXb/PInHiJYiYgLjYLTgEJiB
 NT/yYU+0mCr4p9EtfCwZ4tGxvv7ttP3MzIWyex5dtwxDo5iInfuzFuE8uN2YwIiSLLYZ4i0Ze
 UOYuTodH8LfhuqaEOjohEt+kjdG17oZj5XunyOMF4nEm7XlXc2EZ9VMwQDTFzL2iUqFk1joY9
 Gl8bddexGn32ukIWaGZDmGGADdkPaaJDR7errM/miXUZGnV7Zh6MMpta3uhENsOoN0B0+xNqT
 6XpGm9lvCxUukAnYZl9r6kxd6XEHFx31AaNhtkdHdDbfEHaY9ZmWdLr38vYma6xyP/8WbkDqg
 ez8sLLmWb0gtG/N+NdMRqPX2IJtxRevTPlr8Swsk5AOBGLQ66cTDsuv+32EGQTJ/L3gNfjhMn
 a3n5awg0my8TlL21Pmdq9LhZXhMRJDhHhI7mCv/lq4Tcq+9UlhZeySLTmGWENUPXWYTpxdyVr
 SOrmlMdlg7DaH/gnPwFTL0CPBWT1XNk/nt5C292qmPj8TqDyt6ls4vPNYTn+HemMQPz4ziXw0
 cFKVKpdrzL0PaWFPP/+ir+xeGfO8PHqy4QC/KFaFpiqNNwUMzVjELHyUZ2D75p/LrTUA2RHLM
 mOb8vu6e5uMP1D7iz7WSqSfMyF+kkPRfKoA/Agt+/9jZXl4071UaLJnlsPhz0++jqiadrpTor
 Lbh/ouk75k6RmkSaprH7K45GgliIoSHokSf2JQwqLZTnH0J1NimnJ8eaA3LyCe8bM1npz6TvJ
 7bBazrMZ2Q9n0366cHc0THBIrGFbxVUKvp1SowIZTNgOrGch4Kople62ZgUJOI5CIBeNxVw9s
 BAExkdYeRNLOC0gcNOQNrQuidg5GgKZ//aOSyNDS+QzOXbbeZch5av4RH/1Gl+Ro9FMX9ng4I
 uTE9cmBsGRYzn3J6Yi1r8pnYfGf//x3UsNxkPaFib8c+g5hiyelfMoLBseR38Jgx03H48UuG1
 RmZ+6P5yunKu4XDZ61U+dHDmdfiGb3qtPAxugINnu48lSWmTSkn8fi+vHZkZBFVtC6AH7UFB4
 ML9V7epkBa9CrKpI7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-952375376-1587811402=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Fri, 24 Apr 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Fri, Apr 24, 2020 at 11:49:52AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/credential.c b/credential.c
> > index 7dbbf26f174..c1a9ca4e485 100644
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -35,6 +35,10 @@ int credential_match(const struct credential *want,
> >  #undef CHECK
> >  }
> >
> > +
> > +static int credential_from_potentially_partial_url(struct credential =
*c,
> > +						   const char *url);
> > +
> >  static int credential_config_callback(const char *var, const char *va=
lue,
> >  				      void *data)
> >  {
>
> something like credential_from_url_partial might had been more grep frie=
ndly
> but this would work as well.

It might be more grep'able, but it sounds really awkward to me, that's why
I did not use that name (it was my first candidate).

> > diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> > index efed3ea2955..f796bbfd48b 100755
> > --- a/t/t0300-credentials.sh
> > +++ b/t/t0300-credentials.sh
> > @@ -448,4 +448,43 @@ test_expect_success 'credential system refuses to=
 work with missing protocol' '
> >  	test_i18ncmp expect stderr
> >  '
> >
> > +test_expect_success 'credential config with partial URLs' '
> > +	echo "echo password=3Dyep" | write_script git-credential-yep &&
> > +	test_write_lines url=3Dhttps://user@example.com/repo.git >stdin &&
> > +	for partial in \
> > +		example.com \
> > +		user@example.com \
>
> even if it works, configurations with a username might not be worth the
> trouble to support IMHO
>
> maybe better not to include them in the tests then either?

Let me counter this:

- It would take extra code _to prevent_ the username from being used, and

- There is precedent where the user name _does_ matter: it is relatively
  normal to access different orgs' repositories at
  https://dev.azure.com/<org>/<repo>/_git via different accounts.

Together, those points convince me that special-casing the username _and
explicitly ignoring it_ would not make sense.

> other than that, like the previous version (which is functionally equiva=
lent)
> should be IMHO good to go.

Thank you for reviewing it!

Ciao,
Dscho

--8323328-952375376-1587811402=:18039--
