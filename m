From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] wildmatch: properly fold case everywhere
Date: Thu, 30 May 2013 15:52:09 +0700
Message-ID: <CACsJy8DpJKPgc2h0yV3ZHOV6mhEGs=j1NZJ2WQBWG7hAk_iuBw@mail.gmail.com>
References: <CACsJy8CuaowyZJGKh7X+43qRwYAdUCDbVo8P5CpEtukBzRiReg@mail.gmail.com>
 <1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 10:52:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhybJ-0007H3-DC
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 10:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967996Ab3E3Iwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 04:52:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:50494 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967933Ab3E3Iwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 04:52:40 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so168216obb.1
        for <git@vger.kernel.org>; Thu, 30 May 2013 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gA0kXXtP5snxNeuk7Rr617HIjTo2tJUf3k6WxJT+goA=;
        b=iXpBWDh2m8XjisPZE5Wfn9Y0/cLrbnh8IQp8DTutWyCKG/ZkJYCm+Yl6MHt/x95Ywi
         Cxzc5xLDsP46yKlAl+QWKPBpzlAFJWuynO5dXSDv7PGJ+JPNnlJadFDI3hJLNAsuyHRf
         kzrgW8Nd1sSfxsk9Mpf6I2p8sTBJWMJfAnI7R4NGZtetcfkJOIblavzcYfQkLLkxT/7h
         b5nXIseQ6712i0zUD8hw1x+zzS0/zeLRGAkl4oLSJbfXwHjT1Tal5WJ4rRlQHU3oGKdF
         jIhEqw0ZhRSr8lXHA76+Lh1VStXMirj8mx/VtFLa9STMAHR7GJwKfWTSR1fOtbj0Gkr/
         /4eQ==
X-Received: by 10.60.97.232 with SMTP id ed8mr2637176oeb.96.1369903959848;
 Thu, 30 May 2013 01:52:39 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Thu, 30 May 2013 01:52:09 -0700 (PDT)
In-Reply-To: <1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225946>

On Thu, May 30, 2013 at 3:45 PM, Anthony Ramine <n.oxyde@gmail.com> wrote:
> Case folding is not done correctly when matching against the [:upper:]
> character class and uppercased character ranges (e.g. A-Z).
> Specifically, an uppercase letter fails to match against any of them
> when case folding is requested because plain characters in the pattern
> and the whole string and preemptively lowercased to handle the base case
> fast.
>
> That optimization is kept and ISLOWER() is used in the [:upper:] case
> when case folding is requested, while matching against a character range
> is retried with toupper() if the character was lowercase, as the bounds
> of the range itself cannot be modified (in a case-insensitive context,
> [A-_] is not equivalent to [a-_]).
>
> Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>

Reviewed-by: Duy Nguyen <pclouds@gmail.com>

If you have time, you may want to send a similar patch to rsync, which
contains original wildmatch implementation. It does not look much
different from this one, except that (flags & WM_CASEFOLD) is replaced
with force_lower_case. Thanks.
--
Duy
