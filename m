Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11513CA4AF
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559760; cv=none; b=EhhL8g7jd1G8NSwC5FDLMT5k57QrMiXss5CMXKFBnsBEJejeY2LQQ6x48eiRXHmIhAmjf9FbGDhxtTC1FcDzfAmOWW/ex4xHdPio39+kUwbZ7RLivPSoXuwV4EdR34F0O2EH+s1gUVhbY6slEjK6oYGDFokq3c3DBobBrxNcLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559760; c=relaxed/simple;
	bh=SscAYP71x8Zjl8cHpzGypNQw6tf9Y+LHJRMa7bMX6JM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPP8lBJYJu+7OUbulajdiEcan7Wbq+77awoxy9rB+mP+mgWPnZMoG/bf5WkmOF/0IwoZSundYzuvznFDhN5gn4igERKTm9uqt8Y1OjIXDPAX+bSiPuGFHb/koXprM27v8eMWerW+2HqxfYtvkj3jlF+0Z5x/3pvoaLOY4gQs8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o0ZGFl1I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ivPElLMr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o0ZGFl1I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ivPElLMr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D5A22EC019D;
	Fri,  4 Sep 2026 18:09:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 18:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788559757; x=1788646157; bh=5LLSgfs+50
	K65MMPDhQ/awAfsGiSakiTWVnTZLLXM1A=; b=o0ZGFl1IdykH/cN5nssK6LkFxI
	t0i8bZmNQDLX1w3T/PU3koC1mHqCPMk+hkKZdfVbXXt/AQkGY0pPmUDvchzzeNZ0
	q7O3h4I2QYAYHQF0RUGN0KwvoE6gzHblNmOVV6dHnoiR7dQ7+zinf6UoH8YMnElG
	pQYVDDOvIgVNZ/kyhKGzRDfzt56ip2as0hjtpU9WH2bj85azLe7X27mEPWrzaCOO
	tcpYVQIJ8VKK1Lfmy5KZIsfMYs5sQauH+J0zbCbqtwdgXJIYRjn6LmJV2FH7qQvD
	xm/3nZTEMAzXZwNi0OzUFS2EC6lqBLH4hV+hwGX/Kawolm/TdKLIZj3jQiTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788559757; x=1788646157; bh=5LLSgfs+50K65MMPDhQ/awAfsGiSakiTWVn
	TZLLXM1A=; b=ivPElLMrLkvb7neT7xM6+EmXAWsgUCC6ix07pGSYgAqSOwI4mmW
	i956dGAosWPABNjnJ7ZMMYEYsMYBdYYJWOJufM3LB6N3o5V5zULmK/7fdrME4SaI
	6NVMPh9L74oOySmxAfDCuS252KvuQhfUOCX6J2BEbFNX+B6AnWqd3iPZdp7SKsl9
	EoZLa29a6nfJhcIFYbBoMubGeNG+fGiQxnfetj2oGXhMp3XLwPrL+8by6RUvxUXy
	qLrTPHuqr0AedYZDNiDI3D7/O06KxaJawhFfmEe3bPi+7GnpAhxdtZh+hY0HxtXC
	SAGhCBzpcKazfxjtIaHgwb9y6vWqLdbqfhg==
X-ME-Sender: <xms:jUGbaravTk6222q_DdsrvpybqjV9N-JfQO7ryV_uCyN1crpiwFD5Cg>
    <xme:jUGbahQ7U_SeHH3hSogtz5xnf4OVzaj3UPi5o2-7IsbWMa8kRFOmuF_p4-wWOlABI
    GH1VotklXBCl20hmTtlwN7JBU0zXThukNVH3Uxme1v0dsYMRuOrx4yS>
