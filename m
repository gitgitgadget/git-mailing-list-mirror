Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4540683F
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784846451; cv=none; b=pP/0fssbbz7Jq9yzzkBQ81CU80EYPlncF4dK5U8WJNkF0ujTtWtPJw0FuYalAJ4+1AhCf099prKAcZAThPHranFcTPilaah+7+efyLBV0SpLqDboFbyhey2BDrvWAZHWzcekufW5COr7mgrlkS+37M+cpzy5aE1ZXIJclSrs6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784846451; c=relaxed/simple;
	bh=s4r5keHRG+/55gNK3o/9vFWZPL1u2zw7Gxp0K22YUgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2OqYSbxZk19Fk/r1/Bi9y2fTUsW7MeW//7lHZhXk3GypRFUVWwPxfrWeWj2fK4TFjvQgMmDRRtnGWKHV99/LHe9aqosoaOSEOog4n9zwf7zDgjuGXzLuL0gbTPxtt9TX3y35vlHi+qsWgA7Iuhfu2NaOyV6Fz0wv5MnCJRvb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SS8IEg8B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMZUiNoU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SS8IEg8B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMZUiNoU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C91A31D002B3;
	Thu, 23 Jul 2026 18:40:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 18:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784846448; x=1784932848; bh=tCJB0ZMzt9
	V4Nzw/nGGB2/p9TwNEWgEEN0ZPohPss48=; b=SS8IEg8BAykBz/ykfqv415IHGt
	PD3HIuxuyoroyYPZllAkER81Y2hhy3sEVvlSe46Xfgj6znLkPP7C1F3o9hQY1nLS
	6AaCIll9R7JZUGYyrY7/Tr1Z0LWdXfkjR5Fssy7IJoJdJd0RtzVzt09/SBiWSKnz
	AIzdvq9HYCUNr1r+ISJJt/L6Z1jEf8lfUURrc07sChqLXa4cMK/3iOlzKo6JErws
	RhRmtK5eYTcTx2bt84fQCJ2u+l5InZPf5DGLU4MDfhfAAAnvtIUh4/pGTG6tOads
	kjUg2HZ6T/UGGAhym0Ki/IWVdjraAYjIHBtxt+12X1yuii6sYS2MrLCn+Gaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784846448; x=1784932848; bh=tCJB0ZMzt9V4Nzw/nGGB2/p9TwNEWgEEN0Z
	PohPss48=; b=OMZUiNoUrSCGea8Crjp9VGh8Wbt8Nu+JzkqzARRXetc/qcnAJvM
	DvqpBLgSrBLv8kKyfFMNaTdMlhxXe36ONPIcPLTLylt7AJ1M4pkTtrj5rOdUd4rj
	s/93lMosl8p9gxoBAFafL0I4RvIigmV3AET7j+qHkTIOaRmBW5aJwIENkF+p+hlr
	uiwu6foHfqCtWGfcoLGOScv7qTPaWB9eW0CHIipEOmCdjOSZ1wsPUStkrIf3tf+B
	V9AgxpFfIH+2rXHAVR5HgfQGoA3sO3nRGLYUcPSJFga7Racc7cpXK8Yx3Va2Wp4l
	btGcI+QlynkHeQ8/JXp6eL37jZo1jcNXc9Q==
X-ME-Sender: <xms:cJhialy3kf-dbMJPb0QhAOme6gavQK0PPB9d6z3gNmM_MeE2ClgX_g>
    <xme:cJhiasKgxKeC-4JNcDPZouHHrJdpa7Q90ZW7LeokGTNpacp6ucBuz14KVkGFaUjCW
    FbLh4ARjT0l4ij4Bvkr_rzMZ5rMZF8X3iY4argVb0EDSxZmn3Ke>
