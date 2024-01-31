Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3853EA96
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731344; cv=none; b=oBMkNx7c0xSxPNKW6Aq5rB10tyh2gY/9J5DHPZ1+1SjQx3dkjI+y8a4eCBMcovNoEzQe05ZuhMY4WbtWMI+XvTTIxmXKMpp52Wlky/9Mva4UgVEtZ117mw244RyXRvVwZb5vg3iEbTFc9TPfnZQYEw6qHLSOpQZ7GP5nxhIJVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731344; c=relaxed/simple;
	bh=B9lVQ3p0szt7XFEhlU1etduq8MiqjhnbzosXzQPBNd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCVXjlEE60/HzIduBVIkQCOZKtkUGtOJLcHywtdILwsYhqFZCCV1W1X7PYAMnFeepAfuHvpaBkWBJyvcW9cxb81ZBOk1kWHLHJ7Ky/Mli2HFDKQ0AGqklQZxfvk3TxBx7dGpQP4/UI5mXBcioHbPqq9k92ausbv9aflyMBpBv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8i4hPVH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8i4hPVH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d76671e5a4so1339145ad.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 12:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706731342; x=1707336142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9lVQ3p0szt7XFEhlU1etduq8MiqjhnbzosXzQPBNd0=;
        b=P8i4hPVHIatNs3AssMpMs8Qg7IQJOon6PGoYdiO16hRc48TQdkY2+wLYUdzhbbnEEE
         r+PKCLHJjrwFrSNF9jvhWJY/pYO5TKRWmh/DcpWKP1crYf32iLA7Zey2Z0aVWDfue7xE
         /5g7dkJ0ceWhpHiYgQ/xk2+5Tbw9SapKYsukB4r9KkZ0bEvLYIkO4qX4fPgOPqSfZGJY
         GvNbw8LHMumTBUzrf32qc5H2p4TVXooZkqma1lXjmYGZlk/QbVgs7jULGmH0rWfMWcg+
         j+gMChQDiKJmlCWYq2tIqbqkPac+DFmD4FsCJNlWRz5AgOYr+vvPbEZJ/3e0Wok5RDVN
         gnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731342; x=1707336142;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9lVQ3p0szt7XFEhlU1etduq8MiqjhnbzosXzQPBNd0=;
        b=RcMG7ik5o3t0mU+kDYiOvXTMcjthbln3rfLR15GvlRrvANeVR1hEL1+nq4ioEQBsbW
         l/61+ZtJULo8XmhenpszzTiTwAMoCVNjL7FuTzmgndJXqWeo54X2v3Gs7u60Qh0pu7/U
         pLofqa6OD/AgSy+vbb7/Vnf/mtLldkAZCVc/A3zmSe2jse65LozCRJE70IRANVxF0An+
         so6rRrzgTfT3m9EdTRjVEtbhY4ngEC+9KBnGUZW0JX+uFd9wo4xnMJ6pZ5xGCHZT3IQj
         ItBNK/UxLAMNGBYSrECZsd+uqQJrvTpKAJWx9mCvKXuS1Fj0IOUwMRhc/WSLeNriak5y
         hEqg==
X-Gm-Message-State: AOJu0Yz/cjTxcKrBsvgv6t2MuTCnKlZDmLwNqxHONKQ38+BKuZ5cgciS
	HEUvr6EAgOJM62XAWomLO4qfs633xE97Bssg9S4mhW/cASQftK7ijaSw5zSdGQ==
X-Google-Smtp-Source: AGHT+IHwYwCtaa/p80wyc+/hxi4drXQ7L0MmvJta9b20L7KEijKtof4rn0huIz+jllS3VRbILH9U/g==
X-Received: by 2002:a17:903:190:b0:1d8:e946:38ea with SMTP id z16-20020a170903019000b001d8e94638eamr3170540plg.22.1706731342104;
        Wed, 31 Jan 2024 12:02:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiffvuA8a1HXFCaPmMr8j1JP2J9Lycl3F+TjaTUJ67BSqUcgn9QEWUR2Fu3Y8oY4cTMHdphl/W3vvFKvOvgtmGUa6AhIIGs6INjEobeEbjl9sH9TD5hej/OX8bKXuMxzrYzNVrkEmBq2sUJuritVTIAMWdMyAApcLGJoxz0HdZ4GtdpnzhXtvOVqHE6Ta1El97hcw6Vn6RkODD+cE=
Received: from google.com ([2620:15c:2d3:204:cb48:caae:a426:b2b])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001d8e4de7a44sm514752pld.127.2024.01.31.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:02:21 -0800 (PST)
Date: Wed, 31 Jan 2024 12:02:16 -0800
From: Josh Steadmon <steadmon@google.com>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
Message-ID: <ZbqnSNPjIQW3Durz@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Linus Arver <linusa@google.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>

On 2024.01.31 01:22, Linus Arver via GitGitGadget wrote:
> This unification will allow us to delete the format_trailer_info() and
> print_tok_val() functions in the next patch. They are not deleted here
> in order to keep the diff small.

Needs to be removed after squashing v2 patch 4 :)
