Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11288385D98
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119600; cv=none; b=dp8hPJNkT6tAnHvOrhxBdBfPjFZ3ZoG8/P9UkTbYUWNq31KVxeZwVtaaFSTpqyR0fADY1AIvnuVmxEHjH3g4HdmY8hdPaPpra4iDmi4zsfYywKt5HLqmEupWaO9+qX+3dOms/iyOYpW9TPxq+4iZIPx/dzyKvdlAptiEtt4CkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119600; c=relaxed/simple;
	bh=Iy0l9JdoTkGnejqlSDpyXYrtcWue7ov1yfqx5OBkf0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqJ3nHwK1PwUuBbP3pWcRPAt3Qhc0CM/RESIV7AX9JdP0oMJChkIZYaOCebfKEdiJvShtQbNhc0VzHoreLRTUJQ+Xp+ENftrGCXkBkHfV2eMgPE8PLvki2C0ranpIjR1Ahj2DVUZ4r7WiLvQbdhTtf0P3WHM7jDmRZj9Cer8b/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pusoobkH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSyn3Uys; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pusoobkH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSyn3Uys"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DD7B1D0006B;
	Fri,  7 Aug 2026 12:19:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 07 Aug 2026 12:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786119598; x=
	1786205998; bh=J4/dU5bcEqJKOnULR3CxTAr+9+TkSp/xqRUvKw1j3Bw=; b=p
	usoobkHus9JxAvETV2a2AJgkkEltMI0DHspQIoeQtSwauj3Fydd3P36PhTgZqc4G
	Ti6zDzGl8jB0xySbRy7zo+H8KqAz0B9+7jpffJPZJY/mT1zGum1wQ1MYhv05qcDw
	IodYFmzJ6EmnFsfZnxYWecRvGLsWcb5VbYl0g7ris8qI4uhmJLg7qneCS4MczYJ4
	hGGXMY4vkes1AUSuTwVb/B+RL9OBoancEBh1zIIpcN7+E97lRcl/1+6kVGysJW7Q
	9jfpTpUdREsnBb7s5e6EknHRGq0USHvAl2ACg9owyBDxPh0AmJfOBpLMX6ERlQQR
	vO2MeV3rSzaRKlzO7x50w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786119598; x=1786205998; bh=J
	4/dU5bcEqJKOnULR3CxTAr+9+TkSp/xqRUvKw1j3Bw=; b=KSyn3UysYpxQ1h1Jd
	EABYuzPI+k0UZ2pWpV1XXZq12q/ken7o8Hl8Fus7q6Q//kpGXJjugdVY6glUacCr
	URBGRh5CQo0A9DXZDS68fOncUUIIrm8hgSV7WfAc7oigAPMMnn/gwfCzOdDganik
	pdJd8MmMZ1tK6jl3h9Q6pifSw7/lIP5warZEyF2Per3a3PQgew1mWxchpZJOj1Lb
	zYgswliMu2xXSy2V31FbFw8UmzbBXBtW5+sAYSl1Sv2wclC1hTENDYRrTWhYGA4b
	kGIAMG7y5qM7jBgUyQPnBoVVBb6qWrLIjiFsiKSIdd/pYNhqa7LZzm11F0ZHRwc1
	uGLyg==
X-ME-Sender: <xms:rQV2amWgqoQuZ3gJ6GmPE7tHI6SyVqNTLA7AFgbqoUcjTCPzOwaSgA>
    <xme:rQV2alLpkG4w_FdAD1Tw8URZlKs6snk8hJOpQC0w-c5bmqJS3uFkdE7P8b93S2uCq
    H6nA1wYTgpYqkK9H5W3AKF2RC5FLy3GvIG16Oc-jl0f7U5TayPVDA>
