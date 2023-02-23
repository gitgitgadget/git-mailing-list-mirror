Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B7C64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 18:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBWSB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjBWSB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 13:01:58 -0500
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FF52DDF
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:01:56 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1677175315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UC3+e2h2dGcficbIyKS29qYPbACeXKEtD3JnCn8kSA=;
        b=TIokFOJa+1oSAfQMhOfQOU5gVlbT13HlkDLlb8XsEUXPQlx74uH3ViUipTQQTS7Fh5mU+Z
        +DCeIrHebumD7Ci31QgKnBbQ0WaAhqqlNwpp8wDVTCaPX5htFbhsIKYLZF8viJHPhOUEl2
        ADkMxIJ2kjsknPsn190ReVNGT6NmP+c=
Date:   Thu, 23 Feb 2023 18:01:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <52a5d6ae0b5d668b1c5e9c05a51701b1@rjp.ie>
Subject: Re: [PATCH] update-ref: add forward command to safely
 fast-forward refs
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, ps@pks.im
In-Reply-To: <xmqqpma09udd.fsf@gitster.g>
References: <xmqqpma09udd.fsf@gitster.g>
 <20230223011530.47477-1-ronan@rjp.ie>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Unless I am missing something, this=0A> does not seem to be adding anyt=
hing we cannot already do.=0A=0ACorrect. In my case it replaces:=0A=0AMER=
GE_BASE=3D$(git merge-base refs/remotes/origin/master refs/prefetch/remot=
es/origin/master)=0Aupdate refs/remotes/origin/master refs/prefetch/remot=
es/origin/master $MERGE_BASE=0A=0AI just thought the "forward" form was a=
 little more convenient since it could output it all in one for-each-ref =
invocation. I mean, I could always open .git/refs/* in vim but that doesn=
't mean I want to...=0A=0AOriginally I left it as a three argument comman=
d but figured it might as well be possible to update to the descendent of=
 any given ref, so I separated <ancestor> from <refname>.=0A =0A> I wonde=
r if=0A> =0A> git fetch . "+refs/prefetch/remotes/origin/*:refs/remotes/o=
rigin/*"=0A> =0A> (with or without the '+' prefix, depending) what you ar=
e really=0A> going after, though.=0A=0AOh, that's perfect! I didn't consi=
der that it was possible to "fetch" from the local repo. I think the refs=
pec 'refs/prefetch/remotes/origin/*:refs/remotes/origin/*' does what I wa=
nt =E2=80=94 fast-forwarding my remote tracking branches to their latest =
prefetches.=0A=0AIn that case, if you don't feel the forward feature is u=
seful feel free to drop it.=0A=0AThanks,=0ARonan
