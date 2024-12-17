Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967031D5CCC
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437842; cv=none; b=kkKINwYu8Us2me16aKG5l0jB/fPdOQ5ThVFGw8HI3+Rs2uj/GKWK0/n87RGVH8e8zHmcarEtwtu76DQD5zRN82pt2AvxobG8ZdXMkYf5Imi89Le/MT1tp3rANWPaJgcJXg/Ls7sPNPWzAMhBp4MiL4XFlgJAHEKmxXA8o1WyAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437842; c=relaxed/simple;
	bh=P0j22z07qOt/XUlXPqp0zgC/yEjWAAWOJLA7aLR2i3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slxPdeP1ZuMJW2ebh0dK/+CuFcLsA6cQEYteTXfmASSugbLNDU6rguIhzXuIz8HN4e1JAuw2vvQX/ooqwFDMSKxtP5u7zhXQCjsqzm69lSPVm0K/K4bxqkgz3NwNv/yqEtPnv7AFQf2tFZzjUx4rIXO8BBhwf1Q6GtZFvfhP2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiNlofmJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiNlofmJ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725f4025e25so4380840b3a.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 04:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734437840; x=1735042640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYHhYwO/jtYAhqj6gHmDNHmgYphkce8G+/PUomOJ7ds=;
        b=WiNlofmJrLiGtmS8uf6dSTPHb+yXUDhaitlv2f14EdHf1b1QYwyjMyM6eOAfJWJcTu
         TAD6JEpBxGfTAjUwQwJ/y53P2kZAaO+NXHoWJCfP9sWiO40+pYHOUYlNW8lDLOuee09m
         /YzSuByfopsJrf/uV4SLsssx6JISde905bY6mPkqKfPq/0D949IpwK5Fn88cOaRjszNK
         PrmLeQ2L0rJgh+nS7J69IrJayae/s2dpbngvXuEYsAUmEheO4sskRRwOL/z6ahzwJVEG
         8pyzlUhmBtGls8yRearzrAQfLexBPGOdGYZTMISdFK1ZTIrSGmSfDLhNnBF10g7pjQaP
         TQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437840; x=1735042640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYHhYwO/jtYAhqj6gHmDNHmgYphkce8G+/PUomOJ7ds=;
        b=NUEczxEkUpp2Y4b+s84WXid6VPQuEYSKMX22lgQF9C0EyIHDkGdRp2NbQxLt99kFSk
         JEolJQYrteCODQLkSp8cyAhMMW1IyPpClA2mlnNC0XMUDDmX/A2XbfXmDrqc+M2q2OCQ
         w8+iwDr+KQdLAOrarQNT4+s5XNYNEbLMjNhP39NLabbxj8uE9g8v/gJt2j9JxfjoX1n5
         lI2sjg4lZISu0CdPCeUP0tFZk2jNO4Uth8hrQ+i5xDmB5tweGGoGt6iVcVCiCT0Au8Me
         r6IHU5py+I+YPMCJBPcqdNIzSI0ejo9HAEX9YzlrNw3FJqpWi+rkgNB1EAYb7EWdzlI8
         OYug==
X-Gm-Message-State: AOJu0YysaXIKaowgZhhLFAARtSQAjeTqaP7gQCkYugdEQlysaXB4Tcqw
	0WXwNfXuTOf4nb7j7Vtm7DsZxamEaAlcRNTmijgBlpf9bZxJfYfyf3FUWA==
X-Gm-Gg: ASbGncu2o5yk3MHCTw6PtDfA5DE9yPkISt82j/wDWUtHf/LqUzjc4T92ixC2O7L8ivX
	DAs4hyyZ8ILWHOuUIGu8f9kOLX3hHvCoZmNt0xvNovYSFO5/lQq9MjXYyr/FAopgTELtro1x/Av
	yVDM0LTiRKc1ALeATzjuHfhMSlawOojwXMqU7UTGw34cqwzXxSG9IKzubTuYyJnMsH3V1qL+aGs
	uCgLqdEvBT4W9EjaBHlnFHZ/HngPSkAAeG8x0LBs14e6dDFGG91
X-Google-Smtp-Source: AGHT+IFC5AnHvElsdcL5bTiheqfwAjxzYp2jabhaAFStCsAHrbT7h8ulpDH/x01bJVUG5dpsGk0IzQ==
X-Received: by 2002:a05:6a20:431b:b0:1e1:a211:bb4b with SMTP id adf61e73a8af0-1e462d60913mr6767375637.31.1734437839843;
        Tue, 17 Dec 2024 04:17:19 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad780asm6719727b3a.66.2024.12.17.04.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:17:19 -0800 (PST)
Date: Tue, 17 Dec 2024 20:17:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/14] pager: stop using `the_repository`
Message-ID: <Z2Fr90U9ujGFv2IT@ArchLinux>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <20241217-pks-use-the-repository-conversion-v1-2-0dba48bcc239@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-2-0dba48bcc239@pks.im>

On Tue, Dec 17, 2024 at 07:43:49AM +0100, Patrick Steinhardt wrote:
> Stop using `the_repository` in the "pager" subsystem by passing in a
> repository when setting up the pager and when configuring it.
> 
> Adjust callers accordingly by using `the_repository`. While there may be
> some callers that have a repository available in their context, this
> trivial conversion allows for easier verification and bubbles up the use
> of `the_repository` by one level.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-patch.c     |  2 +-
>  builtin/am.c    |  4 ++--
>  builtin/blame.c |  2 +-
>  builtin/grep.c  |  4 ++--
>  builtin/help.c  |  4 ++--
>  builtin/log.c   |  4 ++--
>  builtin/var.c   |  2 +-
>  diff.c          |  4 ++--
>  git.c           |  8 ++++----
>  pager.c         | 14 ++++++--------
>  pager.h         |  7 ++++---
>  11 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/help.c b/builtin/help.c
> index 05136279cf7b1007ab754f5630c34536a5f9461f..c257079cebc3c09fb91f258c3b0148e2f204c0e7 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -658,7 +658,7 @@ int cmd_help(int argc,
>  	case HELP_ACTION_ALL:
>  		opt_mode_usage(argc, "--all", help_format);
>  		if (verbose) {
> -			setup_pager();
> +			setup_pager(the_repository);

It's possible we run "git help" outside of the repository. Here we still
pass "the_repository" to the "setup_pager", it may be a little strange.
But later we will use the "repo" parameter instead of the global
variable "the_repository", so this is OK.

>  			list_all_cmds_help(show_external_commands,
>  					   show_aliases);
>  			return 0;

