Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B204168AE9
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972926; cv=none; b=DT49Z3m38ZQyKb+SUyvwi9R9S0dso9z9dHFtoGVIft1G2YkA5qJcsKyxCNwdMGjJvApAIQjqO7jNg3F5MQrXcNzBtFkGRjZc5+SIlhIaDBpAXExZa1CXuVDDMIBSIBv0U2lOm2nOz7ELih6n5Qgycvvx2XFo3sKwS3KFPgtfa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972926; c=relaxed/simple;
	bh=mP8beVR/L4xl3s7Nome/61IZMOBFd/Z24d/uD1FnqSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LUbMNSAs0uwNgxTWFjXgdUtzWyV280/0fJ0GfeUadifYnCADgC0pJNNSr3w4Wo1m5p1vPKwpIYfghNfYwErDCZYGEax8VO4jIuR79gfQ+jWgAEsG6GSZbdxM/dgBj0jJzWtK3MLsuwU23f9L7VZ+Vu5BY51rnESn/ZsiTvmUZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tczVfRux; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tczVfRux"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BACF1FF5D;
	Wed, 24 Apr 2024 11:35:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mP8beVR/L4xl
	3s7Nome/61IZMOBFd/Z24d/uD1FnqSY=; b=tczVfRuxe7bd1x2tLAZ8yEHGc55G
	JkzJI6C2df3JyLn6iQw3A4dTLc5NIgo5/ecTDsXVmMLOzypiIBzfjm93EqYdoQ/4
	EGy6T3cyPEV9f56OJcFyL0p0X90LymEyFVhgFsCNRY7ju0EUbeux6LIWxtKiPPXQ
	D0tSLe81tT8vG4c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 518D51FF5C;
	Wed, 24 Apr 2024 11:35:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE93B1FF5B;
	Wed, 24 Apr 2024 11:35:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <41d23496-0bd3-47c7-a470-39334588f520@gmail.com> (phillip's
	message of "Wed, 24 Apr 2024 11:15:57 +0100")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<xmqqv849xups.fsf@gitster.g>
	<41d23496-0bd3-47c7-a470-39334588f520@gmail.com>
Date: Wed, 24 Apr 2024 08:35:21 -0700
Message-ID: <xmqqfrva22py.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 43A54C14-0250-11EF-8869-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

phillip.wood123@gmail.com writes:

> On 22/04/2024 16:50, Junio C Hamano wrote:
>> Rub=C3=A9n Justo <rjusto@gmail.com> writes:
>>=20
>>> 1:  0317594bce ! 1:  b418b03f15 add-patch: response to unknown comman=
d
>>>      @@ t/t3701-add-interactive.sh: test_expect_success 'warn about a=
dd.interactive.useB
>>>       +	test_when_finished "git reset --hard; rm -f command" &&
>>>       +	echo W >command &&
>>>       +	git add -N command &&
>>>      -+	cat >expect <<-EOF &&
>>>      -+	diff --git a/command b/command
>>>      -+	new file mode 100644
>>>      -+	index 0000000..a42d8ff
>>>      -+	--- /dev/null
>>>      -+	+++ b/command
>>>      -+	@@ -0,0 +1 @@
>>>      -+	+W
>>>      ++	git diff command >expect &&
>>>      ++	cat >>expect <<-EOF &&
>>>       +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}=
W${SQ} (use ${SQ}?${SQ} for help)
>>>       +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
>>>       +	EOF
>> Interesting.
>> My first reaction was "how is this different from checking just the
>> last line of the actual output?  The early part of expect and actual
>> both come from an internal invocation of 'git diff', and they must
>> match by definition".
>> But that may really be the point of this test.
>
> Yes - we want to make sure that we are not printing the help and the
> only way to do that is to check the whole output

I was not questioning that part of the patch.  "My first reaction"
was solely about use of "git diff" to replace the golden copy of
expected result in the test itself, only to allow for use of
different hash functions.  As you (or somebody else?) mentioned in
an earlier review, diff_cmp is there for exactly that purpose.

>> That is, we may later decide to tweak the way "git diff" hunks are
>> presented, and we expect that the way "git add -p" presents the
>> hunks would change together with it automatically.

This argument cuts both ways, by the way.

Insisting that the output match the explicit expectation (not what
"git diff" of the day produces) has a few advantages.  It makes the
test more explicit and easy to see what output we are expecting, and
more importantly, it forces us to update the test when we decide to
tweak the output from the command being tested (i.e. hunk selection
UI) and/or the output from "git diff" command.
