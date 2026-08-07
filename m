Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90226B2D3
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115590; cv=none; b=gOsCUTueTz+Ox9taXxFuWy65WlAHYRxLhsUe2SI0+pNqrwLPlvc5BeV9SHUNUjHTQcGW0tFKIlbinBPpCfQ50ATrUsiey1erb1l+s1Wv2Mn93TFpFBMwJifHaFOTmWK40sFBWrhiP4829SZIJm3VqfW6OzVPVLi12IbDgv37mtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115590; c=relaxed/simple;
	bh=SrfZSd9JWUUzFYwe9X4lFxOVpRDjrnK8tPH+7WuuEqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=trWN3F0mGn8+Y3y5HjeCcDLU+NxrvRIXjtMFbQ69hocFmnX1yIw2HMru7cvzHSKYsGydwmrj03HmgOMQ04hSLg8N4bpnDgkB20dGFxDNP59zJa+m6VM4f3GD6g6HK3Gf/E+52XASiJfGoQr0KGLOuqFDa3pHZOP58kzj0is2eEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H7m87Diq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZ65QDqF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H7m87Diq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZ65QDqF"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9855C1D00070;
	Fri,  7 Aug 2026 11:13:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 07 Aug 2026 11:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786115588;
	 x=1786201988; bh=jNVe0dZpbPudkb/UmsC268U+UTFTzI02XoRDoJExa8Q=; b=
	H7m87DiqNoKGKG0z2+R+VOnenuzsJiypOEGPYdgbOHUkA4cgMZOhn17GdRgGRrgU
	h4a7Yv/r7KPm6ktAQjGBIfa8uLMHTJ0mSyyFNIFNeFEnH/CvEfyf2CukbRydoSf8
	zPLBhc8Kq5mE8Zeef+jmTG1aDid9EQHrIRUJ3Ozi1q9oXjLcjUCdS1l8sQ9RZqHT
	DLm8YrblLY8UQVs5/salgvswytTGxXBJAMKorCdCB5fFQbnQbmr/IEv8gx3tywam
	KuE4/cTz5zxVFyVPqFcCo4wIheUPCE9UO2VJ98dTZDMUnZFG79oZieiTnyTTXh7k
	KofjulhLjMnUHb+ovn7/xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786115588; x=
	1786201988; bh=jNVe0dZpbPudkb/UmsC268U+UTFTzI02XoRDoJExa8Q=; b=d
	Z65QDqFJ8rHHVu7/wqhmuL9cg3LkJz/26+AtLQ38y4/YjOUH8K3/FUhGAW/hbWco
	5ETKW7QrfmbSVl3Ikizop+XffPJLLLeIQQ9EhUSCf/2jgjyPQheMU3QK9n+I4Opp
	k2cwcPiIBWhjsS3p6Dw6EBxPt72kX8MUHutxECYdaFGsMRzCKyd4fX9gnMOclMZw
	8Na2wskmbhAyaQbN8m6QlOyOXbB/sityeeuEJgTlQRhJ/gcrs3oEv3rnNvnu9cNZ
	oAPVbJUB5S23krVzUmWu14leJmo33/cEKnXyOtnkzfWZ2ahAulkFtIjPmOaMSJjc
	szKWWbWwKlilPdowPVi3Q==
X-ME-Sender: <xms:BPZ1astKDDuX16c26cJqSOzYtppLMabqrb3Hi6Vz61KlRHY-miF8-A>
    <xme:BPZ1asAaRl9R-knmSteCP2cfWXywXSF2RspcIniuTvvJkHLAGP66MZiTeL4Izl-MM
    _kHZTPesmwkxaqWtBr7sIKoghpdClLotP8udRzrMptbtByEHtGcJZs>
X-ME-Received: <xmr:BPZ1ara4_zyf_tKGO8y1WBXEJn5wI4Pqn5K3IwzQlUIY_6i0hCHs8Gyo6ApGz8U-_IwMSKc1FjK-Z8a-mtslJ6lmZrUK83-tjA>
X-ME-Proxy-Cause: dmFkZTGwlpMdOBxPZHBRTeBuVen+/NtNg9B0J+wK7Yni2t1D3Yd8ETJG44bp7Hj/awRWyU
    0c8bCd06QayYHq0aSUNueCjPmhGvV3UHM/ZYF1vk8ALOIvFkFqV2kn5IoravFlE1hXB7pb
    U81Bxx2DC2duO7h3nNQPlbDbPYG03YgdyrSAdJ0C1gg+gwEZRBD4bQsb/W7LJcVIKFm82W
    Jgwbj56pXWBxO+k3QvDQB00GtlQcDHDYSiN2OaNuyjNeTys/32bFSslIRzVD9tQTPivtEU
    /OOFZm+Pya/JPTaLVbWZoIxUXdgdRyS+RX2t80rDfg71qP1q5xkT1OeI1nj0CFTqSZcQnj
    Eeufr26VhtxSTcwxyrjDQjHbB/dJFtw3KzeMPQpz58G1NxsmU03jFfveGul8AFrSIomUUk
    bgrD+5XWo2gdSjTI+0lWSLISL5EkOsZtD/u7W9li/vfeLvY9jr5mCbLkdwzcyZX1rtXH8n
    etSA6gq771QIWpgvOgJDBkBE41cRvv/beasEyPyunnPWjg+ZTEX36+Km2X1zTQLmFJAwWa
    huX2zA2vjeh4jWHHuoA8Y4P8tqNVTYzJcraSwfYTb+hk2sI4Kbz6ustrZTBAP2vTZ/2Wvc
    uW1ZhuDY0+Oqluyo4XX2S0bY+syA5246zDVmgs+ejxtWYdSCoNH/BAZecT/A
