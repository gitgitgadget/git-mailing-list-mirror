Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CA3C08A
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630246; cv=none; b=MqV3Flq0gR49uY69yVfXKGgo6+T2BTTFK12TArmZtRsWXUMGJaHYynGUh+GR9milylTeheHugRwmEj9pI1d3rTbKuICy8TM/7kiRv1ccGVuXG/XCDSMoEysYSFYZc1nmBRiDxGIWP+yG2Oim799+ZY2sz6siOD6QHSOFTM+qyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630246; c=relaxed/simple;
	bh=QNvMxU5Ytk39z2VA0PSuLWPL2MvH5HyMyjF242m2QcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0S2BhXDphalbE2/oTuE6yjnIeOfALiPCDq1DZfh2VVRwkJKHmIONeEGKAJsI1v9sZVftgB67kxtgSv6VW9F0sZ4LmGc9oV4qf9RFRrLCFCONr+Fj8EFfcMUyu0Behm7K7HxS8B58Qu4LFIoPz0rYgPBUgRcH5SXv2P4Nj7eUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWAsiinx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWAsiinx"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59b178b75bso944593166b.0
        for <git@vger.kernel.org>; Mon, 13 May 2024 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715630243; x=1716235043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfUZ+QdoGZtfb34AQhKpNTU8klThh6jtu4NV+xQO0oM=;
        b=rWAsiinxAkMTigH4LQTlldQDVrFwMxsG4jV75xrn+vFX9YTrGG8nDRKWlbJRBnGrak
         N6/Grp9/L1A3CSZVICm6urch4M8XMF6U/XSdpYz9CQ+QxuTGZFWNEvWjn/bluwPmdMt1
         OEGM9JoAfdf1ezR978guqcPe4LjOnimQFj6yr30jDwGAEZsSLOmErd2mtoyFRWfa/pm2
         FM/ajZM66+GHn+L8GOt99iSEesfYfXLsfwtFkUzSaKeMwn+4xCyd0w+/Uyr7/BtvjCyl
         FJu+ugv1Wp92SiDrjL3cTIX6RE/XG3qRL23XdAT8U/cqEAgTu/YJ6I0zOO5a3h5uu6bG
         UJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630243; x=1716235043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfUZ+QdoGZtfb34AQhKpNTU8klThh6jtu4NV+xQO0oM=;
        b=ZvrplOhqdUjQxHGhF9Aajq1kHpO5oniYWncGc5F+zUHPCnK+HHOlWQFtrzFPKIvU/8
         lUbuAHMph1hKeIYx0c1hQSjRQ986FD8VErJ9eujl55Zm8Oq5tlFO8cKSd4QQex3l+Y5N
         lcy3WKk6LwE/gPDplVGVPROhfmIkD+wfKS8PgYP3/+q0R79tOwk4R2kVePNfTHIkIvNt
         hSVIkAv2CmTeObOOiKHKJq0z4q1aEheyELJdqOYOn1mqkEvboGzkKt+b/VmFvWnDzlTW
         tTkqoLzYOkGyp8cqMdvw2/u6Pg6gB/mhXbZgMyogWb3/chMXb1nXgr3U0+bxdygP3hTC
         0qjg==
X-Gm-Message-State: AOJu0YysmkyoEKcjVipAKfTU9UWF0+EK6lPRouNZK+eh43Twx1oWn1iq
	5BrSTU0GCxY8UXn1Eg8tyOtGpnRdt3LGHj2ertvcotu5IJxQW3Bv5dGKyfOll7KmMpoZgb5JTji
	Bb2uSj1vVbiFUEgN2epQiqrUkyq2k5uIGdd2fSe8q6wSTXQphXw==
