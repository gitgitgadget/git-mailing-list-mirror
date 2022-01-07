Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41487C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiAGV0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:26:10 -0500
Received: from mout.web.de ([212.227.15.4]:38603 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbiAGV0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641590766;
        bh=tyDxfdwYZPrepold15WYMhJWcDVEx7O+SQU5pA4e5cU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mhUNmMON1Gq5x7or8AJHFCBEDnY6DP96pL0Vpj2acZqgWDbse/KO+/RqxpHfSfQMS
         KHLffhq639W6UxPLzv/O3jDIWvJ6InYORMSdBxm2oxpAFqBJLh3+4N+2VonFrXBYH/
         7J4Q1qq18sa4BUtagXHXISqfnBSmjG8OlV4lzDAw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1nBhN52cVh-00EXsq; Fri, 07
 Jan 2022 22:26:06 +0100
Message-ID: <96a83437-1858-bbe4-5218-2d8defcd5fe4@web.de>
Date:   Fri, 7 Jan 2022 22:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 0/8] RFC: Server side merges (no ref updating, no
 commit creating, no touching worktree or index)
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
 <CAP8UFD1Z74yuUmzPCr6X8-i2B1zaiT8kPxNDHxK5MeHw8OcnRg@mail.gmail.com>
 <CABPp-BE5breKX5TciAwzKi+BQnqy1aKq_v4tjiqiX7swrZf=PA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BE5breKX5TciAwzKi+BQnqy1aKq_v4tjiqiX7swrZf=PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QbJyu/mYViBQKLGqqZHspz8u2TxmjQS5HmWpWXbu+nwgbVRHnNv
 IWEcZ21uCUOO72exDRu3Rmp4Z8J3DOuDfCniO2JLedQLKDeFxSGDcJImokbRAX9dbBTh7i9
 ZDE6VxdgPOS+ZqTnoTA0V8mR3APc+6/9gQAwzk7DvWFhxsj9+070mHo+h8dR4dXzCtB8MBM
 3kNVC9+EDw4KXaDdxnjeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJ9EXhkU2nU=:7ujScxpvDr91c65I4WqtBd
 momnpJUvg15NJi4R/QkZUGVZuE6Y2tsSyePBoAhY8Zwi7KqZX3RFVPSVzIHclCjCMJmPfP2Zq
 dPFvC4RSxYkFHpHoSdhil4RR90LlZx3I8+8w1OioCwDlk63yDJmHkXMsC4FNFnvVLaEXRcjhE
 b6Gs6a4/HPQM7+ZNX6ZR3uajvokBy2lh1ipMmzEoQiAf67jrM6kaFIN12SAyxTn5g/8bs5pKm
 kgAcG/ll4KtTE/yfroaCgp+rUG5WlVgcAEZ/GxBhfi1QcxcEEe1fUdbM5UwE8ZGLYq3Pk0a2L
 5ni8zMs13JSTIyF3qHFpeD1S3LEN00HkE7vwJlUI4wm4qw9eEEn+Qe4bpl5ymgRKTaaihcDUU
 S5IKiK+Sot5ESoMJR8bWfOJmreIzsSITLK1dBjnLOaM5fLi7OmmSBU+ypH4HGVvPVSn5vyoxn
 108DBmJXIF09ENZn/ga2AYXRn8hk3QB6vfKSagyLdilTQQMUA6VI7znYHQ7MDEEO40M/b5wZL
 9YliqxN0hLmDpJvwcTRfZeDPvEhJULhp8CpVDselLdahFJB0rfSsmGc5KxVIlvkOegziXqmjM
 Du+qSujv96gAulu0Ys4IhM1RJasjqw21Q/+b+EAqPTV+01qt/4a9t2e62xAdZKhpxDqxKb95s
 9tCrRlgGH3Li6HhhJQWdGH8agXkts5GoGINk6CI1jERPiPCKXHeVOz6VsEmYzg2dGx6zzswtK
 l2G4d+8ecTLqHYz4flaz0jLnRYKYD0/DHV/l9sMWcBqAPGs6J5gT/+jLfZXXUD+Xkvy7eFmek
 PV07oUQDJhKT4QFC/T7PhYl7CMrv1CblFwSe61AgjCp/BjbIjGH0eR+Ncn657pfPHMv3+SJi7
 iYfFJfhpcX0saW238gh/5nckXP3hyrXL8HPuUX89cJNlex3WDDHirdl50SClEWNKsuBS5AGaS
 nGJ2/yEi2reiZ5d3VgLo8Zm3zivUgkp3MDqqym8PWBShnwDcnQCfRq8J8OzlZU9YZH6EZjvmw
 mV/XEWaWkP00XxfZlB1lRWXX0WA6LzP9fPElBBz8ulvhrcaLo8zdL08/8pMe05vsKCL48lMy5
 8zgrKRLyni1DKM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.22 um 20:59 schrieb Elijah Newren:
> On Fri, Jan 7, 2022 at 10:46 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> On Wed, Jan 5, 2022 at 6:27 PM Elijah Newren via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>
>>> This series attempts to guess what kind of output would be wanted, bas=
ically
>>> choosing:
>>>
>>>  * clean merge or conflict signalled via exit status
>>
>> (Maybe s/signalled/signaled/)
>
> I can't determine the difference after a few Google searches, and both
> seem to be in dictionaries with the same meaning so I'm having
> difficulty figuring out which is preferred.  Usually my searches will
> either suggest that one is a misspelling or at least bring up whether
> one is a regional variance, but I'm not seeing anything of the sort.
>
> It can't hurt to switch, though, so I'm happy to switch.

https://en.wiktionary.org/wiki/signal#Verb says: "present participle
(UK) signalling or (US) signaling".  And Documentation/SubmittingPatches
says: "We prefer to gradually reconcile the inconsistencies in favor of
US English".  So this seems to go in the right direction.

Ren=C3=A9
