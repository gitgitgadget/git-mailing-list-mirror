Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786E3C4172
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950993; cv=none; b=P2La8ru4Zc0QLUZixXab8J7QIl8/MxgS/kveoxpKNHjiS9M2bGIYza6ANtw6CThUIfKozUS9BGycXW9iqUTzpnGTp12hBjh0+R9wj6nhUBUAEQ1dYjj4n7KOfRmu3TaTSVDXsqs1S0lcWJx0nTEhmrAw2FXb6ktq5lp+iVP/Has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950993; c=relaxed/simple;
	bh=bIdq0qYJ6yrqcUmV6EnPPlKgWHqg5YX52jnb2X/ggyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCagu8qIFXHe954z1D335GtSMB7XZQ/ofuwh3fztfnHJFCGvlXDoHWHKYs0pDDOIJgIFOAAU9KodqZG2HBrZRmRo6doKPlLrdHKGefrvhUyjW1pcB0zVa9/tYHqepYuVSQ5gCvOFFEgYXhjnrmurxz944yGd0hBViO54DJab5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r3y8+753; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=km53TnE9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r3y8+753";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="km53TnE9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F36D1D00163;
	Wed,  5 Aug 2026 13:29:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 13:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785950990; x=1786037390; bh=PLN+hIWuxc
	4Hswm5THtC+ZviORRnoEFAt9y1cFzpet4=; b=r3y8+753fBmS4C0ay2EDdo1pd7
	tCe/qi0q3Y/2Clc58nXMxhFqt8klWltfcwLyvEV4UrmB1Xn+PBpOYSENBI0C7VWG
	x9CDZzP/E7twrQztDqb2W+EaMDNcXsLaIhMBlXrQr2apJcCNIdWHspyugGtNTzA1
	4J4H390RHtKv/9lX0sYbAUBnZvdf1fThkKYryXg5SC4gipvxIho0LyRICD+1oJb2
	uwmfKD+Ec9mD8/OYU2Wl1GV9a4BMKAUiW4f4gS5d8IvuCzt93LyXg1rFvs1+Tlfc
	B+OFgzTDJzdydcRv3aejfbolF84M+U1mpkGmxzWpdvSrNNEVo3B9drAqUG2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785950990; x=1786037390; bh=PLN+hIWuxc4Hswm5THtC+ZviORRnoEFAt9y
	1cFzpet4=; b=km53TnE9vGeTxlebmoT8yvXzPpdsr5KwvKfvGWk6seV8dQ8JZaA
	k9VE0CBHq5idOuNB/5r+UZwSc6Yf3YbZNRFXaFsD1H0Su+76Fe6lrt6IzsBKhiIX
	Q2mymrrPIA4N2Ki5dBUPMXnnTc92zx76AzJeEcyafsBovJQEmKnSkOBKIV8l7llL
	YF6bNSnL7Mk+avX6c9uCJUDGVxvRV2q2fEYh7q2slBWoMHn87gLr+huBw6qyi3Ac
	gBF57e5vZFo/YpxfHshnaFWgPUqm2/SpyjYjWExQ/eb3JJPn9gyykM/Btpv5QT32
	Px76Jrq+CqZirISjtcxT9dKwv1wRpMggAtA==
X-ME-Sender: <xms:DnNzarmbUq1MebWWmfWO2aofwj-EhsoCMAMqX-BDQxbH_RtCQr396w>
    <xme:DnNzal1Ez2P2JDXEAXJdqCs_h4TCrQw4KCABOkZmQNJselY_kBU-eV9MQOHxEyKhJ
    1bcEiEEcVV5PyB7a7iSiTpa1ay-HWeUyCHBTybxcIyDBczatuPxSQ>
X-ME-Received: <xmr:DnNzamq3UdAKndDQ_X6W-BXpSqdikR655JF5uTAjqJ6oeyoW7jLRXAKgsZiUiEb82rWE2yFZNoTF4vZzUHhcC4T16LQl8Bz7Ng>
X-ME-Proxy-Cause: dmFkZTEZqlytj25sdIOI2VgU4W/XvdIYIK3R5sVyMDbH4laJ3XIFwsrOno3mqVk4Bq8BkZ
    L4vuHimeYUsDQOc2PugvQaDBSXVo3yBGoQYH1Lr1B6E9kuBJi9dPhb2KKwIBKMn4vxwUB0
    G6y3Oce21VZsJFLG9vXvzeC+HuUD0XO6oUjeYE/H+SRQPvYKIOJp5FTnvu31kvqHT7afeD
    4Mg17rtslFUWCo6KPLtLqDXsqaNSbnzBVVGVuP6fIJTF1jldNTtwaX1/qn08TTwDFkX7dw
    JbdmT7+2vIss4oKzpqA2Y4/adogAvYnn94FS4Uc0byP42pBBN0lRqteoAW+3HV2X47yRB0
    JdWBvj/yU/uEW2NDVZo6M6ggsnczpSOJCLlS5VsRqE/F11GCzGnh/eaqL1MR8DVCYSTIy5
    CjJEZme2NXT8Cc0962NAt3Lw3tE3dO3t3e7DO6igeXHulq0NnKKeVO92UkFwEEQg9m5Hc2
    GjpRHXGIdu7dgdCdJu3w/pIPlfaqaaSZpMQt9yJS/cDppZh4eCV0ZAKk8XM1ARv+tFqLrS
    W73ymvuWSBHlfqtkfA6wM2KMg8BGXG9E7uAg0RMNPQ8x0p10ILB/aiy9/pelGmFxCRsT7I
    4A4t4l4wvjorm2I4y5iU8/m5R3tw1AfeK9/HtYsq4TVEVf4IKKIisQ6WzfDw
