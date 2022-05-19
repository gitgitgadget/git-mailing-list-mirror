Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A3CC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243661AbiESSKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiESSKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:10:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A603CFE3F
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652983784;
        bh=yYVNOBfZW2eaQR3syzsX4Ti4MdhlPnUbJ9fHlcIUTeE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wady99tHN0L4UzkMCgvJGdYkTWb7VrD0XPDWBqyDYq6eSf/VCHsCu0I4lmXam6pQM
         d6OiTExUp8ikPhrcBEAhc3zY41RIr6X9LiDoVRDlAZgA0XEuBWD5k/FBfJspKGTDkL
         2dgkZkEHW0QE8xsREEjDskRIhuqOawlwjp6FaHSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.215.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1o3LRO2X7G-00EwTA; Thu, 19
 May 2022 20:09:44 +0200
Date:   Thu, 19 May 2022 20:09:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 2/7] archive --add-file-with-contents: allow paths
 containing colons
In-Reply-To: <xmqqmtfp6ohc.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205192004490.352@tvgsbejvaqbjf.bet>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com> <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com> <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com> <xmqqmtfp6ohc.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XR2sYbUrNdvmxQmsA28kmwqjwYDUe1+5pMC/WaWlMwR/u0t2tZS
 x7WWjp4wwR5OJUMlx8Y/xpRaGw+QpgNlCuw7VhM4euoJb9aa1SdVFbLRJ/cA6DO6V1VVpww
 r8e6c1qPYzVNs6hqQi753sx5/nkK+4oCcFhrUSZhvErXyZEOvroDIf/8ncX7lY5k3i5vFtm
 /CfFDNukwU5/zP6lCN2rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQ8mthukVEk=:Yqn//TRVOwCfyzUE2KJefx
 WJpQg0Kz6wq0/8lif+dyj+IFwH9RxBieAnlLVlo07iW/rL9NtYkYHznxQeZp9GGcaevNieHK4
 kZaAZqYZJB2izti43HMco9skFOGknmX6O2OJLy/P9w7ewLMCVdH5bEfswFJTlgpcPzogJ3che
 dwGbylQwZnZRZ8s+ohD7cNa3j4stz7lJAmblJ7N9LcKBVJP37MOrJKKUMTxnGP4w6UPv0azaY
 efPf1kBqSUR2Fmx/zCGMvG0EwVfQELrxIhrpBCml/ipmMMA2nigjR1yHAv8miQpByQdp9OCDP
 7/VXouwqu+jN2gotteCrUs9RsV10ha9ICbXyUq3nfl7Jl1ylAqg9NplC+OiIzCygUjNsZV29K
 nKo9og6Hl+yu1CM5/Z97z1+md2LJVjFHnJ+aa3376BTIqPsVazhKanggbI08Qrz9+o4k9zrqQ
 DIB3CKdWKq6E8Z4r2TTnRlcLYh0suMkRFtIeBIJasuxc1g8s3el5XmcyvEPyrMt1SLUeNeuFA
 ZRYVMmiPaGB3Yi9RKXEikU91iIQtOxaPx4t2UC4zXoUM+hzHC5cTRSbG1QaHqnP086PTqBYfa
 7uaqt1i9zTPrMdYz6nPTWkoV9aq0WwFRyqeELKRFjsfymbMPuS17LSgp+k6pWMYUmSKaYOVGc
 4GWJQ3gGJWwrQjoyKY7CckO9gK6mf8zhEvQ7po4b/frieUoqGa8RSew0U5McqSvs0gCy2yofd
 jQpFn4OnvkHfwoE8Ur7mqI4DYsqbwZ4kDPyQAjHYb3j9KvmLMJ4ssVrr/aybEZ3ZATd8/5+MP
 SlaezXZaoBi0CmSLhagPdhJvfuc+8RtjE9xlCnzeEhA41Wio0+kyEJx9TUtsf4aPATuNN69DI
 XsSGAXiTpiz6b2KG98+XMX9yFe9qNmCZ0JmtXPmgv5PN6hOlIr+afN0TcuogsKr+rY6DbSxmR
 B4Rm0iM5L+MClONkcFW3Rde2nf3e14xMGHJnj9+GEOEZXvqgdpEF0GtWB5aH2cBVUtZZrohqF
 ZqM5RNFd1mi8vGhvz/v5tEaftATlL32OU6VwgOnZK4HOSgqDZKGTqDqUkOWuEwqiZ0IKZLA5i
 wCU5bbn7ofEEBndxmJgdJ//8pFxQi8fywnBwT9NF4yGERpy4WODybZbEA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 10 May 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > By allowing the path to be enclosed in double-quotes, we can avoid
> > the limitation that paths cannot contain colons.
> > ...
> > +		struct strbuf buf =3D STRBUF_INIT;
> > +		const char *p =3D arg;
> > +
> > +		if (*p !=3D '"')
> > +			p =3D strchr(p, ':');
> > +		else if (unquote_c_style(&buf, p, &p) < 0)
> > +			die(_("unclosed quote: '%s'"), arg);
>
> Even though I do not think people necessarily would want to use
> colons in their pathnames (it has problems interoperating with other
> systems), lifting the limitation is a good thing to do.  I totally
> forgot that we designed unquote_c_style() to self terminate and
> return the end pointer to the caller so the caller does not have to
> worry, which is very nice.
>
> Even if this step weren't here in the series, I would have thought
> the mode bits issue was more serious than "no colons in path"
> limitation, but given that we address this unusual corner case
> limitation, I would think we should address the hardcoded mode bits
> at the same time.
>
> > diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> > index 8ff1257f1a0..5b8bbfc2692 100755
> > --- a/t/t5003-archive-zip.sh
> > +++ b/t/t5003-archive-zip.sh
> > @@ -207,13 +207,21 @@ check_zip with_untracked
> >  check_added with_untracked untracked untracked
> >
> >  test_expect_success UNZIP 'git archive --format=3Dzip --add-file-with=
-content' '
> > +	if test_have_prereq FUNNYNAMES
> > +	then
> > +		QUOTED=3Dquoted:colon
> > +	else
> > +		QUOTED=3Dquoted
> > +	fi &&
>
> ;-)
>
> >  	git archive --format=3Dzip >with_file_with_content.zip \
> > +		--add-file-with-content=3D\"$QUOTED\": \
> >  		--add-file-with-content=3Dhello:world $EMPTY_TREE &&
> >  	test_when_finished "rm -rf tmp-unpack" &&
> >  	mkdir tmp-unpack && (
> >  		cd tmp-unpack &&
> >  		"$GIT_UNZIP" ../with_file_with_content.zip &&
> >  		test_path_is_file hello &&
> > +		test_path_is_file $QUOTED &&
>
> Looks OK, even though it probably is a good idea to have dq around
> $QUOTED, so that future developers can easily insert SP into its
> value to use a bit more common but still a bit more problematic
> pathnames in the test.

I actually decided against this because reading

	"$QUOTED"

would mislead future me to think that the double quotes that enclose
$QUOTED are the quotes that the variable's name talks about. But the
quotes are actually the escaped ones that are passed to `git archive`
above.

So, to help future Dscho should they read this code six months from now or
even later, I wanted to specifically only add quotes to the `git archive`
call to make the intention abundantly clear.

Ciao,
Dscho
