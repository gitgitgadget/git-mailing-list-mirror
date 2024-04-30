Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EB180A74
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495118; cv=none; b=r7/IxZhovuR1DOugi9vkaB4dWq/L38NP+WbERzbiPysKLPGI0TJoNnNG1l811Zfo8yoXpFlKnL60GqxydEDahrCnRe6ZAQ+BYlwg8GLO7PWX8Zqs7WWGg8HvEHMYrjPpANk0ssTtItTMDyYIy2y3uRv1Eq/m9Y1topVZV7bNsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495118; c=relaxed/simple;
	bh=lhikxmxFOyNPyJdBP9holhMPUfG3WOuduf+H1rtJh5c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g831KXxqCqfByI9NdN8FOdPa6DIGBEwVRBkdtxNhTlWcoLMCUxnZtFtNOA48drceL1UPzztlSJeaVo3dbUgO6CkA8Ie6CmuAA4HZ2gCH41VAm4L3WFCP7/Q1X8itLnS7D0RwJZjdB0kXrWLl/qhrjTziJ2vfpjevZK9e3PsKPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE2KxuNe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE2KxuNe"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so68871751fa.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714495115; x=1715099915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YoSYizTreEu3W9RLcd8ppo1VewEfhJsWSIBHVUaD2Ls=;
        b=bE2KxuNeLb0a2fp5wLCCw14dk+XWPx8EOe+0iHcwewTsZfmyTaCC4N0rfEOH7l9cwY
         Aoo4fJJyoxpNIN+48WZEQ488n9x2daRCinQhWWnKLoL9/Bo+wKLyYrhAisdd+GinpakB
         DLxIhp7uIT+JEohprY0Bf2GYZ5RjD3ypKmvhbxXy8HD/CpLKCXWBshwwSHXuVxEpV1Ne
         rwc1z3i9Ax8Ts/oOPgAw/wEPISbaUXSJJUuczRUS6pmiMAWMjkW+5+aF9fPn9mP361sp
         Q3eel5DhJCZcorQTvKxrTn3fRCL3OR3zgSxsmi5x9pF6Y1rI4jGRmdKeUFFuq9NFiyDz
         zA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495115; x=1715099915;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoSYizTreEu3W9RLcd8ppo1VewEfhJsWSIBHVUaD2Ls=;
        b=ZfhbX/J0P4d8v+wYxdxnONpCkAYg5i4I+JQiMetLfNgFvkJXK47w24dObl3Pu8esdO
         VAOe5IH2mWLEOdsUf07cxant2x0QIeFEYTIyzXHSZXW4vfIrb5n0viBBInCqNURykIw/
         rsIz9lcVIkt2iondT8RcELEr8dX1Pus9nsQWTvY2hK6qjXACzPno1AXGSiqbuF2FnPqD
         viruJ2k9PFM24bxQr+C9g8QHqqzWYm6PnRDcarvarxymgMQesQDmBh2XsBLRUfE/Mt/t
         OYqbz/OGel8atgkdkJ+E8J1x8NPjYfpFiB8n/o2P2aYvIfyFoijwMfltswFmVLd5Svsx
         TRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1fh/UxFeyXzxDgJkFoYWYcnz69ujOLVTS90ZIJ8PHmwos3av8arGvSPXu3BJ/UTF6c/BDwLD/S+9X55vMN652AzVf
X-Gm-Message-State: AOJu0YydYNmlL860FerBvluhXKlo/u5EdjSmCAiQhXIGuCLKXVPX5j6M
	6+hPFdoUpQkFA/EO8kpjLEL/pm3h+ypDkxCRiU3Ktdt7FZpZB+v4PGEjTw==
X-Google-Smtp-Source: AGHT+IG36LCKXKwuJsTojgkuctfgMttkwM+wmEmJOvLD42ueX32Go+ffdGnUeZdW+siInZ5xeWEyRw==
X-Received: by 2002:a2e:b53b:0:b0:2d4:5321:9daf with SMTP id z27-20020a2eb53b000000b002d453219dafmr96468ljm.44.1714495114696;
        Tue, 30 Apr 2024 09:38:34 -0700 (PDT)
Received: from gmail.com (51.red-88-14-204.dynamicip.rima-tde.net. [88.14.204.51])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b0041bfa349cadsm11499656wmo.16.2024.04.30.09.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:38:33 -0700 (PDT)
Message-ID: <ce11355e-25f3-4d76-91ae-bd561143dd49@gmail.com>
Date: Tue, 30 Apr 2024 18:38:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
 <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
 <27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
Content-Language: en-US
In-Reply-To: <27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Apr 30, 2024 at 03:47:04PM +0100, phillip.wood123@gmail.com wrote:

> > @@ -1778,9 +1777,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
> >   			break;
> >   	if (s.file_diff_nr == 0)
> > -		fprintf(stderr, _("No changes.\n"));
> > +		err(&s, _("No changes."));
> >   	else if (binary_count == s.file_diff_nr)
> > -		fprintf(stderr, _("Only binary files changed.\n"));
> > +		err(&s, _("Only binary files changed."));
> 
> These two mean we'll now color these messages which we didn't do before. I
> think if we hit this code we don't print anything else (apart from the
> warning about add.interactive.useBuiltin being removed) so it probably does
> not matter whether we use stdout or stderr here and I don't have a strong
> opinion either way.

Can we consider those messages not part of the UI?  IIUC, if we hit that
code we haven't entered in the interactive UI.  Maybe we should:

diff --git a/add-patch.c b/add-patch.c
index c28ad380ed..b11a435738 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1780,9 +1780,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			break;
 
 	if (s.file_diff_nr == 0)
-		err(&s, _("No changes."));
+		error(_("no changes"));
 	else if (binary_count == s.file_diff_nr)
-		err(&s, _("Only binary files changed."));
+		error(_("only binary files changed"));
 
 	add_p_state_clear(&s);
 	return 0;

Or, simply leave them untouched in this series.

> 
> Best Wishes
> 
> Phillip

Thanks.
