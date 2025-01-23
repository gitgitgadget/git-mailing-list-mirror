Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE813D520
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668891; cv=none; b=OGV5Nh9Nl0d50J8QKastvNUAT8S3mBnm1D/LaHemOYLIQdLbZe6ELKI32kpzV+oo6lfsGK++mTPyd7TqhbRPVx1Ozhl+s9noPHH6LbE1O4cTfIZSIAu7H/dM90+DNrQG82QCP5Hfdmvb+g7JNKz1xcQJVYCk+GjTiWLsEYgq5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668891; c=relaxed/simple;
	bh=9C3ewpPeJlH4VlTQsJGLdXm6Xj+HKaymLJcSxueJwLo=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=BZSIGxJ1AO+n5ODsdyzLiFX71CjzF6BMTDob6NkWU9U3ac3HxYBNTmveifs6OknhQYgk1ILWZJTduiw2jpsq3WVL9WUhDjHiW4+cvvhv0dysy8ZFelVsTKEz3ncw+pbmQwqO+blrEHEL2PA6owywQ/dWXNiHNv/8H489M5+hhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=VwBh/+K8; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="VwBh/+K8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=cvCdvsjXrHnvVHk1aDTtCVoMgL9uucI2eWWQ/ghqm7E=;
 b=VwBh/+K8APm2ZLL49Eox4Umb3MPuTwV7Ni4XltG69sbcs7rfyNw9Vmc+q2QLKrESJLfeDOB+QbXi
   unZLBBz9z9DK3mfeqsNWxZrQL/wYaTNzHhLHQC2hWn32YZnjFWtBF7q79VKyLJacns24HVCGeTxU
   W7UjUTaMpfYeOs2f/yyeKV3z/x7IBx1cmGdscllkB1p1VshGBVh/baPByzeh6kUs1CeqJhxAE+72
   xkOvzXWUZ3HhrIGPE4nlXveJmnn6QSqpEN65Fp/aui/mfGZgIkNJR4g/NQixgUXWISk3DRsHzYPd
   v7PIBFjmVEghHwi+e/R4eu64n9TLn01EkJVodw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQK005EI9NJ7F80@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 23 Jan 2025 21:42:55 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 22:42:23 +0100
Message-id: <D79S38LX7NLS.34MN1BWV0HVJ0@ferdinandy.com>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare repositories
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Christian Hesse" <mail@eworm.de>,
 "Christian Hesse" <list@eworm.de>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20250111202628.0e5894e4@leda.eworm.net>
 <20250112165125.130400-1-bence@ferdinandy.com> <xmqqr04tqm86.fsf@gitster.g>
In-reply-to: <xmqqr04tqm86.fsf@gitster.g>
Reporting-Meta:
 AAGqQ6FpNX794oUyaAb/ZHrG1noQmZEJ4+k86DIwU2L3cqSedU8AEEt1TY4LV+WR
 CFYt9uZ6r+AFI2WAGf5m+jrwk7fIIB6HFwOjsdqzO411gEvfzm8DXUqzrbaQe3zU
 crqpMhFKS5I5Allx05MyTbDXI50TrwQPJ1Ny22LByOGM3gabHm7W4C0UvNAKx70w
 /x4OCB4WTt4eAxmHGnhXoUlNng5PL+U6RLZE87jF7/21YLW72Hna8ySLt2ny2pry
 9AAxNCjY7lc9DzoTivahVs1QqCJC7JFT+sFY111QBGVs+sW4BEQX9EmKbvmBpzUK
 dBLyJvnXfKa/uWXwmptgDYIJiXKt6BADJALFXqqlG/CUU1ErC1TSroEg9I1GDpen
 XNeUlbneU5wckjwBpVyVEz3UINuz11caj/poJbARuRd8S9hlhn8be0F79Y94p51Y
 vmLIVMZffiqBdg+ltiQ2Csa6J71jUOim7vXuJhcv2YP6846F8tI/MIyS


On Thu Jan 23, 2025 at 22:00, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> In b1b713f722 (fetch set_head: handle mirrored bare repositories,
>> 2024-11-22) it was implicitly assumed that all remotes will be mirrors
>> in a bare repository, thus fetching a non-mirrored remote could lead to
>> HEAD pointing to a non-existent reference. Make sure we only overwrite
>> HEAD if we are in a bare repository and fetching from a mirror.
>> Otherwise, proceed as normally, and create
>> refs/remotes/<nonmirrorremote>/HEAD instead.
>>
>> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>> Reported-by: Christian Hesse <list@eworm.de>
>
> These should be chronological; somebody reports an issue, the patch
> gets written, and finally it is sent out with a Sign-off to certify
> that the patch is not a stolen property.

Makes sense, I'll send a v2 in that case.

>
>> ---
>>  builtin/fetch.c   | 15 ++++++++-------
>>  t/t5505-remote.sh | 10 ++++++++++
>>  t/t5510-fetch.sh  | 13 +++++++++++++
>>  3 files changed, 31 insertions(+), 7 deletions(-)
>
> We haven't heard from Chritian; has this been tested OK?

To the extent of the tests I've added, but I'm not aware of anybody else,
especially Christian trying it out.

>
> What the patch does does look sensible.  Thanks.

Thanks,
Bence
