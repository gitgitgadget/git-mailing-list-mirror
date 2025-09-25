Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE72512FF
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785963; cv=none; b=aFwu9v1Dc9u7CmTdPgF83Sim2jdWdvi65TJm28c434EXCNCR44p7N9vzisLIzHDdLFLdLnrCWH84MuNvE/ULy+a93+U6gY5yy6QZXPG3TfiF3rD9fisAJSYwCk5s+wq8lB8xQx7nUome3ZXqTMEs/oDMeA1Y/HWj0BhD3Gz6Sww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785963; c=relaxed/simple;
	bh=Ka4uD+AdtLIHG615I7qltoCtY81hbTMSUXR/0B0hs2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaEIYh01jqsXF9sq9TV+7XhLQHWFaYAjGYUB+5BaabHEnokrjx64PP0awGAIVYN0e9CMa3ZhozJM3cJ+he4qclwKBpcBP0w1Y8Ch6mWqW/SSXTEswRVym3HZXYN6/F1man8mUY5dRNnO5RVh74Aa4rcGExiMMWq87YZL0iF0PM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yAXG77OZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hUGHH/19; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yAXG77OZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hUGHH/19; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yAXG77OZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hUGHH/19";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yAXG77OZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hUGHH/19"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2EDD40298;
	Thu, 25 Sep 2025 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758785957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+H5LLpQetZrPGKEohHjgV3N6VAd1zXhubwEVo23NsE=;
	b=yAXG77OZU82TdVxG6HizYjOXyblk8JcbgmCd0cbNvtu/+F+QjXqOSreZmqSGDM1qihY2/K
	SuADXgIjDNTdmfuU4qmEYWMSveR/Mdh2qVq3zOUKykhEIsjcpubI/EnCOSEPrBMr0UGWz8
	y+J7NraVHgIE0Z+bsBR0JzFuUqoreAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758785957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+H5LLpQetZrPGKEohHjgV3N6VAd1zXhubwEVo23NsE=;
	b=hUGHH/19ZdGNFHjdqP0djeRPLz+Y933iQ5Yf1hBKT8U+pNG3QHn8VFTAQ7ClzwxkBG5NLi
	52PBf0kibhZCVUAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758785957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+H5LLpQetZrPGKEohHjgV3N6VAd1zXhubwEVo23NsE=;
	b=yAXG77OZU82TdVxG6HizYjOXyblk8JcbgmCd0cbNvtu/+F+QjXqOSreZmqSGDM1qihY2/K
	SuADXgIjDNTdmfuU4qmEYWMSveR/Mdh2qVq3zOUKykhEIsjcpubI/EnCOSEPrBMr0UGWz8
	y+J7NraVHgIE0Z+bsBR0JzFuUqoreAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758785957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+H5LLpQetZrPGKEohHjgV3N6VAd1zXhubwEVo23NsE=;
	b=hUGHH/19ZdGNFHjdqP0djeRPLz+Y933iQ5Yf1hBKT8U+pNG3QHn8VFTAQ7ClzwxkBG5NLi
	52PBf0kibhZCVUAQ==
Date: Thu, 25 Sep 2025 09:39:16 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Rename detection fails on symlinked files
Message-ID: <aNTxpDrfUKsbvkZt@kitsune.suse.cz>
References: <aFFN9UHCspTjliMv@kitsune.suse.cz>
 <CABPp-BFdEn8rYu+FW+CdgrKNDUGBY9h6ePSH-vjYy-f_Pji0-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFdEn8rYu+FW+CdgrKNDUGBY9h6ePSH-vjYy-f_Pji0-Q@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Jun 17, 2025 at 10:44:23AM -0700, Elijah Newren wrote:
> Hi,
> 
> On Tue, Jun 17, 2025 at 4:16 AM Michal Suchánek <msuchanek@suse.de> wrote:
> 
> I think your subject might be slightly misleading, and that a more
> accurate subject might be: Rename detection is not performed for files
> still present in the target version.  Let me explain why and you can
> check if I'm understanding your problem setup correctly.
> 
> > commit 5d51b10d8b5206ef5eeb9d214237b2ec2e0b789e (HEAD -> master)
> > Author: Michal Suchanek <msuchanek@suse.de>
> > Date:   Tue Jun 17 13:08:51 2025 +0200
> >
> >     rename file
> >
> > diff --git a/somefile b/somefile-renamed
> > similarity index 100%
> > rename from somefile
> > rename to somefile-renamed
> 
> So you've renamed a file, detected at the time you run git log -p.
> 
> > ln -s somefile-renamed somefile
> > git add somefile
> > git commit --amend
> 
> Here, you reintroduce the original file, as a symlink, and amend the commit.

No, there is no original file:

diff --git a/some file b/some file
deleted file mode 100644
index b649a9b..0000000
--- a/some file 
+++ /dev/null
@@ -1 +0,0 @@
-some text
\ No newline at end of file
diff --git a/some file b/some file
new file mode 120000
index 0000000..b649a9b
--- /dev/null
+++ b/some file 
@@ -0,0 +1 @@
+some text
\ No newline at end of file

See, the plain file and symlink is so different that changing the mode
to symlink is represented as removing a file, and adding a symlink. Not
same file mode change, not even a rename. The symlink is so different
from the file that it's completely unrelated, even with exactly same
content. Mode change to/from symlink always breaks, regardless of content and
the break rewrites setting.

diff --git a/some file b/some file
deleted file mode 100644
index b649a9b..0000000
--- a/some file 
+++ /dev/null
@@ -1 +0,0 @@
-some text
\ No newline at end of file
diff --git a/some file b/some file
new file mode 120000
index 0000000..b649a9b
--- /dev/null
+++ b/some file 
@@ -0,0 +1 @@
+some text
\ No newline at end of file
diff --git a/some other file b/some other file
new file mode 100644
index 0000000..b649a9b
--- /dev/null
+++ b/some other file   
@@ -0,0 +1 @@
+some text
\ No newline at end of file

And here we now have one removal and two additions of the same content,
no rename detected.

So git cannot agree with itself if symlink and plain file is actually
the same file or not. They are presented as comletely unrelated to the
user yet rename detection fails to detect the rename of the plain file
that is completely unrelated to the added symlink. That is the
discrepancy, and the bug.

Thanks

Michal