X-ME-Proxy: <xmx:DnNzaidibPgWeJvwTVYNLhFuH8Dg2vzz-2mMWsHKf1Poo4JWTcd2rA>
    <xmx:DnNzaloKiiEFs_HJUZOVdqbPchXIE5XSgw_Kx3ftvTDBV1b_3I_mhQ>
    <xmx:DnNzajGSoTLmiO_5ob8txlR0SRbyjNImv-OgbYwMUcnnF5NV20ainw>
    <xmx:DnNzaltYOoMpkYd9y7X-pF9-Va0guRASSXgvDSuv8x_Q4LiCRhbIJg>
    <xmx:DnNzakDtsFxGB-9TSwJNZPx67ftxayDAFJcG7LwF4von5qj1yFSxraYB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 13:29:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <1593d1d1a0dceb58640cfa56b49bf30d8a2c6365.1785939999.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	14:26:34 +0000")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<1593d1d1a0dceb58640cfa56b49bf30d8a2c6365.1785939999.git.gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 10:29:49 -0700
Message-ID: <xmqq7bm4qxv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -                ifeq (CLANGARM64,$(MSYSTEM))
> -			prefix = /clangarm64
> -                else
> -			prefix = /mingw64
> -                endif
> +        ifneq (,$(MSYSTEM))
> +		prefix = $(MINGW_PREFIX)
>          endif

Mental note: if $(MSYSTEM) is not an empty string, we set prefix to
$(MINGW_PREFIX).

> @@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
>  		BASIC_LDFLAGS += -Wl,--dynamicbase
>          endif
>          ifneq (,$(MSYSTEM))
> +                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)))
> +			# Override if empty or does not start with a slash
> +			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
> +                endif

Mental note: MINGW_PREFIX that does not begin with a slash is forced
to begin with a slash.

>  		prefix = $(MINGW_PREFIX)

And that becomes $(prefix).

> diff --git a/meson.build b/meson.build
> index 7073d5844d..6ddc461873 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1318,7 +1318,6 @@ elif host_machine.system() == 'windows'
>  
>    libgit_c_args += [
>      '-DDETECT_MSYS_TTY',
> -    '-DENSURE_MSYSTEM_IS_SET',
>      '-DNATIVE_CRLF',
>      '-DNOGDI',
>      '-DNO_POSIX_GOODIES',
> @@ -1328,6 +1327,18 @@ elif host_machine.system() == 'windows'
>      '-D__USE_MINGW_ANSI_STDIO=0',
>    ]
>  
> +  msystem = get_option('msystem')
> +  if msystem != ''
> +    mingw_prefix = get_option('mingw_prefix')
> +    if mingw_prefix == ''
> +      mingw_prefix = '/' + msystem.to_lower()
> +    endif
> +    libgit_c_args += [
> +      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
> +      '-DMINGW_PREFIX="' + mingw_prefix + '"'
> +    ]
> +  endif

Lowercase mingw_prefix in Meson world corresponds to MINGW_PREFIX in
Make world, I guess.  -DMINGW_PRFIX gets mingw_prefix which begins
with a slash.

I do not do Windows or Meson, but doesn't this contradict with what
we have in [12/12], part of which says:

diff --git a/config.mak.uname b/config.mak.uname
index 2f7d445eb3..0b63be10b7 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -535,7 +535,9 @@ endif
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY \
+		-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" -DMINGW_PREFIX="\"$(patsubst /%,%,$(MINGW_PREFIX))\"" \
+		-DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
 	# invalidcontinue.obj allows Git's source code to close the same file
 	# handle twice, or to access the osfhandle of an already-closed stdout


IOW, -DMINGW_PREFIX passed to the compiler strips leading slash from
$(MINGW_PREFIX).

Isn't it necessary to strip the leading slash from ming_prefix also
on the Meson side?
