Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F962F8E93
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648359; cv=none; b=TrMibiNlSzBWzzgmeLGQdA6wKtIpWGa/w59LGgFUuZJuWKoWkrb4f46VO78IcI3XwGbwiQWkK34q1SvTl4v3HVSmEtpLyolim9c/RvSP2dlktvKfOwLO8Lm+2SFCVBmX2gRoeo3TIhh65C/bJpiEgCwKb8+mMxtwXdpp8IQZLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648359; c=relaxed/simple;
	bh=QCDn8R2winci3FH+j+7KXqFPZDSz2885pury7/4jVbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bn3Rslz+w3mW0zHohsN8p0rcyCRIvbzr6tvIVAWwF8s1GwW+t4T6JzuscSTd0x3cBpQ7D6IFGoGLNa/JWocLsKY16z6IKrfaUMlSIcvqwBJBR9n3clgyrImXF9AHUhqIDBwarCurYOFpIE8lfVlYIK2QGrqzDaDXnlIvgySNy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sSqqj7Sf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEBu5H7t; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sSqqj7Sf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEBu5H7t"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9905D1400143;
	Thu, 13 Aug 2026 15:12:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 15:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786648356; x=
	1786734756; bh=YF7tgW3B/y6CuR6WpQVEfrruNSNSF1M6ccdLcPhN1DE=; b=s
	Sqqj7SfNJyFSAFE168RvBafJ3PtxbmGBvOEbZh63fZpftZZfhgOrnhqTdYSW/pwX
	tQWshbYrlTDkepFD3a7VtCKJlG5ueZ3fWUWHiPC0S1OSqpfk8vU4++MiyhSku9dI
	96dPLG6mMGsE6ZUMtmYeln+J7DWNzbVvCWotBWUPPwdzXhez+6UrCX7iLIQ8hfnw
	ewZivjBy5CZQb+9CpwjzmM1g1Ghzi1VcyVR4LNWmlEWDjubIUPJFACUOLS6ltg3g
	kYab3UM0QrqJVxPGDgDNFW7qPFJ25CJw+4+fpywXiY6B7gIGjJYMYnNVD0cRYhe2
	VLyRlccqcI4a87VpEI4RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786648356; x=1786734756; bh=Y
	F7tgW3B/y6CuR6WpQVEfrruNSNSF1M6ccdLcPhN1DE=; b=PEBu5H7tQ+WTxc5Bn
	+uK1bfMlSgLdypke+fMSeBHjglWo7T2+LzqoulkIvtuu15AJVtqWrdgZaVBGyaqz
	brytB2btezWh9OW8xz/IOhGK+4PLEpSz2m5nfjqGNB32DQtfbc0FdKl1XU39yyNO
	y71BhemT7sN7zr0sDrFIe6jhrli5GT69VzfWjpqi5Y6J1B8Sbn57XAN+aqezUz3X
	5QzLdXBZ4ychoy81SgLYGHmMednfb5YdpCAdwnA9ouavvi8OoCC5mZrDGyOihZa5
	tsjcqv5ABe3H/g66gcLJl2Zwbxvu0zRKJsimYxcnesLm0BZhlFtK/zSq56pSSWIY
	VXFcA==
X-ME-Sender: <xms:JBd-agGXEKZL74ktO1lWl9bKQZYfMlqyNWq2aM5my-iThMR1I59lUw>
    <xme:JBd-agwpeWGEoIVZMqBPRJllVl1dD5Au_ms4ca3mZF04uaCvjYqXFds_HCF2XhgDH
    HOlYyZ8iqTGEfsJhuHinJ9y97RUREiagHhQfNoOtePFYo0Xb5ivRvw>
