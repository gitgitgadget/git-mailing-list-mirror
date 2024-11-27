Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECE13B588
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686630; cv=none; b=dmSFq7X/pOlAxCpfUSzuyJ+dSNI4YJTGwQFHdkDaoK2Yskr2+WaxMqedCLn2bsXTj8AlgF5hFlgRVVDrFY95ObCempwkDQoH7vSTXjBOvCRWGAOZ6nik+NExXMfKPI7q4XQyQwhuXll7PFbyVMpevhqB7qxWzz4VkDFDACAIQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686630; c=relaxed/simple;
	bh=L3qBb+FD6aDIOcFo3AYlUkgpnGfZ6zzKCn5v5YF7Ki4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjCtv+x/UuXrWoEUj/Y1ewITkY456q9ORvOsLb56ejhMCuQZR4cd0/MQeUbrjNLmeRQ2Dp7ghtUvfVh6aHvTN6ZmA/UkcPM/B9cNyzKmCRphmBhxthr4YDWCN5ZN81qKM1CCVCu+fffBzYwwWn3NwsVFYXuZ3QYD7NtNIW+8eP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FtsT8Jwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tE5rlRJu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FtsT8Jwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tE5rlRJu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3B831140191;
	Wed, 27 Nov 2024 00:50:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 27 Nov 2024 00:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732686626; x=1732773026; bh=VF/Sbm9Rbx
	z93fhGdCbIOQGuU2JDTy6bkMAiUfNs7kc=; b=FtsT8JwzmckPrLqrdzwxATTZFK
	PknPToYDEwYovnTYWQh7FUG9VMj7ANpYBVG2BwOeJIBn4IL3bVxjUHCd6pVcwslI
	0p1E3LRc25Wl7veAGO9gl8E0TDkTGrCGgpN5W182FufRpX/FZIE+6GYq/0DPL/HN
	iyPi0NA2a8OvbLh8vtx31RWRLIzzsssPBpXTDSeeZH1kzPhCDq2qjfWpqvK2HnUj
	uB9YBb7JGaFv1CNbaimvK7zcCFffsc+yw4gkog5nJJ+dLu3HfGfUXVYN8Z2fhpCg
	n22Ns83zFQyItPPrUg34tFSjFL2yV/Y60/FRAMK4I9XaIHm7rKsDV6xXg1qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732686626; x=1732773026; bh=VF/Sbm9Rbxz93fhGdCbIOQGuU2JDTy6bkMA
	iUfNs7kc=; b=tE5rlRJuB9a8XPKSW7EoFdr8V8vYYEn1Ljk8zoCjxvGwDog26RR
	MhBbwF97PLGEPUN/ytfN+zAkuNGTFtyizyVW6eDvawr0juRt25ptukX6rlUu6LxX
	MpC8Dtl9dl6YuN6y2R+vTkoPIF85em0CdHJIisBW8q5sY7jfmf+i6y5uZFMkPjFB
	98bpOmMXrXZy0JwgOSKYwm5SW/7ll/XS6y5cuTBKiS6VnnAXpm08jtFoldeqU4zF
	45KsfUxo+/7gsZSvOfsUNvhJqwKr5by1PnMCZK4SpgTPrGN9Ds6F0K2wczxszwra
	bX3gKFMiKdPxAh17M57ELBWe73o1N+JfQbw==
X-ME-Sender: <xms:IrNGZ3LMMbb2uM7r10ZEPgVUKruTjsM5-u0iGn2-dY50j3gpDYdi8A>
    <xme:IrNGZ7KU8O0YSV7-ajo8ImCa5PtMuDIqwOGZs6oJasGMkrxmrrbrHCGL46xc5Pji5
    _MFTrcNwY6vkQByvg>
X-ME-Received: <xmr:IrNGZ_uTf9ze7moE-CBHCBaqWR1xpXbxsCaJ_DggjZ0i3yRRCZctcMBPrdZOVUHI30Nn_WoF2V1fYYi76m9fmQMMY_J4TS-1__T9IEL8P-Qtgig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IrNGZwbwjNsZOJm0bCfJQFf3i92U1k9R-kPG3EHjDtJEORdrnS1J6Q>
    <xmx:IrNGZ-Zac9CLImlBOw_IMNnG3upsxvp6owPZqIWPPnEL-qg3cBYJUQ>
    <xmx:IrNGZ0D0tiWKL7eO5iRUfkYWxroSh17_uU-CO5rmvPzWk5v5DZBIHQ>
    <xmx:IrNGZ8YQ9YuedWXfvXRgISc97K8c-D5GQq4YIbihrqvdCCacIiBl_w>
    <xmx:IrNGZ1xC5lPYyItaIURT2QvWtusVz0ZTWaRfyyr1fwtURuw7z5Ko8nxo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 00:50:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 75490c8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Nov 2024 05:49:19 +0000 (UTC)
Date: Wed, 27 Nov 2024 06:50:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-cache: fix invalid free operation in `free_ref_entry`
Message-ID: <Z0azEzigqr6DlitP@pks.im>
References: <Z0Xd-cYPNNrxwuAB@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Xd-cYPNNrxwuAB@ArchLinux>

On Tue, Nov 26, 2024 at 10:40:57PM +0800, shejialuo wrote:
> In cfd971520e (refs: keep track of unresolved reference value in
> iterators, 2024-08-09), we added a new field "referent" into the "struct
> ref" structure. In order to free the "referent", we unconditionally
> freed the "referent" by simply adding a "free" statement.
> 
> However, this is a bad usage. Because when ref entry is either directory
> or loose ref, we will always execute the following statement:
> 
>   free(entry->u.value.referent);
> 
> This does not make sense. We should never access the "entry->u.value"
> field when "entry" is a directory. However, the change obviously doesn't
> break the tests. Let's analysis why.
> 
> The anonymous union in the "ref_entry" has two members: one is "struct
> ref_value", another is "struct ref_dir". On a 64-bit machine, the size
> of "struct ref_dir" is 32 bytes, which is smaller than the 48-byte size
> of "struct ref_value". And the offset of "referent" field in "struct
> ref_value" is 40 bytes. So, whenever we create a new "ref_entry" for a
> directory, we will leave the offset from 40 bytes to 48 bytes untouched,
> which means the value for this memory is zero (NULL). It's OK to free a
> NULL pointer, but this is merely a coincidence of memory layout.

Makes sense.

> To fix this issue, we now ensure that "free(entry->u.value.referent)" is
> only called when "entry->flag" indicates that it represents a loose
> reference and not a directory to avoid the invalid memory operation.
> 
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/ref-cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 35bae7e05d..02f09e4df8 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -68,8 +68,9 @@ static void free_ref_entry(struct ref_entry *entry)
>  		 * trigger the reading of loose refs.
>  		 */
>  		clear_ref_dir(&entry->u.subdir);
> +	} else {
> +		free(entry->u.value.referent);
>  	}
> -	free(entry->u.value.referent);
>  	free(entry);
>  }

And the fix looks obviously good to me.

Thanks for catching this!

Patrick
