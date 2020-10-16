Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE0C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A1F20874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z2JDF2fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411165AbgJPTyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:54:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52214 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408005AbgJPTyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:54:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B863100F39;
        Fri, 16 Oct 2020 15:54:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RL6VWBDun33ydYcVKK3j2Nhf3TM=; b=Z2JDF2
        fpYr2wOn+jDShi/BMrgOQknwJ9JfR1SShQr4wRgR3LB1LDHl6E6LO95abg9YL1SG
        JN5pY1M79P1NVX3gyNjoCLlv25Af+CGOyDMaiT2P2zQG9CzsQLNS2FzlSXCRYv4o
        85BDjF0a+Bo0lKKtSmnki6G5ZwJ3qtwNSl3t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ezwxuu9QqD3oOXAZ1LFV97aavPqlvuIX
        Ks4n6oGZFF3oONAvuon14XMK/J2kDun1WfbpB5AKXQgxJlNmBd1O7cXuBMF0/8O/
        wuVQgxLAAABZaScmCOsyAqOeMFtmIRwQ0Eru8gLo/xZ/Cm+JyOSPhKtEqGxfAipH
        aC/6/wDROPE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44945100F38;
        Fri, 16 Oct 2020 15:54:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F2DA100F35;
        Fri, 16 Oct 2020 15:53:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
        <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
        <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
        <20201016015937.GA3335046@coredump.intra.peff.net>
        <xmqqft6eewc5.fsf@gitster.c.googlers.com>
Date:   Fri, 16 Oct 2020 12:53:56 -0700
In-Reply-To: <xmqqft6eewc5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 15 Oct 2020 19:30:34 -0700")
Message-ID: <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 548E7396-0FE9-11EB-960C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> writes:
>
>> What should we change there? We could perhaps bring up signoffs earlier
>> or more prominently. Or tie it in to the git-commit docs by saying
>> explicitly: these are _our_ project rules for signoffs.

Let's tie this loose end.  How about squashing in something like
this?

-- >8 --
Subject: SubmittingPatches: clarify DCO is our --signoff rule

The description on sign-off and DCO was written back in the days
where there was only a choice between "use sign-off and it means the
contributor agrees to the Linux-kernel style DCO" and "not using
sign-off at all will make your patch unusable".  These days, we are
trying to clarify that the exact meaning of a sign-off varies
project to project.

Let's be more explicit when presenting what _our_ rules are.  It is
of secondary importance that it originally came from the kernel
project, so move the description as a historical note at the end,
while cautioning that what a sign-off means to us may be different from
what it means to other projects contributors may have been used to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 291b61e262..f83a050b35 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -300,15 +300,12 @@ patch.
 [[sign-off]]
 === Certify your work by adding your "Signed-off-by: " line
 
-To improve tracking of who did what, we've borrowed the
-"sign-off" procedure from the Linux kernel project on patches
-that are being emailed around.  Although core Git is a lot
-smaller project it is a good discipline to follow it.
+To improve tracking of who did what, we ask you to certify that you
+wrote the patch or have the right to pass it on under the same license
+as ours, by "signing off" your patch.  Without sign-off, we cannot
+accept your patches.
 
-The sign-off is a simple line at the end of the explanation for
-the patch, which certifies that you wrote it or otherwise have
-the right to pass it on as an open-source patch.  The rules are
-pretty simple: if you can certify the below D-C-O:
+If you can certify the below D-C-O:
 
 [[dco]]
 .Developer's Certificate of Origin 1.1
@@ -338,14 +335,15 @@ d. I understand and agree that this project and the contribution
    this project or the open source license(s) involved.
 ____
 
-then you just add a line saying
+you add a "Signed-off-by" trailer to your commit, that looks like
+this:
 
 ....
 	Signed-off-by: Random J Developer <random@developer.example.org>
 ....
 
-This line can be automatically added by Git if you run the git-commit
-command with the -s option.
+This line can be added by Git if you run the git-commit command with
+the -s option.
 
 Notice that you can place your own Signed-off-by: line when
 forwarding somebody else's patch with the above rules for
@@ -353,6 +351,11 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+This procedure originally came from the Linux kernel project, so our
+rule is quite similar to theirs, but what exactly it means to sign-off
+your patch differs from project to project, so it may be different
+from that of the project you are accustomed to.
+
 [[real-name]]
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