X-ME-Proxy: <xmx:BPZ1avXeKeKlMALnIGrs0dTFvtmYqaTtEY5NEdjv-ZJZaq5xsQDwyA>
    <xmx:BPZ1aiM8gGugIURS5Roy8Qb8unQoRSjKnllpNl6ZL2irFaVM7oBlsQ>
    <xmx:BPZ1ahbDhtfi4GNYfcUqYvlUyOxYMFiCrzwGNhzzcpbco42IFhfDaQ>
    <xmx:BPZ1ap_Q9Yy40dvPRSCPduA6nEFVYCFJXA30y-fHhGUr-kag_lPqLg>
    <xmx:BPZ1alLoIc9rYCvW96GQ9KVEv83XC-lOHCem2hkH-X_EpbtyV8XA5WGg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 11:13:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Britton Leo Kerin <britton.kerin@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 2/3] completion: complete tracked paths for 'git diff'
In-Reply-To: <CABPp-BEAtpT208afwSNoBbR-Nowss8OsLsL8ynETuBfN_xvWag@mail.gmail.com>
	(Elijah Newren's message of "Thu, 6 Aug 2026 23:18:05 -0700")
References: <xmqqcxw010me.fsf@gitster.g>
	<20260807013830.698340-1-gitster@pobox.com>
	<20260807013830.698340-3-gitster@pobox.com>
	<CABPp-BEAtpT208afwSNoBbR-Nowss8OsLsL8ynETuBfN_xvWag@mail.gmail.com>
Date: Fri, 07 Aug 2026 08:13:06 -0700
Message-ID: <xmqqldaiezgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Thu, Aug 6, 2026 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> When completing arguments for 'git diff', _git_diff() delegates to
>> __git_complete_revlist_file(), which only completes revision
>> references.  This is good [*], as mixing both revisions and paths in a
>> single list for the user to pick from is simply too confusing.
>>
>> If no reference matches, or if '--' is given, however, _git_diff()
>> leaves COMPREPLY empty.  Bash then falls back to default filename
>> completion in $PWD.  This fails when 'git -C <path>' is used because
>> $PWD is not the target repository.
>>
>> Update _git_diff() to use __git_complete_index_file() when '--' is
>> present, or when revision reference completion yields no matching
>> candidates, so that tracked paths are offered as candidates.
>>
>> This changes behavior even in the case where '-C <there>' is not
>> used.  The new behavior omits untracked paths from suggestions when
>> no revs match the prefix but matching tracked paths exist, which is
>> more useful in the context of 'git diff'.
>
> I'm looking forward to using this.  :-)
>
> [...]
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index ccd3b2a372..845fd19f70 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1981,6 +1981,10 @@ _git_diff ()
>>                 esac
>>                 __git_complete_revlist_file
>>         fi
>> +
>> +       if [ ${#COMPREPLY[@]} -eq 0 ]; then
>> +               __git_complete_index_file
>> +       fi
>>  }
>
> Curious; __git_complete_index_file() is documented as "requires 1
> argument", but you pass none here.  As far as I can tell, it works
> anyway, but feels like an accident:
>
> 1.   __git_complete_index_file CALLS
>       __git_index_files "$1" ...
>       (Here, "$1" == "")
> 2.   __git_index_files "$1" ... CALLS
>       __git_ls_files_helper "$root" "$1" ...
>       (Here, "$1" == "", again)
> 3.   __git_ls_files_helper "$root" "$1" CALLS
>       __git -C "$1" -c core.quotePath=false ls-files
> --exclude-standard $2 -- ...
>       (Note that $2 is unquoted, and since it's empty, it disappears)
>
> It seems like it'd be better to pass an explicit "" to
> __git_complete_index_file than to implicitly get it.

OK.  It feels a bit strange as an API for the function to insist
taking one and only one option, which forces the caller to do

	__git_complete_index_file "--cached --others --directory"

when the intention clearly is "we take zero or more options that we
pass to ls-files", which would have been more obvious if the above
were written as three separate parameters, but I'll do as Romans in
the (hopefully small and final) reroll.

Thanks.
