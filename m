Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7A770FD
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618440; cv=none; b=DGyMALuAbPVmjhUm26ZiXzenL+k3lqu1j6KLZ8e9MrAjfmMk35zNy2cXPmclUTaiLvZ7vYUAXsBeJswWnMQAWf+M6q8BaoERCxUu+B7Gmi3yWV5YR3inq1W8m7yEi7eFQVkVhHSI6ALg7ZDCym04yirnyKAvtFZe5XRYuq0/xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618440; c=relaxed/simple;
	bh=beMQaw1yj7WiMybY8vsAMIC5fKDSLGs6tF2lZJEbWRw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmRKSJGyCcPZdm+HizORc2wsCk7HQd4qEh19ctl+RToq6DExuQiyiHnxWgxd3GlXd9Qq0UJYoCmqKsMv1hbNZluXE0P4nnM4gRk25gC5Y0niI4l1M1qyFPtA8ySLJ6avAIunzl5KzUXd+4Glvu3U05BpaNprMbrQ9R2Qq7bvHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=d+uOmmOW; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="d+uOmmOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729618436; x=1729877636;
	bh=zWaXI5iQ6OaBaa0z9rBUbm2U8YXjGNuqiO/rXEz+G9c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d+uOmmOWK4olubDdKSeBFef/PY9GdILOCdGf5u1eb/7SddKcZjXZt3p7J5KLZ3xfH
	 tgJ2C89GFjbu+29OtDYbj9On4X0gND84dncPL7DHkQtn3u4uA+1DQ6d2jVYLYYfMtO
	 GRrCbYkSItg86zt8X8FyZdvrS86zYjvtOkSd8D+NFvFpbivH65lLLQpqCDAY7ufUO7
	 6S7cXx5Rw3osmShAlZ0RewD+n+K/MjLxwMPmgEzEnpTOr86zAyAECMjiV8jsv5dcBI
	 3lV9m92tRHf4FLwJKQkJcMOrl88Rrk1gjBKUwzP//Of4yAJ/fjfypmOTDXuQ+SIIuF
	 oEtp1rHemVgLw==
Date: Tue, 22 Oct 2024 17:33:52 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: consolidate extensions in git-config documentation
Message-ID: <D52IK8WN7D0S.2SGBXWAEE2CBZ@pm.me>
In-Reply-To: <ZxfdJs5+YbpHgpdv@nand.local>
References: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me> <ZxfdJs5+YbpHgpdv@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d75318d7b5c1bdf9d7fab1d206da864d6f2304bc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 22, 2024 at 12:13 PM CDT, Taylor Blau wrote:
> On Tue, Oct 22, 2024 at 12:08:49AM +0000, Caleb White wrote:
>> -Note that this setting should only be set by linkgit:git-init[1] or
>> -linkgit:git-clone[1].  Trying to change it after initialization will no=
t
>> -work and will produce hard-to-diagnose issues.
>> -
>> -extensions.compatObjectFormat::
>> -
>> +--
>> +compatObjectFormat::
>
> Should this be `extensions.compatObjectFormat` instead of
> `compatObjectFormat`? I think the latter will produce awkward headings
> when these all get merged into git-config(1).

No, I built the man pages and visually inspected the changes to ensure
they were formatted correctly. This is modeled after the `advice.*`
config section which has the sub-sections listed as an indented block
under the main `advice` section. It looks like the following:

    extensions.*
        <description>

        compatObjectFormat
            <description>

        <next extension>

One thing we might could do is bold the sub-sections, but the `advice.*`
section doesn't do that so I didn't do it here.

> Otherwise, looking good. Thanks for working on this!

Sure thing!

Best,

