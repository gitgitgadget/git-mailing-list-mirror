Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8295317153
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774659784; cv=none; b=TejPSjT/5MdMwnbSmK9L4zGyLL2K/YEIi45dTBtlr25SGEEFMo5TSdu+rEMcZsWbFVHVBPwCuhMipKBpaKcHESDdatK7Q89pETNYzGq+YKkP7Z39Vkx8/cCej51NWJ5oZFf1lVAGXJp5d6SyvZkR92DXuTC6UKJFjuZJktfogyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774659784; c=relaxed/simple;
	bh=r4VASTXUvRbRS9S8oWdvnZ5DbflUooqQSpyS/Zwn1Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UtU9ij76MxbCm1VkNUAolA2ZLHe1ktnwPtzP8fyC+z8MamPAzMcjyX/DMSXfqHnxZI/53pVry8MOMCLaGuHzcP2qofoYV2tJ/iyH+SV5JxnVtM20Ud4pFh/HkzwUgVTB8v2bRjC+IHCE8Sm455Cfu0Y8tBTbTAL3nOj4XmjKmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fjK4c3gDdz9tSN;
	Sat, 28 Mar 2026 02:02:56 +0100 (CET)
Message-ID: <8c6cb953-e4b5-40c2-9fc3-734ffee7f313@opperschaap.net>
Date: Fri, 27 Mar 2026 21:02:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Johannes Sixt <j6t@kdbg.org>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org> <xmqqbjg9mex2.fsf@gitster.g>
 <09c5fe7d-8379-4f68-bf1c-9869e2924cb8@opperschaap.net>
 <acb_SQ8gdy-fQaFj@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Wesley <wesleys@opperschaap.net>
In-Reply-To: <acb_SQ8gdy-fQaFj@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 18:06, brian m. carlson wrote:
> On 2026-03-27 at 16:49:35, Wesley wrote:
>> On 3/27/26 12:10, Junio C Hamano wrote:
>>
>>> I somehow thought that this practice is so widespread that it was
>>> one of the few first things any new people learn to do, but perhaps
>>> we do not have a good documentation coverage?
>>
>> As said before it is weird thing to configure a global ssh configuration
>> just for git transport. It doesn't make much sense.
>>
>> The problem with ssh_config usage is that you need to change your ssh
>> config, which is machine global, not just git. And not portable across teams
>> with configurations committed to git. Myrepos is a good example of this. My
>> former employer had this and I know the Perl metacpan project also uses
>> mysrepos. Changing every URL dynamically in committed configs isn't really a
>> nice ask.
> 
> You can also use the conditional inclusion functionality to rewrite URLs
> for repositories in a certain directory with `url.<URL>.insteadOf`.  Or
> you can use conditional inclusion to use `core.sshCommand` with the `-i`
> option set appropriately.

That is what I did and why I thought a simple addition in git would make 
it declarative in git via its configuration. This would limit the 
scripting side for just adding "this identityFile should be used in this 
repo" or "this remote". Including allowing setting sshOpts for specific 
remotes and/or repos.

Cheers,
Wesley

-- 
Wesley

Why not both?
