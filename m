Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD6535AF
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178768; cv=none; b=QVdOFz/zgTGPBhfsOrwAhcUiRKL/L7ymsrRZRZy4O1fbWUPKiZ6kSATSuKEUkQ+U4keB+LbMrsDZGD1o+HzeBX8taiTMRbbMV4M2XY4jTSEbadp9oIFAI9reUXIoIWwMdb0DNkIO9OO4WO7XXShOFUBs93Bqa5kHJFeoCSvuOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178768; c=relaxed/simple;
	bh=s3aJsrDfmnhMLwTWK1T+kNOP48nw0KhVZV3QQkbSuAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHp+zEU4Lf+2zpJCcF7wuUGB3AUEvqlUY5mWbZ5mTINcNVZ0dLRbX8ACimQvsjhLyPsYHTSrTD0Un3uU/R7xOKaIomRyn6Bfn8cAjanIvQ6NQdWEC/W09Ugzws9KCtHoA3IgMA9WgWAI0ljQjsPC2Fji/huI5ZoyxXEaw2lnPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E9rSfVr7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E9rSfVr7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 778D826051;
	Mon, 11 Mar 2024 13:39:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s3aJsrDfmnhMLwTWK1T+kNOP48nw0KhVZV3QQk
	bSuAU=; b=E9rSfVr7I5uhjf2zQ6nzmlpqcQgk63QEnDSpeNxE3tnZnnhcyWB92l
	qr62TQmH1PYn6CO0QLLeaMbAcedUWefESHTvpJL2XkoIPbyTeoAAhqBGS+FhlNgR
	VFiBaU5k2Q3eEDnKi78pfNbag02A4KtIwyzHvCRpQY9q+20zSPQgc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7073826050;
	Mon, 11 Mar 2024 13:39:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 156CA2604C;
	Mon, 11 Mar 2024 13:39:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ignacio Encinas Rubio <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
In-Reply-To: <9fb02065-12d2-4c92-b1a5-74c06125c692@iencinas.com> (Ignacio
	Encinas Rubio's message of "Sun, 10 Mar 2024 19:46:14 +0100")
References: <20240307205006.467443-1-ignacio@iencinas.com>
	<20240309181828.45496-1-ignacio@iencinas.com>
	<20240309181828.45496-2-ignacio@iencinas.com>
	<xmqqy1aqvx9n.fsf@gitster.g>
	<9fb02065-12d2-4c92-b1a5-74c06125c692@iencinas.com>
Date: Mon, 11 Mar 2024 10:39:21 -0700
Message-ID: <xmqqil1ssm5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C46D4C2-DFCE-11EE-9F9C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ignacio Encinas Rubio <ignacio@iencinas.com> writes:

> I can't think of any room for improvement other than integrating
> hostname (or a custom hostname) into git and using it in the tests, but
> I doubt it is worth it.

Ah, that is a thought.  We have t/helper that builds "test-tool"
just for that, and exposing the output of xhostname() does sounds
like a reasonable way to go.  It would roughly involve

 * Add t/helper/test-xhostname.c that defines cmd__xhostname() and
   writes the result of calling xhostname() to its standard output.

 * Plumb it through by adding it to a few places:

   - t/helper/test-tool.h wants the extern definition.
   - t/helper/test-tool.c wants it in its cmds[] array.
   - Makefile wants to list it in TEST_BUILTIN_OBJS

 * Then use "test-tool xhostname" in your tests, instead of
   "hostname".

You can run

    $ git grep chmtime ':!t/*.sh"

to find places that needed to be touched when a similar internal
tool "chmtime" was added.

