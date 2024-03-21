Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFE2AF19
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710997129; cv=none; b=Au6h/8+Oh8ASE29I+VeG5ZRqp4EKUTf1jExGivgCiOUzG4loHzqLcJvOW62lnSTd3IERZiHMJ7O+1oD8217MjkBMERnJ88djsDKhwU/foEsN9HvtpZc4sw6cRH7vWdU3eCFrAgMZQUplYuy8zae3C+sfuD6W2vBOZ/ThxEtCPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710997129; c=relaxed/simple;
	bh=KuXJnqGZlcSQxtItoxAXf9PTyy20q1xwgpNVy6kMRV0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Wz+YnG8+IYy3xTMwEiUmaDcg07wPQI1qP4n3OggsWNiUAPj3PKX8/0ufLH3xfzwCGbZlnsfjtib4MCp5i/k0u78+LJsEhGiEODclyQaTum29LshpSAo2ZsGKxYxxE9YS0g6ud2mbOOoP95i4looN6jq6AYEQ1ve/hUHt/EPF7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wjFYP0KX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wjFYP0KX"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710997124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arbfcikys+bMLPw9SfvsbM01plz6sCSX0/DMl7BWrdk=;
	b=wjFYP0KXud9GTMcB9vngayZTE8dcBibRtZ/Kt0Rky3RYJ3sEgoWxltcbFVb5WpYllJ4Fc4
	SlYsSrOHNaJLwPemntRNWvyGWhR9JYWlfGo2WV2wGoTIid6ZWI+DuoKR3wFkduwmQfd3xl
	AN0XhkEam4513MosWuB0b4MN7L7KOfpJRIE7WAoiVfGA/gFXXHt10pD3VoaILaDpYJDs49
	KJC3vQ051ueAYmpZiX2oOaY2Ybvd5nhAKfUKME0hPrujEG1hrKNzayJ1ZPfsvaTwRwNy/6
	Q0Hn5dnUkzZFrloKCjBKzVwJzscfaY8usvBq3Z63t532GTWwMpqfYCAc5NnVew==
Date: Thu, 21 Mar 2024 05:58:43 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v4 0/4] Fix a bug in configuration parsing, and improve
 tests and documentation
In-Reply-To: <CAPig+cRCCqRHYOpMxdL4MWaSF5S0Qb7fcJ5HqkT0j_MU1dRvfQ@mail.gmail.com>
References: <cover.1710994548.git.dsimic@manjaro.org>
 <CAPig+cRCCqRHYOpMxdL4MWaSF5S0Qb7fcJ5HqkT0j_MU1dRvfQ@mail.gmail.com>
Message-ID: <2f5f35d6171209cd1c9d5ea1a1d3cb92@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-21 05:50, Eric Sunshine wrote:
> On Thu, Mar 21, 2024 at 12:17 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> In v2, this series had five patches in total, out of which the third 
>> patch
>> (i.e. patch 3/5) was dropped in v3. [4]  Other changes in each version 
>> are
>> described in each patch.
> 
> In addition to a written description of the changes since the previous
> version, reviewers also greatly appreciate seeing a range-diff which
> you can generate automatically in the cover-letter via:
> 
>    git format-patch --cover-letter --range-diff=<...> ...
> 
> or less frequently, an interdiff via:
> 
>     git format-patch --cover-letter --interdiff=<...> ...
> 
> Both options (--range-diff & --interdiff) also work for single-patch
> series which lack a cover-letter.

I'll keep that in mind for future patches.
