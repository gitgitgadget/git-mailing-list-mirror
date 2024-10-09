Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578922EEF
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454814; cv=none; b=jD5CB4h7pfmR1Efc1yMWpzStozm0d3ez+vUyc6ybQC5o5LvzDVjdWFvlO/58DxoLQvofqQwT+og6oeCoDG7PHGkjMbyHSIwV5fzYh8YEFc5rEPxv8wxH1FPFMu5SSubFlgAi5y6AOERSOFs/bW1Xx7QtfDzC0ZdQ52klWJUd8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454814; c=relaxed/simple;
	bh=FDC0iVEDWnu9Iq1CDumYFxxr5uQGb+4g7pIUNhzOv2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0JZ64DTvQujwCjtLE8PvGlQLrd6b3Yw8Y/5eA+j4B6ahHXTC2oXdK1FEPVYxcDCLzE+dPM5w9xNjMQqK971WgNjkn4BRISgln3X7cwt9mk427wCoDCDJyv1f493YVfldS3EReWivGv13PbYPcsv2Opw9Wg8vIkpAaLeaUebJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU7I5BW1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU7I5BW1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e29522f0f1so896842a91.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728454812; x=1729059612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbV8y2zWHU93iJeEpNjpx49qUFwa/2mQidkgrfSjqW4=;
        b=VU7I5BW1YlzOmMU4xZsS7YvfDWKx7QX2Ld2gy76OwanRUQeNscD+34BUmzvq2Ol/Ht
         KIIgbH1Bno/I+2OvaKH/6L2PbHKibqCawGEtnGzDMpvFPLVLZZyPh3p91PsY9E1I5CIG
         MBAh8X4NN4+fB/KC4RzuPA5iih6RcRmBqpUgh39eRWMHXt4QnBqsOtlzFd1WGhZrS/TQ
         0OZslxr9ATQfG7N4hZzgKLhBN1vFRoC0ZKkHu/QDBdMo9ur4DXsV6Cih/58NZ1kPgtgr
         znTlgpcvVidshImuNnFOC789d+JbTVrJl0VKEGoMdYO8CezdM/9+80fzwMigCaNKj//d
         d+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728454812; x=1729059612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbV8y2zWHU93iJeEpNjpx49qUFwa/2mQidkgrfSjqW4=;
        b=Z3CMzyWY05KvgdLo9fLzbCM2oBvLjYUoCvuAQ5jvnWgAIKxzo6k3Cn6bABygOuNz0b
         YVzJ8VWNn9FM0BnQ27Rqdr2gq6gmH2REws1QWgoe+mkey9C6SpQq0SmIYflsQTMZioi7
         k5d4cYDTrWgfFFggK87+UlZ7IToAMzHqw6wx8BmZSDFiWvYSMB8VcWMUQgLPUm/BmViG
         qolkCMPFOG0PSPrBIpa1KOIPba4k+jxND1wPefzj889OUP9/rNV/MFMHn314ezdGWF9r
         qqVByeycR0hkkTiuC/IEa20RxsNIfVvWx5qziT6bomJQ3R5hl+vMqzmatq3F6rFQkAR2
         UnQQ==
X-Gm-Message-State: AOJu0Yz1mcMX9GtkWdKGepERlPZzXYpGSh6PvpNejH9DeGhnSBFvWZqO
	Z922exPbmufDVBi2z8Voek4oM/oLiuTyVdq1BLq0FOTnsyzNbWV6s7oDIg==
X-Google-Smtp-Source: AGHT+IFGPbwsbd812vcBwCBBfcK0QnNkWnbxvo3QNbHcAl/SHLdjvNau/l7a5SMTTXRY0hteLoKIIQ==
X-Received: by 2002:a17:90b:11d5:b0:2d8:9f4c:ecb8 with SMTP id 98e67ed59e1d1-2e2a2335c89mr1983677a91.13.1728454812019;
        Tue, 08 Oct 2024 23:20:12 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:904b:28a0:64b5:6637])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55fe0cdsm737765a91.23.2024.10.08.23.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 23:20:11 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:50:08 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [Question] local paths when USE_THE_REPOSITORY_VARIABLE is not
 defined
Message-ID: <ZwYgmNe6qk6jBZVT@five231003>
References: <ZwQSWcmr6HWTxxGL@five231003>
 <ZwUkUuQgxaE2-djk@pks.im>
 <ZwVzF9Xgn72tT5Ee@five231003>
 <ZwX7ieAvmjQma45E@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwX7ieAvmjQma45E@pks.im>

On Wed, Oct 09, 2024 at 05:42:01AM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 08, 2024 at 11:29:51PM +0530, Kousik Sanagavarapu wrote:
> > On Tue, Oct 08, 2024 at 02:23:54PM +0200, Patrick Steinhardt wrote:
> > > On Mon, Oct 07, 2024 at 10:24:49PM +0530, Kousik Sanagavarapu wrote:
> > > > Hi,
> > > > 
> > > > I have two questions but a bit of a background first -
> > > > 
> > > > [...]
> > > > 
> > > > So my question is - do we want, in the future in which we are free from
> > > > the dependency on "the_repository", for all the local paths to be a part
> > > > of "struct repo_path_cache"?  Which in my gut feels wrong - one alternative
> > > > then is that  we will have to refactor REPO_GIT_PATH_FUNC - or am I missing
> > > > something here?
> > > 
> > > What I don't quite understand: what is the problem with making it part
> > > of the `struct repo_path_cache`? Does this cause an actual issue, or is
> > > it merely that you feel it is unnecessary complexity?
> > 
> > I feel it is unnecessary complexity.
> > 
> > 	$ git grep -E "(static GIT_PATH_FUNC|^GIT_PATH_FUNC)" | wc -l
> > 	65
> > 
> > Meaning each of these would have to have an entry in
> > "struct repo_path_cache" in the world where we don't rely on
> > "the_repository".  Some of these are also not direct ".git/some-file" but
> > ".git/dir/files" where ".git/dir" is also given by a seperate path func,
> > like ".git/rebase-merges" and ".git/rebase-merges/head-name".
> > 
> > So why hold pointers to such filenames instead of just calling
> > repo_git_path() manually - all these filenames are "local" anyways - unlike
> > say files such as "SQUASH_MSG"?
> 
> It does make the interface easier to use at times because you don't have
> to worry about freeing returned strings. In other situations it likely
> is unnecessary.
> 
> In any case, not all cases must strictly be converted to REPO_PATH_FUNC.
> A refactoring may also decide that using e.g. `repo_git_path()` or
> `repo_common_pathv()` might be better alternatives.

Got it.  Thanks again for the nice explanations.
