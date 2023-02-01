Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C01C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjBAMZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBAMZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:25:24 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 04:25:21 PST
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [IPv6:2001:41d0:203:375::c6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6979C470A2
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:25:21 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1675253841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pp+hmvjLkblGrXcocOF5E5+cwFfeuL0c2uDK+eVvlRE=;
        b=azT1ehjpbrB9yiRqEtuTEzXFskoNS3PJ+YKx08egvvfXnqJDV3Y0tWO9OQcTlJmGjkRh8G
        OBSry9zTU4hj/FfNR5L/WJ7Zp6uJSWaeh8hALBMoroVeMpJdrkT2SCnj8agJH2YqnkdVoa
        +Q6CCJ9/YnR+wkGBCOspI90i4iyADPI=
Date:   Wed, 01 Feb 2023 12:17:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
Message-ID: <8452eb684b212b1e364bdc4709d4b202@ameretat.dev>
Subject: Re: Stability of git-archive, breaking (?) the Github universe,
 and a possible solution
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=" <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        "Eli Schwartz" <eschwartz93@gmail.com>,
        "Git List" <git@vger.kernel.org>
In-Reply-To: <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
References: <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

February 1, 2023 4:40 AM, "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avara=
b@gmail.com> wrote:=0A> As people have come to rely on the exact "deflate=
"=0A> implementation "git archive" promises to invoke the system's=0A> "g=
zip" binary by default, under the assumption that its output=0A> is stabl=
e. If that's no longer the case you'll need to complain=0A> to whoever ma=
intains your local "gzip".=0A=0ASurely if reproducibility of .tar.gz file=
s is the goal,"invoke=0Awhatever arbitrary binary on $PATH happens to be =
called gzip" is an=0Apoor solution.=0A=0AIt is only even possible to cons=
ider stabilizing gzip output as a=0Agoal for Git (although this seems ill=
-advised for the reasons=0ABrian already discussed) in the post-2.38 worl=
d where git is=0Adoing the gzipping.=0A=0AIf one has the requirement to s=
ubstitute one's own specific=0Acompressor, there is an option for that.
