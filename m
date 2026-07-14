Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811963A6B71
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029634; cv=none; b=VqaFlRlteilOSPyRVkpIrpI5A3GO7PcjodUWpRDSpXfPUBcVGTgXieDbnN0ok/xMTr/KN0dbq3d34XSk4BeDfGw7tktlt3TabLeBik/zYBD0EPRMGeXFeYl9cc7NtsNcosWB0pCyrZWKVDHpKw0f61hC4F/spmO01BTxTVpCO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029634; c=relaxed/simple;
	bh=UBaqwBvYemo39i4zJRqnJsg/J/WV1GZxus6WoiWjSa8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RDElqSAE/ZYT2Sj8Lx0UkCMqqfDqVCnZNL71cJPGu68zvPjsgSodjsLAiO4p1zRvfQ7X+5jPUG4/Ihla9YzwZg6QNyFhcWnuGS+rNxYbSDOu18pp2G5Z4PwFor9gYNW8rlh0T0iqnFBlW042Omx4dQAipb/PA7daHuZMqH9RIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcf9a6rF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcf9a6rF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b966dd74so16183605e9.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029631; x=1784634431; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IauvLaMjEntZ5dWJFaNz8fMifMFiHwV1slMzMWp6jSY=;
        b=Rcf9a6rFDF6FtvtxezVUnAP11K1ZTWCBYOxCUKqaGaqDUV8tEUaLASmJQiUUdKsX8I
         lIlf06B1v0VgKp/BT6iFpwvn0gr5rThJQfos/88XrRfFWd/gST3OP2wCsRjdCpgMyy+X
         qdaJovgmbUEnZJ6MsQqnFgnQ7Aw6BfuitjNqgOBiXAkgE5bD72j15srjnOuoUOSWJQ5E
         AyaKwW9+KVQrkeXQEXDAjJ9GI2xeJCfWgW31tUdKNhURdo/kBXT4dblaBcce+vU2Wjoe
         2LvcDmM/onaTgY5E9PUKnrgwvOKCRrxLhugK1Pexe0XHCpZlho0QgWsgIbkLNpkN0exI
         J1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029631; x=1784634431;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IauvLaMjEntZ5dWJFaNz8fMifMFiHwV1slMzMWp6jSY=;
        b=i4qCtq8++fO1X5V7K8oC7uNUxK37rzGpd2imOKVND9uWjzBB7Neu4nMLqpasR9WTMu
         wQRWHu0meoIh6OG8f9dTyaPfyGf44Z1cRJttf+PqL/G1lDemF0uV+aKOmP16FkCD4QpN
         y5B/hxF6j8mesMZHD3m5AyUHtjx2N7pj5MuuVyJePMtomIztwv4remAPidm1XdOlqiLg
         9BMNLmfuCbLJsEG5cMDYpMp2v5W2Th4SSB5IIuGVwOD4CylC3CZ32o/t55zLIuqCOJIW
         NHJb51GlVEikL+TZn8rpNlVVMZN1PVQmQDwb5cRS6PUlZbx5BKVJfsGzGnQ97ITECPNG
         9Nuw==
X-Gm-Message-State: AOJu0Yyk9qRTdvY9CdLcJ8/z+bmuaXjhiKIeM5renhBYuGjg3GM9ycHG
	tsnB0hgpHQ5xPv2vmNyBCxfD8TNbLHcHsZUW3piL63na6c/D/5a/cDEF
X-Gm-Gg: AfdE7cmJ+p0tXNpKuy5PqU/SQ2DLI8pUEmst4VTFByXsdb4nFG+FG7SHwtw0GtZoEQU
	/rEVcBKDkrIYLHGRyLbmbdvslbIOJj1SczOkm3CyK8S4Zt++dq3w9bZVHfcke6yr2tzY/MJo4yh
	Fzag7hHGOXeHbLyRPmrJPbU6OjXS+ZWNHyHGkXNJ/7EwvYQArUVhQ3JfJw8UpLUv8WOBUgWtWVu
	M+kz7jITTaiMY7yzENPgcqo/4wDO+b9yYUViNP31qaN9gXyD2VWtK/hKp5n6CmdhS8qoa6ml4sA
	lsLSed8ZBRtBHzpUWnFDq/mt7bzCGgGPgDb7Bro2P6jDUOrbMlAYJxAd4hpNya8/g0qq1ovjgNa
	J66QTeUVs01TJKQCz8ZLJ6z/v0MvOqZ9VuTLiztcQS+G7fL+4+AsNYnZC3d0mqqxjLkVZsr9mop
	lR/3+mGZp2kROO6ZZ2XnRt7v6cNp8CK06ywPjmLowrYBaApLuus0hxqIKR03K55+shc1PixxIxo
	NfYxYq1PtY/6LTpAOeuShVztTGvL4mOwbA35raNAXclDphUJJxCI5CKHdy0hd2lnEVNOVStmbT6
	VF4kqWJlcG3h7KpZ3n+zUHi+jiffkpHhHo2YhzfF3FSYDGL96Zynf2CF3ORPxTZUEAwumA==
X-Received: by 2002:a05:600c:5489:b0:492:68f5:6b30 with SMTP id 5b1f17b1804b1-493f87f1b34mr129671375e9.17.1784029630401;
        Tue, 14 Jul 2026 04:47:10 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm81741805e9.13.2026.07.14.04.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 13:47:08 +0200
