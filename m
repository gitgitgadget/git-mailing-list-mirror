Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655535DA6A
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731727; cv=none; b=DHMMYdoaEVSxpAD39chW7IpdMh7QvxsGusExjr3OvK6r24cyBuHnHKp/JGA3Z447Xi5h134TrThfPhiBVMGGRTH2FIimBziAl7ZfJrbiIir0V8EAGpKW8iEuQKLMB60icT9fnXfK63DQf9pRv9C5EW28WYVWymGJseqprpIbzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731727; c=relaxed/simple;
	bh=9FjXLkqgVdxyF+3T2sDSex8eg7YQ2ULj12lNaSFqfRg=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mSlL3NI0yuAPfD/dFRhmM2NDcGGWyMxZQ4IembyUrGAu58BZJddCgWgCC+y0fAKMnp5/VBQ+cg2RSawqXtO5gNWSNuUqplLkysJC31EK36DzGI9Z4Yj+3BKRTAq55+I1+R8YDqi5YravgdOBtbqQVnfCws8Ank7SF4pd64ldCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Vhn+IM2z; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Vhn+IM2z"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-805cc8b4231so3274892a34.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790731724; x=1791336524; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOYlgFJcKVq1SZ/fY27gBHyaW2Bujnzmo7elQsU6iDE=;
        b=Vhn+IM2zjBbXeHv2qKSa5J3yYUuyvNGKRMPCExS9d6/2COIWO5WlCeCDsl8N8A5Qp7
         GuKk4VqpkU0a9nVUAjGXT0vTcbtZF0lfB3j/wz/wLdmt+Dc6vlCGbyqFqwKzATYjdVeE
         2oGwIYmWhliReJ5EQnDpRo7QRpklH9qAoP7qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731724; x=1791336524;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hOYlgFJcKVq1SZ/fY27gBHyaW2Bujnzmo7elQsU6iDE=;
        b=FXqoc4cn9wTPrHxm81H6nixY6cXvpnx7Nh+uEpUTgejtWyJYfDCkURj2eLO9GLdPic
         szYy1wPkshmITvVIy2QGdMXyd5DfRqqf0xcUJ2gmpOEERDuzvU/Z0HLKPmRN1DsiGxTq
         PiZM6NULTk+0UvoRx81TCUXPkTLOvT/W11ufnxlPPX7a5JdFNEXarXfKwrHhSeH7V+52
         eCk6crEyir2+5bakhzuxhEFE7xkEz7d0MYTxFUk/Sixtj/4yx+jt73n6BwZKpnY3XxyQ
         A7bow20xPMKThX8/T0TdjRn6O1wrLvv0XCMNugIk4KoDYm4lzGhN7ZBsK2Y7Titrd6Ez
         3A9A==
X-Gm-Message-State: AFuF++m2a9gV8X0zCVzhqNpNgMKZ/r+8opjlUYRsH8JuhkYts+ZizE7x
	rvmLHlFvD+yUVVZMTgrVQK9b2oxmEn2bzm3ckGnv/Nf2bQ7qB4C9FQsYsVTxSacmpR3niKEGKas
	qiOrDXMw=
X-Gm-Gg: AYBFou3EwEszXgtosugr3u6YU6H+zRwlIhWmg+dQcUnD8XybZ9jw0w1xS//cdd6mg/H
	11Y4PglTE8+uK73leKmVZjfdgmAUjl7vDSd880nIvzQP7Ue91F9gDV19m3mmtbCvgcs80PF5+59
	mwYrr6NIHYatqFXtcEoHaCnc8INj8dcZEQdm/AS0+2vdhA3Li7TjumOAIC4acSu/le+1I0PcSYE
	+CP4tCov5LyE5Qiq37xEgua3QrtXJtDjIwL3LEscmW95oDa5nt4RkYbX1TFd6X8sGtrTzMicSDL
	NKQmQRM8vLKAirdQWRsD0zU6L19zBgJL1xEZTBBtVQut3NMsbEsIoc5fGZHOLf5UVt8tNzUKmRu
	I2ElSKg5ri7o1TpAEt9qgmFrAASKthMId7pCnQcZN2fiNp3MI5KwSp5N4a/ycaB4WR4JSzaau8E
	33D3FBQu5SoI3UOpaoZp0Zwesq3Mly1dor+eexB+COORV2Z/Q7wmvqvmk2KmLwss1FeAv2XQ7qr
	zxmuA2tn3X9xOtWV0YIf2r2vnXxw+9Tdi5F7NYOFxDt8/XW7x/yET1AwPGAgQ7m1OKlFbUsyvoI
	IJ6BkGvk
X-Received: by 2002:a05:6830:6311:b0:7ee:41ca:e7b0 with SMTP id 46e09a7af769-82049311f43mr35622a34.14.1790731724363;
        Tue, 29 Sep 2026 18:28:44 -0700 (PDT)
Received: from com-79390 (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81faf30bbaasm1523167a34.11.2026.09.29.18.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:28:44 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Tue, 29 Sep 2026 20:28:34 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH 0/4] repack: various corner cases for cruft-less MIDXs
Message-ID: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This patch series fixes a few bugs I spotted while investigating the
cruft-less MIDX feature.

The bugs addressed are found in various corner cases, and, when
triggered, may result in a MIDX being written whose objects are not
closed under reachability. When this happens while the caller is trying
to write reachability bitmaps, bitmap generation may fail if one or more
selected commits are descendants of the open portion of the MIDX.

The series is structured as follows:

 * The first patch is a preparatory refactoring to add a context struct
   within pack-objects' handling of '--stdin-packs' to minimize the diff
   in the subsequent patch.

 * The second patch fixes a case where once-cruft tree and annotated tag
   objects may prevent reachability closure when objects reachable from
   them are not present in the input pack(s).

 * The third patch fixes a case where incremental repack operations may
   introduce the same bug when the pack generated by an incremental
   repack does not pack an additional copy of once-cruft object(s).

 * The fourth and final patch addresses a similar case involving .keep
   packs.

Thanks in advance for reviewing!

Taylor Blau (4):
  pack-objects: introduce `stdin_packs_context` struct
  pack-objects: ensure tree/tag closure with '--stdin-packs=follow'
  repack: retain cruft packs in MIDXs after incremental repacks
  repack: retain cruft packs in MIDXs containing kept packs

 Documentation/git-pack-objects.adoc |  2 +
 builtin/pack-objects.c              | 73 ++++++++++++++++++++------
 builtin/repack.c                    |  6 +++
 repack-midx.c                       |  5 ++
 t/t5331-pack-objects-stdin.sh       | 81 +++++++++++++++++++++++++++++
 t/t7704-repack-cruft.sh             | 51 ++++++++++++++++++
 6 files changed, 202 insertions(+), 16 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.56.0.4.gbee41d2fc68
