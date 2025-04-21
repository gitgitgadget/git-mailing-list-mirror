Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00A194A73
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249596; cv=none; b=ECY0VFHsh3PMTHmfOt98q9jPNgK8TteJW4jppWC7hJRQTn+6LngPnSwUpAXRGp7PHeTWGi6TE+bjkbEEMN/fV2z+TDyW2TJef/Lif8BUE+APJk8FF1Z8YLS9h/AHJyTkqfMkcoCY64PqYJRiF5WBYsAwAI+GSjt5IKa1BWw1ERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249596; c=relaxed/simple;
	bh=z+z83AA3gpn/dgXl4mRqeb7Y/qZQWsSkhmZWtpOA6B4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOAoYnm09AnWBcN1OqQjO4rVR/u2MLdjpO7b95PtwrK718QlnMYQIaFAR3CHD3cTNDHUFFg2xTQBz3WuenxAatEobZGEUUYanVHogftvoM42LqQm4jyThKxW3rBxxaPrnGxASUZrW1JQ/R2ynsMeYzhiY//esND8EiIGYnjw89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOT6b7Cu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOT6b7Cu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c08fc20194so16938885a.2
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745249593; x=1745854393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZVZB/Ij//VoK5Os5EOLid1r+XSPuR0OJDz3sooGzUo=;
        b=iOT6b7Cun1R1yEgq2hP0v1jUB/s4OEEEU9/5PbNlY7ikMQHkV6GkQpxNG2zFdlmXw8
         77zk82pQayhlPlJhz/EFbH7oigymq7jTgADkg1b2HGonRDdCdO90RCmhKWuFV9UBSeVx
         CvZkpeZXMO7M0M2/HZXYg/VS/PZvqJ7Z+zx57OgwtdEvGoD1bpVfZW4mkacuWGWQRSbu
         dw2Fq4EBso/612I3ZG6Bqp9qt1usLisbdIOrcyqjJ1iov0Q2V7Zv5Vwilib7GK/38GqJ
         q68Zu+IIbTFZA+o2Hpy8zj6egW+MZ38t0bD6D+4YBDnN2IX5Mnn9NNOkzfFrc5XPD8++
         DSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745249593; x=1745854393;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZVZB/Ij//VoK5Os5EOLid1r+XSPuR0OJDz3sooGzUo=;
        b=DEC+APrcA1ghALLRFPLpmW2wlWgmNZPINDQf9S4zzzUH8s8NgTcRB/Ku7Ma80R5YFf
         1xzekwEnn9ddmQWVUwJuVXB+uoCuHdFJCIOTUkmQDBi/cbDx5jxLQPyExk9N2ny0CS8P
         u3M54Cn+F/E3inbkw/2Of/zeRgGZqQQ40PBpGgc9f95icPGqW9y1liiayKEzkvSJpZ/P
         tJcJ8QF/V9aE8CuFwYiBI2YsBUIijn57ALvOM2XR6MsDsRS4GiIuQr7IwN4p2GyTm6rH
         spHEk1x9lTmJrWLlUEsEBB/2mUaves/WQ0yjSgi6S2WaCkOPNFe4noufEqjnz+XmrxG1
         aEkg==
X-Gm-Message-State: AOJu0YzK/R0vtBA9znjv+4HY4ZqWwl7CaJbotc+3DZdOv3MkBi/Yhh4M
	UtZBLB68bUos+ftvCUyQwn7FcyJ9tQRlGh/x2IhozVjF141ExNjKZUL6aPIipDVsRRehTkJpUdJ
	bj/c2TKbL3ih2PQ/gGGKo2FFfBxy5/w==
X-Gm-Gg: ASbGnctjGC3qWXVeoCf9h4FrL3/u4tLBpX5thmCmlPffElAzyyt2iArYxKKj3q+hGcU
	LK3SpC1QMsdCS1flf9Qvm5+jE2N/mgbSpD9PCChC6fWQc1xh794w8hz+UMZ+HEma+bvHNBE13I0
	0jaYX1jUaYiBgsL9G/7yLe0QvAfMjDbRoqZhcjGaE6xzIuJ60KqPd48BZm
X-Google-Smtp-Source: AGHT+IF5NZb8o9kiXM2NvsRfmV4R22vExC01/jOYbQAfmWJUiAQ8fdXV8DUHNhOIK24dGBYYmm/eskFL+dyETfc4EJ0=
X-Received: by 2002:a05:620a:1727:b0:7c5:99a6:7883 with SMTP id
 af79cd13be357-7c92804d673mr2503331485a.54.1745249593250; Mon, 21 Apr 2025
 08:33:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Apr 2025 11:33:11 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Apr 2025 11:33:11 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Apr 2025 11:33:11 -0400
X-Gm-Features: ATxdqUG-z0sKSOTcc6XUsaXsLys2TDjkqoOZCiJQ75w7LPgKgRywpVEpHtUo3qA
Message-ID: <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's hdr-check
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000000d2ef006334b9688"

