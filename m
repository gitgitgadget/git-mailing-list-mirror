Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868B17BAA
	for <git@vger.kernel.org>; Thu, 23 May 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496321; cv=none; b=lyXIlhz1b8Jfe5kWMotalCY+MlkiIC/zmNO0p/uW7sN4I+1fdVZ4sTqgHfUhz+QqgaIu/MqAqf/g31XJcZQ6Dn2fvxuThMsmyaPvD5yNum3QM6rw0FZd427oCcrDeZDheKVJf249voFNo5R/d1c3a+gbVhxUC78EZFnrpBNF7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496321; c=relaxed/simple;
	bh=jsL/b6VftOuF36FakKyd3R70+l00fPVAuG2AiiHUF1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlSOBQYouNgDkQAm0fDhcH6OXNdHMRzikQBpAZwf8QaNakWFGTwpJ///lGvPM7NsThRvC4NzBndg1mlR1juc/JTVnu2Et/L+ujUuravaTiBTzTf6CY/nf4RsFkbKpDOGUdIi+UB7ncdC5w8XsEVRE3ncZxJ96ZB4MafjpVlFzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 10719 invoked from network); 23 May 2024 20:31:48 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 23 May 2024 20:31:48 -0000
Date: Thu, 23 May 2024 22:31:47 +0200
From: Marcel Telka <marcel@telka.sk>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
Message-ID: <Zk-nswiCF-SnyxLE@telcontar>
References: <Zkdk7R9GIfsyQjkc@telcontar>
 <xmqqsey8tnny.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsey8tnny.fsf@gitster.g>

On Thu, May 23, 2024 at 10:59:13AM -0700, Junio C Hamano wrote:
> Marcel Telka <marcel@telka.sk> writes:
> 
> > The usage of backslashes in echo is not portable.  Since some tests
> > tries to output strings containing '\b' it is safer to use printf
> > here.  The usage of printf instead of echo is also preferred by POSIX.
> >
> > Signed-off-by: Marcel Telka <marcel@telka.sk>
> > ---
> >  t/t9902-completion.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index 963f865f27..ed3d03367e 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -73,7 +73,7 @@ _get_comp_words_by_ref ()
> >  print_comp ()
> >  {
> >  	local IFS=$'\n'
> > -	echo "${COMPREPLY[*]}" > out
> > +	printf '%s\n' "${COMPREPLY[*]}" > out
> >  }
> 
> This has cooked in 'next' for some time already, and I'll merge this
> down to 'master' anyway, but this being a script very much speicific
> to bash whose built-in echo we are using, the portability argument
> of "echo" made in the proposed log message does not quite apply to
> this patch.

Could you please help me to understand how the bash is used to run the
script?

$ head -n 1 t/t9902-completion.sh
#!/bin/sh
$


Thank you.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
