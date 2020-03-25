Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD725C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF4020772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 16:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bHWW0Sxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYQfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:35:45 -0400
Received: from mout.web.de ([212.227.15.3]:53337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgCYQfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 12:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585154141;
        bh=nhrDeD4i+J3ieKZ5sqX3w7RBs0PXqW0HNeKg9MaeXZs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bHWW0Sxw2+oQT8D8q0D2yg1hTCq6eZubIn7LNHchK+3F5HMXFEFJBTBPx1c/yz4pX
         c35YYl69H/hkhw27Gy+K+GG3PhtlZSGYYWSpK2LX60KKnCLkX+Rhb6vIA3Ip12iVGH
         InDsptEmzTQDROE5bqxyEOA1zckxWlte+wD1unq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiUVY-1jp6J63hOe-00cdjo; Wed, 25
 Mar 2020 17:35:40 +0100
Date:   Wed, 25 Mar 2020 17:35:40 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Andr=E1s?= Kucsma via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Andr=E1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH v2] Fix dir sep handling of GIT_ASKPASS on Windows
Message-ID: <20200325163540.vdc7l72fke7yqryb@tb-raspi4>
References: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
 <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Ru3EJuMyYKZacMUvQM0+rXYnch4+VxJiMTjovQ6zdpJf1Q32k9J
 ytYsORa+5JPn6fPWcBpw8f/JMI2nocGMy7619viHzzxTjVpI6Bkpm5XwzF5gIctH6VZ019k
 2WKVhpK7PVjs8RaTZf7YkvQ6SbtWFQPMe4D/Qws5ZLSFiyyKopeh3I/Lqo7VHneU+ZfMn+V
 qx2rKL+JmygtJYQVITXVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzOI8W4DM30=:Yskfr8mncgIoox0nR0EabC
 o6FxRbmPIOjGWRnwaruj8xihGj3N3Tvm7X8s2QRrJHc63BHOxKClAG4mxf+bJPpITABCua3Hu
 KfswrxX+2pFD+Gz1dhPoPgHYVHfbBDNyaa8hZoNTTD99l12wMaQ9AGambd2C0kURjloWdGuwd
 C0urrhmS+LMipy/dqK1sjGN1pmyxA4a1IxCaCMNsN9QyBl6MMeA4KnYuUXhTG/qIv0mUKM3SE
 toqTAVDc5Km7ywT1wwK8kpjI4XVs3VKdhOEcQqHBKOxfWoDspgAnk7l8Ov+2luuv9nRqazW+A
 hXNu40JwGIrNP1tyJhllx49GGypJHt8iv36CW7Ivm70lVfelgoW2AVHIbbd+Dp/lW/CdHCmgx
 HU0P7l8HUu7YmP8CEiz+iPe39DixPsXcD926o4FQEIL64Xlz6/8PMxSDMnmugJCWCPoqcFvyF
 004mF7ZgOgskrYjgMAUljVuLIJF+cUcrEDUHPm4Qm65eyBHYytjEET8DWcOHVn4aZHENqbNwm
 89Mxotojtdbs6mbvxxF9zGuFna0BSEs6+0NoDeZkRzs3wm6amsRy6FHxF+wp925znhNCHIhlq
 B8al0cBNd68Tx8xKdvvKdLHzkPG75YdeTihXyL9KO3jbfUZCWyJuYXq4UfGx+EyxD7PtG8Qo7
 +aUgaxrnQf3ev/WDRVjX1M22ZN0t7mic9doJPyOVOeZ6ba0qPyGrk3Y1kZSHPaNebb1uEW9Ku
 1Wfc0z0tzdlZXvKbz05iDZG+PSrDc2+qN+jFgJ2w7qnOzlk1w7uMBl/qfhAtgfIiZIkUnaZHn
 8qHTGr32ejt0wfns/57YlnXM32KyJWiEN8m6KgdSwXHgvxZGbcGi6VDIFTa7DJtWRXSjx8+FE
 qOXtOhT8S7qxzn1b0TWRedJowMMZ1/9oA14Dtiip8T8nydNeWSODW7Asq7pcwEl5mbICnU0C3
 Qknk+tZ1ZhVC3pbIHNgSYY+87dmwFxl/qGAt/Tt7aSZSAWWKpb0SMT4brzV2vuAdJ51ZeekEs
 1ErDTDcqvMX9FLK85w1Vwt4Iv1IMZEdVlN0suqhA+6ArweFuoXoTToQTGsdTmLE/yUObQAlkR
 yqjxWFizGqIiCtaerqNrz9riq1EbKcuDkRo1gM/dm/+YgjzjN4HFp/9GMO1GZlqsbIyr9u1Vd
 2Grr30JWqYBOeN7rG4DW/ZVynKNltUfVwS6zl/3iAvDKy7B4ybGCZlbsOI21Yz7q7KLlgjNFY
 uyiZ3WrJTFwk6gvPe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for working on this. I have 1 or 2 nits/questions, please see below=
.

On Wed, Mar 25, 2020 at 01:45:10PM +0000, Andr=E1s Kucsma via GitGitGadget=
 wrote:
> From: Andras Kucsma <r0maikx02b@gmail.com>
>
> On Windows with git installed through cygwin, GIT_ASKPASS failed to run

My understanding is, that git under cygwin needs this patch (so to say),
but isn't it so, that even Git for Windows has the same issue ?
The headline of the patch and the indicate so.
How about the following ?

On Windows GIT_ASKPASS failed to run for relative and absolute paths
containing only backslashes as directory separators.
The reason was that Git assumed that if there are no forward slashes in
the executable path, it has to search for the executable on the PATH.

The fix is to look for OS specific directory separators, not just
forward slashes, so introduce a helper function has_dir_sep() and use it
in run-command.

