Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B241F406
	for <e@80x24.org>; Sat,  9 Dec 2017 19:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdLITBX (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 14:01:23 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:3067 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdLITBW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 14:01:22 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id NkNCeDITQNSVVNkNCedWnb; Sat, 09 Dec 2017 19:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1512846080;
        bh=eAnyhaBeMrytJ4qeLAb1uv3Zzwxdz+aKPQYaIX+4XR0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ap2yuW9btAc/3xi6F8JL0I8PS3JPD6F0u2XAbjPt+tMfl5J0brX9ne0rU/0ATDbjg
         QPhlTbI989L3w1F+7ddRCCtFcKctiv1iQcRliy6Upn/pOjV3en2urMg9EX1uu9ifac
         G8n1xi/c2gTAF13pRGauh1skUB6M4LXP8sTrq8Xw=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=cqbjjwBjl6n-utjRzjYA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge,
 noworking tree file changes)
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Alexei Lozovsky <a.lozovsky@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
 <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
 <xmqqo9n99ohc.fsf@gitster.mtv.corp.google.com>
 <a3510c14-23e9-d1d9-0847-b60451f8e15d@gmail.com>
 <D842B04A-9331-4F26-8F19-B61F6F13FC79@gmail.com>
 <92643df4-f54e-cd31-da4a-138ec314655a@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4a92e34c-d713-25d3-e1ac-100525011d3f@talktalk.net>
Date:   Sat, 9 Dec 2017 19:01:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <92643df4-f54e-cd31-da4a-138ec314655a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNtCscPWkDPACovlA+7nw47zaB2BjWnQQYJBoUqhhB3bUDUxv8GXzUKgD8MZDSZRUAVRVLw6LpVhbTSf5mCpw5K0wSWGit5rn4E96SDkS17GEplKe7QA
 BhKg+CcCGYsYSZjLmrMhhoK3ga64xx6KQ/1Z6xgUzJbUGieavS2wvjWLiG6bU1BlZOt/rJMzVVUOHVilSLvpcuLn0Mc2a6Txq3tNnYOXX3cLYBn1QhkIhoHa
 LdIH2xlIWPivwZRd59XdAJ7EiQVC8H57aJYx0Uf/76k745+PJaOxH4i5Djp+qu0839P5/LSTfmSElmUGLJvJVzksHpnKSa28aU3kspC3hGAogOERNZrbEPVN
 OJgYeK/gWVSOgtH6tKt2PqU5zJLWzhPeEMmFnjJ7x+76aSb9lmyvYL73OCJ0TpRJ/PYwTLp4XvPME5iuo01tmynieb+c8IAB4G9eIOlLV+AR0q+EoLZCD/bJ
 UwrE/Gi8cMwXvdfs28j65+mRYdvF1Eyw9rGrwCYfNc/OtnJqbA/DP4L/EPQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor

On 09/12/17 03:03, Igor Djordjevic wrote:
> 
> Hi Alexei,
> 
> On 09/12/2017 03:18, Alexei Lozovsky wrote:
>>
>>> Chris reported in this very topic[1] that sometimes, due to
>>> conflicts with later commits, "checkout > commit > [checkout >]
>>> rebase --onto" is "much easier to do", where "commit --fixup >
>>> rebase -i" "breaks" (does not apply cleanly).
>>
>> It was more of a rant about conflict resolution by rebase rather than
>> a concern about modification time of files. While I'd prefer git to
>> not touch the source tree unnecessarily, it's not really a big deal
>> for me if it does and some parts of the project need to be rebuilt.
> 
> Nevertheless, I found it valuable in supporting the case where 
> "commit --fixup > rebase -i" seems to require even more work than 
> otherwise necessary :)
> 
> But thanks for clarifying, anyway, it does feel like `git rebase -i 
> --autosquash` could be smarter in this regards, if `git rebase 
> --onto` does it better...?

Creating the fixup directly on A rather than on top of B avoids the
conflicting merge B f!A A. Creating the fixup on top of B and then using
git commit --onto A would suffer from the same conflicts as rebase does.
I don't think there is any way for 'git rebase --autosquash' to avoid
the conflicts unless it used a special fixup merge strategy that somehow
took advantage of the DAG to resolve the conflicts by realizing they
come from a later commit. However I don't think that could be
implemented reliably as sometimes one wants those conflicting lines from
the later commit to be moved to the earlier commit with the fixup.

Best Wishes

Phillip

> 
> Even though your explanation seems clear, having a real, easily 
> reproducible case would help as well, I guess.
> 
>> I kinda hoped that you may know this magic and incorporate it into 
>> "commit --onto" which will allow to immediately get to the result of 
>> the rebase:
>>
>>   ---A---f!A---B'
>>
>> without spelling it all manually.
> 
> If you mind enough to be bothered testing it out, might be even 
> existing/initial state of originally proposed `git commit 
> --onto-parent` script would work for you, as it does incorporate some 
> trivial three-way merge resolution.
> 
> In your starting situation:
> 
>     ---A---B
> 
> .... you would just do something like:
> 
>     git commit --onto-parent A
> 
> .... hopefully ending up in the desired state (hopefully = conflicts 
> automatically resolved):
> 
>     ---A---C---B'
> 
> You could even do this instead:
> 
>     git commit --onto-parent A --amend
> 
> .... ending up with:
> 
>     ---A'---B'
> 
> .... as that is basically what you wanted in the first place ;)
> 
>> (And yeah, I'm actually Alexei, not Chris. That was my MUA being
>> dumb and using an old pseudonym than Google insists I'm called by.)
> 
> Ah, sorry for the confusion :)
> 
> Regards, Buga
> 

