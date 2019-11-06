Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFBB1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 19:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfKFTfO (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 14:35:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:48347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfKFTfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 14:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573068908;
        bh=rMVfgtx/xP+mV6c65vBv3U5JUxDBGrbTVWq4wf6dICc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HN0HabmUHAksF9TiT973eLct41kcx+J6mHHhAQ/lJpGhs7uID6Iq4em/iURFtzDV/
         VMRQTsB7TKY4HeZgZ7OXcRuzTihBElYq7iJeE3CmrG9XmYVKi19hK+NE1JFtQ7elYp
         FDT/5vay5tIy3ZmsM3+vU2WmRe/9Vm2i9V6I0el0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1iQ1Pm3b45-00XKON; Wed, 06
 Nov 2019 20:35:07 +0100
Date:   Wed, 6 Nov 2019 20:34:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
In-Reply-To: <xmqq7e4dtd9n.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911062031480.46@tvgsbejvaqbjf.bet>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com> <pull.453.v2.git.1573034695.gitgitgadget@gmail.com> <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com> <xmqq7e4dtd9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1009258605-1573068722=:46"
Content-ID: <nycvar.QRO.7.76.6.1911062034040.46@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:JrhMuHWifF+L7BhqgRj6id9pS+z7t2irCeNLZYRuhcDngUEOQ3r
 fS5Tw7skYBTSTN4F//haLYsQJACbFCMxOhHhWPBVXBJ6/0qRg+Q9K1eXqNOL8V7aRyJKJ9h
 UYcMDijUhHiGmfL54Rf29CjklBrso3J7bmx3tbVcjvtgvDXbrEB0HCjCvXktJOEVnbyoP7t
 EJ3Ug8yNbONnSfTl8urvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kWjQLEJNEjc=:QoIZJiXEN5Yl8DDDl/WLT3
 eyWQXedZ79T1e8Xy7WfeKCIyX0gYnLlFr5VxCD+zNJ2UtCILmwPh19JiztIMUZ5y1ntE2DVUg
 Vs2BkoG/4r7lPXyzyg0Kad25ouq23Py841qFdtIRl3RXoaf0djJxS4KCjh0WXxehHoqqC1QT1
 xyXeTZJkvu27G2zjMU950Uui/4vWazUAZjRPKk7Opn30UWa3sBj5Oh4PYX1qv78ZbHeNYNKoY
 wGAA2gzuqmjNVLRmZISxKyioc+O6xL0CJ8TgYgYkYm8gDKoJ7FpYwL5/vzvZp60J2rmzHde/y
 ph2NCETrcDp5y52DQEunfJ0u59uC5SvDiUTa7nCiGkZyIkmH3pdbhDUlfWS2wosLXddREbi2m
 +sGON6f49HrlcmIp1LhHn3i2W2K9+n80S/dEC4777gzB6ZOHnzvRcM/razYELJ4MuYqddKYoN
 pry+yeCpu8rxW7yi7c6AJHWTUR/t9utNhmPeXhcku+7rtEPVc/fihn5Dn5mNpSd3pu34IB9us
 TMCfyWzkDzxQtfafgt59U53J95pHbD13L4NqNN2O4FCvNcECYiQWwS2eBZZfBh2Ow711XjsBp
 g+ZN4iyhD79ezy+eqIZIChVco1clr9uI4ZBq2A3oxIXpalsj9ytJrAodAGfxtTYopA/oe9n5C
 SZ0N1nF0Ms0DVxPnE0de/RB0MiMjGuZHTiM9jdcCA5mKJheUjW6ArImHJ4QkADjM9tW401r6F
 hvACZRo5n/UnvAVZOxVwfYpxMnFFkrP9KL0qULMkceLXy1thFe1IegVByoF2n6ZpU+TXbNHqA
 v60fdFf2rooTTuuls2bnqP+k3ofn/5kYrzLd8RQBKjWOlCHyEQ7ke6fePbqfTJCSTIq6q1xxv
 srQn+Y0pKBDMiN8jIRDgYzoJt5d2SWw9VYyWEmP5NOUTPBws3h8a/fMR81xOhWxQI9DvqxhsZ
 XnhF6RqJdt3/Zh9YYImkKZ81zClu+eFA12qVXj48ARWBvPHGo+WDiMw6+l2BG/+3TTybWZNWv
 s3z/MFpv6EgjrvxkaN6EdmzfAfrhT1obm1XbTqfaUIwaVuexELeTsQTfzl5OABZo3/HTl6TW4
 zfOAB+xph9o+ug32YW2oKROWhaKB489FR4C6TYncOIZS5/NifmFop14fuaxnHrSOq2OeGGPeu
 55Nsx+rBdVd+1PEL5Er4QyYYEwpiWaD/HFlkfQbdKhqu+2nyydtQ3DqooI6NvvhlsNw6niPA2
 iAzSawB7haENiW+R/1Jp3m58Ge137h+5yfxwwCR/YvWE0S55oUoNQ2jy1RWk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1009258605-1573068722=:46
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1911062034041.46@tvgsbejvaqbjf.bet>

Hi Junio,

On Wed, 6 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 93b980e58f5 (http: use xmalloc with cURL, 2019-08-15), we started t=
o
> > ask cURL to use `xmalloc()`, and if compiled with nedmalloc, that mean=
s
> > implicitly a different allocator than the system one.
> >
> > Which means that all of cURL's allocations and releases now _need_ to
> > use that allocator.
> >
> > However, the `http_options()` function used `slist_append()` to add an=
y
> > configured extra HTTP header(s) _before_ asking cURL to use `xmalloc()=
`,
> > and `http_cleanup()` would release them _afterwards_, i.e. in the
> > presence of custom allocators, cURL would attempt to use the wrong
> > allocator to release the memory.
>
> s/allocator/de&/; perhaps, even though it is clear enough from the
> context, so it is probably OK as is.
>
> > A na=C3=AFve attempt at fixing this would move the call to
> > `curl_global_init()` _before_ the config is parsed (i.e. before that
> > call to `slist_append()`).
> >
> > However, that does work, as we _also_ parse the config setting
>
> s/does work/does not work/; presumably?

Indeed. Could I ask you to fix up locally, or do you want me to send a
new revision of the patch?

Ciao,
Dscho

>
> > `http.sslbackend` and if found, call `curl_global_sslset()` which *mus=
t*
> > be called before `curl_global_init()`, for details see:
> > https://curl.haxx.se/libcurl/c/curl_global_sslset.html
> >
> > So let's instead make the config parsing entirely independent from
> > cURL's data structures. Incidentally, this deletes two more lines than
> > it introduces, which is nice.
>
> Yeah, string_list_clear() is more concise than curl_slist_free_all(),
> and we have already been copying one list to another anyway, so we
> lucked out ;-)
>
> The patch looked good to me, too.
>

--8323328-1009258605-1573068722=:46--
