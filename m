Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06D818
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623315; cv=none; b=pv8sOoNG8lKcAoVQzNLBxIUDg3MKTwlfWkaXHRNyr+aNSaALRuTnDMO08nJzD63sBFNC3YUqOx29+wUCyUzRaWPuQZ973bsxia3BQSAzJeJzE/y90dISt7AjsHh6jsZSF+UATnwjf39Rb0AvqMuntbBSjRM+gmExV7BnsU0N/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623315; c=relaxed/simple;
	bh=V03H4buE0t4zM3KJy9lNwVmKa1jvU0chD9OR0JxxGoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rs83vOl/Ckowutg8IBT5Y+FrV91Ap0ePgeY9CYUZFiAd0Gx45MgWaJ0lkKzgFqipGbbr+2dtFAi0VHM4xk5CAhmD53SjubVRdbql9DA0XvFYpoNytB6F+o3xge8HQuO5ScCRY+iHoSRZBdKQ3DwGgX9MkegEgD+CBCN1+1DUQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rwBG8IVx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rwBG8IVx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D93419A4F;
	Thu, 18 Jan 2024 19:15:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V03H4buE0t4zM3KJy9lNwVmKa1jvU0chD9OR0J
	xxGoM=; b=rwBG8IVxDHjUl3pkW2cvwlZ6v316Dm4uz6F9Z0PxuVrMU0X7GQCqWa
	MPPXMmOOM752Vr2WZqJTpdXL3rE9bPxpAaCBsligikGsZs/TTRLvmsZcIT1fj4qJ
	kKLxpi7yvXTLbRLDlt+sSnIS+qbGT6+8F266JLJ8rY9vNIHKyLMdI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E4C9719A4E;
	Thu, 18 Jan 2024 19:15:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B3AB19A49;
	Thu, 18 Jan 2024 19:15:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 02/10] trailer: include "trailer" term in API functions
In-Reply-To: <owlyv87qgozb.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 18 Jan 2024 16:12:56 -0800")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<5f64718abfc2e61b4e259de700c137bc817fbb1c.1704869487.git.gitgitgadget@gmail.com>
	<xmqqfryup98u.fsf@gitster.g> <owlyv87qgozb.fsf@fine.c.googlers.com>
Date: Thu, 18 Jan 2024 16:15:00 -0800
Message-ID: <xmqqbk9inpq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CA239508-B65F-11EE-AA41-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> Ah very true. I think I was thinking of the series as one atomic thing
> (all 10 patches or nothing), which is a bad habit I need to break. I'll
> reorder these two on the next reroll, because principles matter (and
> it's an easy mechanical change). Thanks.

Thanks.  I wouldn't have minded if these renames and moves were done
in a single step, but because you already have them as separate two
steps, let's keep them separate.

