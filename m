Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18C2940B
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759069030; cv=none; b=ZHsYsl2fOcs5aj+n6YfuD1/Z9Th72CvNHeGyPfzfXHmLVNp9voaY+BWONbgmv72fPF9bBo7YNxzh8S9qShfx4GMNYrPHl2A4mcIBOPXAR9KjSXOkWQf9X0trgSeQ7eYc0OExFl3EzmWg3ufg+Mm9eC69ualavCELRWVqCfHBJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759069030; c=relaxed/simple;
	bh=58jN5FfExanNuvyAJuarvKMAcT7f7vyR0dsEa1XltcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs6QOnj0paBFxqarP2RRXQyuFJ/ddInSglD9m5//fZTNb5pKDIQD1JUtyTfnq4v/EjkK2os/HOytd827ztIpQSjMT9VtP811EovCcDqXFsgAzP+SQ3Jwd2BDTzILPxFN0oSvaF4rNNhM0hPQn9BmQXsmTgOzSsfWpkr4vzyE8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QivlHK/E; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QivlHK/E"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-80ff41475cdso33708996d6.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759069028; x=1759673828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BolwwJb7urgoAaz45wkMFVOAQps+olQCsuPeo0fWB4c=;
        b=QivlHK/EzBjIZF+I+m/10IhoGhhCmMnuwO+gFKSi+E/gQsalCBW2aYSTES5xunCq5d
         Og46yy3BB4+bRBkih0a9Qav1QymodQDrPNqY0uXVnYGk9iC7r6sHepJkDGJEG1LzGl35
         0vJr8wq+knyB0aZRaWXxlfPs+jfn5zZh47xkIDwvrVLKywCZvc8DYdzXh7Yr59/XgBFc
         p8mX1RHJVBQoeiiavYdvJMWKCHpJMs5D67ENV1Y5ESnY4IQM73n27x6Ycs0oygh4hDgr
         xHDChVrkyELbFtkqH5nRcHGxohPM1dHPOh6CWH0xhXOh1vkHMzRqNw0z1cT44QQE2mCB
         O9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759069028; x=1759673828;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BolwwJb7urgoAaz45wkMFVOAQps+olQCsuPeo0fWB4c=;
        b=kGZDxN7ZweDzN9dFyFzlVU2hnjCxcrMG+wQzBbhCE7X5CMrLdVnzh3YDFVdSW/ezdE
         b7uws+5M8k78DwKVA2dSqT37/rATf0OTwJgh4QvcRG7S1GyU6/5VCk/7rdIxFKJqYQZC
         pGoy0/DGwwIqhowHBlWLotbZmJGhsO6Q8shlvrjtmnKXNv1oNTh+7L78cDru+dhRjSKu
         uQvl4mhzB5eetCvEu6+qClJ77MNcWhcW1onGuetju27SP14dLRraeSzWtKEBODyFIkE2
         NzgAxp58v8rq9sqW/AIBSI0a3ft8vRmv7Epm05IXQrTO56NI13zzwFg+Ibca8in5q9t5
         qEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2RpT4hOihhuSYQSUOkRaA3Kf84Hc0zcfaXtVq6w14lc9Z+rIBJeGdLdhUxrHpoSmg750=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD5lO9AkBakpJz2VcoM7Cu4oIf0aP4HNy/FBZ5wpPWOFfwqXI
	d8qOOuFkYVf/9hJDTYP7Z1FeEmxxJIJZaGyk81yqX8ruetRuccZeREXB
