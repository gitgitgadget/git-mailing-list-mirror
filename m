Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B535C69C
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240536; cv=none; b=JU5Agxlj0hlAGk4StW01h2DXvYA7pOvFeZFI798aG3Y9L5fAt95nJ2cqWXuN4sYx1EWiYufZ/3avr3StM6B2m0yS5+sSFbpxG4Fif15IJVg2IMFA7k7hvBRyjxxBnnsjhJCL6g4E9rISPDJTG+Zx/8oiOZHMskDm8sqG4hPDxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240536; c=relaxed/simple;
	bh=oN5bHxTc+/6JzEi/UFCPNXUR1MF/V4B+qzNlzIB42Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZMhH+mOqEHQcnXxTa4OvDIPprZHDIq3A5Z6CMB/yWsxSsqWNqcNgsJtMIVptRCFl4/D17VOGPG/MNUFubqmIfKCIHCpRJKhZ0Fw+/TKliyolQeocoLL9W6YKdVMFCQ6v64JVcGXjZA8cGaYGvz3Ppl1qKoEUX56Lcn9LxfGT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bau6uS6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=onAjp2HZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bau6uS6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="onAjp2HZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 46FC81D000AB;
	Sat, 12 Sep 2026 15:15:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 12 Sep 2026 15:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1789240534; x=1789326934; bh=c7iBb3wigsqDXW5hB4kHJ
	VquYNnFxrXWsopK/0kaTZg=; b=bau6uS6kxVJk7FzhPx22/KObE3bmY4df99HKI
	iqADMaYjiJl3i1b0oJrJAvBMiiXAhYBjrBY7+3RPIJycdf893v2IWGMqmFGvELZX
	OSa5OhfHHNxKirE1ig2xqYplJH21DXtOfIiNkPQjklme7owsfzeFusPIcX4fKh4l
	GaL80HBoMPU/MfhXcpm2Fn4GEOFXz3+lTQYCebZnNoYNPdY2MMOUaYHZLuJnvXSX
	Q90rwHyr/u1AUZTTDVj5js+fxHDAUSfMoUEj2zE/WZ539yFj2XsvWtcUhjnrs4R4
	0EVYXpHTEOg6QXrOMREibbbs7UgSukeIMhaUnhKXXw3QUfbKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789240534; x=1789326934; bh=c7iBb3wigsqDXW5hB4kHJVquYNnFxrXWsop
	K/0kaTZg=; b=onAjp2HZS6Q6Pt02iVRTAcB/vWTVceCIe8ZchHkJw7+xjWK4kiY
	swnwYWM6W0OMwQcxRt+VXEUeCahcZskr9WWmtjpehB3VwIuPiMvnKmkpWcumGFeA
	eCWYrBvPUDa5zSg6ldAdtwa6w8RbvkrL7q7iGQ7SxVnsKJkF9N4nQirrP3dBQx9T
	4PcBLa2HhATJQPHcEsX9GaOsVdmvzoucvWdYS/FbVAqzRXyZ9pyqSDe3IBZcK8LP
	gb50xo6Qed3Q2sl4nN/AOyOoMss/iGeKjmP5wovIFeh1xC8a22Vy4gx2n3fiGbOJ
	cJ83Ld0tTg/OjIANcn5Et/UOYLjP9cPXlUA==
X-ME-Sender: <xms:1qSlaqFAw2cE39koj5RaymKMLq68qM2B259p2I3q8kmfv67mqOPxJg>
    <xme:1qSlahXKMqVo2NB3SBUzS71QdTbooS7kza4k97M-IyNTGu2c6HOxrvZ4-tTg8SiKw
    Hdn-LbpxmGlfEYZSdXRepYwOPqE9I1EjpgpM-okLJUkEXbYTh3HqyE>
