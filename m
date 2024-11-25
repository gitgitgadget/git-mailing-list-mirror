Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AF190662
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528315; cv=none; b=nSr44BlTTYOlHKhsp3oum6/YwcZ9TUDqvq6qHddfzNY07IJSYuYOr8qcvhSuxA2XpltokdKW/IPW0vQ9P2pCWFoAUyirCoqEtd1en/suf/VZuAiy9xcEzhQQlpBV9nCD5sxdXE+XrqPp3ZyEKHEedOgK5uWZ5uU8HXU9gLf1JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528315; c=relaxed/simple;
	bh=0sIEoTiX0HbXA9A48NJip3o5I0u7pvBFqIbgk5qO7SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW4i2PtHxiVxr2w+Q1RaUNvQGJp7F4S5sqADdNnapGUq8e4eAJRcunF5DtnwfgaHWbRVZiTTY/sNMqFgEwyNEc19cO4gZ3aNpK5BohhTnlDQ0sXs4tr5KpMK1+Sw38zOau+Bh8+kofp0M6/yWDZs4+1eUmVb3ey7RnaA9qlOuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZjBw8Z6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nx3/9ZL9; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZjBw8Z6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx3/9ZL9"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 00D8111400F5;
	Mon, 25 Nov 2024 04:51:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 25 Nov 2024 04:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732528311; x=1732614711; bh=v+EHL+NZXM
	LpgguFEpIXvJt/brIAgyZBmMJW6Ohfwsg=; b=TZjBw8Z6W7/DMFIfq6JuT1PGGV
	foCWYvck43YJvbMJYzZpiH25RKQoWP51QzLmw7PYdd+0qFVJbuXUad7RraqM34ez
	qxBOB8p+2UN2YXYU5Kq++Dae2RE0uiOMIeiQgd5gxhY1B9tKu9HtVZTOYtYzRtkf
	29QVX8rX+MU6St5xP49dNfT/BqnlY37ATutmjcM7Gq7s9bsFadQhmbeg8ynqpVbe
	VbOxjTW2hwl90YJfFlMdWwt5Vmd6r9of9X8duEc1779ELMaNYCfGNg8gwbhWaokX
	pfx+AU61DLzR/SSI1AwB1tiaTOAvWOUoGWuFAoS553kKzZofLBja6znQAHzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732528311; x=1732614711; bh=v+EHL+NZXMLpgguFEpIXvJt/brIAgyZBmMJ
	W6Ohfwsg=; b=nx3/9ZL9TxHHE5ONrtmkjFaFZpDe+wNNMvE0dg8ar0Wr2GCr1PG
	iL4+iz53EUJiHBuXrdATo02124hV7D62AcFbzi089CLXWu7Dhq/IyUBVmgXKs5jC
	1zSP3M05NnQXUwGuP93AmX0Wi/qrbmyXRZwreafwf0vxQA4fIrpuxo4mWSmO/716
	QhaA5Ftm+GqQhptu8MEDUcdz0mIa7igtG9pBoiX7TWi7WPPsSpnqrZ5AkID7dQUX
	P7zl27mM9OYHe0P6dKzVLxnt3G5wWAmoqPI6lhE+yU/5o2ILtbPW+lrPFZpCZ4P8
	jxTS1eqIs75swBfSXHZtpS1I6lqlQnS+vVw==
X-ME-Sender: <xms:t0hEZ_kvRQHI8PW-zmtFkahAOCgn8vUoM5UBd_BN7HCZZAdFc0_BEQ>
    <xme:t0hEZy0_ESMJOHMowXBADZnRrmp1gbcBeKZRjaFCJ4RhDEgeAD_UVDNz7rC6eKlyC
    qUCAZQFWm4civQDxg>
X-ME-Received: <xmr:t0hEZ1qs9qffy0AxG7johaOW2rH2j20w7X1m8KJOan5gd1HochLpFN3-YH2L8soa7IHYpfoM1RJUVAfnsiyEdx7wKQ9TEVRs02kAh6rJAuYEkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoheptggrlhhvihhn
    figrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghrihgtrdhpvghijhhirghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:t0hEZ3mqu1ZZKPsTr9qZNgxF6ta6MU4bct9poPNFgtXnYECmkQQJKg>
    <xmx:t0hEZ90P4Noo-yFE5ed_eoFyMNnS5j9iyz2prcPvAywi_RqF29KOrg>
    <xmx:t0hEZ2vrSUYm8-YX9xK-vKJprYPPTqVyMhNgeajdxJfwDDz0LBcf0A>
    <xmx:t0hEZxXwPJo80TGmEhOfX7kHI5WBxpelPNsehu6L21x2WEoBpoa1Ow>
    <xmx:t0hEZ2JfcaOOcoK8CJqA6HLnAhIe2XNuMDVeca3GVkHoul5QvExM8yV4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:51:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e174ede (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:50:48 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:51:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v7 2/6] fetch-pack: refactor packet writing
Message-ID: <Z0RIqUAoEob8lGfM@pks.im>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
 <20241125053616.25170-3-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125053616.25170-3-eric.peijian@gmail.com>

On Mon, Nov 25, 2024 at 12:36:12AM -0500, Eric Ju wrote:
> diff --git a/connect.h b/connect.h
> index 1645126c17..8b56a68b62 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -1,6 +1,7 @@
>  #ifndef CONNECT_H
>  #define CONNECT_H
>  
> +#include "string-list.h"
>  #include "protocol.h"
>  
>  #define CONNECT_VERBOSE       (1u << 0)

Instead of including this header, you can add a forward declaration of
`struct string_list`. This is mostly done to keep compilation times at
bay by not including too many headers.

> @@ -30,4 +31,11 @@ void check_stateless_delimiter(int stateless_rpc,
>  			       struct packet_reader *reader,
>  			       const char *error);
>  
> +/**
> + * write_command_and_capabilities writes a command along with the requested

Nit: we don't typically use Go-style comments where the comment starts
with the name of what's being documented.

Patrick
