Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42836404A
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658209; cv=none; b=bTwEoIjU+ZQoxrgBa/z/LH6007QZHodlI+hUXj9712UXlHM58sRrMDzz+JBO2Y1ImfqV/hmrEEtAIUl171Ex9iiHmgpxFxr1mA7sYtGKRIL/XI1oj3E/HFXt3uqsi2N/Tf2XMPJJmJoIxbSWNgko8FOdNRhaoace8e/UOPVyXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658209; c=relaxed/simple;
	bh=s9xOBR+0GiVvcQ2qJmQ+No/EMgZm+xr1wn7+lh/HNJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9OgWvCS1MGxk3zFJqz5Xt4OEF4q2YjpyPqVAiMoIokejnawRMUpM8/9yWXKbY4Q7jzg7tobJInGCW7gCfrwrLgS1GjZRuu8tqX4sm7S4MUdwTi4qbVY9d1zz0Z3h79Q+4BDOWMH4XRiw5W6lSoTQd5yfv4acr76fCym8F4Tq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVd+OLST; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVd+OLST"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40ede943bf0so1449939fac.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772658207; x=1773263007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SEhRwHAWyLzzQNfRYT54xGRyMbx78lkvS82K+QuaCw=;
        b=fVd+OLSTPyPBWyLFcP1Pg3V+aUsjoaxgUpTGN8dxz1LruuEsJt8CXDUgvdDH3EZ/nN
         wtdDqkaCcvBhYAGfFScQEdlYsVoqziRDsqPOeinfLQn2MZvwycCx3E69oaPBnM9Kn71L
         4Km0Ov3f1lSMjyL8IfojoAGg1g/eGZHAHG2blDxsUoa4t680yCh2+H2Re8LLr5tZUQd4
         Meh7GBgldkkoEUPEBqo7VMHd+xGgcidQQE7FqgeKL/rPhyaZEC1cBXNn1+9sT/dISGLl
         v9Lamfj5AP1sKDSfEvH3tGIQxjLY49qsw1H5oMFOpKgLQdmn0KZf7tyiqJwX7N3fqoq+
         MQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772658207; x=1773263007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SEhRwHAWyLzzQNfRYT54xGRyMbx78lkvS82K+QuaCw=;
        b=oGojOzf/0c3OonC7PP0DXkt1v5zvmrMNNqYWzt7EgGhDx4dt1HVsQ3Un88+2asCW6M
         vh6Qi4HkI72+BMASlIFdcnzfNLuaKOPbOJMda/xrs5EmDbI1ZH0nGZuRZnrSbcFchtn7
         mg4gAOINfFwLeWd0Lyl5werE4q2xceOt4d0Bhd28NtUe7Bpjjwc3jO09HVGs7eeYwBVl
         suj97RY7/EWrNVgOgrVpyxolYlq8tyfiGuXwh4w/XBdM/GTCsd7DrCp0o1Qy9lD4jsGl
         PizkCdP3yg6JXQAx1g9+aUP2atOAk0xzYxWYWkM6oZODKDlKwhXNXaBkJ5EsiY56ygDM
         JRbA==
X-Gm-Message-State: AOJu0YzyhPhmE4O1Pa/KcVD4kL0NyyQ11xQAGC676QU+Xnvf+jujbss9
	rx9kzllzdawf4I/R8kXvnjO9iFmW/pKE9e/hRYJpHrH544iaFSivfUghkhX5KA==
X-Gm-Gg: ATEYQzxPRtaFJlI07SB+G8O+E3IkXWmnlQIIB8Mo7DLHpSAMbEbkTAm1+jnjWMlML/V
	Ha7e6H3jbU9ecx7dBdUPalN2rlgvrmvc+00u6iL6sBruvZi2xFaOZ0q6tVtuwY64kF6TXNJtGtv
	l9FHJeZ/GZlYRE1eAsog/6DAxCboz+5J9TXkMkzVAwh3hJvvBfLTKCuGEiGg+XMkQzvGb4205Hd
	HDo85E3aYM59mePNcr9Qso5B1zYUJZWujORw/aAaz5Uq/uIDCsVhkC2XWg8bewO3KpEhmQp7gjE
	Iw9qfblHAbmb9mjghVoh2vSOEwvV1zRfj4ou8PN3RS3hqcMBxTghrrw4XA/vyhCSuppZLUGoS9p
	BkdVsqlubNF7bRKNu2NFsosisgMzPUP7S9q3QMFdb07RyPOsMph6yMMv/jTwkczByoduY/18DVa
	cnj/7MKXknhEa9awbO
X-Received: by 2002:a05:6871:69b1:b0:409:dd35:2a51 with SMTP id 586e51a60fabf-416ab6947c9mr2036512fac.16.1772658207114;
        Wed, 04 Mar 2026 13:03:27 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b24dsm19036454fac.7.2026.03.04.13.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:03:26 -0800 (PST)
Date: Wed, 4 Mar 2026 15:03:26 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/17] odb/source: make `close()` function pluggable
Message-ID: <aaidbdpkpH7tfn9x@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-8-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> +/*
> + * Close the object database source without releasing he underlying data. The
> + * source can still be used going forward, but it first needs to be reopened.
> + * This can be useful to reduce resource usage.
> + */
> +static inline void odb_source_close(struct odb_source *source)
> +{
> +	source->close(source);
> +}

Just to be safe, should we BUG()/ASSERT() in case the provide source is
NULL? Or do we expect the calling pattern to always provide an actual
source?

-Justin
