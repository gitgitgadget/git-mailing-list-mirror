Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D25C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbiEJRvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348399AbiEJRuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:50:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2805A2C8
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d19so9007405lfj.4
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ostif-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=YTXuoswGEz2MAqkG8EYd9n83f96bto7x5LesOB4n3yc=;
        b=oEHLdVeu1EN197ghORba30EZvdwxtPWCnk3UO2MzxlslQ7mfh3Gk32qu+8uIi9hs4A
         BiMf0Sac4QdiPywsqUrvgCUooldYQPWRPXaUkT409CwC5gByiiQeyG/7nNioTwDMwYdh
         l+JWB7Q9BiRPtqj/Uq6kDb2lB0cqKRxvH3O/DXIIYiJ9AOhpQZA5sJR8jptrsp4nW5i/
         cgm52VtlheEhfbiAGub7gVGJSXfGLsz0OwLEM1o0Zs81+taS8T3BIkOsC0I8ncAV2rdy
         Ap+vruAI4bpMODx4t2BjVHGLeBP9lrPFpXvh2ycIuyGw81wTaXIt5Wjy+oq3LBzw7izM
         d6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=YTXuoswGEz2MAqkG8EYd9n83f96bto7x5LesOB4n3yc=;
        b=I/PvK4eBSN85b/H+NQJuH1j94vWHZMA06fJYPyqADrGDsM36EeeeotvfBlUdkq56sz
         IRHPEGAjkU9LhR8tYkvXnXO4aMmD5RmbvTrLxT9QOuC79nejmmlK1hpPjndViNX+A41k
         jPHdranU+LTzEuw1tJsD5wkVINJ/yF2DNongcKpD/yCpc/s1sY8gfxJKse+TUIdONMX7
         7t2N91kQ2EWA3qzq+wmfVmwZomGmethxwqoZntzPSh/OpbpGb6Pwubs2W5x2f3+3lGsz
         5TmzQZXkzWMmgeFhOWhYqjne/i7gKMIuLy73paxmycd1/9yp//VpFP5x+tQqqclZS8nY
         0vDA==
X-Gm-Message-State: AOAM532k8Q2zhfQ8OL/+7IzHOLlu35g1KKZK7llrtA9Iq+fYLognv349
        0PisDtJkZC+8ugKTjsaK8e41JZKejyNxUiw+K5K1CnXoH/c0Xqo6
X-Google-Smtp-Source: ABdhPJyiIRqoTqnu91HoxIXltJMtXBRqj+q4bPuPvi6BozNAJqvMd4O1Beoc0ud9obV/dCqGGQR8qbT66JlWXVDuUgo=
X-Received: by 2002:ac2:48ad:0:b0:472:4ef:d347 with SMTP id
 u13-20020ac248ad000000b0047204efd347mr16610921lfg.422.1652204797113; Tue, 10
 May 2022 10:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
 <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet> <6cb10d5e-d8f2-0d7e-a15a-4728466e0c21@x41-dsec.de>
 <nycvar.QRO.7.76.6.2204071350080.347@tvgsbejvaqbjf.bet> <CAJY0qZLwQJ_6Me1em4X6M=YJb0O2+7rSYeKisLFOGH7_BW3Lww@mail.gmail.com>
 <CAJY0qZJaBvwA19PN=Gm4c5gSVqYYBOoVwgF=1mZTNEjmXFSc7A@mail.gmail.com>
In-Reply-To: <CAJY0qZJaBvwA19PN=Gm4c5gSVqYYBOoVwgF=1mZTNEjmXFSc7A@mail.gmail.com>
From:   Derek Zimmer <derek@ostif.org>
Date:   Tue, 10 May 2022 12:46:25 -0500
Message-ID: <CAJY0qZJ5sUmXeDZG45fvotcvFo4PRQy1Fv64Y1J7OjTF-8s0Mg@mail.gmail.com>
Subject: Re: Covierty Integration / Improvement
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all, (this is a resend, google mail arbitrarily decides to
switch out of plaintext whenever it likes)

Thank you for the conversations about Coverity. After some internal
discussions and negotiating with our security partners, we have
secured some engineers directly from Github who want to work on CodeQL
for Git. They will do the work of getting CodeQL working, do a scan,
and then evaluate how much work getting CodeQL into a usable state for
Git is by looking at the false positive rate and figuring out what can
be muted with rules, and the false negative rate vs Coverity / other
current tests and create some custom tests.

This should give us a good baseline on what is needed to get Git a
solid security scanner for the CI/CD pipeline. We are focusing on
making the results useful and removing nags to save as much developer
time as possible when using it, so that you get the security benefits
without significant drawbacks.

Do we have anyone here that is interested in helping the team set up
CodeQL? I'm sure the engineers will have some questions, especially
regarding the current Coverity mess and what needs to improve in order
to make this new setup more usable.

Derek Zimmer
Executive Director
Open Source Technology Improvement Fund

Derek Zimmer
Executive Director
Open Source Technology Improvement Fund