X-ME-Received: <xmr:jUGbamSyBkBAUhX04RQqlNMg4M54sD9WQ6sy9yeZLHPGjP2juqqssANsMRQlROfXSFWQugSaZ20izSHfeu0rJu9fzeOTtwGuzg>
X-ME-Proxy-Cause: dmFkZTFAwvyC+jTQsfxhG17OlGV8mTr3eOixhdH549U6fZOOCrBfYLqxfeMO95pv1lwc/V
    F0ENscqC5Q2Bx95pksoZpjkifZd0+BGJ1kf7EKuxa7X4zpfl+AhJYGn1plqQLIy+8TNMDg
    omHv/aG31JqO8zjHzyde7QcvIvnfs+iyGSlpcqX5288DKMjgPLkmZkAw8AijgwY8XzAkmi
    iRrEKyPwlUNM0XBlbeDVODmEErZdAQFL+Ot/VRnhj/KRKrle1h9aaBIIBuridvBql/ZPQF
    MRXA9yPDSSCYzJgukR8S8Px8mE57FruVEswNbDUjQtxbs3RnHfawnUcEhNeQ17In0Qudqu
    RRzkcpxVNAG2OcZEWEKQqBfjD5RfVZvqHy4vB7YFeZjGeJfdoj+nsfCCn8iz11e4U1g0+1
    kAscV8Sok2rtY8lkfzBxdSDC8oUfTe0gREHhsNPjTdco3d1ha0FYVAtd271IklX6ZWOpD8
    EHEDCjBBbZiiW7uEU8W9I5zf01QhKTqOgunVpqTIyqj//dXVlsJmjCbL6xz0PxoxpyqGyd
    z7tkGSMrGJxC7BwBkBb3CUk/UzbfvV9ZzEVPpCW00DCa8VOwfbq3LDbUhsob2tthZ3O++z
    NI2FDKgqHLzJE7EqHG2PHu3Ol7FC/Ysxowuae5pPjLje+bMzGXlUqBsgpBBQ
X-ME-Proxy: <xmx:jUGbatT28PhEZmYfQiodJ_CmNx1Sf3gvwOR-pHIETzFaTZR6p4iIMw>
    <xmx:jUGbaj5N4RTuTNH2jsSmRR2138acXnQqQAdBJ-kgzjvKQwMsybwxAw>
    <xmx:jUGbah3xd0y9eclImLUHiIOULKAuzAjLGtPcBlDffzvvp3QL4fwnWA>
    <xmx:jUGbamD_phSyL2gK1dHfti0mlCcWAOOgtdmYonc4AJy0geA6I3EMlQ>
    <xmx:jUGbagiqBIsZ34uvJnK1eme22J_DQdjSTbulwKJTQg3ZknX0vojSPbcO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 18:09:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v5 2/7] repo: add path.superproject-root with
 absolute and relative suffixes
In-Reply-To: <20260825175818.645579-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Tue, 25 Aug 2026 23:28:13 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
	<20260825175818.645579-3-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 04 Sep 2026 15:09:15 -0700
Message-ID: <xmqqh5k43bzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> +static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
> +{
> +	struct strbuf superproject = STRBUF_INIT;
> +
> +	if (!get_superproject_working_tree(&superproject)) {
> +		strbuf_release(&superproject);
> +		return 0;
> +	}
> +
> +	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
> +	strbuf_release(&superproject);
> +	return 0;
> +}
> +
> +static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
> +{
> +	struct strbuf superproject = STRBUF_INIT;
> +
> +	if (!get_superproject_working_tree(&superproject)) {
> +		strbuf_release(&superproject);
> +		return 0;
> +	}

Here get_superproject_working_tree() does not care what repository
we are working on.  Shouldn't it be updated to take "repo" as a
parameter?

Since it begins like this:

    int get_superproject_working_tree(struct strbuf *buf)
    {
            struct child_process cp = CHILD_PROCESS_INIT;
            struct strbuf sb = STRBUF_INIT;
            struct strbuf one_up = STRBUF_INIT;
            char *cwd = xgetcwd();
            int ret = 0;

I suspect that it based its decision on where you happen to be.

It means that when I have a checkout of "git", with a submodule
"sha1collisiondetection" at its top level already populated, in,
say, /var/tmp/x/ directory, the following happens.

    $ cd /var/tmp/x/git
    $ git repo info path.gitdir.absolute
    path.gitdir.absolute=/var/tmp/x/git/.git
    $ git -C sha1collisiondetection repo info path.gitdir.absolute
    path.gitdir.absolute=/var/tmp/x/git/.git/modules/sha1collisiondetection

    $ D=/var/tmp/x/git/.git/modules/sha1collisiondetection
    $ git --git-dir="$D" repo info path.superproject-root.absolute
    path.superproject-root.absolute=
    $ git -C sha1collisiondetection repo info path.superproject-root.absolute
    path.superproject-root.absolute=/var/tmp/x/git

The last two ought to match, but only the latter works correctly.

Before this series starts reporting path.superproject-root,
get_superproject_working_tree() needs to be corrected to work on the
repository in question (instead of relying on where the process
happens to be), no?