X-ME-Received: <xmr:cJhianpRESnQtwB5O8jakkczY3GQofovM7HlEaAdlkGKVv_LyliOka_a7qfdebJu4NVL-2zlb6c291Dnp4r6cMLWWnR0BQlSeQ>
X-ME-Proxy-Cause: dmFkZTFQmVYjiFb7j04t04jXSocvoIenW+5J1o4s2OibEKhxLJ/U72cJDQLQYfzs9OTKfg
    p3lJrCB0af77ASNzMhDtV2WcrW3blnXDB22bhtP5/EI9cstUHONqx05nvFkqRQBOvBvUbb
    aRM8BANLR5fLIIih+RbX+GQSAviQavuqQXQ5MgeVsAmeYbTBI76lorsrxRzKFjmF2PhmVU
    qrUIuLH7EvKgPqHl09Y5Jup5WkqGiOvnZqVumAImZXZ1VJTOh8mWZNclYmVoBxzk1Bj5v5
    FE+siP8aJ7I5EunjvqUz59uMUdcM6aF7BCnKlsAe8K+y/QKDJ/7rtYqLv+opf/3nlLY9Rm
    HTZjXdoVnaWBQOmJ0pXB796P5FLg43VEagb2aujZ1vRSKS49R4d9utFXHuFjrv6ZWuY7jg
    0rtsW8J3vDzxS0YkNwHM2+/imMYbJCo+pRg+JBOmURmN74EBaGE1eNqDPQ/1anVLX/HETI
    ekzbEX+iIFxlrEXharqjnIbfjWLbpkwfMXOdWDveU+TLKkNKVbny49hxEDvyLJzdkma3lC
    WUV1L3szqBqOpEnX8nVMY2pL2WrfrUDxhp2dZS+JnYLyRbE4aiPIHx8fyP+PkSAZ/ezKRf
    jeX4qRb0zD3f/auMmRHWEFqhM4EjyQupZlEti6G0r+isgwZGsqs2sp6IH7tg
X-ME-Proxy: <xmx:cJhiajJ3rHmLeU0NkEEuMuf3xB2LFkbrm_IbKwM0TIwo9HfVMEeVgg>
    <xmx:cJhiakRpszQIAUYA2uWlR1dwxm_Qv4hjSXI2p4CxSEN6-poqY7KVsA>
    <xmx:cJhiaqtDo6ffcbDOamVxR2f8_CHhgUz4vzoP3VZKnxyl28xTpxptfA>
    <xmx:cJhiata5LBF5WRYbwqKx59H9rcMWXM0FPqdpld88ICGeKi-3DBViUA>
    <xmx:cJhiauYL40GyAJF_ezQMdCeZ8l72BOR4mNX_EfJs_6AejfTuPdCNRGFK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 18:40:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Zamboni Orioli <lucaszam0@gmail.com>
Cc: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/2] mv: check for missing destination directory
 before renaming
In-Reply-To: <CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
	(Lucas Zamboni Orioli's message of "Thu, 23 Jul 2026 18:38:18 -0300")
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
	<pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<1a790e001610d3324ec45d86ac67ca5720678cb8.1784812390.git.gitgitgadget@gmail.com>
	<xmqqo6fximn2.fsf@gitster.g>
	<CAH01Q-_2APONq2fXmjF=Wo08rTzScMEjyXL-G=_GH6TbjJmTBw@mail.gmail.com>
Date: Thu, 23 Jul 2026 15:40:46 -0700
Message-ID: <xmqqldb1cosx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Zamboni Orioli <lucaszam0@gmail.com> writes:

>> lstat() can succeed and 'dir_st' may indicate something other than a
>> directory (for example, a symbolic link or a regular file).
>> Alternatively, it can fail with ENOTDIR when, for example, 'dst_dir'
>> is 'a/b/c' and 'a/b' is a file rather than a directory.
>>
>> Both cases will cause 'git mv' into a path assumed to be a directory
>> to fail.  Shouldn't we handle these conditions as well?
>
> Yes, agreed, both should be handled. For v3 I switched from lstat()
> to stat() so that the check follows symlinks the same way rename()
> does, and I handle the non-directory cases:

Generally, a symbolic link in a Git-managed working tree should
not be followed.  Following a symbolic link would mean that
'git mv x y' could move 'x' outside the working tree if 'y' is
a tracked symbolic link pointing to a directory outside the
working tree.  "git apply" for example avoids being fooled by a
symbolic link for the same reason, for example.

I doubt that using stat() instead of lstat() is the right
approach.  Doing so essentially amounts to ignoring the
presence of symbolic links.