--0000000000000d2ef006334b9688
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/04/2025 08:48, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
>>> 'es/meson-build-skip-coccinelle' merged in.
>>>
>>
>> Like the previous round, this round also seems to break linux.meson
>> job at GitHub Actions CI when merged to 'seen'.  It may be quite
>> possible that it is caused by some semantic conflicts, and help to
>> find where the merged result is wrong is very much appreciated.
>>
>> For now, I've ejected the topic out of 'seen' again.
>>
>> Failing CI run:
>>
>> https://github.com/git/git/actions/runs/14563669225/job/40850047961
>>
>
> "git ls-files" is complaining that there isn't a git repository. Looking
> at the output of the checkout action (reproduced below) it appears it is
> extracting a tarball rather than using "git clone" because git is not
> available. I don't know what the best way to fix that is - I guess we
> could run "apt-get install git" before calling the checkout action.
>
> Best Wishes
>
> Phillip
>
>
> Run actions/checkout@v4
> /usr/bin/docker exec
> 6334961fdc01ddadb7a7af1fadd8ae33a6fce79b7428255d2231145f5e09f51d sh -c
> "cat /etc/*release | grep ^ID"
> Syncing repository: git/git
> Getting Git version info
>    Working directory is '/__w/git/git'
> Deleting the contents of '/__w/git/git'
> The repository will be downloaded using the GitHub REST API
> To create a local Git repository instead, add Git 2.18 or higher to the PATH
> Downloading the archive
> Writing archive to disk
> Extracting the archive
> /usr/bin/tar xz --warning=no-unknown-keyword --overwrite -C
> /__w/git/git/23521f8f-82bd-4a9b-994a-cacfd7101756 -f
> /__w/git/git/23521f8f-82bd-4a9b-994a-cacfd7101756.tar.gz
> Resolved version git-git-c9e21a0

Yup, this seems to be the reason, I was primarily using GitLab CI for
ensuring everything was working, apart from locally testing it. Seems
like there is no issues on GitLab CI:

  https://gitlab.com/gitlab-org/git/-/pipelines/1777164771

So the only difference, is that, like you mentioned, GitHub strips the
repository information by downloading a tar file using the REST API. The
reason seems to be due to missing the 'git' executable:

  https://github.com/actions/checkout/issues/363

I tested this with the following patch, which seems to fix the issue at
hand. Will send in a new version with this patch, once I validate all
the tests.

-- >8 --

commit b4567cac2b5eb5e9b50b468a85854bad66a9f445
Author: Karthik Nayak <karthik.188@gmail.com>
Date:   Mon Apr 21 13:06:45 2025 +0200

    ci/github: install git before checking out the repository

    The GitHub CI workflow uses 'actions/checkout@v4' to checkout the
    repository. This action defaults to using the GitHub REST API to obtain
    the repository if Git isn't present. The REST API downloads a tar of the
    repository sans the Git information. Since we don't install Git before
    this step, using the REST API is the current behavior.

    The following commits will add the 'hdr-check' static check to meson.
    The check will use 'git ls-files' to obtain the set of header files.
    This will fail if the repository doesn't contain the Git directory. So
    install Git before running the 'actions/checkout@v4' action.

    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 37541f3d10..a09fcf4d72 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -414,6 +414,16 @@ jobs:
     - name: prepare libc6 for actions
       if: matrix.vector.jobname == 'linux32'
       run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
+    - name: install git in container
+      run: |
+        if [ -f /etc/alpine-release ]; then
+          apk update && apk add --no-cache git
+        elif [ -f /etc/almalinux-release ] || [ -f /etc/redhat-release ]; then
+           dnf -y install git
+        else
+          apt -q update && apt -q -y install git
+        fi
+        git config --global --add safe.directory "$GITHUB_WORKSPACE"
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home

--0000000000000d2ef006334b9688
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ba898900109f1b2d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nR1pUWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHF0Qy8wZUJsS0F5T3V0RE55Z1lqdXBGanpuZlhSUwpTOE9SSE9OR2gr
YVBaT0YwdDVMdWwrRlBFVkhzL1JDcjMzV1V3Q004aTFVUE95V1hBeWx1U1l2NCtPZ2hDdVRaCjhC
NnlJMEZIcFJzamxtVWNiSzF6cE1ndDhzSUdzMDBZdFJNQnoxNXcrNnE5MlA2OG5IcmtEbTlDNW1X
OVBjNEgKcEhIZGZoU0tyMFE3ZnBTNkFYekNxdnR6cWZLeXQ3bUMzak9xSmpDcE5CK0doelBNRDVw
ai85Z01YVDBCeVZ3UApDT1hwbi92YXFvVCt0OUlEMjJNVFBxU3NGTmQxUWZQSFJ0Z2JKYmRSNjc3
UExwWUZlOEFlL2RESy9raHVXYXdaClNJR3JEcGt3ZUFFcHByTVNDeUZWNnpSQkFJeXc5RDJ1b09D
WldhYSs1WW1yc3d3M0ZqR05aWlF1NnVYY1FRVlkKNWVZeXBOaWhvNWprT0ljU09ZTVVjU1JzTWM2
azUvcm5tUzNUcURMRWNsLy9wUWZaZ3FRUFRGU091UnkzU2JQbwp3YzRLTmd6K054N1FKdlB0aFFE
Q2JZNnZCdWRocUN1QW04bzNIL2ZpNmxLR1AxcTU2eGd3NVNwc1N4bTlxR0hOCjRTSzhDNVRDRGhL
bzlZWEtRQmlhclROWFE2T3R6YWxtUUovUnJ3cz0KPU1jTGgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d2ef006334b9688--
