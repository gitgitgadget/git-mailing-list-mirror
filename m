Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C947A72
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828947; cv=none; b=ozd4XO4srYj6YP5YfRWPEZLn7dVH7hi5aC/mGrLgkAfSZvKNabvJbHSePmBYowkBnE9p4H3It4uiAvHDhqci7XGFkoIvcJisE+FgMsrKhEABygtOpEhGjC13uVLmcMXrA3vQSlPBb0h3M3BQknEsk/cbWdYngMV2II+MfPQHEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828947; c=relaxed/simple;
	bh=NrbCYYU5v81BzQAwrD0XoAW72qmiIOABR7mOI1tFyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWiZ89609rgp7LuvA7gNGvDoVtVyQH3a0oLCoNl1isJAKiE+Nme3DR9NWPcL1FAILgRl+6Hurc7J244XYjhWgd0aQGBy3IezeeogxN81p7DZ0MbrQn+DjVHRe2ZcfDOIAfbmIRotiAoRkXLrRFnxq8bfjv+RS/pdosvr7FmMqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBALniOK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBALniOK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d71cb97937so14166605ad.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706828945; x=1707433745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EzPFmwkoQaJBaGwetROcXiiFf6AT5UQhLD145DTAdc=;
        b=sBALniOK5dtgBQxUI9MHHySnP4wt5RvcYHB+tFvNSkYh1/1iGObKKZZBXCUkxgCrZX
         77ZRRwIuB5CtbQ8/LtH2qj0Kgpom2nGI5KpI8Cl2MuexS3aZzB+zncu5yze7ZkW7VOcG
         j8tOxYKZA3vjspm0gsT1Cfri5qefywb7YZloliBRt/kucitrZ+Z7qTg9EDjfF5OPd/p7
         dak64ZHgJkOKiq15xxgzEtIKuYz5kz33WqDTkIAbxbrpHzJlxxvvCtrjJNp5elCdFJuv
         ZsFHWUgoUr+GglFS/dzFRdK3LN6EcJJRdNo1GbK3jqnrC+lZz663MD57W/Mdmf4F5lbm
         k/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828945; x=1707433745;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EzPFmwkoQaJBaGwetROcXiiFf6AT5UQhLD145DTAdc=;
        b=msEnWW6OEk5C8xct1ZtAS7o9GM8PihYkp2KkkanUMnmDTWIBgkUr9C/WcfTZSVC2xI
         zQ0P096mflcWU3wUcyOugRGPgv6l99+QAQLoQlX9OHmF0DRKKJs1zLLzP9b++PvnzdwX
         YVG19Qvl96WH+0dmHhcqCGWXEOJ7Qh+zheE+LNG/6QSnmI+41K1jjFrVRXBA1RBj+08O
         Wtpd1BRskHj3UEtX7QuezcNzFrUcGf4fglk4fpIgsmGGltiNANTMkwPafgB0/GYfW9jy
         7u11qVRX5nbkCoodkoi1Ef7secC1hWtDCL3YyZH7ISQdBYQcROW+gboPs70+p1yaB/SL
         qOdg==
X-Gm-Message-State: AOJu0YwFtznvhIRh0coYj3c3YUWLr4s1bm0aikBOgfNGHFAq4Ucd69Rn
	GSZ3xuy19IKpIgtHyQCNzDu+CTpk4TisdUU2Rz00VWec63bzVpRjOxjyNT3fag==
X-Google-Smtp-Source: AGHT+IHEc4GPcXwVu6jJZ7q8JtdK2hFCZZh8/iaFgkqxv+JZV3QbRqxarroYECDgUuVtp1Z3iQ+VfA==
X-Received: by 2002:a17:903:22c2:b0:1d9:3d72:b282 with SMTP id y2-20020a17090322c200b001d93d72b282mr6641286plg.31.1706828945004;
        Thu, 01 Feb 2024 15:09:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEX7tC6vgUWdNTiq1CVfvAOVaIBV3v0ehVXYtpESw3cvMSnK/60CP5gw2nbo6rmR9uUrdCAzynabIQQ53Fg2TJAAwWpntg+lfx6X+mLshA5GJZFTzXa6Lo97cApDqmVWfezrnoXk5KSNXsgV5HDGYzek6yGkY=
Received: from google.com ([2620:15c:2d3:204:4b5e:af03:86e9:bc80])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902c98a00b001d95eebffaesm353903plc.88.2024.02.01.15.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:09:04 -0800 (PST)
Date: Thu, 1 Feb 2024 15:08:59 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/4] test-tool run-command testsuite: support unit
 tests
Message-ID: <Zbwki_Dk2hGRce6Y@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, peff@peff.net,
	phillip.wood@dunelm.org.uk
References: <cover.1705443632.git.steadmon@google.com>
 <5ecbc976e6216b941e760e096e166ab432ee7784.1705443632.git.steadmon@google.com>
 <xmqqv87sx3y2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv87sx3y2.fsf@gitster.g>

On 2024.01.16 15:18, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> > Second "--(no-)require-shell-test-pattern" bypasses the check that the
> > test filenames match the expected t####-*.sh pattern.
> 
> This one I am not so sure.  Do we still have situations where
> erroring out when fed a non t[0-9][0-9][0-9][0-9]-*.sh script is
> problematic?  IOW, do we need to keep it as conditional?
> 
> 	... goes and looks ...
> 
> Ah, this variable/option is misnamed and that is what invited the
> above nonsense question out of me.  The logic this option disables
> does not "require" (and error out if the requirement is not met); it
> is used in a loop over "ls *" and "filtering" files out that are not
> the numbered scripts.
> 
> But that confusion makes me wonder if non-script side of tests would
> also want some filtering in the longer run, even if the directory we
> feed to "test-tool run" happens to contain nothing but what we want
> to run right now.  I wonder if we instead want a variable that holds
> a pattern used to match programs readdir() discovers and skip those
> that do not match the pattern?  Its default value may be something
> like "t[0-9][0-9][0-9][0-9]-*.sh" but alternatively you can give,
> say, "*" to pass everything, or something like that.

The original implementation and this series both still allow passing
additional patterns on the command line. Only tests matching the
hardcoded t[0-9][0-9][0-9][0-9]-*.sh pattern plus all the command-line
patterns will be run. The new flag just bypasses the hardcoded pattern.

Given that V2 will already be changing in non-backwards-compatible ways,
I think it makes the most sense to just delete the hardcoded pattern and
require callers to provide it if they want it.
