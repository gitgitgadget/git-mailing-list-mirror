Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339652;
	b=TA6eXoqVllGp5dY/G9U2a2LWXbwklQ8cXQsYcaKD8PG0JxOb/ej3SU6SDaHV4GWe7/w2
	 GFjmToj/3l9WTOclTjgxZO8demmBzO0UA4bHjKwoURROcnfd8zl9ITOx+1q4lPyHceO75
	 vKNzCBhaleZFQQm8PlE4/xQPPLLFcU+Fom0hxE+wYu/qxLhKaHucULPBDvhkY0nIUFE7c
	 zsF0hdH/n+1lCNpOq+sm9a/497uSChfDo2kdfc4mOkqPq2+5455FyerOk2gJMVyV4gxBs
	 b2D8AYnOV4kNQfJKqgz1Y/wPywFNpXXc+NZL4lIYjfmol7cMqQDUA7lxXVOcBOGbzmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339652;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=/7uBAu8Xjdtumm+uy3P1/c3RsGQeCjo6Eg5PqwHdo30=;
	b=gtJOhyq3KCjTTdJL3NDELBXCXW0XAjZwJyNExVMH2WI/s2x8AdFhc9iFKG4h7tln+syT
	 /AmxqulSjopqfDSWn+ntn1U38slqOIKUMvd/WjlyhZacSyBiaii4dsMvD9HQW/vEgqHs9
	 LDE9aq0iYqsUnoohnB+0ZWkydtP5I1cA4YvONiWjU4hvcrBC5LujGWbHvg9VzGPlA3XCF
	 nPGN8502lWlJFSxmiAZFIJNgIJlTUQrfNMbOoN0oS21ofVGbqXnqzi2gi3PlG2g/dd3Gw
	 jTsHEZpaKXWziqForcq9+gQQJ2hrwWETZbJPm3Xi7fCzyuHAtGXibdYarnPIPAOgwuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=d8AyZXmJ;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAA606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAAA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=d8AyZXmJ
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AM9RPqG2216832
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 10:27:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795339646; bh=/7uBAu8Xjdtumm+uy3P1/c3RsGQeCjo6Eg5PqwHdo30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=d8AyZXmJl+G5561D4N9Jg3LODF3kS2XqpaXv3TeFesT4XfMXNQaJl14voqlqAnMgI
	 Qo2hh+xxkf16O7B97BtQdh46GWf/mMb8QwTxxz5nin96eIKbKP+2DBHfxU0rw9An29
	 1y39GYhRYTTRD63AT15JfcKdinT81Fot7DaFiTtY=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/5] utf8: introduce bounds for
 display_mode_esc_sequence_len()
In-Reply-To: <CAHWeT-bkoGXYRv3hWTB1LhGctVF9gcQO5cw_+nz4gXosCywwEg@mail.gmail.com>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
	<20261120-master-v4-1-5ff523db7285@gouders.net>
	<CAHWeT-bkoGXYRv3hWTB1LhGctVF9gcQO5cw_+nz4gXosCywwEg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 10:27:25 +0100
Message-ID: <ghld6lmd1e.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 22 2026, Andy Koppe wrote:

> On Fri, 20 Nov 2026 at 15:11, Dirk Gouders wrote:
>> +void test_utf8_ansi__sgr_len_end_ptr(void)
>> +{
>> +       char *sgr_1 = (char *)"\033[m";
>> +       char *sgr_2 = (char *)"\033[31m";
>> +       char *sgr_3 = (char *)"\033[31;m";
>> +       char *sgr_4 = (char *)"\033[31;0m";
>> +
>> +       cl_assert_equal_i(0, display_mode_esc_sequence_len("", ""));
>
> Strictly speaking, that's undefined behaviour, because it makes
> display_mode_esc_sequence_len() compare pointers to different objects.
> In practice, the compiler will pass a pointer to the same empty string
> for both arguments, but the test should not rely on that.
>
>> +       cl_assert_equal_i(6, display_mode_esc_sequence_len(sgr_3, sgr_3 + sizeof(sgr_3) - 1));
>> +       cl_assert_equal_i(7, display_mode_esc_sequence_len(sgr_4, sgr_4 + sizeof(sgr_4) - 1));
>
> Those sizeofs return the sizes of the pointers rather than the strings
> as intended. (And the lines are a bit long.)

Thank you, all of these will be fixed.

Dirk