X-ME-Received: <xmr:1qSlahzf061vOyG2VWNGW1PUap52qHUNJo8O_rUsuyepihPxWpnKhxdFnB8DUpOlOc2-RMsDfLtIfdNrsv3qLTAJ5sAqBoyKNk6Ytq3532rJIJEm9o-0UAhrMp25lDwNJuzMhu2kdIkGvabX>
X-ME-Proxy-Cause: dmFkZTEmatd864Co5gxv065DPBLhe0NpHEeejRQ0IQZF9eA9aSytTP9rgEBA6DeohgAinE
    xsqjemKmCvE1dhI7MTBVmbVPayzjKxkOESVgf5RiqHUzbQE/wIsIFpY5f6oTv2k8OQpxAi
    fcsV6dd1/D0wYuoZUUft+6MW7wHcTPCzpCpL6lX2R/FFgufEXAma5RTS8I8Y8+OtDB+EeN
    qE6or8q8hKC2S+25so3TTpYkiZk+pJd58KoZcQ/RugIXh+y+5oT8k78+X+oHdzOjLduo3j
    b31VPINDeHwIMCSfzojVmi1sF73My1OyxWo3CQ6lePONZ8xDhlxWWC2zi+mwKcoSJy6ghZ
    kNnvP3zbKKQzKDSHQKNwEWiGcf2M2qa0fCWoGnQuVyIGJ9sBhLYycFYSxzP2mjGJFc0jnJ
    DK+yJETxFkWLaX+7euaPloRC+byD+hGHiTyGUGiK7kYPgYHgKCTnvVIo+BbmZXFhosPTiv
    WglEf2y+gjimUC42xwPPYXqQXGe7JB6D5otvGbQ/mF1QPA5XNuOl1DbF9U/JW/y6CtB7jx
    21vIIKdeg6QtvlAZXxvTVX/08hT9D8bIaZqOSM9phifTToJPBvI4hVaRvqSs1H8tihExZq
    pXTrWNYfZ2Ni265crOQVbw41S39mDr8rDTBou4SgvP6QuKBsvdyRY7plnVHA
X-ME-Proxy: <xmx:1qSlavNvU3u4OnU-bKKCLheTNbHeBNnV7q7-hvuFhYQD7FlT5e6WxA>
    <xmx:1qSlai565VD7740gLZcZVThy698mmPHm363dB6ivGyAAMYc3ij05gg>
    <xmx:1qSlagNFesGjButqze0bG118weC-ZCWFEIH8I5-mKzCWz58wzWnN1w>
    <xmx:1qSlagnHaE-uvE1Gd8J0TPJxKjHdM-lxfDEzHP0GhBo-hs7-oCNXeA>
    <xmx:1qSlaj50g-s7SvNibmNALpuN7SdotwhV_dZsGb7WxPSrG5MKm6MpA5D9>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 15:15:33 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH 0/3] doc lint fixes for pack-refs and refs
Date: Sat, 12 Sep 2026 15:14:59 -0400
Message-ID: <20260912191509.844954-1-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was reading git-refs(1) after noticing it learned some new tricks in the
2.56.0 release notes.  The formatting stood out because the first two commands,
migrate and verify are bold (in the man pages) but subsequent commands are not.
The HTML is similarly affected, with those commands colored differently than
the rest in our online documentation:

    https://git-scm.com/docs/git-refs

This is due to inconsistent backtick-quotes.

This led me to the lint check, which I think might benefit from the small
change here to match commands as well as options.  Running something like this
reports a number of files which could also use some tweaks:

    cd Documentation && for i in *.adoc; do
        output=$(perl lint-documentation-style.perl <$i 2>&1)
        [[ -n $output ]] && printf '\n%s:\n%s\n' $i "$output"
    done

I _think_ we want to backtick-quote those when using the synopsis style.  (If
not, then the change is wrong and we should remove the backticks from the two
commands in git-refs.adoc and other places.)

As git-refs.adoc includes pack-refs-options.adoc, I updated it to consistently
use backtick quoting and converted the only other file which includes it,
git-pack-refs.adoc.

Todd Zullinger (3):
  doc lint: match commands as well as options for synopsis style check
  doc/pack-refs: convert synopsis and options to new style
  doc/refs: backtick-quote commands and options consistently

 Documentation/git-pack-refs.adoc            |  8 ++++----
 Documentation/git-refs.adoc                 | 14 +++++++-------
 Documentation/lint-documentation-style.perl |  4 ++--
 Documentation/pack-refs-options.adoc        | 10 +++++-----
 4 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.56.0.rc0

