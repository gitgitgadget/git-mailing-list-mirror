Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6F28504F
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771815732; cv=none; b=E8F+bpmllhtOT9HuhggEPTytcRsnGrHE0xG2vPtEuY72RIrpWq8wJbkfiMLC0Un8jCI9fjYHoDb0OEq0F/AyRR8nvz/lLrfnyRDKGs0dLHJ8wnzJoJBJlUiFkWRynKbISVLbW8lUaVPBwqMRTMdwlOgmtCDSX2A2ewokufCn97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771815732; c=relaxed/simple;
	bh=CMxaGZy9I08ZvdOfTvGftJYuJCKa2RUATAc88VF3CIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSPJ7Fj3q1tk1UlpsgBMgEcTb7VQWSaCk6CeqIjG16+VBgAkyHJRWcdtSH8eVCNHQZEj+ret1RaknSk8Sxai70mz+v9BL5xAAPcb98I74MF9lrLBT5ioNuGeLBY1tPDedF3tWtOvnnZoG725p8VQrsCxTxmhkmBJapVxJBC/cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn5f85Zl; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn5f85Zl"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c307db9aso1972604a34.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 19:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771815730; x=1772420530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enJDjYVH51S+uYTeHSWfwEdjV5HdRdF6Du4/JtKYr58=;
        b=Mn5f85Zly35XQ5vT77YTebrqgYaYTjTb9X+uu0Ks37AMlw8q/z70H3ouUp/2vXBAEY
         jsXHXMFDNmD5tiu2T+rogB9QHFthERFF8FjIvl5gAdN9FwwjEAD5MudfahYUwV0kfKkh
         qwIJgyBzc1YBWNooSi35RvaXCQNXx0d+U6x/KfpLqqG6zOxoBcPktVxYWZOwEL/xh0Bk
         sC7At9+vcAcpB/v8cK/AOMG9iHFrDpPZJiw+EyJ5SRVq+ALlb5+2F/9y0rHGjiszDipt
         rH0RRSPAQ45VfWDzda1aL6LB6IokqT6Zygh79KgcGtT4EiJ33y8baiv8w8iVsdOnFzNU
         czhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771815730; x=1772420530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enJDjYVH51S+uYTeHSWfwEdjV5HdRdF6Du4/JtKYr58=;
        b=q/Rza1DE8nBqaEIhwtnWgF42ncaqbcDtA7+AOt4t/5rfKmFtXfsu7RCwc352JpOvPo
         6RMuEQq2op49cn9/pFNS43ylh33P3cfYIuFV2GzHUqEvdJGvCW8Y0pOk3d0Aa+QiAMLf
         mcraKx6JkEZWyfilW3xX4xqzb3SH65k5tlos7NzP0h6RYwEx/+w42RXe8Dt9OA9rXO/6
         C1alUh/VBw7W4MUw5HxTLQhgqbOq63STpFTiAQnPQWWhIplO6RGiJ3uwfELpJVaPHz8z
         MKq6iSmrX4y01fRoz74SGWBZ/jlwXADkdsvBeXqO3N0va3VVKHI5UQSDZh3yNjdq/sQz
         BOUg==
X-Gm-Message-State: AOJu0Yzor25j3AS0J9nzkPV5StaeYX1G0Jg8wIBCzq5WLOWHQt+QEcDQ
	9zwTMZWRhExDVTNcGutYRboiFLJD4VWjuRkNv4m7hrZGSNYUPEXUX7cl
X-Gm-Gg: AZuq6aKckbecJTxP/AsmepxEQPuOGgb4sHLuob08QbnHbHbpvMRzKjUHYm988eJSVc6
	Pa/iJIQMA1aMsoFkO0SeLhOH5G1RNAwPe4cvHB8TnFI7YFKWC8j/XrR4ujIAKNn3zMK3yNjH1p5
	0af7Swwhr9LpS6HajPJeN/D1ut/auZ+ozRcOoEMM3pJAI/OIYJoX5QuF4QTj8DBcsemSJiodoZm
	0zxsfiu39K8wpNysKkWoVqFShUnQ4uokUBihWLaE6cC5Dm/OD98YX4fbE9XFNuO5Ybkrap2+5h+
	5X7ocz5Nv836dZ185yj9jSSb0KVoArwLFeLmxkF/MuccClHkR5lGlxxXA6uZp+TB8EZXEvnrWeK
	82QvhlBm1h9ZDgNj7ERa8x42eyll7RYNk1TihFuj59rNqoKCSuszAt4sc9CionKiP88PgUTRCXv
	RJmHeFWQ0bTVx5SG0c3Ti+Iv+mVbQ=
X-Received: by 2002:a05:6830:2a0b:b0:7cf:dbb4:320e with SMTP id 46e09a7af769-7d52bf52eaemr5315771a34.18.1771815730108;
        Sun, 22 Feb 2026 19:02:10 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf9f663sm5813000a34.11.2026.02.22.19.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:02:09 -0800 (PST)
Date: Sun, 22 Feb 2026 21:02:09 -0600
From: Justin Tobler <jltobler@gmail.com>
To: eslam-reda-div via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, eslam reda <eslam.reda.div@gmail.com>
Subject: Re: [PATCH 1/3] repo: extend info paths and structure statistics
Message-ID: <aZvBLAvM0rfA8VUr@denethor>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
 <9f2b3a46a4475ef9dcfec65def3a9965b476b4c4.1771784936.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2b3a46a4475ef9dcfec65def3a9965b476b4c4.1771784936.git.gitgitgadget@gmail.com>

On 26/02/22 06:28PM, eslam-reda-div via GitGitGadget wrote:
> From: eslam-reda-div <eslam.reda.div@gmail.com>
> 
> Improve git repo info by adding path-oriented keys that match values
> users currently obtain from git rev-parse, including common directory,
> git directory, top-level, superproject working tree, and additional
> git-path based locations.
> 
> Teach git repo info to accept category keys like layout and path,
> and add --path-format=(absolute|relative) so scripts can request the
> desired path style explicitly. The command now uses repository context
> passed to the command path instead of relying on global state.
> 
> Extend git repo structure with deeper repository metrics inspired by
> git-sizer, including per-type maximum inflated and on-disk object sizes,
> maximum commit parent count, maximum tree entry count, longest/deepest
> blob path, and deepest annotated tag chain.

Hello,

Just FYI, there is already a series on the list I'm currently working on
that is extending the "structure" output for git-repo [1] similar to
what is being done here. This series collects largest inflated object
info, max commit parents, and max tree entries. It does look like this
series is collecting a couple of other data points too, but maybe we
could do so it a separate followup series to the one I'm working on? :)

Thanks,
-Justin

[1]: https://lore.kernel.org/git/20260203221758.1164434-1-jltobler@gmail.com/
