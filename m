Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025121D3D9
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078968; cv=none; b=N/c9ZN5QrIlQQD0D5MuOmk9X9G03FZAe7tOg0dnhgGjG0QMzyolGthzKiiFlbPqYlz3ekue9ZOlvC/PtElsh+ER2wvdWhrBsNGY6/FdToNy7xaQlTroQzA3aaBX8jkLl9E+8TD4RWPKtJ4A7A/aaYI7QwrZy2gP8QFTWQK0ko0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078968; c=relaxed/simple;
	bh=ELyYedTBVZh9w8KfCOzeM6dhrEosYgw/tYtEEldbEGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En7BuWia4rFARbhXYAvHFBMKzm4f3upepYo5AOVniD9JdKgJ+nAyPIozawZtFVqgPDDxeKKoRi6ASx4vK9NEE0lL0iQ6PHVMhzUpnJs249jdPHo54vs3GeXQAoVjeEANHAo2ObbVXXqHNHn15jj4Zg35BY6eOK0mb9shyyLupVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK8b6nBY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK8b6nBY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so63731b3a.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752078966; x=1752683766; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HALWPgII0vsBquyiPgCmCnM+9KSO/sdjsNdksKt8Ilw=;
        b=VK8b6nBYQaZmTu0oUsromzR/DkvH3BSglSx3lktl6NZl1SghFjjLlaVDt9VmHuiEtR
         hSIq6fClsXD3jO3DHKuYoA/ViRlOFnWSEusTIihx+LWN5GFwLgbN2okgiKY9eXFQJ1L3
         2kd0jcy2IisxmwQzgT+Dd/I+2EnS9nQeeSaTsWOHaNekQtN/H8iX5aSZE1c/X7Optj3R
         ndSiw1o5QceadNDSpZEbNU0dn1zDiN9+t/M2QKkeKPy/5Vy8eQK2M1eFrWfwXmx/QpLI
         w1awTfM52LeOB1g9AUteFN49va1Mc5W0JYIdMyhwvf9wvycWvLmBDN0zCIgZQf77u4Te
         p6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752078966; x=1752683766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HALWPgII0vsBquyiPgCmCnM+9KSO/sdjsNdksKt8Ilw=;
        b=Q5iNkO+Lic2wwAcRlXVwokpUCPziYwXSZOH6ujTuMUIi602yWgJ5Z+IcY/0ZLVjsZi
         jNXqF/6gJp3vVLb2+nqbZOp89FDA77HORcESmc2mfZqVXMqdstvDFscEzc5DIgDHE46A
         1G64IIDVLe44+0gmGDArNPrsofLCMqiNNae994jc54PRpvu0qUA1/p0nS61UpcFql6iK
         5mkzOa5UxaDAavua17gkJ/s3a+hi8GjYsaR6VFu4K/VevhS1ZDlf+msp54/uNTvRo2gf
         tjdEUsTXMjbyeAc0dXe6r0g+X2lAGEioerKTzvBgKIDD07g3vdA7vLYY4of1xHN8ZPHd
         z0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqk2bMV+ShXwwnRzKR9KuncJ4Nshmel/r5Xkkfy3PgxXpHth5KqUi9706NY1U843rMooY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPr02awyyy1g1Vc2NgisQzozNQKg1gpWWPP+ofkT+lKhanGXp
	ppbWezPfjOC/s1sWhaXqyxZ1syRencBZNne/GGDZHgVKUOI2bNOC2hFG
X-Gm-Gg: ASbGncvsQFwwIIpEFzvtyHTdtjAhYIZ1tft6X9B/GQ02kEm+wyUhr19W+pT7sSPoGTU
	MlUqWyd8LeMrMyHpALt5lZozA/yhmKN7TQAhILaiGeXSCtnVxTlfKT/jap2aUNGjWwW21r+r/Ea
	SD95FLMcySefsouwR7u2YLF0QvA/xcG/wY3ePNm+39YybfagK3Di3LztHoT5Eum+mS8dAlejGsh
	zhjRX4dKIfkLPwiy3Y4S5wbPAsYfVMGO4DmkTmPhLhubvF4MnQODQYd2KZDHLlc6aqaTJtnpc2q
	xUX6aJtFa/pilwsepdtW9uurDtlCAvRCKKLg+qcdudfdxLWX+SHtdmGoJ/8ErWSlqTKmsx9Wrjn
	kzwkaSmxakoMgQQ0kkfbADkU=
X-Google-Smtp-Source: AGHT+IF3WwWWqD1nLcjJN0lNo7i/Mem5F7IEz+StvFpKMA3YImi7Wtf1UGyzBj6rayUQhpV9QFhpfw==
X-Received: by 2002:a05:6a20:7d9c:b0:21f:563e:b7e8 with SMTP id adf61e73a8af0-22cd541efc7mr5581881637.4.1752078966312;
        Wed, 09 Jul 2025 09:36:06 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:ed82:7a2e:d82d:94a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a26f7sm14554933b3a.133.2025.07.09.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:36:05 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:36:04 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
