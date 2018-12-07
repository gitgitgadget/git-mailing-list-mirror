Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347F520A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 18:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLGSTq (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 13:19:46 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:46877 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeLGSTq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 13:19:46 -0500
Received: by mail-qk1-f182.google.com with SMTP id q1so2930518qkf.13
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 10:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=JwaCNHBX3r50Nia66+h9NzK0K7qI13YZ8UVePLqonAI=;
        b=Bz81N8D/FpDNQ7C+rIlJbE/Y4BbHJYyrdJZnPdCcnMST8I/tJzO5LeG/tGSP9h66+u
         TO6aZ3sB5llOiNqqgfwg3datoEayw/PjcYTGJ3uHMzmyetF3xenuWdbLn9kmSgf+c5et
         hUbbF+L6GqJkt1AgVYU0kFXU/CSVNstwphbCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=JwaCNHBX3r50Nia66+h9NzK0K7qI13YZ8UVePLqonAI=;
        b=ICyIg+O/djK5kJrHoRxZlph1SctLw3wMOT5xAO2EYL6cDYAOazvR0jBpsNBd04tXrk
         qh/3NqTCqWyt3n6ZG/cDsdHRkB1ftv03Wr+8G8lGeUqIc57J/KA2k1zWf70ahjy903e0
         8M/FGRfJwqrWuylAuIxK8gCJj/p2ohwHlY/Htv5YafMmLqJ1CdJUHVgTRQ3ourJVEJ74
         cAwJl3+rAt7x3lpWpsz5o8rJELHmEG+TwPNxqbyL+1oZLroXP/HvD+ibTiy0bCiWCXtW
         7+7+PWdYvl5GJ0kXduBbSZd9ghyTp6NMXPUmDxyvB2ryT/rVvFLljyaaHBRbvptwzuyg
         vIJg==
X-Gm-Message-State: AA+aEWaD7jMyWCk5xwlfrfP9J6NYK+Iy53cHnc+IZVDBRmk2mes+mLGf
        QL8Muw7lzyYUog/vd8cirk3ZvRb3t7kdbLZG
X-Google-Smtp-Source: AFSGD/UWePDDg/QvTOXoRHckC8LJqnwGE8zpJk/BXW71gXDuNJEghsBoNTwUohXaZ2qmlJvIO0iDyg==
X-Received: by 2002:ae9:c10c:: with SMTP id z12mr2784907qki.22.1544206784818;
        Fri, 07 Dec 2018 10:19:44 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id v186sm2244229qkd.13.2018.12.07.10.19.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 10:19:44 -0800 (PST)
Date:   Fri, 7 Dec 2018 13:19:42 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: RFE: git-patch-id should handle patches without leading "diff" 
Message-ID: <20181207181942.GA6411@pure.paranoia.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, all:

Every now and again I come across a patch sent to LKML without a leading
"diff a/foo b/foo" -- usually produced by quilt. E.g.:

https://lore.kernel.org/lkml/20181125185004.151077005@linutronix.de/

I am guessing quilt does not bother including the leading "diff a/foo
b/foo" because it's redundant with the next two lines, however this
remains a valid patch recognized by git-am.

If you pipe that patch via git-patch-id, it produces nothing, but if I
put in the leading "diff", like so:

diff a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c

then it properly returns "fb3ae17451bc619e3d7f0dd647dfba2b9ce8992e".

Can we please teach git-patch-id to work without the leading diff a/foo
b/foo, same as git-am?

Best,
-K

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXAq5vAAKCRC2xBzjVmSZ
bB0AAQCiD1cpRvs3On2EMW3pXFj0Hxza26+x1mxySfUw7i/zvAEA1Khw+GZ8ATvU
QMWxgLdM9U/fVuJr18yfw1HMkrsODQg=
=QZqC
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