On Tue, May 10, 2022 at 12:43 PM Derek Zimmer <derek@ostif.org> wrote:
>
> Hello all,
>
> Thank you for the conversations about Coverity. After some internal discu=
ssions and negotiating with our security partners, we have secured some eng=
ineers directly from Github who want to work on CodeQL for Git. They will d=
o the work of getting CodeQL working, do a scan, and then evaluate how much=
 work getting CodeQL into a usable state for Git is by looking at the false=
 positive rate and figuring out what can be muted with rules, and the false=
 negative rate vs Coverity / other current tests and create some custom tes=
ts.
>
> This should give us a good baseline on what is needed to get Git a solid =
security scanner for the CI/CD pipeline. We are focusing on making the resu=
lts useful and removing nags to save as much developer time as possible whe=
n using it, so that you get the security benefits without significant drawb=
acks.
>
> Do we have anyone here that is interested in helping the team set up Code=
QL? I'm sure the engineers will have some questions, especially regarding t=
he current Coverity mess and what needs to improve in order to make this ne=
w setup more usable.
>
> Derek Zimmer
> Executive Director
> Open Source Technology Improvement Fund
>
> On Mon, Apr 11, 2022 at 1:49 PM Derek Zimmer <derek@ostif.org> wrote:
>>
>> Hello all,
>>
>> Answers inline + more context
>>
>> > If OSTIF can help us get better support from Coverity (as you can see =
at
>> > https://github.com/git-for-windows/build-extra/commit/23eea104 I could
>> > have wished for a better experience there), I am all for it!
>>
>> We may be able to convince them to help based on the volume of work that=
 we do with many open source projects. Not helping one open source project =
may seem like a small loss to them. Not getting recommended to hundreds of =
high profile projects because of lacking support is different. It is especi=
ally concerning that this particular bug likely affects a huge number of cu=
stomers.
>>
>> > If not, have you considered if you could help us getting a comprehensi=
ve
>> > CodeQL coverage instead? Theoretically, CodeQL should be able to do th=
e
>> > same as Coverity, while allowing us to tweak the analysis in a lot mor=
e
>> > powerful ways than Coverity (most notably, it should allow us to reduc=
e
>> > the number of false positives rather dramatically).
>>
>> This is absolutely an option, although we may have to petition Google / =
OpenSSF / the Linux Foundation for a slight increase in funding, as setting=
 up CodeQL from scratch is a much more laborious task than setting up rules=
 for an existing Coverity setup. We absolutely can do this, but we'd have t=
o split it into a second project with separate funding in order to keep the=
 primary work moving forward while we work out the details.
>>
>> If you ultimately think that setting up CodeQL will yield better results=
 overall for Git, I can get started on finding the resources to get it done=
 immediately. (I have a meeting with the Linux Foundation tomorrow.)
>>
>> If we are going to go with CodeQL as a separate project, we can drop the=
 Coverity work from the current SoW/Proposal and proceed with all of the ot=
her action items.
>>
>> Let me know your thoughts everyone on what best suits Git here. It sound=
s to me like CodeQL is the way to go but if there's a compelling argument f=
or Coverity we can explore that.
>>
>> All the best,
>>
>> Derek Zimmer
>> Executive Director
>> Open Source Technology Improvement Fund
>>
>>
>> On Thu, Apr 7, 2022 at 6:58 AM Johannes Schindelin <Johannes.Schindelin@=
gmx.de> wrote:
>>>
>>> Hi Markus,
>>>
>>> On Thu, 7 Apr 2022, Markus Vervier wrote:
>>>
>>> > On 4/6/22 00:17, Johannes Schindelin wrote:
>>> > > On Fri, 1 Apr 2022, Markus Vervier wrote:
>>> > > > X41 is processing the current RfP
>>> > > would you kindly provide a bit more context? This seems to come rig=
ht out
>>> > > of left field. Is "RfP" a "Request for Proposals"? If so, I am not =
aware
>>> > > that the git developer team submitted one...
>>> >
>>> > thank you and everyone else for their comments. To clear up the conte=
xt:
>>> >
>>> > The OSTIF (https://ostif.org) is organizing a security audit for git
>>> > and one of the questions was about Coverity and if the results it gav=
e in the
>>> > past could be verified and/or improved.
>>>
>>> Thank you for the context!
>>>
>>> If OSTIF can help us get better support from Coverity (as you can see a=
t
>>> https://github.com/git-for-windows/build-extra/commit/23eea104 I could
>>> have wished for a better experience there), I am all for it!
>>>
>>> Out of curiosity: are you (or is OSTIF) affiliated with Synopsys someho=
w?
>>>
>>> If not, have you considered if you could help us getting a comprehensiv=
e
>>> CodeQL coverage instead? Theoretically, CodeQL should be able to do the
>>> same as Coverity, while allowing us to tweak the analysis in a lot more
>>> powerful ways than Coverity (most notably, it should allow us to reduce
>>> the number of false positives rather dramatically).
>>>
>>> It is the number of knobs CodeQL allows that has looked too daunting fo=
r
>>> me to give it more than a cursory try [*1*].
>>>
>>> Thank you,
>>> Johannes
>>>
>>> Footnote *1*: I had played with CodeQL last year but was called away to=
 a
>>> more pressing project, therefore this is woefully incomplete:
>>> https://github.com/git-for-windows/git/compare/main...dscho:codeql
