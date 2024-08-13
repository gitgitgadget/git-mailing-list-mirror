Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F536B11
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589155; cv=none; b=h5MotPSdm05FMsLXF4aBzr+9nSIxO/VD8/ejBqpIfMe9/1EurVcNzjBTdQncyo66JYF1sNAZeWe+58eBMhdnHOcvTcw8IzfNqQhzUjJ89zisJZDgIbaVTsRJVkQmCwyWrNIAkM8/+CsBvgE9QdeuffQ3VsPEXoB1rhV7ExBKUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589155; c=relaxed/simple;
	bh=az8kYKQe5kLI3TG4Fr+C0HgnrWHZcenYbfE2Uk26vAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSdZNZkUV3T7SrLtl9ajr3Wterkpc8NjM/VoS0bvOwXYMX07mWJRDv7jj2fC22vk0fDlu7MhnSJLGo0NEBgjNwhXQB0ZFup10SeCOsjGcX6UWSL8K79E+fRxd5BEIy6Whgs7OE3/MBY19VxNfutNSn8xoEYy1K+hvnB3xNpu+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HSTSSCYb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HSTSSCYb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd66cddd07so42104715ad.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723589153; x=1724193953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPKbuBnjydi6e9z/SLXu/ISKAZQHi1PoZmfKe2T2Qf0=;
        b=HSTSSCYboPwee36gaVoxQoaPzsU8YSelZUVRaUY4qJ62HZDPV+jE+zDsS6IFic8+rK
         0QWrIC5lK54OVEpIL7DYFgMUV+vATR75QaWJpSTvcl0C3BRcfJBRNHaWQsUdogvXmz4k
         in1z+65r8pcD9RKEreabTq7h8YQy3Zj2fC3SXLu/HNnq71iEvfunhohnMCk1awyoX7E7
         CmnnGuL8qltzWzYmJ/dRzpjTNProctsHfs1x8zeFpSTxByoH/rZnZWQ+l7VD3132Wua6
         RAuzcDTwS+oqO5GJTcrZPc3PlkamffN9U8BqfgIj+EwmoCcfhWA0LzFBGsEFhMMz5ZVh
         iZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723589153; x=1724193953;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPKbuBnjydi6e9z/SLXu/ISKAZQHi1PoZmfKe2T2Qf0=;
        b=ToSn6zDsvfMT8nMm2m5dQZdVaj7wHGJpFSJQXCdWfoD2AV5BK67u3M0nHJxKEFW5n7
         0teZecckPQTrZ8hDraQ1VuZgIB2RbPntfm5XKCjW1bu7z15gV5T1UhmZcR/i6oJwiH8L
         uLzvFfBOvJEF18gZNU7Er4pZVTxoBcDBpd6zeqP+b3W/E1/cpY680lCvrZWla/fG9UYu
         6sBbMrI1wWUVdi/liStmJiWJ7yt1aswTkuTq/mf98fh849PZKZvknZMzzi0lxKs2U+gI
         bMEeq0IXPuSJX7OzdCejJc2r2KUlW9BB8q2r3+XDlHyPMfcqrSEnfLfiJip5N+igIc7d
         2Wiw==
X-Gm-Message-State: AOJu0YzoNwLFYesn2TrYRFF6MA84v9b9OKqSbTIhlWnu2BzwsErq5cuW
	6mJsqJLW953GvRjLoMg6Fq7drhU6HpwkZpFo3LvhWhuJX6RmcAdOPfSVJKNIpkEHyrJwNGRUREO
	XOw==
X-Google-Smtp-Source: AGHT+IHnl4rnTvtnN5aGtKKg46OJwN5gZ0q7akx7+CPAAfjuqikr0WJ1+WVecf8zDjMH2bwwe8pW4A==
X-Received: by 2002:a17:902:ea02:b0:1fd:7e56:e108 with SMTP id d9443c01a7336-201d63bfd9bmr13434275ad.25.1723589152434;
        Tue, 13 Aug 2024 15:45:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3e87:d579:d973:3685])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1b9d29sm18499375ad.222.2024.08.13.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 15:45:51 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:45:47 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, 
	Anthony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH] format-patch: add support for mailmap file
Message-ID: <2mvexuxcaow45ifnqmrvpn2yz2ecxzazsbo5ui7xaiwwpzt7hr@mvl6ehbrhrp6>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, 
	Anthony Nguyen <anthony.l.nguyen@intel.com>
References: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>

On 2024.08.13 14:45, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Git has support for a mailmap file which translates author and committer
> names and email addresses to canonical values.
> 
> Git log has log.mailmap, and the associated --mailmap and --use-mailmap
> options.
> 
> Teach git format-patch the format.mailmap and --mailmap options so that
> formatting a patch can also reflect the canonical values from the
> mailmap file.
> 
> Reported-by: Anthony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

I am not sure I understand the utility here; using mailmap at log time
makes sense because these are old, established commits that may have
outdated contact information. But when writing patches with
format-patch, presumably these are still somewhat WIP patches. Is it not
better to just reset the author information before running
git-format-patch in this case?

If I've misunderstood the use case, please let me know.
