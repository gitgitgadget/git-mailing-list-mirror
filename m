Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71DC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbiDGSj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiDGSj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 14:39:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE6261F
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 11:37:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so7453658edw.6
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iqLW9E0SbVTJWMNott4kFc9NyFPzQ9pxbb6PiUhe614=;
        b=gb7ijjtviwLqepm46pbpvURJC1i/R1Z92U/6dJXn3UeyIoaaNXwv2ckGsEv/gQ4FFU
         yC4DjbTZVhvNndmtHRi8mFfR6pW1Mei5Gv2/Vw3CvFnUbfZnd+0p4DbIizfuQ6gYAtM8
         CfdBkGENZO1AXWEID/OSXxk4ZIz+/SfOHF0DOzc0ikMYjWTpH5WyOJDL6MTODjioC+QR
         EEqnMAv9tlkba6ntq0RIy9o6nscX7ap1JAWqqoqZlkqh88Ghvh4cOAkCgCJh4ixKPUtp
         Zzp5MMXUNsn0wQaUeOOA+iDbluP4V+ObpAw1u3RfJxGbu3Njm475QTVQiMw6oZ2Z8nDT
         ocUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iqLW9E0SbVTJWMNott4kFc9NyFPzQ9pxbb6PiUhe614=;
        b=2gH54lTw4KPYY92emblDtNbIfjv3Z5jae+ZoPrhmXkme3ayJTKKktkjt4E+mc6ryka
         qa2qPn4QVZYbPtyLIPeibG7MXMGwNBL3bk4sSJiyroL0NElY/XWKStFloxBsGX7j/YrX
         3l38XM7jBd2fuTGlKYBKI8A8nheVfH9q2xNiLp/R4NshWoY/lK16ETSvs2Qnk3MY5zEa
         uv8eF7aoLcOkdsZiBK3OsAyrb1AktKo15qAVTuju6Zn3b1H5k37hiZ+aKgpxQxZfS9jO
         0xzAG8DsjvXyBBRKMzOI/8OC/nfWgqw+hh2EwzwPwcW2fLlHra+Ckg+jcJR6HowYoqFk
         dfWA==
X-Gm-Message-State: AOAM531oeqf+qTN699ocK+NsRW5kqVkgaVhft721yqlgpuEKyK9VIvdG
        gBF0isAsAF548oQoBcvqHIF64PvNpbk=
X-Google-Smtp-Source: ABdhPJzkWYEqtbcn6m6cVsWKbB3Yzi+cxSe1sFjQKOHzf1YvDedLBCO7tqMvlAxSxnnRmtwTzwYzug==
X-Received: by 2002:a05:6402:22d8:b0:41c:c3cd:478e with SMTP id dm24-20020a05640222d800b0041cc3cd478emr15734534edb.34.1649356643504;
        Thu, 07 Apr 2022 11:37:23 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p9-20020a50c949000000b0041d180b8beesm220500edh.48.2022.04.07.11.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:37:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncX0U-001AVs-K1;
        Thu, 07 Apr 2022 20:37:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] doc: replace "--" with {litdd} in
 credential-cache/fsmonitor
Date:   Thu, 07 Apr 2022 20:35:53 +0200
References: <20220406184122.4126898-1-tmz@pobox.com>
 <220407.86h774dcyk.gmgdl@evledraar.gmail.com> <Yk8qU66OzzIEwDP4@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yk8qU66OzzIEwDP4@pobox.com>
Message-ID: <220407.86czhsd9jx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, Todd Zullinger wrote:

> Hi =C3=86var,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Looks good, for the linkgit case let's check it in "make check-docs":
>>=20
>> diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlin=
k.perl
>> index 1c61dd9512b..2f46b261282 100755
>> --- a/Documentation/lint-gitlink.perl
>> +++ b/Documentation/lint-gitlink.perl
>> @@ -46,6 +46,7 @@ sub report {
>>  		my ($target, $page, $section) =3D ($1, $2, $3);
>>=20=20
>>  		# De-AsciiDoc
>> +		my $raw_page =3D $page;
>>  		$page =3D~ s/{litdd}/--/g;
>>=20=20
>>  		if (!exists $TXT{$page}) {
>> @@ -61,6 +62,7 @@ sub report {
>>  			report($pos, $line, $target, "wrong section (should be $real_section=
)");
>>  			next;
>>  		}
>> +		report($pos, $line, $target, "should link '--' as '{litdd}')") if $ra=
w_page =3D~ /--/;
>>  	}
>>  	# this resets our $. for each file
>>  	close ARGV if eof;
>
> Excellent, thanks!  I had run the lint-docs-gitlink target
> to see if it reported any issue, but it hadn't.  With this,
> prior to the change I made to git-update-index.txt, it
> properly reports the issue:
>
>     make -C Documentation/ lint-docs-gitlink
>     ...
> 	LINT GITLINK git-update-index.txt
>     git-update-index.txt:531: error: git-fsmonitor--daemon[1]: should lin=
k '--' as '{litdd}'), shown with 'HERE' below:
>     git-update-index.txt:531:	'linkgit:git-fsmonitor--daemon[1]' <-- HERE
>     make: *** [Makefile:442: .build/lint-docs/gitlink/git-update-index.ok=
] Error 1
>     make: *** Deleting file '.build/lint-docs/gitlink/git-update-index.ok'
>     make: Leaving directory '/src/git/Documentation'

Yup, note that it'll find the other one(s) too if you pass the "-k" flag
to make, i.e. it's erroring out and aborting on the first error (as is
make's default behavior).

It won't help with all the changes you made though, e.g. headers etc. We
could add that, but it would be bigger change. This seemed easy enough
for a proposed squash-in.

Thanks for the fix!
