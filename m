Received: from mail-oo2-f28.google.com (mail-oo2-f28.google.com [74.125.231.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D44BD789
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496729; cv=none; b=kU6km2NNPN9uO4NSEipmfcngPefvvAd9xdxdGxdgFiLS21QRDNeQGdYe8Cow7R3nqLbjYPyveTu7wP0OAC5SU4zuGyoEkwP+7XALQQWMwka7zRL+cd04lt/+N5R8s9d2Cv6YeUvp6wswRTwGiL4g/RrarQ9SSknqIkXLaSllSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496729; c=relaxed/simple;
	bh=k3uaxufYfobKhoQ9dWP1HdshsXbRS0WXKpbDo1lPSQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUHiTQu6IiRg9NwhW6+yM2NUrs7noPH6RE+ljYF5UbRArHepFJrfXJzCfIz5jvlqSy8oMzJXoHH+FjvB8AzS1JNRDx4cJ+CIouGpWvt/IDqYIKFVSkY3JJuiRiwoyZU/MFo/L+RK4LsW5Soi4swCKU6IQI9ug09F1HShlT8x8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj9A9PnF; arc=none smtp.client-ip=74.125.231.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj9A9PnF"
Received: by mail-oo2-f28.google.com with SMTP id 46e09a7af769-7f4f0d1778eso32681a34.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789496726; x=1790101526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H7gjkeb6C3Nn2mv3f7kV3B8VRD9U87ePpBZd7669gAE=;
        b=jj9A9PnFubwVsL6YVvLldW/ZP5vsZAKoO8I2ssYfBwttQxxdlqUkUGW+rBxc30eFUZ
         eqnm8xzXgdPdk4K4o7dX247UoV0O91SVGKjkMYcc1LmkYIcaImc6k3viGc/004J88NCr
         QOvbetVyPJBLlUtKUuLrRwA4aGe52itBrs8c8uDwIKIXW7vW/jUmkpVdwL5jEXtUjaSA
         0Tmr2FpE0vEWDTyU/jQl41dABNp2F3FCg/osXw7Dvfm9cvku/rM63NnVrjvaK6zNqZdh
         XsrRS2gFeofDrZVGsi815VgfqW+/0g+rrOtsfUCT+sH5b89N0G5rV5jKk481dWir+W/9
         fE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496726; x=1790101526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7gjkeb6C3Nn2mv3f7kV3B8VRD9U87ePpBZd7669gAE=;
        b=nDjpt1RdmOAIE7KkXXLqO3rxQJyk3TP3QRji0vtfO+rUqzssgez7rQCARtrzEJTJou
         nAOyhBFPmS2/JJ6ExxXvxXV/ptIvhKIczE4szNb1wXJXkYgTUeW4710T/I6Mn2HGQAKJ
         k0qIcceufcTbeVx0l4MBGik4VRijZeKiZ9MZKa/JunV7QwGvqv1LI5lY4SzcuB9FY3Tv
         OnBaUeWzFeVTokC86p4gDTcLVn6NlziHc/qQa1h8KijvIIqr4uMwTlbLZ42HjF1I+k1F
         bvL7Xm6CpJD8i/eJQNTdwoChpMHVqGOErO2ZYvQ6wZD7opTNBdQEGp1+za8mNG6/mqoo
         +CfA==
X-Gm-Message-State: AFuF++n24XzwEvdgrjtibH8TmWWK3VW/4rqFf4G+plGO78Uju+Zmotof
	SsIWjbz+CsD2SzdUOVmtnETKrmpgtLuWymj1B3rbUdTWfzlJt2Cq9994PsggGpvt
X-Gm-Gg: AYBFou2Eq/rNm1sfhFvG9B5UXYWqippVrZFRrzydBm87jN6eoVP6HpiAC4kCPrH7oCl
	jSVCIIlPfRSQOIB8W7rY1KZgASKSIjhuf1N7ICmfq05PQa15wj/Tdj75/Khor3VbqSpdpGLna6g
	Wi9FGU54rb5pkj7pzpaEk7WdpRCbgJkcN49YW/n/N3tYgMcHizE2TrBqmpOzkVFix+Y2jWosOUv
	cewx6F1IpRtNxwUxp+BVhB/B1PE0eOhenDyHjg2h1GsUxo3ueQ7mBQjfL9H5JDGmwBWlrsSJclg
	G84pC6RXuouC87qq6t7+6sBmBYKDrfjDarQyhzcm/SJrvcaZ4vwdZCah7+1DCZYqXF7y6j15ffb
	5pFpcGBb1ZXFR0jyzzFqMiJlu3u26BzMJfIjG844C1ZE5nhZwVbpFyLQ/7R2OXbQglU5JrtCUGo
	4jcnbPPUPVxEuslTPaN911BXF+7nZW+BqVeTO+Q1einQ/2YOioolrHq6GXLTmMCDWXyuYtRSdD7
	Vm01Y67xA2hN16F1MK7Gh7x++mU
X-Received: by 2002:a05:6830:64ca:b0:801:d2f7:9e74 with SMTP id 46e09a7af769-80a74d7a92fmr2594042a34.3.1789496726333;
        Tue, 15 Sep 2026 11:25:26 -0700 (PDT)
Received: from localhost ([2600:381:4412:b8de:4644:b965:1819:a1da])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b07ad0373sm84266a34.26.2026.09.15.11.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:25:25 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:25:19 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Qin ShiCheng via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <ttaylorr@openai.com>, Junio C Hamano <gitster@pobox.com>, qeesung <qeesung@live.com>
Subject: Re: [PATCH 1/6] odb: don't remove a ".keep" we never installed
Message-ID: <aql8Wt2q9RnQpjEC@jtobler--20250820-SHC54>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
 <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com>

On 26/09/14 11:31AM, Qin ShiCheng via GitGitGadget wrote:
>From: Qin ShiCheng <qeesung@live.com>
>
>receive-pack runs index-pack with "--keep" over the quarantine, which
>writes a "pack-XXX.keep" there. The path we register as a tempfile is
>a different one: where that ".keep" will land once the quarantine is
>migrated into the main object database.

Yup, when the ".keep" file gets registered as a tempfile, it needs to
know where it will eventually be located post-migration. That way it can
be deleted after the references have been updated or if the process
exits early. This is a bit awkward, but its a result of use relying on
git-index-pack(1) to create the ".keep" file for us and it gets written
to the quaratine directory.

>Nothing of ours is at that path yet, and something else may be. Two
>pushes of identical content produce identical thin packs, index-pack
>names a pack after its contents, and so both want the same ".keep" in
>the main object database. If the other push still holds it, that file
>is what keeps its pack from being repacked away, and we remove it at
>exit regardless -- even when pre-receive rejected our push and nothing
>was migrated at all.

Interesting, for a pair of identical concurrent pushes, if one exits
early it could end of deleting the other processes packfile out from
under it. Really the process should probably only delete a ".keep" file
that itself created.

Something worth noting, if there are two concurrent identical pushes,
both will generate the same ".keep", but the keep message contained will
differ. In such cases, when the quarantined files are migrated to the
ODB, the ".keep" file that gets migrated first "wins" and the other push
will fail because the competing ".keep" fails the collision check and
consequently the push fails. I mention this because the current behavior
for how Git handles concurrent identical pushes is to reject one of
them. So if a process encounters an already existing ".keep" file in the
main ODB, it may be sufficient to abort early anyways.

>Register the path right before the migration instead, and once the
>migration has returned, read the files back. index-pack wrote the
>message we handed it; a file that says something else was not written
>for us, so let go of it without removing it. tempfile gains
>unregister_tempfile() for that.

Right, registering the temporary ".keep" files doesn't really need to
happen prior to the ODB transaction commit anyways. In fact, we could go
a step further and stop using git-index-pack(1) to prematurely create
".keep" files altogether in favor of letting the commit phase of the ODB
transaction create it explicitly. This has a couple of benefits:

	- It avoids the already awkward tracking of ".keep" files in ODB
	  transaction pre-commit.
	- It would also make fixing the issue in question a bit easier
	  by allowing us to simply try to create the ".keep" file and if
	  it already exists, unregister the tempfile and abort early.

Completely unrelated to this bug as part of another series I'm working
on locally, I've already have some patches that start creating ".keep"
files explicitly during the ODB commit phase in the "files" backend. I
would be happy to pick these patches out and send them upstream with
some small adjustments to also fix the issue here in your first patch.
Just let me know what you would perfer. :)

Thanks,
-Justin
