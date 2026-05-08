Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC62BE7DD
	for <git@vger.kernel.org>; Fri,  8 May 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276393; cv=none; b=GONpfye3CNDz+tsy5nL7vX6usUSF4G1/hBP4GquKkWw4HbFwYu9P/OvBSdlWODNnkxzotU/mqN8GfPusAWyympKeoo2mca72kBPFMTsBwCUKN+cr5A8XQJdOroL7KA3C9ir2e5oebQ3KM3cKhRWQLQai2+Cz/6IaQrMcN3FG9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276393; c=relaxed/simple;
	bh=9yPXUHGiXxJW9TytrGaxUOMJQ6pATcjo+GzyYAU38Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eymOueOxXX3S1rjcmv6Fbi9wGR2w1wRqQqx/C7X7AXb9cO0HHy3QJjjq9iAAv+aOCD3F3maImVqHLKpCbOJ78MsuNDDzrGDgF4beQ1UKCVgytGg1AwfiCorK7IlTcgVfNlNGY82FzHR8Z8kALRDTQLA8U2VuiSnlwjDTbKARC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (135.197.67.86.rev.sfr.net [86.67.197.135])
	by joooj.vinc17.net (Postfix) with ESMTPSA id 0B0981CA;
	Fri,  8 May 2026 23:39:44 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id 4D1B9CA423D; Fri, 08 May 2026 23:39:43 +0200 (CEST)
Date: Fri, 8 May 2026 23:39:43 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
Message-ID: <20260508213943.GP5260@qaa.vinc17.org>
References: <20260506010927.GE5260@qaa.vinc17.org>
 <7cedf86c-5db7-45ef-b8d4-034b792f0def@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cedf86c-5db7-45ef-b8d4-034b792f0def@kdbg.org>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3+4 (71f3e314) vl-169878 (2026-01-27)

On 2026-05-08 14:48:01 +0200, Johannes Sixt wrote:
> This is expected behavior.
> 
> git diff --word-diff is not agnostic to whitespace; if you drop
> --word-diff, you see the line-diff that the word-diff is based on. If
> you want whitespace-agnostic word-diff, you have to add -w.

This is not how it is documented. Even when using "git diff" without
--word-diff, but with GNU wdiff instead, the output is fine:

$ git diff file1 file2 | wdiff -d
diff --git a/file1 b/file2
index da04344..0074613 100644
[--- a/file1-]
{+++ b/file2+}
@@ -1,5 +1,5 @@
1
 2
 3
 2
 4

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
