Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D8CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjIYLxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjIYLxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:53:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA1DF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695642778; x=1696247578; i=johannes.schindelin@gmx.de;
 bh=UNgw/qDwyquEyGgIbxFU49dhRL5eFFWY57epZuQYP0E=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=gFNfdr2Y3268lxaRFE6EDoGFRrC4AFqjI+rKrjjD493ZuERbunwzC+ro6O3aGH9ax60RL7zo+Py
 k1wdJ+lb1xa+ZUjAxiaYGcNAG/6J9tG3zij0Jv4zJ3PPOwVatdV8jqc0JCiDW8zZpwpgfLW/yZJzH
 +hm681Oh9qtC4fkIUQ6MIiLZ7HtUSV7J37xAGW8xFkuuPpxGrYyw2hGM3uqyUtpDJvn59ET73yJql
 IwFqSFP1SjJV6q+HnGvhe4baH5rTo+nD9p9cvYwtgxPNn1DZv41CG/DL7k4YUsHJScsXcWgdX4NJ8
 4zR99L7M8a7ruSMuGr1gC55P4GR3ZkuSdMiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1qooki3sUj-00DZQ3; Mon, 25
 Sep 2023 13:52:57 +0200
Date:   Mon, 25 Sep 2023 13:52:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/6] coverity: detect and report when the token or project
 is incorrect
In-Reply-To: <20230923070735.GC1471672@coredump.intra.peff.net>
Message-ID: <f1c818a8-5b18-58f5-ec42-45eb8ad3e00b@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com> <458bc2ea91faf88a3e1d21945f12f314d1a7b78e.1695379323.git.gitgitgadget@gmail.com> <20230923070735.GC1471672@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hsdCtu2OXG0xugvfTkmkw9Gkis24dgaH38G2KaftWERkkN3jqUS
 xHCr6DFmsVsRJrNG0MQJH5dlUDo+9gx9qddRgc4hfo8Bs/gANSb+U8Sx7WR2DrLmMOa+ztI
 XbQJqq+Rbru1QUYxLpYmSZzg6lLmOW8XP1GAJ+My8g2Cqpt/sMuo08Lg76QYaCh8fX65RUm
 xtYmHT8hJgZikf31t4n1A==
UI-OutboundReport: notjunk:1;M01:P0:3TUfu1c+KKY=;gDI0/wktcpZqKfbXT+17cAMqQwS
 IOiOUdIk3J2kvZ1EzqKgAgalWl9ldizNAg1MTdVW3DpEHt/vDg0oeORy5JjXeURSEBUvOpqG6
 jRIKu2TCcVpPzOgighBVmLUBD8Sc/4PYjpdnda9+2xttzhYV/Qt5m2K5j22Mr8RXdItgM1wAE
 jK4RFRV4LIOGbHd7WMe67DBLMQO3Y4z9yubh4D5SW4vaaWpdxO19IoiDXp5ztbN1Al0oy7K5x
 RpGqLfBT++73VjYIajlWnYYDtndt7AMNOHWv4xInjvB1/OYKEJpPilgYKjKaMxxDVipnDhtcN
 VsOFVQUWUK9Ivhl0NlphcqVUpH0s9fdxjkBc886oS4xxJWb8uXUVWaHg4jnSgTl7SI1mVIZBQ
 MCeM8gA+zSYML7xneIC/060wn0pMW3txB9M3iLn4XroYGFGoTkOI1fq1WdyUjf8uFjnvy4hAT
 cQD/6sNtq3hyYGoyj2n8KFWqiKDGxZ3yU1K8k9dvdLzmVrM+NOGK5eIJJZit/3pydFdqYazbp
 8Cazs/mIq2bSY2vhxBqma6yFVcTJCyud/LQrSAVR2FwLeQ2WadMYN3E5sqt+fyscxingbmoZ5
 hUTc1ZYeFlyMCvTZ4YYS0O06wEcvM3NYlVfAx4etFEdnnlnEhroPedw4RLZhlFsByrv6HP+P4
 n5/4sC5ayY86s2In6geXfL6PzOGDYDEp1H4+IAQarXnukxUyuVaBz/XRKnNKl3RnmWatZcWh+
 l6Z4acY5POqF3cV38rSB05/wnv4jCKkNV683dyJegcVO9PoNEhQHTWEDFNbJS8R5UHOYUaF4z
 EIx1umcwy8Sk3lVJZneClyziKarUgw/2AOtp520aFxQnHxyDN34L1b0ZQ4DGwNIwH3cdOjT3a
 JxtcdyyFK/bXPiZ6/xR68+m2Xh2DrbO1KJaDl9SkHdj9MTxrV6WGbHYG93okMSicL46kwveKo
 U+wBEw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Sat, 23 Sep 2023, Jeff King wrote:

> On Fri, Sep 22, 2023 at 10:42:03AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When trying to obtain the MD5 of the Coverity Scan Tool (in order to
> > decide whether a cached version can be used or a new version has to be
> > downloaded), it is possible to get a 401 (Authorization required) due =
to
> > either an incorrect token, or even more likely due to an incorrect
> > Coverity project name.
> >
> > Let's detect that scenario and provide a helpful error message instead
> > of trying to go forward with an empty string instead of the correct MD=
5.
>
> Ah. :) I think using "curl --fail" is probably a simpler solution here.

Apart from the unintuitive error message. I myself was puzzled and
struggled quite a few times until I realized that it was not the token
that was incorrect, but the project name.

To help people with a similar mental capacity to my own, I would therefore
really want to keep this here patch.

As a compromise, I will switch to using `--fail` and then looking at the
exit code (with 22 indicating authentication issues).

Ciao,
Johannes
