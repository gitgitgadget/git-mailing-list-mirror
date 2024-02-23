Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C675823A1;
	Fri, 23 Feb 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708626; cv=none; b=H6ZZ1hmt7VLnxZwBSDgMW+f7/vBP6cV0Tk+XnBmPdMryqntqsSJn7s9kzsvz1HVssMpk/OBvKS2xV+zTN2oGQ9muQD0PlCGob0edNr144OzbovB6c0uUxFB+vuiXkGvGmh4TokGcZ3naso7GWD7A+KmLoFHituFVV/tUfQGlmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708626; c=relaxed/simple;
	bh=6qq/XNi9OR53IROnWAKTbGUUyKJGYwuKmtfTohCEYz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tdsux1QdikhFLQK8ic74a3cW5NL34gRJCWGhx8V/7EYQAXzghUkWjcQbAWD4sABtw85okeK6SApJJc7ppP+usLw8GPbwWJNy1KhcNLO1PEBYoVIOqzo0XwZoCkHlNVW4sLJlsx8coSmx4unAWM+p9bFzU5YaY3gvjdpSPo6x5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xlk44TmR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xlk44TmR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E6624226B1;
	Fri, 23 Feb 2024 12:17:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	qq/XNi9OR53IROnWAKTbGUUyKJGYwuKmtfTohCEYz0=; b=xlk44TmRRb2UyVS7l
	v4nWDkZ1LLOonQSK92b6j3XyGjt9oFLZW+3GFSNP1r6hux4+PAaqmDRXUzlvbkWv
	7zNWsqKv609tPJocLOlUlJDLL5XdSCyVasrSpkqSSTA4P5Un+JUTg5exFOoTrVfN
	VA3bstFf0kiEQBPq8zY+FPGo7o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DDE80226B0;
	Fri, 23 Feb 2024 12:17:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00F00226A4;
	Fri, 23 Feb 2024 12:17:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.43.3
Date: Fri, 23 Feb 2024 09:16:59 -0800
Message-ID: <xmqqil2fw16c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B4F064A-D26F-11EE-8137-A19503B9AAD1-77302942!pb-smtp21.pobox.com

The latest maintenance release Git v2.43.3 is now available at
the usual places.

This is to fix another regression in previous 2.43.x release that
were not in 2.43.0 and 2.43.2 did not address.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.43.3'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.43.3 Release Notes
========================

Relative to Git 2.43.2, this release fixes one regression that
manifests while running "git commit -v --trailer".

Fixes since Git 2.43.2
----------------------

 * "git commit -v --trailer=..." was broken with recent update and
   placed the trailer _after_ the divider line, which has been
   corrected.

----------------------------------------------------------------

Changes since v2.43.2 are as follows:

Jeff King (1):
      trailer: fix comment/cut-line regression with opts->no_divider

Junio C Hamano (1):
      Git 2.43.3