X-ME-Received: <xmr:rQV2auDYCACB-Te2Z5qS1Xw1jeIxtSIHxVObNwefleth7yAWEYghjx8c_bVJ4mkBdWD8V-d1ihc5SDr6lUwW68aAIg4mcoUFvA>
X-ME-Proxy-Cause: dmFkZTEJHuVEstLDdAlOrrWjTIWdUA9quoxA0GV5FCGAe4XBYM7Z888qo/hU7NnNePIuz4
    rQHMSqQYQLb/Ym0RUVJfFi4Dv5CcciN2hbH5SWtoduqhzhRnj3sdJTxUYxAlvLRCJNR/KN
    hjRViy8aPjLbfjuaNjmNP9Ho20ae79z8cHu10U64OR6NOPmEeZkJIjSoJwuEf2ITSERc10
    J8ESxDecb3D3Shsvwq0USUM/DWEcqWRuFN9G5iDud6LgIwjItzePX4hie1vl3QlazsG6hx
    5XR4Mamngqoa+SytwKSA8Ry51qN7m3NIouxeWJGf0iN5wprEWgOKHjxOAcyFP6rh4GCPlt
    4VEPx//gqujkKZJyu48DSicFmu6Hjftofm0gCwXyc4TXoR13J7jtBxUrw7EfHkQnnl4Pfq
    nvOMcHt4KG9P8eDxNOAT0pVZaHnqJ1P3b6LM8dCvPQiwQRtFXQh8oeid31bQG+INKQ25GW
    fXM5uvJn7ILnzRF0LUlCVomcWnv4DdHwKE8drrG2Gzusp9/rmJ+jHdEl+2XrxuTuFmmM//
    Xierqzar/auoT54aFza6qH6Y+iyqdqGsegZs0HkR8+28+sUQnB+EtFap4Ov3nF1vpuXDAv
    l88Q4uDI0+PEIrLku/vvtG+DoM4IQ7tplDLZL4/hAj6emC4Ga64QRfy+0C4w
X-ME-Proxy: <xmx:rQV2atdMqjKemOmuH5hOxEr9J4voUTv2ZPLXPWCy8GM9p2K6zQnHKg>
    <xmx:rQV2al0RQF2jzX_5N-BtPuZE5uckrwBxmLixGQ92lcriljBLJvYh4g>
    <xmx:rQV2asioPv2GxYpTlxR-KPtBfex2mMrfL3lRqoeOdo72ZKkhNMFKwA>
    <xmx:rQV2ammJuPBzRa_LRu3Y5AKwkRT1teoqoBJocdO6C0bus7eKgfAmYg>
    <xmx:rgV2auYSktgKDwZKf8jz6lOMmIghANdkzFTFagduPVuSODqcMg0AXZt2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 12:19:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 0/3] completion of 'git [-C <dir>] diff'
Date: Fri,  7 Aug 2026 09:19:53 -0700
Message-ID: <20260807161956.1004889-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <xmqqcxw010me.fsf@gitster.g>
References: <xmqqcxw010me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary motivation for this topic is that the command-line
completion of 'git diff' does not handle paths (unlike 'git status'
and 'git add') and instead relies on the default behavior of Bash
command-line completion, which completes files in $PWD; this does
not work at all with the '-C <directory>' option.

This series teaches the completion machinery to complete revisions
(unless '--' exists), then tracked paths, and then untracked paths,
before letting the Bash default kick in.  This way, we correctly
complete 'git diff' command line even when '-C <directory>' is in
effect.

The v5 iteration addresses two points identified by Elijah in v4.
Hopefully this will be the "small and final" reroll.

 1/3: completion: no-op refactoring of diff completion
 2/3: completion: complete tracked paths for 'git diff'
 3/3: completion: 'git diff' completes untracked paths as a last
        resort

 contrib/completion/git-completion.bash | 69 +++++++++++++++-----------
 t/t9902-completion.sh                  | 59 ++++++++++++++++++++++
 2 files changed, 100 insertions(+), 28 deletions(-)

Range-diff against v4:
1:  d3c51c042c ! 1:  8295035d13 completion: no-op refactoring of diff completion
    @@ contrib/completion/git-completion.bash: __git_diff_difftool_options="--cached --
     -	--*)
     -		__gitcomp "$__git_diff_difftool_options"
     -		return
    +-		;;
    +-	esac
    +-	__git_complete_revlist_file
     +	if ! __git_has_doubledash; then
     +		case "$cur" in
     +		--diff-algorithm=*)
     +			__gitcomp "$__git_diff_algorithms" \
     +				"" "${cur##--diff-algorithm=}"
     +			return
    - 		;;
    --	esac
    --	__git_complete_revlist_file
    ++			;;
     +		--submodule=*)
     +			__gitcomp "$__git_diff_submodule_formats" \
     +				"" "${cur##--submodule=}"
2:  c3658d6ca2 ! 2:  dbb14298c1 completion: complete tracked paths for 'git diff'
    @@ contrib/completion/git-completion.bash: _git_diff ()
      	fi
     +
     +	if [ ${#COMPREPLY[@]} -eq 0 ]; then
    -+		__git_complete_index_file
    ++		__git_complete_index_file ""
     +	fi
      }
      
3:  ba5dc6f164 ! 3:  d661a1a5dd completion: 'git diff' completes untracked paths as a last resort
    @@ Commit message
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_diff ()
      	if [ ${#COMPREPLY[@]} -eq 0 ]; then
    - 		__git_complete_index_file
    + 		__git_complete_index_file ""
      	fi
     +
     +	if [ ${#COMPREPLY[@]} -eq 0 ]; then
-- 
2.55.0-655-g8b87133eb9

