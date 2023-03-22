Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC61C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 13:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCVNyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCVNyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 09:54:08 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE2113C4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:54:06 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id r7so12680136uaj.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearearth.aero; s=google; t=1679493245;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEo+RijC6BVgJVCx5CrgFTTJ9L4J5E4DXbbg3QqbtT4=;
        b=Y6Oo9Sd49N0cmNKWQSFuFbSa5893VcfixC049BMy4mMDlQPuyKiPimAKs6VwQZ0jvd
         ZtsKRINTJHU4mxG/lQQpZjeFyTyGoaknuQ8xcNNYWfpIfMYvIkwLws+mv1sxoFzF9cXd
         m1yj0gQ2O6h4aAydV3SvlFpEjklNHKalRMu7/tz0evA4NG18NhEI2z4m1zEmViNXhyTH
         2cqOd6hMi1+pTk/mYj7y81xMHNRXWwMWVWzOVUhDBrZvr0b8ImjgYzYTP9I85QBoIruh
         KtEAHCh/H6DUpp6yswkAHMbDugR2Ny6W7Xv2wIN5LZwb67CU2JEvQKOWIVx9H7eDZko9
         EVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493245;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEo+RijC6BVgJVCx5CrgFTTJ9L4J5E4DXbbg3QqbtT4=;
        b=jYUiL8zGj/9A9w8JVPTHZJpzkaAUFa3y9u0MGA9/AXNXtt9rClGwbZY2ar5ve/XQjL
         Z4ld5GT+IWhSx1DZ6RCAFO/+4kePsq7VLiJfqMgJeaV7sfJVvc2TkeIz+DtLByVwFDRw
         XtCLBjw4f9BS31mCXRwX2+qhdZuwvS3xIfL/9WUMbIkl+eQuzmDGFnWOWVk/eobR1VwV
         s5+wO02CrRKlIuV2oaGlCHF/lw7HnG8zdbVMIUeMW/41DCVcs1OoqZVg3BMzjhXXDRCJ
         AKFXWJI8cSgxE+hjRhoOzBXXEr1fB81ev1S8Jw3vypacVYyxT00nhnq5CQsEu8tey6V6
         ZgCQ==
X-Gm-Message-State: AO0yUKVVYMcug0t573E5N7nTRrJD4nagRGPgKS+aSF83UNNLmBF/UbmS
        8yJhEbiNgJv72TgOfB2/TP+0WA==
X-Google-Smtp-Source: AK7set8kTyXCFn2PBLXrau2Zb2jh6Bs3sUbC90JOVhqN1pQeArcbYArgsmH9dBvrtrt+yPakix3xng==
X-Received: by 2002:a05:6122:929:b0:435:de54:6e27 with SMTP id j41-20020a056122092900b00435de546e27mr3414172vka.13.1679493245580;
        Wed, 22 Mar 2023 06:54:05 -0700 (PDT)
Received: from smtpclient.apple ([184.81.152.146])
        by smtp.gmail.com with ESMTPSA id 188-20020a1f01c5000000b0041192a05bf7sm2132614vkb.4.2023.03.22.06.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:54:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: Feature Request: Ignore Tracked IDE files
From:   Ward Hopeman <ward.hopeman@nearearth.aero>
In-Reply-To: <m0o7ol6ta7.fsf@epic96565.epic.com>
Date:   Wed, 22 Mar 2023 09:54:03 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACA3ECE1-689A-4BFD-A8EE-9CFF30128C1C@nearearth.aero>
References: <94EFF553-E498-46D9-B14A-3500FEDEBB47@nearearth.aero>
 <m0o7ol6ta7.fsf@epic96565.epic.com>
To:     Sean Allred <allred.sean@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sean,
   Thanks for the feedback. I had not considered that the IDEs the teams =
are using might already have that functionality built in. I thought I =
had hit the nail on the head, but I agree there appears to be an =
alternative available. I will pursue those configurations with the team.
   I am curious if you think there is a class of files, under the =
paradigm I outlined; that need to be tracked initially but then ignored =
for regular workflows?  Just curious at this point if this was discussed =
/ considered previously.

Thanks,
Ward
>

> On Mar 22, 2023, at 5:10 AM, Sean Allred <allred.sean@gmail.com> =
wrote:
>=20
>=20
> Ward Hopeman <ward.hopeman@nearearth.aero> writes:
>>    Request: Create an Ignore section that allows for minimal IDE
>>    inclusion without impacting IDE settings for local users.
>>=20
>>    Reason for the request: Most engineering teams share some IDE
>> settings when working on code. More often than not, local IDE changes
>> force engineers to resort to using "git update-index --skip-worktree
>> <file>=E2=80=9D to avoid the IDE settings files from showing up. It =
would be
>> nice to be able to identify IDE files that you want in the repository
>> but not necessarily track all changes as most of them are not desired
>> when individuals make those changes for local setup. But teams like =
to
>> track and have available generic shareable configurations like tabs =
to
>> space and line length etc. By making it a user configurable section =
of
>> ignore it allows for future IDEs to be listed without impacting the
>> way it works for common IDEs today.
>=20
> It sounds like you are rather after 'public' vs 'private' IDE =
settings,
> which would be a feature of the IDE -- not of Git -- and it seems a =
far
> simpler model. Public settings are checked-in, private settings are =
not,
> and private settings override public settings.
>=20
> This is used by Visual Studio (IIRC) and possible in other tools =
(Emacs
> I know for sure, though I can't imagine VS Code doesn't have this
> concept by now). It's even the model used by Git itself for some =
things
> (.gitignore vs. .git/info/exclude vs. core.excludesfile).
>=20
> Are these alternative approaches not an option?
>=20
> --
> Sean Allred