X-Gm-Gg: ASbGncutiCXDthSuupCu3Hw2P+SQZ98cARBSp0quqNlcGDTDP2bgNYNMMSneou00czA
	0e2LXpaTx1Zxnb4nYC8jrKEEh1G3T5c4xCXavWpriHhH/0H92K3dCn0AexQgcqSpgzp/iqEpJUQ
	6YHcNey+EtV1QvCVKLAsKGkYNaK1pBc/KJJJlXQJ97YdRzSmEvX+vLi4UMg56iNehSevIWAy7OJ
	LT8SvCkxeYVTkAXFIgM8cg09yRgIywju/n8aSkjDDZxEBbmpUQNcX4OYdw/W0Vmwxd7VGaQwcm+
	n4c9mXK3BpYWV70LMUYgeJi22h3BDedFjd1rL6AmSKdg2UNhZ1gDZ5f1apOFiwCUjJwSsxC5Er2
	5cTMDNUEuhasVD+pRtjSKJSkMYyXUM5RE+2cSyBg3RRNRIjKxoxUxxj3EtpMCJDTgHpjbHRPDvA
	==
X-Google-Smtp-Source: AGHT+IHdwz4E48pw/8+5ih90Cbc5E1B40K4npvqExogqAEbbeHdWpCOYGul/QVLF012uM9/Myq7x0Q==
X-Received: by 2002:a05:6214:2386:b0:7f8:fced:b994 with SMTP id 6a1803df08f44-7fc3aa70246mr190901816d6.32.1759069027714;
        Sun, 28 Sep 2025 07:17:07 -0700 (PDT)
Received: from [192.168.8.183] (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135b563b2sm55059276d6.14.2025.09.28.07.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 07:17:07 -0700 (PDT)
Message-ID: <be1e6cba-c94d-4c2f-ab68-e368ffe9daa5@gmail.com>
Date: Sun, 28 Sep 2025 10:17:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Revert "gitk: Only restore window size from
 ~/.gitk, not position"
To: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org
Cc: j6t@kdbg.org, Johannes Sixt <johannes.sixt@telecom.at>
References: <20250928135435.59623-1-rappazzo@gmail.com>
 <20250928135435.59623-2-rappazzo@gmail.com>
From: Mark Levedahl <mlevedahl@gmail.com>
Content-Language: en-US
In-Reply-To: <20250928135435.59623-2-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/25 9:54 AM, Michael Rappazzo wrote:
> From: Johannes Sixt <johannes.sixt@telecom.at>
>
> This reverts commit b9bee11526ec23541ddbbd75716bfd1acc241463.
>
> The commit catered to an unsupportable port of the Windows Tcl/Tk
> stuck at 8.4.1 that was used by Cygwin. 8.4.1 has some bad bugs in its
> layout engine, and forced changes in Gitk to be compatible. All this
> became irrelevant around 2011 after Cygwin gained an X11 server and
> switched to a supportable port of the Unix/X11 Tcl/Tk (it is now on the
> current 8.6 code base).
>
> Helped-by: Mark Levedahl <mlevedahl@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  gitk | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/gitk b/gitk
> index 6e4d71d585..275f353811 100755
> --- a/gitk
> +++ b/gitk
> @@ -2764,17 +2764,9 @@ proc makewindow {} {
>      .pwbottom add .bright
>      .ctop add .pwbottom
>  
> -    # restore window width & height if known
> +    # restore window position if known
>      if {[info exists geometry(main)]} {
> -        if {[scan $geometry(main) "%dx%d" w h] >= 2} {
> -            if {$w > [winfo screenwidth .]} {
> -                set w [winfo screenwidth .]
> -            }
> -            if {$h > [winfo screenheight .]} {
> -                set h [winfo screenheight .]
> -            }
> -            wm geometry . "${w}x$h"
> -        }
> +        wm geometry . "$geometry(main)"
>      }
>  
>      if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
I mis-interpreted an earlier inquiry about the patch being reverted here. Patch e9937d2a03
actually addressed the issues of Cygwin's 8.4.1 Tcl/Tk. Part of that was fixing the window
geometry being restored, as sometimes the window manager would size the main window in a
manner causing 8.4.1 to fail. But, this override of the main window manager on all
platforms raised complaints on the mailing list, and commit b9bee11526 was the response:
it was only the SIZE of the Window that mattered on Cygwin, not its location, so allowing
window managers to set the location was ok.

Personally, I'm fine with gitk remembering / restoring the full window geometry (I wrote
it that way in e9937d2a03).

Mark
