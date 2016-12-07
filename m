Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8A31FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbcLGSgk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 13:36:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:65230 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753391AbcLGSgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 13:36:38 -0500
Received: from [192.168.178.43] ([92.76.239.239]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meutp-1bzUgF0Iw5-00OYaN; Wed, 07
 Dec 2016 19:36:18 +0100
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
Date:   Wed, 7 Dec 2016 19:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:UNeKGBjDrKm+BFT1xGJc1boaUrmJN3ad1yv15h7fPhzJqkPHuPm
 2Wxo7OAtTfAIZ3XDPVumbChbu8J+vETeykDUV9op49f8wCovAbtxai5vEQvSzesPuFJvfXC
 fZJ73cMjyKsrqF2fiow2ycJtWy6zmUhfHp5s0eZyldIxJxpFji4+wMTQpGtUItnHA+vBcpN
 MLZoCkLCVecs+J4FjyhJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:es3z6B5iT2Q=:XXTcph+DvljU1ITMG21NMi
 5MMz+WCX3F2eEAr3WOYAUlDdvvo+FUvwt2itUypOFzPC+pgGnJvT3Y1iupakk05Yo0q9upP2j
 spPF8URFIOXTmHnsMwAX37E+ORAZPTBlBnv9F8F2aCDOqpnz/ZJ4ppG2i7HIPIX0esK/31Egr
 l9hT1txf00theX7H55/lobUEqJRvLbpsGBew2a/4fUfikYvzXoR4ue+b7v4x2oDMVPNwXDvPC
 R4c3/lAz7D/orTJ1YfLj/zLer7F+YKQaoJUTfETAo2pigi83JctDj8F5c3Y3y9Ev+QwXqUs3+
 5pvz06mVkNJ83cOP9nOe6g4AHORtwZEcDDDmGLHPalCGN6wwyT4sf0/+auvJnHIfxIX5DISrw
 u2zUhjHmmgElalvPMonpSKJF9MgFoV1m6V5Ka7ZItTyb1Bru9ULIaWGaMFRFYQ0eM6r+t05v4
 tpA9fhkP+Dtqj9HOmkAHVdDrf0rb4HUkvRZaJE+QIbGwUnPJ6YAOal6mG1xI8I8hJtkcPjyCw
 KhkaXS6Jam3mR9aHxdwtOI7dTDEQR9x1U+FfHH/MNcjrlEnslpTFyQlTNvjlUp2zc9tv2cmMa
 dtgzhV/BLYESZFgDj0fqYaKVLXSw18g1it31UnVDJIs57ehwXtjPM+7HVKooJ+wv2LOaf867J
 I+CG5C8+gEUVgahxvHFUbgeoFWPP9ZpdPcpr8r2md1QNSVIdw0ugSBY1d+djyGuntgHiZUwzx
 C//qjyoDw0l7GLEQDUIRNcCWeAGcNiYNOD/bTk3sGTaiPbeWLYNwejuuBwXLYtTu2dhJIkpjl
 XAflCui
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 12/06/2016 07:58 PM, Junio C Hamano wrote:
> I was burned a few times with this in the past few years, but it did
> not irritate me often enough that I didn't write it down.  But I
> think this is serious enough that deserves attention from those who
> were involved.
> 
> A short reproduction recipe, using objects from git.git that are
> publicly available and stable, shows how bad it is.
> 
>     $ git checkout v2.9.3^0
> 
>     $ git cherry-pick 0582a34f52..a94bb68397
>     ... see conflict, decide to give up backporting to
>     ... such an old fork point.
>     ... the git-prompt gives "|CHERRY-PICKING" correctly.
> 
>     $ git reset --hard v2.10.2^0
>     ... the git-prompt no longer says "|CHERRY-PICKING"
> 
>     $ edit && git commit -m "prelim work for backporting"
>     [detached HEAD cc5a6a9219] prelim work for backporting
> 
>     $ git cherry-pick 0582a34f52..a94bb68397
>     error: a cherry-pick or revert is already in progress
>     hint: try "git cherry-pick (--continue | --quit | --abort)"
>     fatal: cherry-pick failed
> 
>     $ git cherry-pick --abort
>     ... we come back to v2.9.3^0, losing the new commit!

Apart from the git-prompt bug: isn't this a user error? I think "git
cherry-pick --quit"[1] would be the right thing to do, not --abort.

On the other hand, one (as a user) could also expect that "git reset
--hard" also resets sequencer-related states (and that is what the
git-prompt suggests), but that would probably break a lot of scripts ;)

[1] By the way: git cherry-pick --quit, git rebase --forget ...
different wording for the same thing makes things unintuitive.

>  (1) The third invocation of "cherry-pick" with "--abort" to get rid
>      of the state from the unfinished cherry-pick we did previously
>      is necessary, but the command does not notice that we resetted
>      to a new branch AND we even did some other work there.  This
>      loses end-user's work.  
> 
>      "git cherry-pick --abort" should learn from "git am --abort"
>      that has an extra safety to deal with the above workflow.  The
>      state from the unfinished "am" is removed, but the head is not
>      rewound to avoid losing end-user's work.
> 
>      You can try by replacing two instances of
> 
> 	$ git cherry-pick 0582a34f52..a94bb68397
> 
>      with
> 
> 	$ git format-patch --stdout 0582a34f52..a94bb68397 | git am
> 
>      in the above sequence, and conclude with "git am--abort" to see
>      how much more pleasant and safe "git am --abort" is.
Definitely. I'd volunteer to add that safety guard. (But (2) remains.)

~Stephan

