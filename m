Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5AEC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2F320721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 07:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkZUQoXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgEEHtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbgEEHtX (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 03:49:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE56C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 00:49:22 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id w4so985091ioc.6
        for <git@vger.kernel.org>; Tue, 05 May 2020 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yelpddsaqMHXZFlO5eDu+Wu6NjxvXE6u+JWS85a1jBs=;
        b=IkZUQoXoL57UXOf3KhA9yNnYksk6SJwAJN4TuPOfhqlNm834yCeew1uUhQa2l6h6sd
         6KmpesWNXrBA5kzpTJrcOWitJ/R4EQN9m/E3td3AyneHldLvVuzpPbOQHKUfKSZXBHtU
         49V+6CQd6gg/c/fYLLV4PqBo0UKn2pVEZH9T/3JqHppolOTWDSR1xy63K/sl7N86i0/R
         WcuuENN6GkRhbeJ4aVTybaMl1QdB+eCFUy5TBwm8B7oZWTCqjC3uDSlxQB6Eo6n6sGX2
         AkmF46L+uHs70dBIbCv+OL0JAayKjCLB+6WSHUsCIXU5DibG0kq3C4D2S36OSbgEvkjT
         ZIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yelpddsaqMHXZFlO5eDu+Wu6NjxvXE6u+JWS85a1jBs=;
        b=ni2WjguZwGUWPLPfeYmQAr5/U1yVsZE7pSA8C6RTFGxlfvnOrG6Dqik79SWjxS2wb6
         /dMpn9Os5yBmTD2DS02gM//GeEjzHxJ4usq66nCvwMIq7xt4vmGjZKklRwc6P7oKeU+e
         XlSGbnvGf1bQX1VT6U+jxuz6oiWIErxiau83Zy47QGcWSiaVzEhB8CEVAU1j2k4NOjOP
         0ZkIOkoDLywM+jCywHuwEP62Y9z97tnAeIq2L4PVVmCqK0drbKz4py/1mbJutTNlWHL3
         NFgjfFOD+fo2t3LovZYwFxS70BFDgzwQLie0jhjq93uYLEO8cKnvq497jzXoKnm2jdnM
         tliw==
X-Gm-Message-State: AGi0PuYRjpdonuTnfjLtF1Naz4NcTwTGY1bitaLsyYtXWmxz03WY5/RP
        gJHYxPgdofX3MP6gX1FZxiv5WCjs4MY9I4Rh2TcJDSw=
X-Google-Smtp-Source: APiQypKiaYDVYKSTOTi2y9uq6rsKLLKMB10RS5mXvNoOCiQvyejuMH2w+rCKQYHMxSQdoXU7sAUTrmHU1beneX6QpPc=
X-Received: by 2002:a5e:8e44:: with SMTP id r4mr2114756ioo.47.1588664962052;
 Tue, 05 May 2020 00:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha> <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
 <874ksvei1r.fsf@osv.gnss.ru> <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
 <871rnz4eln.fsf@igel.home>
In-Reply-To: <871rnz4eln.fsf@igel.home>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Tue, 5 May 2020 09:49:11 +0200
Message-ID: <CAEoQP9jkP6KinqOM41zbJhV7+MbA742Xgit2ztK1OcJ78+YbdQ@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, but those are not what I ask about here. I guess the Idea
must did it for me.
That is not the problem now, I worry only about those "modified" files.

Pozdrawiam
Ewa


On Mon, 4 May 2020 at 22:41, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Mai 04 2020, Ewa =C5=9Aliwi=C5=84ska wrote:
>
> > Changes to be committed:
> >
> >   (use "git reset HEAD <file>..." to unstage)
> >
> >
> > new file:   .idea/.gitignore
> >
> > new file:   .idea/compiler.xml
> >
> > new file:   .idea/encodings.xml
> >
> > new file:   .idea/jarRepositories.xml
> >
> > new file:   .idea/libraries/Maven__commons_codec_commons_codec_1_11.xml
> >
> > new file:   .idea/libraries/Maven__commons_io_commons_io_2_6.xml
> >
> > new file:   .idea/libraries/Maven__commons_logging_commons_logging_1_2.=
xml
> >
> > new file:   .idea/libraries/Maven__commons_net_commons_net_3_6.xml
> >
> > new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_2_=
39_1.xml
> >
> > new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_co=
re_js_2_39_0.xml
> >
> > new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_cs=
sparser_1_5_0.xml
> >
> > new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_neko_htmlun=
it_2_39_0.xml
> >
> > new file:   .idea/libraries/Maven__org_apache_commons_commons_lang3_3_1=
0.xml
> >
> > new file:   .idea/libraries/Maven__org_apache_commons_commons_text_1_8.=
xml
> >
> > new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpclient=
_4_5_12.xml
> >
> > new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpcore_4=
_4_13.xml
> >
> > new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpmime_4=
_5_12.xml
> >
> > new file:   .idea/libraries/Maven__org_brotli_dec_0_1_2.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_client_9_4_2=
7_v20200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_http_9_4_27_=
v20200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_io_9_4_27_v2=
0200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_util_9_4_27_=
v20200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_xml_9_4_27_v=
20200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocke=
t_api_9_4_27_v20200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocke=
t_client_9_4_27_v20200227.xml
> >
> > new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocke=
t_common_9_4_27_v20200227.xml
> >
> > new file:   .idea/libraries/Maven__xalan_serializer_2_7_2.xml
> >
> > new file:   .idea/libraries/Maven__xalan_xalan_2_7_2.xml
> >
> > new file:   .idea/libraries/Maven__xerces_xercesImpl_2_12_0.xml
> >
> > new file:   .idea/libraries/Maven__xml_apis_xml_apis_1_4_01.xml
> >
> > new file:   .idea/misc.xml
> >
> > new file:   .idea/modules.xml
> >
> > new file:   .idea/sonarlint/issuestore/2/2/22a598feccb13c958ecc8eff5c53=
a9a7f9470a72
> >
> > new file:   .idea/sonarlint/issuestore/4/4/442292b8a7efeabbe4cc176709b8=
33b1792140ec
> >
> > new file:   .idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee55=
7628145ed943
> >
> > new file:   .idea/sonarlint/issuestore/f/b/fb31951790c271e26d568f9ac5b7=
681e7f0804ec
> >
> > new file:   .idea/sonarlint/issuestore/index.pb
> >
> > new file:   .idea/vcs.xml
>
> That means you have explicitly staged all these files with git add.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
