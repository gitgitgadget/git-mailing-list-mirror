Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59B219A7D
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443355; cv=none; b=iY93Ggwk2NArOrFMusfqpXWMLw/TUtwvuYEi0rrbHH99CusGN4irH4QMxVN6npfajFK1rKjlf+Z/8DFhAa8RqTCp+4eIJRgq81QQU0gJHbPk6khtBTEDA1da5+qYH/wCv/yM4CKV3XFWJ/0UAyTG0fvk6P0wTW2AxIssfQoMx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443355; c=relaxed/simple;
	bh=zDI9A4fJGfu8e1MfXL5RbtqlljjrQKvhjDuL7njjKeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5x+I4AhWtCNL26fuY13/A/6uG6WO5PR2Q1No8qJtmsNaM0r255FKOLwwRLECdJZmGRBClk6nztpjeQysU1b+EKD7cXntAr8E9Rg8+Fm0YSJ0+wDG9yLt+jQjVgMHIYqxleoG7IEA458vIDmVsz1vhXZ7sp04RIlFI+0XYEOmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZEdxWsI8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZEdxWsI8"
Received: (qmail 31982 invoked by uid 109); 9 Sep 2025 18:42:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zDI9A4fJGfu8e1MfXL5RbtqlljjrQKvhjDuL7njjKeg=; b=ZEdxWsI8G6bmY9BnJNr+CIT7BiQX1fQpFIAk9Nt7E/dXbTv0Xth8HRdO1rPYPJ9IZYN/sBHy5Jc+0T6UV1AsxlXNOXk11vzD9wRalVdNshfH8/mxKy/XhVH9fu4IlA0F/S6J+z/usCW2kKpY0pl6dG8+wDElECdcQKriGlQvwPq0FJCHN/jPxzyjOZQb8AeZc3HgDQE/ZYUB5TYQikCzyailBIemA8Dk0Jtb2MKYXB5qHxkGetp8rwiTyj+CZWmYue6sIz7OCZ1ZM6HpXEeFNVz9Jow4lut//yMz1juaGoHVFPVR3iMjSerXS5cz+LXxA0sbDUTVdPnqDfa+Nq0Izg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Sep 2025 18:42:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 54145 invoked by uid 111); 9 Sep 2025 18:42:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Sep 2025 14:42:31 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Sep 2025 14:42:31 -0400
From: Jeff King <peff@peff.net>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
Message-ID: <20250909184231.GB1912898@coredump.intra.peff.net>
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
 <20250907233456.GA1281511@coredump.intra.peff.net>
 <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>
 <109prte$j8b$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <109prte$j8b$1@ciao.gmane.io>

On Tue, Sep 09, 2025 at 11:33:18AM -0700, Jon Forrest wrote:

> On 9/9/25 9:00 AM, Jon Forrest wrote:
> > 
> > 
> > If this were a big deal, which it isn't, I'd suggest a command line
> > flag that says what to do if there's an invalid file specified on
> > the command line. One setting of the flag would result in the
> > current behavior and the other setting would result in all the
> > invalid file(s) being ignored and the valid file(s) being
> > handled normally.
> 
> Nevermind. I should have checked the man page.
> The '--ignore-errors' option already does this.

Oops, I think our mails just crossed. I don't think --ignore-errors does
quite what you want, though:

  $ touch foo
  $ git add foo bar
  fatal: pathspec 'bar' did not match any files
  $ git add --ignore-errors foo bar
  fatal: pathspec 'bar' did not match any files
  $ git status --porcelain
  ?? foo

-Peff
