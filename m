Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E863CF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383973; cv=none; b=adToeRby8DsS8wvsKzfk/ucDux40amR7KieMxllyPpBB4yCRjG7dfYUK2lreCHiiwFBAX8QaiMd5sjtquY/Rc9w29+riDh8HoX3Xa/0gTI7tJF0hQKf01Z8Fv3DZUvUu5hRc4y0DBFuRI2ZXAdl/2QMFGVaCrTHYkzVspk/PSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383973; c=relaxed/simple;
	bh=YYzV8hm4jAqQUe6YcDtAii34tos1ePaH2GT+PTRa4BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gk90IULzHIe5FzLYnQ58kMqSlcskOE7hmGhBfEuSlqj5CojA3uwX2FBU/LQhNl6RqOANXignb/j3YwCPJam0z48ygT9AnRPLfLAD+gahLgoBwQwIXAAy1GQ0epDutBBPD7tiGew/2HPQ1xawzoSwjxp0IGMACs07t4SL/d9ADhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=sAbJm/3r; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=Lby0jDSs; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="sAbJm/3r";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="Lby0jDSs"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85ad9632156so178305939f.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383971; x=1741988771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYzV8hm4jAqQUe6YcDtAii34tos1ePaH2GT+PTRa4BA=;
        b=V0as90j33qx03BwpSJgoXaZqSt3ueyVb1NmIParTmXdFUnmovX2vhUZg27r9OI3tKX
         RbSgRPax329G+CBSUr4tDEM4sB1MOrXb6q/7A5qw+V51WO/XpcmYfZUYbcxQb0d1KTd3
         Mnh5WBEgtwHNBe1kpqChquMMS1JOLm05s68+a1kiV69GbD9J/F9r1Egz1qyuIF106hK0
         Fh3Tx1B5/z75CF/3OzYDTAUHGT6lKSSEcGbp/i4oIZyZMG89Rwwi6PNVtLIQi9hEGIDW
         +6TmPcHyrZ9yytz18nMLkNitYP2dnYw5k9K+cIMKuaGUqyUBEA2hTGwQecLlQFwi5uTD
         TsAw==
X-Forwarded-Encrypted: i=1; AJvYcCXDlcVhYbaEkG06O5cEGmEnAbjK5FA6ehwEbEAzdsAZ0A7bASzw5XFmpAp+Wala9F61SCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfWu9gb0G+/UZeLJp2phOKHKolo5MMWawmQYu2zB2DJ+sXcF3
	J/LZACrEfo4qinqBkZCh63JAQcIfhpMV3woNrpAQo1RorC0L1rwH7y6Vz2oqf9FkV65oFEWa66W
	lG1T1nyrwWian+UayUVI/Uxl8h7OzULxlHzgFEPVHfDjf5t/4
X-Gm-Gg: ASbGnctzyWmWRfF+ztz/x/Xv2x+CVdyLGYwHAL5qAICexuzysNJvLrEF2Yfc3P4QEua
	rVrajnFGZ3MtCawjWWA4qlvoDjZw2x9beWDx9pSj7IOtwCRFeUWOLAKUiJ3pfQHC3ZiONjhBo7t
	rcd6AO0yHO3WQ8VC0QYJDhsRFsiRnnrD1MiwrptDfxgmVSZr3pv+o7GBAC4nr2LcGULtNZXKfRx
	lrreyz6g518RMbE9SVcfoGAMTBU+r1A/iWP5ka6AfQM3RNTeEAM3Df4CSwRtZRdeqZRWMh84rZR
	XFudwvnBXfPXzrVhU+BfXuP0DFb6hl5nOjvxwIzj
X-Google-Smtp-Source: AGHT+IFhB/TXfuNAcPFIQoadmct95YUjewpkAiDBkoRI5VMwaYq3lcSHKzbpG6Wd309JIyEwQYJq+nbfPJWL
X-Received: by 2002:a05:6e02:219c:b0:3d0:4c9c:965f with SMTP id e9e14a558f8ab-3d441a13ademr69319205ab.20.1741383970963;
        Fri, 07 Mar 2025 13:46:10 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f209e1565fsm199718173.18.2025.03.07.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:46:10 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741383970; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=YYzV8hm4jAqQUe6YcDtAii34tos1ePaH2GT+PTRa4BA=;
 b=sAbJm/3rqBi0BVrQWIGFBaN4peIiUqM7pecpVzgQFSOy1fyu6uzMJLmnNionSNP8FP4nq
 ERMGjPfNNgPl/XpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741383970; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=YYzV8hm4jAqQUe6YcDtAii34tos1ePaH2GT+PTRa4BA=;
 b=Lby0jDSsLbfpBPGagVsqM1dqoNUQkjJNNFUDgWWiLqqnvklfX8fGDwIB6VMqo+s5HGhYd
 xP6UuWopeZkpP+tR86pB0fjdYQhbQKshcKia7bC/yXgRU4cEXj9Jd7YDYXbzUYbaWHuKhU/
 RwP/NpLL4J+B/UMrrSk6oPwNB5Vtr4ys6yjH7LwQy7/uf3xhQmXdnhXYDTwDX3bN27t7A5u
 MhDmeLCqfjI6yYM43gQq01rh20BlGQD2TztqLEP6x+q3Cp1Ox2PMqh7Y9AEmmP1+U3DVxa2
 d+eXiob2XnMEh5mEcSgztVZwV/L3wKh0OdRcK0JPoLlQGDN7eCkOy9kZPXZg==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z8fxG0btcz10df;
	Fri,  7 Mar 2025 21:46:10 +0000 (UTC)
Message-ID: <e06caa06-0176-4340-958e-4c43650b40e3@mandelberg.org>
Date: Fri, 7 Mar 2025 16:46:09 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
 <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
 <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <CALnO6CBDjQgc2TNaXbBWiUNqWV=RgrL2Ry-7HzRu3Ozuqazzvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 2025-03-06 om 15:24 schreef D. Ben Knoble:
> I'm willing to manually test the patch if I can understand how to
> reproduce the issue—it sounds like having a remote name with a slash
> is sufficient?

Yup. I was able to reproduce it with these commands:

/tmp/tmp.zOjfmdMx1i$ git init foo
Initialized empty Git repository in /tmp/tmp.zOjfmdMx1i/foo/.git/
/tmp/tmp.zOjfmdMx1i$ cd foo
/tmp/tmp.zOjfmdMx1i/foo$ git remote add with/slash /path/does/not/matter
/tmp/tmp.zOjfmdMx1i/foo$ git commit -m 'test' --allow-empty
[main (root-commit) 4b95a99] test
/tmp/tmp.zOjfmdMx1i/foo$ git update-ref refs/remotes/with/slash/main 4b95a99

Then type:

git push with/slash :ma<Tab>
