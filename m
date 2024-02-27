Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581594F213
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057385; cv=none; b=H4o/rUX0dBHI85FphZz1mis1khjSmgxv6dVmdjqZisLt10+lsrQ02o7AFoWB7kVJZGs7qwioyQl2Qx2JD2Y6rt2sLH/j5+vaU55tUzhjxueOWpdjMk4KeTbGfstxeGAbNDUX0Cp8T+z5b64BKoghNn3ylwVlCR9dJzZtTfU+c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057385; c=relaxed/simple;
	bh=eD+2raSsU9E8kVaW0CGKhij6U7NVY3tpksW0l2FTcR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDleKykm98LwwLkoWQoh4rjf95n3/Du1k5bbkZw1Cu6/kfy/jH90w8PzUFAZkR69yBBqorD0hSf6+lGIoRAouOBknTOCLVCgs2+LY/iaVSo//afKjh3Tr+SM+riDy1RdtGDuy96CUsHcOwF83qWLPmEhWXe5Ye9W0eNHVXg93hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmJkzHKf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmJkzHKf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc49afb495so39201655ad.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709057383; x=1709662183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xDNkHVjs81rRyscxltAeFXImkiVg0ERVYT2gXIeaQE=;
        b=JmJkzHKfaNqxFV2GyuB9iEj8pkHnWdFxw56bShRLuA2nHN9uisfz8HSJvLjFBjDvCG
         Hc1XX1pQpn0N6zOcKAf8VjVnAmpv7xvmz96QGHbsYSuo5ArILfzV2DvdoS33V007yQXS
         JVfSDfCzKiw9q1X7dx/RfUeOlcEvmJIUKH2m5rAJcd01+ISaYL66lnvqeOdbHKjZWARQ
         +XdgRsv7+RsNOGAqKOBk57O7hvkfduuJYXIz/cTlCJZBOykvPy/JDnBbb5a+j5CrKHZP
         bKnUrzJEmQPDgo0sUVX+dG5dQmY5hmHkC9x+dl0selna5jP83mjQe5vwvtIxJGQN8pdL
         LFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057383; x=1709662183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xDNkHVjs81rRyscxltAeFXImkiVg0ERVYT2gXIeaQE=;
        b=KPyI6Ql7HBjC22nnXiXDNNG0SybHCRE+8L0FVCmnFsTPit7/lw7cmuLo42qXUUb0mm
         FPGFNvG/dU2cblSO1RnQqrzfgTEdXNQOjQ8uB2j3ic57XlMSuLHHwhecimlwUu31wjXH
         6My8rKTcSKqIBJGtNcqTZluYGgI9yhbLlvmvE/1kws38uK4ENYKGF3/S/FggViBNVzgs
         Bpeg8yJrXm2xcLLAjwSAHqMhGjsS6k/xtUkQG8KiXkHGdwTRMyOkalcbQaDpdbqUCZ79
         jM/moFOLf4UwtFS+PdbHdCR+GNp77JuUj8K654wwyAmZcYOK9bWvNXF9rczGKJTePLww
         4KAA==
X-Gm-Message-State: AOJu0YyiqwMB+8W9juJgMpirXak4yXTrEfFNxZ+P65nC7NOagnb4+KO+
	2RWER0FfUkO0KnxJH7sPL+KLSRLufCaUbDqTMLlrIZXElutVtGan
X-Google-Smtp-Source: AGHT+IEC5AF/Au42QG8YVN1A1P5eoCo15B2Al8/GadXa6rpNUC9ix6zyVjaaPZOBgKk9APOUl6Unyg==
X-Received: by 2002:a17:902:e812:b0:1dc:b261:6eb5 with SMTP id u18-20020a170902e81200b001dcb2616eb5mr5285028plg.2.1709057383538;
        Tue, 27 Feb 2024 10:09:43 -0800 (PST)
Received: from gmail.com (18.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.18])
        by smtp.gmail.com with ESMTPSA id kn15-20020a170903078f00b001dbb0348733sm1829106plb.67.2024.02.27.10.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:09:43 -0800 (PST)
Message-ID: <0928d29b-41df-40a4-9536-4a8d097faa83@gmail.com>
Date: Tue, 27 Feb 2024 19:09:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] completion: fix __git_complete_worktree_paths
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <a1561e02-40dc-4ac3-ae7a-666db0f810ed@gmail.com>
 <eaf3649e-30cf-4eba-befa-5be826c828a8@gmail.com> <Zd2bnJZtgW2tFMFn@tanuki>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <Zd2bnJZtgW2tFMFn@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Feb 27, 2024 at 09:21:48AM +0100, Patrick Steinhardt wrote:

> > +test_expect_success '__git_complete_worktree_paths - not a git repository' '
> > +	(
> > +		cd non-repo &&
> > +		GIT_CEILING_DIRECTORIES="$ROOT" &&
> > +		export GIT_CEILING_DIRECTORIES &&
> > +		test_completion "git worktree remove " "" 2>err &&
> > +		test_must_be_empty err
> > +	)
> > +'
> 
> If I understand correctly, we assume that the repo isn't detected here,
> and thus we will fail to complete the command. We don't want an error
> message though, which we assert.

Correct.

> But do we also want to assert that
> there is no output on stdout?

To me, the check makes sense;  to notice if we leak a message in such a
circumstance, for instance.  I can drop it if you think it does not add
value.

The test for stderr is my main goal here.

> 
> > +
> > +test_expect_success '__git_complete_worktree_paths with -C' '
> > +	test_when_finished "rm -rf to_delete" &&
> 
> What does this delete? I don't see "to_delete" being created as part of
> this test.

Good eyes.  It's noise.  I'll drop this line.  Thanks.

> 
> > +	git -C otherrepo worktree add --orphan otherrepo_wt &&
> > +	run_completion "git -C otherrepo worktree remove " &&
> > +	grep otherrepo_wt out
> 
> And as far as I can see, we don't write to "out" in this test, either.
> So I think we're accidentally relying on state by the first test here.

The function run_completion leaves the result of the completion in the
file "out".  So we're checking here if "otherrepo_wt" is present in what
"git -C otherrepo worktree remove <TAB>" returns.

Maybe a new function: grep_completion, similar to test_completion, could
make this clearer?

> 
> Patrick

Thanks.

> 
> > +'
> > +
> >  test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' ' ow
> >  	test_completion "git switch " <<-\EOF
> >  	branch-in-other Z
> > -- 
> > 2.44.0.1.g0da3aa8f7f
> > 


