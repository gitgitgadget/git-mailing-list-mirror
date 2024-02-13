Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A836AE4
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822483; cv=none; b=Iv69i2vBOQO43dto7ZTm8iI138+vpP4dkak+fhPX/qhvpiMPx40+sceQb6/bh+8CxMcCQCgrNnquYjzVvMXsoxwxelpXnanr0kO+uR8aG5QEvoNKjPUIWAfm8q7OsQGjuZjiKUxIL0HDwPN1sRAn5THCSXYXw85gc/7JZ6Vybv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822483; c=relaxed/simple;
	bh=uSJb719ASCFvJDsr7p4lxlwxAH9pwjf8BqbnlixqF00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bv568aHzNmT5tmttHBOYpkkhmSZ/ZfL/EAbIym0ylm2PtCRPBfAVOyhVfRK8TxTmfqthFpq20hpzEsf16sOQk3X9Xm8NpbTd7dZOxI72OYhYKEIrxeQurMT4wsrvQ7hInGKO4uldgGua5FthBhfCMkoarA3q/eeU2wB3FAkm2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W21+xGTc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W21+xGTc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411a5a8653aso9875235e9.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707822480; x=1708427280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L+xJ8nmRmPN8rk6KvCsXFJ4Je91LhJ9HkxOZWWmFU9I=;
        b=W21+xGTcoikpLsHqi2dCcR48kOPolMFoUpQYFwvIWh04fo89LuZgjmOD9+k8JtubuG
         2QRA3CqWrAnmshlsems/JXb60MmIapd+syjHDH+PsnRvwJZ60jMI0DKZEQZ6ZtHuhtxG
         tFI5E0UxbfxaXjyUhQ9CzGEnCFgNEbasz6LzFrNs/4qdoi9AlnbUQmazLGOa9223VSYv
         irLzsmwyeL6NVVU2V6SZg/8fQUKkTFO+pA51tqNl2JQ4Td2HU9wrl4hmi6YEQBtB07HS
         TqTN3dIZ44/DRn8CAaVm/drFD68aB+qE8Q3+N5gK8Zl7rPxRR9NTwUYoqTtxzJv113BB
         +gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707822480; x=1708427280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+xJ8nmRmPN8rk6KvCsXFJ4Je91LhJ9HkxOZWWmFU9I=;
        b=o1X5pGYxwBMGrg3dm9uhIQPo6KcmwJujmgIZfjclfQE0RcYzTUIFYy8pD8S1N/b6Su
         ATooTmrx2cZ0slqNzizP5t2Nr6hH8k4IUCO5twLBWyEqBVh3UYj2f3slu7V8ejs/F6O6
         QOKa9C9PBHEvDPtF/QMFczgvqTz+8uCDyLJQEI94C/E8FvtCmR5t2oy5rvZT6Jjke3wF
         dq3M8JCH4UAN/RRdhm7UJ+T+0ZDAia6OWzsOn4+GJtF3+ql9Ecu///Vj3798BWW4Y/0Z
         YxRsQwIIn+LXs2qGwm6CG5VDaAbz8CuivBGOm8iG0vLAaN02OKw9b6uvBRc8IGC/C0AY
         ex0w==
X-Gm-Message-State: AOJu0YyhZ1eHqydb8hl3SjZ/cR1Uy9ZzoajcMlMcQaoHWDnMM8KeBju1
	vHgh1moWdPNatdNbmxk7rrQIDCLzJ6pYnj7t86G3HNLsbyJA1UJy
