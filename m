Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0217E4
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195271; cv=none; b=r2JT598o/TbHFsBfRyQE1mqgeyfomfIMWAByPiOcTmlWAW1CzW8VFNX85YjFUMN7Ox/MtvAZJ7Js33Hi35k98Rc4bFXPc8JH4wO0KrWLf6EB/9i+Uh6k6N1XJN5mNL+Y/3a0p7daoq1h+jT+OylZI+y8ftNWJU6kDimcehWZrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195271; c=relaxed/simple;
	bh=NNfHmnMILvJV+IbGgXJmSIyIe1e31Bn0jB+7xY0WHZc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NBJy8MIDosm9P9xg8Vh7Hplik3gsWHkRE7vWMklaWSmaqdNAJqiM1iSJbOmynQYwR+jJ+kWFYNId6ynLtCD6TRrXwGO13lMiXpSSi/ylP1ceB0HVZePmYXgOfdPbtf0Gy7t6gYb9iztrVfYOhf6lhQ7GdAdCbrB5hvpV2Es1xOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz16t1749195122t150750e2
X-QQ-Originating-IP: 47nNTtpEIDmsWAsuumyvxI3LCfddObH0qLaKMGXJ+wA=
Received: from smtpclient.apple ( [36.152.24.182])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Jun 2025 15:32:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16201199702573377203
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] revision: fix memory leak in prepare_show_merge()
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqmsal7vqx.fsf@gitster.g>
Date: Fri, 6 Jun 2025 15:31:52 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <90FE268F-2309-49F0-9C3B-DFB207CE6F47@smail.nju.edu.cn>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
 <aD_6T0lUOsqrb5sH@pks.im> <xmqqmsal7vqx.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nwz8Cs33/LprHTJOIX3e4DrfCP1czYQoCSN7K1+KIdFRUUQhFMXKE/g9
	ezG0sLFBrty5i/bA7C1rTNP5M4t70iyyZ93U+nzRD2HzS16ASqOE6ijXuSKPHjCvNgY9gim
	/JAEviHNXZ/LAsr7eTCZelgkjBzegzrC4w5Mu3eFxph4HUnCYncREm94W50pT8VqDEWNtfp
	5lHkRT5XQ5oFlmkNqOmZ0Y8vY96dcrewR3YO+K95MJ7h0Gv6BcNGfIrsM48zTtdOvRjK1lV
	NExPtLvAc9qDm6YQyKKjQ0EP2j3FoZbNc/F58f1+HZvuAB1HKOODRVb+raAAQuO7PVUMw51
	q9870IT2iH4iG8xRXfQPKCjreZMF5mCFyf5Ak8mGvxnb+klfvxhtkx1a2tvxi32Mgvx+XbP
	cW19nL/wJuIU4MdFdYhf/kwBg3xxYILr6LP89ZVYvGuf7kHMNdqdfB4rP0w0/yqpCR6VXUT
	3MKvHk8Stscs15tNaPJzNfP23JvuxbK8Y1wU6IukzbP/zIb2snTauRTM7GUgR7B6DQXmzDS
	BNVB2FNzx3QYhWccItueunJA5nLcZ/krR6ZJbAikeZ2Mc958M9gh4weEEy0niaDsPyxzgse
	2WYX9u5ezG0xIZCBolU3QyHxPqWWAFETUfPIaWe41l17oIl49VtA/iCbtoy62C4D/YkjQ+J
	OelfkD3bbV3aAeyhUuhKjJAvSgXesvwumUtv4XwwqTZ6RrNckwH6uO77XbfKeXUxtCWw56n
	bomeur5Yjrua5nZ0Nme9n9FngimKVk2cH6EI3fbQCz57uo0paG8jePidtkpEHqnbGje+1PF
	7qMfbmJ/iaPSFIH7LsnqwNnCHVSqV4njiVxJ50Uy1G4AuauPO8BZo9SbwX8mhpxi1AtwATv
	3EGV2Bpn7nETzwWMy5Bj1zPeFSsvt5YSThXtHGZAp/FThO0lfC2i/tfJlharW6H2qu8luuo
	SOJuAEWitYIugKFsUaX0LWieRR7EyQJ002iPagx393Ii7sc+x0v+UKgXpSX+J13g7odYHMm
	yvV8GRMCAwiyfNlIgU
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B46=E6=9C=886=E6=97=A5 04:56=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
>> On Wed, Jun 04, 2025 at 03:08:56AM +0000, Lidong Yan via GitGitGadget =
wrote:
>>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>>=20
>>> In revision.c:prepare_show_merge(), we allocated an array in prune
>>> but forget to free it. Since parse_pathspec is not responsible to
>>> free prune, we should add `free(prune)` in the end of =
prepare_show_merge().
>>=20
>> That is a rather obvious memory leak indeed. Do you know why we never
>> detected the leak in our CI? Is this code path not exercised at all =
by
>> our tests?
>=20
> I think we have no "show --merge" test.  Something like this may be
> minimally sufficient.
>=20
> t/t7007-show.sh | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git c/t/t7007-show.sh w/t/t7007-show.sh
> index d6cc69e0f2..99f4d0b963 100755
> --- c/t/t7007-show.sh
> +++ w/t/t7007-show.sh
> @@ -167,4 +167,19 @@ test_expect_success 'show --graph is forbidden' '
>   test_must_fail git show --graph HEAD
> '
>=20
> +test_expect_success 'unmerged index' '
> + git reset --hard &&
> + git commit --allow-empty -m initial &&
> + git rev-parse HEAD >.git/MERGE_HEAD &&
> + blob1=3D$(echo hello | git hash-object -w --stdin) &&
> + blob2=3D$(echo goodbye | git hash-object -w --stdin) &&
> + blob3=3D$(echo world | git hash-object -w --stdin) &&
> + git update-index --add --index-info <<-EOF &&
> + 100644 $blob1 1 conflicting
> + 100644 $blob2 2 conflicting
> + 100755 $blob3 3 conflicting
> + EOF
> + git show --merge HEAD
> +'
> +
> test_done
>=20

I could add this test case into my patch. Though I don=E2=80=99t =
understand
> + git rev-parse HEAD >.git/MERGE_HEAD &&

If HEAD is equal to MERGE_HEAD. Would git show =E2=80=94merge still
works as usual? How about something like this

diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index d6cc69e0f2..f693b6e24b 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -167,4 +167,28 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
=20
+test_expect_success 'unmerged index' '
+       git reset --hard &&
+
+       git switch -C base &&
+       echo "base" > conflicting &&
+       git add conflicting &&
+       git commit -m "base" &&
+
+       git branch hello &&
+       git branch goodbye &&
+
+       git switch hello &&
+       echo "hello" > conflicting &&
+       git commit -am "hello" &&
+
+       git switch goodbye &&
+       echo "goodbye" > conflicting &&
+       git commit -am "goodbye" &&
+
+       git switch hello &&
+       test_must_fail git merge goodbye &&
+       git show --merge HEAD
+'
+
 test_done

