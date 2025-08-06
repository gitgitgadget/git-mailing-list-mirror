Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD4287246
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484896; cv=none; b=FOq05sMZyVRUKlMopfHlwpNDeYR9YeJ/o1ce2sjxAsI6u/HQv7MxmqiBsFW5nklEiliYf0TBlBl2xDGhkNHjFMjsxF/ze5vljwQaf8DHEDeOk/U7EILEMLfJt1mqHbcIiZZNa+mky740whXgKKjOdwZl9TR7RD//6N+5lrolHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484896; c=relaxed/simple;
	bh=crvb19AQhqEjjk+mFRIhM1KfW9qkQNR2OYLqxb5k4Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5Y4QJt3B1e3O4/LKyJVznIBGho2CIEUxZ9tPsD6sDTAeltqaj+EJExe0I5/Rj3VNd9vfKB4puXMlq87oKORm9DuEPYpWu94Xok5y44wsIzYq3zbFIa0NomGRa6AbJE4aMhYfzZ2aCmONCCN6JNNw6bfrXelVNdhZYTMxD6CjMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=q19kA8RB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="q19kA8RB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754484891; x=1755089691;
	i=oswald.buddenhagen@gmx.de;
	bh=crvb19AQhqEjjk+mFRIhM1KfW9qkQNR2OYLqxb5k4Qw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q19kA8RBOSGEASLNZVD+faTIixMCH3FQQe9zI03xqE9S5LYgVHr3SQWdc8uaH8ju
	 I32ewewRohrhl3cORy7TjrTjBwe8QLUasx07V6IH9rzzQfFGiUQGc2YHsUrV6gH3P
	 e/7I47BZJ/peSYsjQwOvpPsgzgZxJ+JW7kMn6O3RPdigkXcFODT6+XZxC95hCg0io
	 uWE6iqUQS/y4IoLdLzFRNrb4DffZ0AC238vIYpeb/QweN7Xce7EESvYKZvKkEFx+2
	 rkis9hy8r2xyqLqf0dhncsVv53MSXsPIP990EwuxiHh8ut9VJj72cnU8U+e4y/kqI
	 +G8kRqCJNGLEC5ZvIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.122]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1v3vyH2Vag-00HgE3; Wed, 06
 Aug 2025 14:54:51 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ujdfP-ri3-00; Wed, 06 Aug 2025 14:54:51 +0200
Date: Wed, 6 Aug 2025 14:54:51 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJNQm1r_FOIqsDlZ@ugly>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
 <aJB5uKFdGybf-IbN@ugly>
 <aJCW7aYqJB20LDNg@pks.im>
 <xmqq5xf35429.fsf@gitster.g>
 <aJEppnTkY+66IEza@nand.local>
 <aJL06Nlee6CR-KK0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aJL06Nlee6CR-KK0@pks.im>
X-Provags-ID: V03:K1:qSqlGYOPU7S6IZKCegd2W3o/UgUvs/LdYFtuk5aoF6l1X5YvISA
 TXUCFhjjvK5RJCH+OUoU+eHLNuSV01oDM3wnbdTBrfJsjQDVCAeolsUnFFmXhd1fI2PPKql
 hgFOZu8LFsPV2QthxVrQKteu1zwP/r/tu5XdP5jL/I6KjbbRE29Tk6bgJbQtJsi/FAnhCTx
 zaANtddtaTiuF0r7Qkzbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J4YMc3dCqk4=;AdJ6VL/+ECjOt/zhkbYVbpqtNhN
 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
 D1j3URT+MyPFwRmgbS4thLc=
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 08:23:36AM +0200, Patrick Steinhardt wrote:
>On Mon, Aug 04, 2025 at 05:44:06PM -0400, Taylor Blau wrote:
>> I wrote these counters in 312cff5207 (bloom: split=20
>> 'get_bloom_filter()'
>> in two, 2020-09-16) and 59f0d5073f (bloom: encode out-of-bounds filters
>> as non-empty, 2020-09-17), and I don't see a compelling reason that
>> these should be unsigned.
>
>I think that is going backwards though: the question to ask is why
>should these be signed if they cannot ever be negative?
>
>> It's true that we don't have any need for negative values here since we
>> are counting from zero, but I don't think that alone justifies changing
>> the signed-ness here.
>>=20
>> Is there a reason beyond "these are always non-negative" that changing
>> the signed-ness is warranted? If so, let's discuss that and make sure
>> that it is documented in the commit message. If not, I think we could
>> drop this patch (and optionally the patch before it as well).
>
>Yes, there is: it makes code easier to reason about for the reader, and
>it means that we don't have to guard ourselves against negative values.
>
>If I see a counting variable that is signed I immediately jump to the
>question of whether or not it can ever be a negative value. I assume
>that the author of this code _intentfully_ made it signed to cater to a
>specific edge case.
>
well, there is also the diametrically opposed view:
https://google.github.io/styleguide/cppguide.html#Integer_Types
https://critical.eschertech.com/2010/04/07/danger-unsigned-types-used-here=
/
https://soundsoftware.ac.uk/c-pitfall-unsigned
https://stackoverflow.com/questions/30395205/why-are-unsigned-integers-err=
or-prone
..

in isync, i standardized on unsigned where possible (e2d3b4d55), and=20
sure enough, i introduced one of those underflow bugs not much later=20
(859b7dd7f =3D> 12e30ce56) ...