X-Google-Smtp-Source: AGHT+IHSIlFDXsvP0ddCWD16A/OS4UlLsyATzraphs6xfBbzbfmeJJ33ZxIpNXJm+bJXHmZ0wgsWVg==
X-Received: by 2002:a5d:67c6:0:b0:33b:65b3:e51b with SMTP id n6-20020a5d67c6000000b0033b65b3e51bmr6434135wrw.48.1707822479646;
        Tue, 13 Feb 2024 03:07:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdy5wX2EiSSfmVp+0PBpkRmVYpdglmZy8pI6bV8ZJdYr97GwZ3kiCXIpU4AAVtzFIQi9EmW6mtmcRP9F7EP7QeX/9VHOEDBNtSmet7UkhvJ7BR8ZWJy/w8eEFBZh0LBab9AXuQHvv6yLB682odK/lA1SRWswCwsHsdXFxvYtQcv2E=
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id c14-20020adfe70e000000b0033afe6968bfsm9217899wrm.64.2024.02.13.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:07:59 -0800 (PST)
Message-ID: <c243c260-b346-4b53-b8a2-685389ad344e@gmail.com>
Date: Tue, 13 Feb 2024 11:07:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression
 and breaking)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Xiaoguang WANG
 <wxiaoguang@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org
References: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
 <xmqq8r3p7glr.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq8r3p7glr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 17:11, Junio C Hamano wrote:
> Xiaoguang WANG <wxiaoguang@gmail.com> writes:
> 
>> If GIT_FLUSH=true, it should mean to "do the flush". But that commit
>> made skip_stdout_flush=true when GIT_FLUSH=true.
> 
> Thanks for reporting.  I am surprised that this flipping of polarity
> slipped through.
> 
>> And by the way, only accepting GIT_FLUSH=true is quite breaking, it
>> drops the compatibility of GIT_FLUSH=1
> 
> I do not think so. If the polarity is corrected, git_env_bool()
> would say "that's affirmative" when any one of the "1", "true",
> "yes", "on", etc. is given.  If you have been passing "1", you
> should get the "always flush" behaviour.
> 
> 
> Perhaps something like this would fix it?
> 
> 
>   write-or-die.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git c/write-or-die.c w/write-or-die.c
> index 3942152865..3ecb9e2af5 100644
> --- c/write-or-die.c
> +++ w/write-or-die.c
> @@ -22,8 +22,11 @@ void maybe_flush_or_die(FILE *f, const char *desc)
>   
>   	if (f == stdout) {
>   		if (skip_stdout_flush < 0) {
> -			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
> -			if (skip_stdout_flush < 0) {
> +			int flush_setting = git_env_bool("GIT_FLUSH", -1);
> +
> +			if (0 <= flush_setting)
> +				skip_stdout_flush = !flush_setting;
> +			else {
>   				struct stat st;
>   				if (fstat(fileno(stdout), &st))
>   					skip_stdout_flush = 0;

Given we're in a rc-period a minimal fix like this looks appropriate
(though it is missing some braces according to our coding
guidelines). The interaction of "skip_stdout_flush" and git_env_bool()
is unfortunate, It might be clearer if we changed to having
"force_stdout_flush" instead but that would be a more invasive change.

Best Wishes

Phillip

diff --git a/write-or-die.c b/write-or-die.c
index 39421528653..e68265a94a6 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -18,20 +18,20 @@
   */
  void maybe_flush_or_die(FILE *f, const char *desc)
  {
-        static int skip_stdout_flush = -1;
+        static int force_stdout_flush = -1;
  
          if (f == stdout) {
-                if (skip_stdout_flush < 0) {
-                        skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
-                        if (skip_stdout_flush < 0) {
+                if (force_stdout_flush < 0) {
+                        force_stdout_flush = git_env_bool("GIT_FLUSH", -1);
+                        if (force_stdout_flush < 0) {
                                  struct stat st;
                                  if (fstat(fileno(stdout), &st))
-                                        skip_stdout_flush = 0;
+                                        force_stdout_flush = 1;
                                  else
-                                        skip_stdout_flush = S_ISREG(st.st_mode);
+                                        force_stdout_flush = !S_ISREG(st.st_mode);
                          }
                  }
-                if (skip_stdout_flush && !ferror(f))
+                if (!force_stdout_flush && !ferror(f))
                          return;
          }
          if (fflush(f)) {

  

