Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377F26AE4
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915397; cv=none; b=PNfsbYRwoiLHyPVHp7ppH8pFkGLSOmY1PQRxv2VCB02qoKfY81kyN3luWectN8Zea/MpEWMe24paJQydPwmwFErYdbjOKK9t/EHdrxTJCwvi1w3utFuerzaT44F65Me8nfpWbCxaENkGZ+p0Mg9e5HGVM2PhyQXBnA2N2nb1K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915397; c=relaxed/simple;
	bh=D+FmIv/vhbkg8bNuStnhkwRzQkJ+gYou3gFrQ4eWtxE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=uaheyar9cji9Cvpw0ouqteODYqkc0eyLoBIQ/nGdDiRSl5X9hBCwWDzSI7ge7+BWq5cZgFRVIjlTwYws2nGD0tq8Y56zMGLYberF7SMTdSb8W+HrAxzhUwibRq2JRQibu9gVqHVn7FznRqZMq++SGn2ek3jwmVw9LKtcFwcFqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIDuJyB1; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIDuJyB1"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso4089355276.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754915394; x=1755520194; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcpPw1BwJ7Hp/eUuCtMKo0AHzuGoi+AHpQSazQmqtzY=;
        b=FIDuJyB1Eq319S+Kv9/HliSCEq7efXUu105SSWBjxIoeS+99lfT4M9KLvIIidFIvsG
         ZzLxVLVRk86a2mJOu5WmLDh0sojWasp0YSbjNE16PuiIzMURp22yRFXf5etGwPv10p3p
         CZAJPopTTQAULQTEjvZ911K90kuAmt2wMuq846SfA/jWHBSPS3OCIm+QrNmW3jCmxDcU
         +/ELeAJdzv12ngU8HIfEMDc+yJauCPHOZFHtceUXfDd/uFD/ry3rspmpKRvLVclh4v5Y
         Y5iV2czLdzGajMqnNa37/jscgrvRzHm5T+Y/FOV4d356W9l8tixwc84fWyR3Ndke0p5H
         Cj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915394; x=1755520194;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcpPw1BwJ7Hp/eUuCtMKo0AHzuGoi+AHpQSazQmqtzY=;
        b=D52cNWoljeJdkb9ddJ0inK+j+KDpjTRr0UYRIefkohFdO7GqN1FYbSlktS/IiPQFP6
         yWruSn8+WrPKl4FZZB+iWYThzTCb1H0OjLOYgxwC14nX17GXJ0CCsVKyxAo1GmsXW6Fm
         7+CUoenOGog46YiMePZrzJil8F3ktQ6EdWlfY7r3bmdo+AkDeis1jqZ2UOnXx4y24vpN
         M7beZRtH+Rb1DJO5HMkeRCuesD9eRbgh092+nTuhpWYpP2syV9HADo+dCmtjXYwyU0Ok
         PANxluA0MfpYJVkxTepVlhf/T7ol5+7oj+JFkbHcofH90hMR3h2XgLS0nwzHtRVsZc8u
         EdWA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2h9GcAExHb2t7VHw+2hYM7+OpZkdzKxiY8HBJEs+OpkC10jEdd4jOEVyrTrNLKQ17cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnZtASjHt7eHnUkr8CzJ8jmdJdCFGbdJhYQ/42O+eyn2NDSRA
	X0BdF4hZXN2lu1GMINaS97JLnCybbRmqUu4T+qtok+hrgu8mFs5smygPM0fIYjjF
X-Gm-Gg: ASbGnctnX3avywuvcTJECvgLq3voedHWBqE78s1t+nyWEdTNSqZlPm1w5ozP1cYVrBo
	f46hbgnt142Az6jehu2iC50WqGV3Gsc2EzMpb5Uu7ZHzREFMS/4NpzdOrsmI2k5KSeZ+FURYdxw
	qoxDsq2axAA2YxznA0jDGB2uXveHUFKaWGnINYmajal0w9SQCWdb8odSw0acO1oJJsopvnD1WLo
	5VbUSewwRqzEkXTIVxuZlNMTFIycrEmJ7d/wZqeAQw1IqYzTdFo1oIdifH/C/eb+whLtV35M4Sd
	6FV2WQNjfa53jGJxe7f7Og7WllK/lBtzcSWr6JeGFmdGETXHSTY7xHKKfsqg8Cmmv6pItjgz76D
	0eLiyGW4OUPlMRR/EV0Wj+igk7tZ3O3kPoVnbPHe5AzzqAYUAXncEZ0ZR1NAdKw==
X-Google-Smtp-Source: AGHT+IGJEkZezZBdLnM9zFTxJSd309wMogtHSLw6lkLyqKtu4q2R5MjDxUfIove7UnEp5QedjFMqxA==
X-Received: by 2002:a05:6902:2b01:b0:e90:47a7:d67a with SMTP id 3f1490d57ef6-e9047a7daedmr14990103276.5.1754915393895;
        Mon, 11 Aug 2025 05:29:53 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f5e7:14b4:8a2a:aa03])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e90613ca6c3sm1957772276.2.2025.08.11.05.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 05:29:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 5/5] doc: git-rebase: update discussion of internals
Date: Mon, 11 Aug 2025 08:29:42 -0400
Message-Id: <FA86B191-AEA6-49AE-A04F-EB736DF4845B@gmail.com>
References: <aJmt1fv66bO_ZMpI@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Julia Evans <julia@jvns.ca>
In-Reply-To: <aJmt1fv66bO_ZMpI@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 11 ao=C3=BBt 2025 =C3=A0 04:46, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Sat, Aug 09, 2025 at 01:14:17AM +0000, Julia Evans via GitGitG=
adget wrote:
>> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.ado=
c
>> index 50c84f138212..c16ee37b46a7 100644
>> --- a/Documentation/git-rebase.adoc
>> +++ b/Documentation/git-rebase.adoc
>> @@ -65,31 +65,31 @@ linkgit:git-config[1] for details) and the `--fork-po=
int` option is
>> assumed.  If you are currently not on any branch or if the current
>> branch does not have a configured upstream, the rebase will abort.
>>=20
>> -All changes made by commits in the current branch but that are not
>> -in `<upstream>` are saved to a temporary area.  This is the same set
>> -of commits that would be shown by `git log <upstream>..HEAD`; or by
>> -`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
>> -description on `--fork-point` below); or by `git log HEAD`, if the
>> -`--root` option is specified.
>> -
>> -The current branch is reset to `<upstream>` or `<newbase>` if the
>> -`--onto` option was supplied.  This has the exact same effect as
>> -`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
>> -to point at the tip of the branch before the reset.
>> +Here is a more detailed description of what `git rebase <upstream>` does=
:
>> +
>> +First, it makes a list of all commits in the current branch that are not=
 in
>> +`<upstream>`. This is the same set of commits that would be shown by `gi=
t log
>> +<upstream>..HEAD`. You can use `--fork-point` or `--root` to change how t=
his
>> +list of commits is constructed.
>> +
>> +Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option w=
as
>> +supplied) with the equivalent of `git switch --detach <upstream>`.
>> +
>> +Then it replays the commits, one by one, in order. This is similar to ru=
nning
>> +`git cherry-pick <commit>` for each commit. See REBASING MERGES for how m=
erges
>> +are handled.
>> +
>> +Finally, it updates your branch to point to the final commit with the eq=
uivalent
>> +of `git switch -C <branch>`.
>=20
> Would it make sense to convert this into a bulleted list to further
> highlight this multi-step process?

Nit: ordered list, perhaps? Unless we don=E2=80=99t use those in our manuals=
 (away from documentation at the moment).=20=
