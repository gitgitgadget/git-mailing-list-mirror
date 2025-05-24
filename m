Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0E1993A3
	for <git@vger.kernel.org>; Sat, 24 May 2025 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748056779; cv=none; b=UCLyKfUnWMs9rwooeB+2/HVam7C2V51UU8que2dyEXPNu7nZtri7lpFVLWEePlNToaoAqB8LrMBmoiQvXP/h6GdbGdmI7PkUH3qzxVzKwO9gR/FXOQwDlDRfW1EjXBr4OHz4Joolye098XNieOMiyN+ds+cviVAB9KRkX/jFDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748056779; c=relaxed/simple;
	bh=IXQI9oYTJLEwE9l5NAAel8hkH7v6Xp7JhDj/wUewlqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b8NMiS0MZEOiM7OpAIQ0G/ogBLK7JDmdEOyerYaNqSqWaiqr5SaToxlPR3yEFteNpeUoyq2CYx58IiUtCC/xStJfh62EFbxjEBNvYZ+U23xxH9EKQT9njnpEyz0Ol4sC7+vuNbhDxI0sxcBoZL8GxJ4EMVQVGWL551AmfPsper0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fnqrJO7R; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnqrJO7R"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60219a77334so236254eaf.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 20:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748056777; x=1748661577; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbyODfXb7uMorRatiQ3KF0JbO6aiAMY/yQ8U3DulDKY=;
        b=fnqrJO7Rwk2Oz81Cn7klx/smWiNeCD3uAwtE2zI5v8Ra+EY/uleKvoQiwqqW8NvFFd
         syEFzDVq+pL+7omeaGabJRirxMkv0tohj6q6UAHUC6oMX5h3xxevNIiGd3HtFrc1txtu
         WVRHfcZQab9DD8VR4ZdBXDp//UGGfL2KR4DsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748056777; x=1748661577;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbyODfXb7uMorRatiQ3KF0JbO6aiAMY/yQ8U3DulDKY=;
        b=ftQWHOIwTuxZG4PVFv3y9KttN7pEHb9IKXc0nHh+YK86Fa26BhYzbeJ3vQroWrScW8
         pUu3qjb5p6Co5OV6j0ldMSNNgQYKQ0g3FKJaF52WNrELyFNrrf2ZDQuD0cq/v0IKqfnO
         AosxFg7vywQI5G54hvH4wKZq3PWuDr0VHVyFpVrBIpBSOGLBimDaD8u2Id7ATIt4HaFf
         CMoDw9TXFkPjqkww/nVja+vtJNTZa5jfrZxJHZmSvfC+KPABJWX8/oB6NvT1n0jnMjLM
         6e51EB6THAHaV0n04/GYAAE+tKL9a8gp4C6LWHkth8ebKaaP+szgu61E2q7e68UYiYKY
         9yMg==
X-Gm-Message-State: AOJu0Yz+MODjClloN/4eYniTzmtv4B/Mg00SZpgOKwtec2Uval0VCEJ7
	esRSOqxBTabojlWjzkya57a4EtAEEi5/Z3+0ZX7MImEF63FZm4Jx3sh1xpyB8rpSKgGBxW9kx9b
	dE20Nhg==
X-Gm-Gg: ASbGnctWeMfnzP9OSGOVCgTg2ilNQClhlz22OSi+JnE8Qb/8KB/Y12wVb2oXfI/AmH4
	4qNvrRPel8OzHResyRvW+IgUUKl+wsL9bXz4jKplDVIicTuPMPSAzmMngbzYYFBKMsUXZGM53jR
	+PKPuRUoMkxd7DZSH2flA/sDCSqCyF/7aATwXpJbv6g+PCtFDEQnt/lT3TJGPvQtX2X70+qc1sW
	krRFREWvaLGoM2LhQfvvmWrXK55HyMZgG7C0J505J6C2YpQjSWOvtJPRZs3aGZTiTEBt6eT1LHH
	FAkRO4W//xLBsbLok43I/gJUKny/z4vPH6OjqWakTtWuKFOk64Mn/XBdFsipejXYQ5bzo3WqoiS
	BWXQ9esjeMwVc9BD91+NRyfp68iVhsT4FGYVj1UI=
X-Google-Smtp-Source: AGHT+IF1DBYknz4ZVEuBzBNzVQfOZXipk1Y2OqqTKOsaOWj21LrArWbH9TfNj7LWJgSIypy+2ss6Fw==
X-Received: by 2002:a05:620a:288f:b0:7c5:5e9f:eb2d with SMTP id af79cd13be357-7ceecc7943emr251741385a.44.1748056766944;
        Fri, 23 May 2025 20:19:26 -0700 (PDT)
Received: from [2600:4040:9ce0:6400:e585:dc50:f5e1:64e7] ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494b8fa2cebsm113606271cf.34.2025.05.23.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 20:19:26 -0700 (PDT)
Date: Fri, 23 May 2025 23:19:25 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: Junio C Hamano <gitster@pobox.com>
cc: Git Development <git@vger.kernel.org>, 
    Chandra Pratap <chandrapratap3519@gmail.com>, 
    Johannes Schindelin <johannes.schindelin@gmx.de>, 
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/2] apply: set file mode when --reverse creates a
 deleted file
In-Reply-To: <xmqqbjrivqn2.fsf@gitster.g>
Message-ID: <cdca6dcb-3a78-fa0d-b58b-8dfd92924e96@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org> <20250523172154.93810-1-mark@chromium.org> <20250523172154.93810-3-mark@chromium.org> <xmqqbjrivqn2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Junio C Hamano wrote:
> Mark Mentovai <mark@chromium.org> writes:
>
>> +test_file_mode_common() {
>
> Unlike the two callers, this lacks SP before "()".
>
> I would have expected that "no such file" would be expressed with
> mode 000000 (taken from "git diff --raw" for a removal/creation
> patch), but an empty string works just as well.  The same comment
> about requiring 0-prefix before 644 and 755 applies here, but as
> long as it is done consistently, I wouldn't complain too loudly ;-)

No, it's fine. I'll switch to the 6-digit form.

>> +	test -n "$1" && test_grep "^10$1 " "$2" || test_must_be_empty "$2"

This requires attention anyway. Reading it back, it's buggy: if there's a 
mode in $1, but the file $2 is erroneously empty, test_grep will evaluate 
false and evaluation will advance to test_must_be_empty, which will cause 
the whole expression to evaluate true. This construct only works properly 
as an if-then-else when the "then" clause can't fail. I will revise this.

>> +test_expect_success 'git apply restores file modes (change_x_to_notx)' '
>> +	test_config core.fileMode false &&
>
> Wouldn't this and the subsequent tests want to begin with
>
> 	git reset --hard <commit> &&
>
> to a known good state?  We expect that after successfully running
> this test piece, for example, the path is removed after the last
> patch that removes change-x-to-notx is applied.

Yes, good point. And with just slightly more effort, I can use the same 
strategy to eliminate the ordering dependency between the the tests in the 
1/2 patch.

> Other than that, we seem to have a very good coverage of the
> combinations now.  Thanks for a thorough work.

Thanks for your thoughtful reviews. v3 incoming shortly.