X-ME-Received: <xmr:JBd-anhKBc-TnOixRhwTIwp7K3NyrcON1PU69I2W9mlbLavvnS3bzESHhqA9sqzS_NdolGxTH13vKbW4u18yURALswAcUyg98A>
X-ME-Proxy-Cause: dmFkZTF7f9AHEsNeQDBTFdw+C4bL/UbfZLEZat3n3kk0Oc8PhCOxeM5ju4F6d7ZRfhGQlF
    unijGey+hvpjStdoVCF85TYFEVUgkgTF8aCL1fY/GdQ5vXsVeP7TiVbRx74N5Xv6QGLhjZ
    W3AzcIoJ2/GjAU/AG+5T5E+/AeQyy6evOkxchLRF/64ta4lsLCJrdyHuS0WJzv2d9SYcCl
    b5L1nHbOfGeQeARAfRHH/J+k+jGSEJ9JEtijHfBam5QB9CfdiX1i2YK7YDjhk2TvFlEs8k
    XdNNT9aPnrbPk04uyCk1CbdM52himLz5ZYZKVr5drQXXHc0JfY9bcdhiNkADOcKXQie3bk
    MqZtAsYmANhuTZFKZlqxd9ozMMGDmIMbx/5ISGUFgQux8/cbzsUwMy3M5MkAxx7ziGeb65
    1grfozmO7R2nwYbnj5opAYwqQCA51gJbCyr1GlLuaqG5JLlMcPJRGEMU69FLa62Qin3vkx
    C9zoHGXRD1u1J4mm47hOR3dNf4XJ2BFR0TGaotX/iKrXMOF58Kz5IxPw+r6Lp9QysxlZFV
    2k+BrIoZGJ8BLyO7LpMt8X5iWze0CPpq59Jru4TTXazEHrIt783kZ3HfQau7Y+eIUVSFVE
    o/BUYGI757ieNhCjUuWNpczjhypHqAyhsQOfvj8Krem005/MYM7KeHjYg+qw
X-ME-Proxy: <xmx:JBd-arwIk4V9vf3vBOoGIo4joew_WdFTKbMVWHeDh9N5V-8B5jXBQA>
    <xmx:JBd-aqIbJXng4ODD_J7vstuOoenTXr2t9PJgbNoZttPf7LmgAKYTMg>
    <xmx:JBd-aiTRievneR_uVMu5KagCueEsTJGp4SrmwVYZIA_cvyxpJvdQYA>
    <xmx:JBd-aipul47_uTr3K8l3IG6X1bWb93lW9cZBq5NsH84pFWcpcD3e_w>
    <xmx:JBd-agKF2hk7VopJYKoT24fpowvHl8KGhpTQ_qkvqhW2xy-rdp6utNv8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 15:12:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 0/3] completion of 'git [-C <dir>] checkout'
Date: Thu, 13 Aug 2026 12:12:31 -0700
Message-ID: <20260813191234.1066662-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-759-g9dcc51a0fd
In-Reply-To: <xmqq7blx5oor.fsf@gitster.g>
References: <xmqq7blx5oor.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuing from the previous 'git [-C <dir>] diff' series, these
patches correct completion for 'git checkout [-C <dir>] path<TAB>',
with a fallback to complete untracked paths of somewhat dubious
value, primarily as a reminder for future work.

Hopefully this will be the small and final update to the series.

 1/3: completion: no-op refactoring of checkout completion
 2/3: completion: complete tracked paths for "git checkout"
 3/3: completion: 'git checkout' completes untracked paths as a last
        resort

 contrib/completion/git-completion.bash | 88 ++++++++++++++------------
 t/t9902-completion.sh                  | 56 ++++++++++++++++
 2 files changed, 105 insertions(+), 39 deletions(-)

Range-diff against v2:
1:  33d136ffde = 1:  33d136ffde completion: no-op refactoring of checkout completion
2:  a28754cfd9 = 2:  a28754cfd9 completion: complete tracked paths for "git checkout"
3:  90aec6539c ! 3:  17880068c0 completion: 'git checkout' completes untracked paths as a last resort
    @@ contrib/completion/git-completion.bash: _git_checkout ()
      	fi
     +
     +	if [ ${#COMPREPLY[@]} -eq 0 ]; then
    -+		__git_complete_index_file "--others"
    ++		__git_complete_index_file "--others --directory"
     +	fi
      }
      
-- 
2.55.0-759-g9dcc51a0fd

