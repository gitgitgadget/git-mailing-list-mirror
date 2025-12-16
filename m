Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2E156237
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880288; cv=pass; b=Z5EwKxi/gO39BZVQ+L0vahiYUdJYmEfpxK0GzAGSrP8qdgkUY7NdraDtVAKlWFmGPyfdASeoIpKCc8jWuVWznx+p5WRb+zZg9Hz8gG1VdrVemw1E3BbBIirXKp+W8pdAJ1pLB0lzXWxVhG+UyVOjCDemrWi7IyhnbJrFpyHr2aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880288; c=relaxed/simple;
	bh=N+DmD+bsVMqjdP/o98yrCMcLj9ZkyFL3HbQ6CtCK8a8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zi3bYy8TdCymAz25wXIzKlG3K2bJ5K1G4egScMMPPkirmc+7LxJVqA4N2zK/jD2cKIPFfo+oTVcr9Li15IAc4Bj+phEsVYT9JlsWhs3Qt1oYK9GI9bC6y0xZsfQIYAvRo4pqBstTvZbM0jcz8kn81BwOrhYWTgn3Gb+crnXoHEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YVMyYQca; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YVMyYQca"
ARC-Seal: i=1; a=rsa-sha256; t=1765880271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OvEUHXseTHVQQ9Tibb5Jx+AZotshS3gfVZ9DbtH7QktEazwy+Lh+kxRliiOyhgvOQ1OTVpygaqRM8WV18Ju3N9/aFkmDZi+HBZiSjyvJ7PJEJ8B9qj/7LqVQs8pYLndQwpaN1lA17nM+po/IRRJ4b8tVECkdAwX//Kxu35DD4aU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765880271; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lg0VILItgvJgMS1lDe38/dM5Df5H40XzKlEHzUIIy40=; 
	b=RaQSXtcevuuMnvyp5MWWexOuu8p+PVPMFmSYMjfKHl7VU491aVWW4n7ww0lSp0gdDL5f6TxvmzlBsGAkF8u3DQz4ZlASzJ6/GMniOssxz6m11qA7enElAsDcil8+Lw5LXjyPTIBijcipTfS8tYVd1oy3OrkGz0S0HP//2AKAPuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765880271;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=Lg0VILItgvJgMS1lDe38/dM5Df5H40XzKlEHzUIIy40=;
	b=YVMyYQcaaqwKG00AUuKkg4fBOdyzYu1a9kCMFYdDp/dxKPCDqa8iqMBVaWtBMVr8
	NfU2x8eT/Ms80UuRI8lC+S4Hkrob2F8J19jbwtSuP1n4WoyHpz+w0xBic45m0hcAn93
	sm/Ds8zq/jyJR4sJNcGaw1iBieXBnJNzez5QjZ10=
Received: by mx.zohomail.com with SMTPS id 1765880268530968.3828365537603;
	Tue, 16 Dec 2025 02:17:48 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 06/10] submodule--helper: add gitdir migration command
In-Reply-To: <aUEh5fclig8NYmEU@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-7-adrian.ratiu@collabora.com>
 <aUEh5fclig8NYmEU@pks.im>
Date: Tue, 16 Dec 2025 12:17:41 +0200
Message-ID: <87y0n2g27u.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 13, 2025 at 10:08:12AM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 2b5b4f575b..458dc863df 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1270,6 +1270,63 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
>>  	return 0;
>>  }
>>  
>> +static int module_migrate(int argc UNUSED, const char **argv UNUSED,
>> +			  const char *prefix UNUSED, struct repository *repo)
>> +{
>> +	struct strbuf module_dir = STRBUF_INIT;
>> +	DIR *dir;
>> +	struct dirent *de;
>> +
>> +	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
>> +		die(_("could not set core.repositoryformatversion to 1. "
>> +		      "Please enable it for migration to work, for example: "
>> +		      "git config core.repositoryformatversion 1"));
>> +
>> +	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
>> +		die(_("could not enable submodulePathConfig extension. It is required "
>> +		      "for migration to work. Please enable it in the root repo: "
>> +		      "git config extensions.submodulePathConfig true"));
>
> I think we should reverse the ordering here and first create the
> "gitdir" config entries before we enable the extension itself. This
> ensures that a halfway-aborted migration will still leave us in a good
> state, as the config entries will be ignored until the extension is
> enabled.

Good point. Will do.
