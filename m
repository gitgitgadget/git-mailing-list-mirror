Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C9ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiHaUiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiHaUiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:38:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6BE39A2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661978320;
        bh=/5osQVKoa8TcMIkXmFExUU7gI9cTHx/boDvu/4jk5i0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CDL9P+Jsu4gm91XjbDdOAKeF8IUOdaIa4Mtht1muVWT6CulibnltELRHIpw2sDCRk
         +ovBJ1nycZH5IIlSZqUDq2aIc1gjw6NomGt9DyNKYFhSDdIohy9OWBTmWHV3J5ceRu
         98ZIsBwyEVKEN/VlVMtOYCKZ/SZS3Ci/qL/G5D5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1owLCx2qyl-00WpcJ; Wed, 31
 Aug 2022 22:38:40 +0200
Date:   Wed, 31 Aug 2022 22:38:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 5/5] add -p: ignore dirty submodules
In-Reply-To: <xmqqr10wdv4b.fsf@gitster.g>
Message-ID: <q77sq7pn-n473-p12s-po5o-6970rr884528@tzk.qr>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>        <cfa6914aee0d3ef84d726b97699f438fd4b254d9.1661785916.git.gitgitgadget@gmail.com>        <c205f8e2-62f9-d4b2-0ccf-51dcabc12224@gmail.com>
        <op19530n-27qo-r35s-r1q7-18s3259ps78o@tzk.qr> <xmqqr10wdv4b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BZX4IOpEOwnsPGw7i4NIlOlhKDnvlNTFwrsvWn2GJaVZrj7tWBG
 FHvKvKREseaUfCe+QswYmHbDs29QlphM6e4rVUK4dg3JtPI7iMVUd0byT7hn736acLZ3tGw
 n8g3I9IIwT9SkC6J1t6dL8vM01MrSpqczmJtCyPa0ojNbmS1U94iq7q7W6DKMaKlqrX/cUA
 Jd7JrgYAlhlh7xXLVQKgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:plvWVHK96tA=:E3/yeGNGNj0oi6gYQwyQBZ
 bOdVRqsOmbzIUzCYaT+qoEvjjGgJ+f8FCpCS9saBK/BpmV7SMlyHZJDT9YOThyFSW23jRZDIz
 bFeQalljrCr66ig49EWUeTUCINDGbpl0pW2d8dFBnlrRaobXmph4ax7NrkLTnTnT/jJCjwt0m
 jF8tQBcQQFwZ4wI+2Xze33XF0aE7Zmhp1ADJ2aCxZqEKZkIBKh7wFc6Ohll2N46IlOJlsGflD
 Kop0aggYSbOtn0Jf6XRqvkp+m1DN98/W/ecMU9IicijA0hPnWx2WjuD0xzWYQ1bb8ASLnNpxC
 8le8fvHP3LK84XxsHX0pb6Bvn7eKlJoSjVXadAyslFcm3eT2hMffLjOX1MKALcnc3xT33NdwS
 C9/zmKqsNzAEjH+JRFlHqLOdueMETka4DVbAKdl3tLn4xuuTPHClj8iu0EoSUC1meiB45rwfm
 GWKf7CRfB5ZzyXv1rSqlZBglVb5CKPdyvrqefxQf7Bh1gI9WHyBFqsuwn/dNSeQnAvM7eff8Z
 T3z6zDqBiDvrfjsxVOLPaDNAdonjZdReWzAjWCJWInvlyaRyVLkE0wXlKniV7HU42Mj8qAuWT
 kC34inTRDxJx3vJoVJcu6/m/yA6N88mNhCaNkujDBkO2FJYHPQ/LqgTptuPRUKvVs4RGUTjkJ
 P1b0+gFRDv8cgmDZ9EfIM0pz0t4qYfaWh6Km4/7ixR+gNXsdBm2uKrDG2WcWo9XaahPi5UGWG
 xKiFH7fTulALH9U8JdfkqP7Pcs3fx8HVPtHz6LXrhi0/hnR8nU4hM4UvX2+Jk3RxloHQAw5/G
 Qy/YXgdZrMNZy0T0MwFEGW9gvgF31Jxfm5NiwwxUHfT261TBjepVnzJgQAHWiCJs4vHXxByFc
 Ag5SoRwbeMAfg0DxqRKXs7NxhKgj91i3zFI5g8VDhBQLhcPGaKkGWkfXsGUMzbPEENONf47WR
 QneDUaO3F65xHvMJB17KKgEFsV/qHbv2N1q/bbZiPiUCEVmKT+7Q9MiG2DkG5MsLiK5Q3sYz8
 V70OJ725ALuPLOjmiAAvfdWOZz7mS+daY6lPqmMK7wHLGj6OJQSqdgYQ0yM8gnVeNuzR0qDbE
 sKy5/rPDhdSWV1rPTqQUXNEz+pkmi4ydFL0Rr8WK5hFgTejVaKWhfCxwQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > And it is that doubling of work that I tried to avoid when implementin=
g
> > the built-in version. The bug came about because the full diff call wa=
sn't
> > using the `--ignore-submodules=3Ddirty` option, and that's what I miss=
ed.
> >
> > This is maybe more interesting a story for the cover letter, to be abl=
e to
> > understand how this bug was introduced, and maybe to offer an opportun=
ity
> > for others (in addition to myself) to learn from my mistake.
>
> Yup, the moral of the story is premature optimization bites because
> we are not always careful ;-)

Yes. Maybe even more generally: trying to do too many things at once is
prone to introduce bugs.

> Anyhow, I am getting an impression that the behaviour of the next
> iteration would be much closer to the original, which is excellent.

Yep!

> We have seen too many "ah, this is broken and here is a fix that is
> appropriate in the context of how the new C version does it", not
> "ok, let's make the whole thing behave more like what we used to
> have".

Unfortunately so.

It is a fine line, and not always possible to tread safely, between trying
to stay close to the original and trying to learn the lesson from Elijah
that converting scripts to C without playing to C's strengths causes a lot
of hiccups later on. There are probably better alternatives for
prototyping Git functionality than using either an untyped language that
cannot hold complex data structures in memory or a language to which
everything looks like a map ;-)

Ciao,
Dscho