Message-ID: <3hrbpiapamvfiuilebjcbcruppz3vukf6mndg62j6gvko2jfs4@ll24s25shcgv>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
 <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
 <a1fb8c27-6ddf-42d5-a062-a9710f6cc1cd@gmail.com>
 <o6cihjnfj4q6uiks3syovjun3fcijvsqto444osw7tgtpkttvt@42r37athz2tw>
 <0dd51eab-8869-46be-beca-238a616dd6f3@gmail.com>
 <p6xegxqqq4wzi6gnokypy3k5auxk3d2wxmj4pj45ugfomace3q@y5q3e2al42oj>
 <0931e1f2-6254-474f-be91-664cec9745f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0931e1f2-6254-474f-be91-664cec9745f5@gmail.com>

On Wed, Jul 09, 2025 at 03:13:06PM -0800, Phillip Wood wrote:
> On 26/06/2025 21:09, Carlo Marcelo Arenas Belón wrote:
> > On Thu, Jun 26, 2025 at 04:19:11PM -0800, phillip.wood123@gmail.com wrote:
> > > On 26/06/2025 15:58, Carlo Marcelo Arenas Belón wrote:
> > > > On Thu, Jun 26, 2025 at 02:56:22PM -0800, Phillip Wood wrote:
> > > > > On 26/06/2025 14:15, Carlo Marcelo Arenas Belón wrote:
> > > > > > On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
> > > > > > > On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> > > > > > > > From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> > > > > > > > 
> > > > > > > > A future change will start using sigaction to setup a SIGCHLD signal
> > > > > > > > handler.
> > > > > > > > 
> > > > > > > > The current code uses signal() which returns SIG_ERR (but doesn't
> > > > > > > > seem to set errno) so instruct sigaction() to do the same.
> > > > > > > 
> > > > > > > Why are we returning -1 below instead of SIG_ERR if we want the behavior to
> > > > > > > match?
> > > > > > 
> > > > > > By "match", I mean that in both cases we will get an error return value
> > > > > > and errno won't be set to EINVAL (which is what POSIX requires)
> > > > > > 
> > > > > > In our codebase since we ignore the return code anyway, it wouldn't make
> > > > > > a difference, either way.
> > > > > > 
> > > > > > signal() returns a pointer, and sigaction() returns and int,
> > > > > 
> > > > > Oh right, I'd forgotten they have different return types. I think we should
> > > > > probably be setting errno = EINVAL before returning -1 to match what this
> > > > > function does with other signals it does not support - just because our
> > > > > current callers ignore the return value doesn't mean that future callers
> > > > > will and they might want check errno if they see the function fail.
> > > > 
> > > > I agree, and indeed had to triple check and change my implementation after I
> > > > confirmed that signal(SIGCHLD) does not change errno on Windows (not our
> > > > version, neither of the windows libc or mingw, even if it is documented[1] to
> > > > do so.
> > > > 
> > > > It might be because the signal number itself is bogus (there is none for
> > > > SIGCHLD in their headers, and git uses their own numbers in compat), but
> > > > either way, I would rather be consistent with signal() at least originally.
> > > 
> > > I'm not sure I understand - don't we want the sigaction() wrapper to behave
> > > like sigaction() would?
> > 
> > for at least the first iteration, I would rather have sigaction() behave
> > like signal(), so that the change doesn't introduce any regressions.
> 
> What regressions are you worried about?

Any code that might be surprised by a non 0 errno, even if I agree it unlikely
to be an issue.

FWIW, the Windows compat layer is not very strict on setting errno, and since
a call to the CRT (at least with the current codepaths) doesn't either

> We're talking about changing a
> single call from signal() to sigaction(). I'd have thought we're far more
> likely to introduce regressions if we change the behavior of the windows
> implementation of sigaction() to behave like signal() as that introduces
> more variation between different platforms.

Don't get me wrong, I also want sigaction() to behave the same regardless of
platform, but I would rather do that in an independent change.

Indeed that is why I was asking for the possibility to change the SIGCHLD
definition, so that signal() starts also behaving as documented and we can
fix sigaction(SIGCHLD) to match.

> > eventually, sigaction() should behave like any other sigaction(), but to
> > do so, I suspect the windows emulation might need to change their SIGCHLD
> > to match.
> > 
> > just confirmed with MSVC that if I use 20 instead of 17, errno gets updated
> > just like the documentation says it should.
> 
> Oh not so setting errno as you want to do would not actually match signal()
> on Windows in that case?

I explained my thinking before already. I am not a Windows expert and indeed I
am surprised that signal() in the CRT behaves this way, but I suspect it might
be because of the same reasons why raise() triggers debugger breaks that are
explicitally called for and avoided in the mingw compat code.

Eitherway my preference is for this to be handled indpendently and preferably
not as a prerequisite of this change.

> > Carlo
> > 
> > PS. Maybe we should get dscho involved?
> > > > 
> > > > [1] https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/signal