X-Google-Smtp-Source: AGHT+IGa87iec4A2u/ypxmBhzDJ09pCNtNOdRCSmrNNwyi5JP5yHGsIfCpN/VSxeJgnOra999K9MDxCy6FrAihkH9vI=
X-Received: by 2002:a17:906:f186:b0:a59:b68d:45fb with SMTP id
 a640c23a62f3a-a5a2d68aa70mr746992166b.63.1715630242700; Mon, 13 May 2024
 12:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715582857.git.ps@pks.im> <20240513192112.866021-1-gitster@pobox.com>
 <20240513192112.866021-3-gitster@pobox.com>
In-Reply-To: <20240513192112.866021-3-gitster@pobox.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 13 May 2024 12:57:11 -0700
Message-ID: <CAO_smVg7mdQHp+sg4-vVUEOVRBEoZjqXZu=Kk8PuYc9mtYeMXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] t1517: test commands that are designed to be run
 outside repository
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> A few commands, like "git apply" and "git patch-id", have been
> broken with a recent change to stop setting the default hash
> algorithm to SHA-1.  Test them and fix them in later commits.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t1517-outside-repo.sh | 61 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100755 t/t1517-outside-repo.sh
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> new file mode 100755
> index 0000000000..e0fd495ec1
> --- /dev/null
> +++ b/t/t1517-outside-repo.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description=3D'check random commands outside repo'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success 'set up a non-repo directory and test file' '
> +       GIT_CEILING_DIRECTORIES=3D$(pwd) &&
> +       export GIT_CEILING_DIRECTORIES &&
> +       mkdir non-repo &&
> +       (
> +               cd non-repo &&
> +               # confirm that git does not find a repo
> +               test_must_fail git rev-parse --git-dir
> +       ) &&
> +       test_write_lines one two three four >nums &&
> +       git add nums &&
> +       cp nums nums.old &&
> +       test_write_lines five >>nums &&
> +       git diff >sample.patch
> +'
> +
> +test_expect_failure 'compute a patch-id outside repository' '

Do we only expect failure because of a temporary condition (the bug
that is mentioned in the commit message)? If so, we should probably
add a TODO, FIXME, or some other similar style of comment that
describes that this should be fixed. This way, if the patch series to
fix the issue doesn't materialize, people don't read the test file and
think that these commands aren't supported outside of a repository.

Do we have a way of catching the specific failure mode? i.e. if it
crashes, is there a test_expect_crash? I'm thinking that it might be
nice to be more specific about what kind of failure we expect, this
way if it fails in a different way before we convert these to
test_expect_success, the test fails (due to the unexpected change).
I'm assuming that for crashes of this type there's no good/portable
way of verifying that it's a specific crash, but having the test check
for a difference between an exit code that indicates a signal was
raised and an exit code that indicates that the process returned
"naturally" after an unsuccessful execution might be feasible, if we
already have such a mechanism. Adding one just for this series doesn't
seem justified.

> +       git patch-id <sample.patch >patch-id.expect &&
> +       (
> +               cd non-repo &&
> +               git patch-id <../sample.patch >../patch-id.actual
> +       ) &&
> +       test_cmp patch-id.expect patch-id.actual
> +'
> +
> +test_expect_failure 'hash-object outside repository' '
> +       git hash-object --stdin <sample.patch >hash.expect &&
> +       (
> +               cd non-repo &&
> +               git hash-object --stdin <../sample.patch >../hash.actual
> +       ) &&
> +       test_cmp hash.expect hash.actual
> +'
> +
> +test_expect_failure 'apply a patch outside repository' '
> +       (
> +               cd non-repo &&
> +               cp ../nums.old nums &&
> +               git apply ../sample.patch
> +       ) &&
> +       test_cmp nums non-repo/nums
> +'
> +
> +test_expect_success 'grep outside repository' '
> +       git grep --cached two >expect &&
> +       (
> +               cd non-repo &&
> +               cp ../nums.old nums &&
> +               git grep --no-index two >../actual
> +       ) &&
> +       test_cmp expect actual
> +'
> +
> +test_done
> --
> 2.45.0-145-g3e4a232f6e
>
>