Message-Id: <DJY9Q16CVG2G.GT6U9PD2CRD9@gmail.com>
Cc: <git@vger.kernel.org>, <ayu.chandekar@gmail.com>,
 <christian.couder@gmail.com>, <gitster@pobox.com>, <jltobler@gmail.com>,
 <karthik.188@gmail.com>, <krka@spotify.com>, <mroik@delayed.space>,
 <peff@peff.net>, <phillip.wood@dunelm.org.uk>,
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v11 7/7] graph: add --[no-]graph-indent and
 log.graphIndent
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <20260713-ps-pre-commit-indent-v11-7-dcb65bc4ba99@gmail.com>
 <CA+J6zkRXbW=bLQ8nDcbPwocetdi2JpyM_R5Gff6sMK-Gb_JGhw@mail.gmail.com>
In-Reply-To: <CA+J6zkRXbW=bLQ8nDcbPwocetdi2JpyM_R5Gff6sMK-Gb_JGhw@mail.gmail.com>

On Tue Jul 14, 2026 at 12:19 PM CEST, Chandra Pratap wrote:
> On Mon, 13 Jul 2026 at 22:14, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
>>
>> Some users may prefer to not have graph indentation.
>>
>> Add "log.graphIndent" config variable to graph_read_config() to read the
>> default preference. By default is graph indentation is true.
>>
>> Add --graph-indent and --no-graph-indent options to overwrite the
>> default preference.
>>
>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> ---
>>  Documentation/config/log.adoc       |  4 +++
>>  Documentation/rev-list-options.adoc |  8 ++++++
>>  graph.c                             | 10 +++++--
>>  revision.c                          |  9 +++++++
>>  revision.h                          |  2 ++
>>  t/t4218-log-graph-indentation.sh    | 52 ++++++++++++++++++++++++++++++=
+++++++
>>  6 files changed, 83 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config/log.adoc b/Documentation/config/log.ad=
oc
>> index 757a7be196..f7dfce69b5 100644
>> --- a/Documentation/config/log.adoc
>> +++ b/Documentation/config/log.adoc
>> @@ -59,6 +59,10 @@ This is the same as the `--decorate` option of the `g=
it log`.
>>         A list of colors, separated by commas, that can be used to draw
>>         history lines in `git log --graph`.
>>
>> +`log.graphIndent`::
>> +       If `true`, indent visual roots when rendering the graphs with `-=
-graph`.
>> +       Set true by default. It can be overriden with `--[no-]graph-inde=
nt`.
>> +
>>  `log.showRoot`::
>>         If true, the initial commit will be shown as a big creation even=
t.
>>         This is equivalent to a diff against an empty tree.
>> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-lis=
t-options.adoc
>> index eaee6ee839..af74f10bb4 100644
>> --- a/Documentation/rev-list-options.adoc
>> +++ b/Documentation/rev-list-options.adoc
>> @@ -1269,6 +1269,14 @@ This implies the `--topo-order` option by default=
, but the
>>         By default it is set to 0 (no limit), zero and negative values
>>         are ignored and treated as no limit.
>>
>> +`--no-graph-indent`::
>> +`--graph-indent`::
>> +       When used with `--graph`, indent visual roots (commits with no p=
arents
>> +       or whose parents are not shown) to differentiate them from commi=
ts that
>> +       are vertically adjacent but unrelated. Enabled by default. Use
>> +       `--no-graph-indent` to disable or set `graph.indent` to set a de=
afault
>
> s/deafault/default
>
> Also, I think you meant log.graphIndent instead of graph.indent here.

Yes, thanks, I'll fix it.

>
> [snip]
>> +test_expect_success '--no-graph-indent disables indentation' '
>> +       lib_test_check_graph --no-graph-indent _58 _59 _60 _61 _62 _63 _=
64 _65 _66 _67 <<-\EOF
>> +       * 67_A
>> +       * 66_A
>> +       * 65_A
>> +       * 64_A
>> +       * 63_A
>> +       * 62_A
>> +       * 61_A
>> +       * 60_A
>> +       * 59_A
>> +       * 58_B
>> +       * 58_A
>> +       EOF
>> +'
>> +
>> +test_expect_success 'log.graphIndent config disables indentation' '
>> +       test_config log.graphIndent false &&
>> +       lib_test_check_graph _58 _59 _60 _61 _62 _63 _64 _65 _66 _67 <<-=
\EOF
>> +       * 67_A
>> +       * 66_A
>> +       * 65_A
>> +       * 64_A
>> +       * 63_A
>> +       * 62_A
>> +       * 61_A
>> +       * 60_A
>> +       * 59_A
>> +       * 58_B
>> +       * 58_A
>> +       EOF
>> +'
>> +
>> +test_expect_success '--graph-indent forces indentation when graph.inden=
t is unset' '
>> +       test_config log.graphIndent false &&
>> +       lib_test_check_graph --graph-indent _58 _59 _60 _61 _62 _63 _64 =
_65 _66 _67 <<-\EOF
>> +       * 67_A
>> +         * 66_A
>> +           * 65_A
>> +             * 64_A
>> +       * 63_A
>> +         * 62_A
>> +           * 61_A
>> +             * 60_A
>> +         * 59_A
>> +       * 58_B
>> +       * 58_A
>> +       EOF
>> +'
>> +
>> +# graph.indent true and no --option is the default state.
>
> Same thing here.

Will fix it.

Thanks for the review,
Pablo

