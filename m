Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA41FC1D
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552026; cv=none; b=UubaJQlcSVpAj8Xozyz95zBFOC1mrcPm7tqcE5ner+2VbFHgmhaqW6O8DfF6v+OiVMdtB52STgTVA3YriGeTRJ5vgbZ0/fxMYvyWoapEv3YjwX1KwufAIOvgnnvhJ40+ZDdJWdWslRHfKZrvB/vV9PBAoHN5xnc7KbvkDkqsQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552026; c=relaxed/simple;
	bh=WaInlwW/NiP2lsfXCiupTiNEyBNGtXkuPQn3IUU/QJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoAGr2lAeaDHTY2eRw6WSKqOGREGliDQ3ZqU2Ha0/s/fCqrvSkhWgWupbYPII6DeSPtxDQ/7tpMoHn53xdhPadTZSQVJLmYiBadXGLEcYZqRb/EEr1AOGfNwH9PPC4B4xH30NkCSu20BR/5X3ePFzFCDPjNzUIZWGw/qenmUA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe0/CbAW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe0/CbAW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7024d571d8eso2828738b3a.0
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718552024; x=1719156824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRW5AzjsrIBYz1iAkDMRmccCk+8yqw1/ph7zZreNHuA=;
        b=Pe0/CbAWCIINDH45vM21speX24iuHK1QWijC23OP8iEs9S02qowdR7GMJbqXY76jbx
         hL+r7iR962D6jHA9aJUR4UeA1Hvar8/xsT/GNN6cdBUFVl/1ANA7A2lOgLKuJTwljcvo
         68luBa/LI06Fsxd7DKcE4V+vvec8MKREWqUbrViDmQiDy+LdgvDdC0UCAZwa+NsnQGnp
         +R9qNEZ1UH3akR01mEp5MFQN3UA/PEo897wQiao7dXJGGhmhaGSmy43NBLLZbOwOmk8r
         fv8d41XdlVb+UftJnnObNICDbGUc2wc2wYgbl/xfygh+l6AmDOUnfHBFqN9/Tko5lv1/
         id3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718552024; x=1719156824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRW5AzjsrIBYz1iAkDMRmccCk+8yqw1/ph7zZreNHuA=;
        b=bOqtq01sfmXDLMy4WqaF17syCPHSamiDti1XmnJTNQnsdhUtZxwRv8gkUZ7NDDEZJ1
         zMJ7ocXGcPfFBFRazzzEdTh1OtcbJcnX63vBnW5jPa6ZG3S2/yjMu3hORZXitjj3Qifl
         M3gzNKKgnKEgblfGxz171y5M5dOeXDXgYmnYC2suV1VFFEZc32Lu+8cYE8Y53rsh0TTO
         s4eW1w4dCenW+OOcQUxk1RawT9RW1OEjjGR38r1UDV6b/wbq9zYwARE1snR6ULBmGLsM
         oc81Dp/MwIZkcBUceI3fF2nqGX/mccYnAlJmHKATXosB4JQdcN4IXirtMGeUA9iKdh9v
         oISA==
X-Gm-Message-State: AOJu0YzlPsggCQGmPnNCDPbbqYEF+XcFR+f/TV+4XqexVcbuThFnSMfP
	ILrpyhzJ5MWkna7a2Uz7Bh0BR5Pdfz1DqsvY7hBgKuYp84JWwnSgG1FE/Zze
X-Google-Smtp-Source: AGHT+IGc4qzCCh1yWdb9RdqnLzQZ21zH49ROR5E1310peh6NkuByDNQOZkkdW3e8o+2TpRE6o02RYw==
X-Received: by 2002:a05:6a20:1595:b0:1af:f514:6d96 with SMTP id adf61e73a8af0-1bae7ddafe4mr10590658637.16.1718552024377;
        Sun, 16 Jun 2024 08:33:44 -0700 (PDT)
Received: from google.com (182.51.125.34.bc.googleusercontent.com. [34.125.51.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee2d34cc2sm5382515a12.64.2024.06.16.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 08:33:43 -0700 (PDT)
Date: Sun, 16 Jun 2024 15:33:41 +0000
From: Jonathan Nieder <jrnieder@gmail.com>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Add warning when v0 protocol is used/downgraded
Message-ID: <Zm8EqOfc_v4KBVVK@google.com>
References: <CANM0SV3CQPRyJCDanB8JFpkAMwuoo-mg3A=_L743_GXJtoFtQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANM0SV3CQPRyJCDanB8JFpkAMwuoo-mg3A=_L743_GXJtoFtQA@mail.gmail.com>

Hi,

Devste Devste wrote:

> - When "git config protocol.version 2" is used, there is no
> warning/message when the remote returns a response in v0 format. This
> leads to any issues related to slow(er) git caused by old protocol use
> being unnoticed, leading to wasted time debugging.

Specifying protocol version is meant to be backward compatible, and
there are cases where the old protocol still needs to be used - for
example, if an SSH server doesn't support transmitting the
GIT_PROTOCOL environment variable, then having the fallback to v0 is
still useful there.

So I'd be concerned that printing the protocol version in the default
case would be overly disruptive for such cases.  This would be even
more so for protocol v2 for push, which doesn't exist yet - once it
exists, it wouldn't be great if all pushes using existing servers
produced an extra piece of noisy output. :)

That said, I'm sympathetic to the debugging use case you've described
here.  Do tools like GIT_TRACE_PACKET, GIT_TRACE2_EVENT, and "git
bugreport" produce the right information in these scenarios?  Would
"git fetch -v" (i.e., when the user has explicitly asked git to be
more verbose) be a good place to provide some additional diagnostic
output?

> If
> protocol.version is not explicitly set or v2
> and both the local and server git version are >=2.26
> and the reply is not in v2 protocol format

Interesting!  We haven't previously used the "agent" field (server
version) for anything other than logging it verbatim; I'd worry a bit
about getting into the same kind of mess as User-Agent parsing on the
web if we go that direction.  But I would expect the main obstacles to
updating protocol version support to be in (a) reimplementations of
git protocol rather than the standard git reference implementation and
(b) plumbing such as httpd and sshd around git, rather than git
itself.

Thanks and hope that helps,
Jonathan
