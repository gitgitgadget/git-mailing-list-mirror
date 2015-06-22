From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: apply --cached --whitespace=fix now failing on items added with
 "add -N"
Date: Mon, 22 Jun 2015 21:45:22 +0700
Message-ID: <CACsJy8BBxWme=y6jF_O74Jz37qPy=Sqf4w0cg-QLYzpxM5iwVw@mail.gmail.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Patrick Higgins <phiggins@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72z7-0002ME-1l
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbbFVOqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:46:00 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33808 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbFVOpx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 10:45:53 -0400
Received: by iebmu5 with SMTP id mu5so116368977ieb.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0HlYAk9ZwQR3urdtIH1tZ4SXmIsi7hbp9AxHy0+fSIU=;
        b=cch2sJGrA0vcZzGadAWmdBrd60pWJxNkU8mNiM4jxjyG32mmOinllo5QyM4qcDyAk4
         adB9uyHH4mVjd0Y7Z5vLslABJjxUhjuQg2cyhp5juBfZDKUDfJ3H/GjvrHuc/fdPBMjU
         X23UertuIRhHXuaGDFwnwp2aYr3WS2YGDVs7CeNUFJWrMamMYXln7+S9D16ZTN9b7kiO
         SkY1sPIG052pGTFYW5Q4701HRauo5ME7tkhujc/k9D4fVGzC8dKjqfeaExtGEnWDLe7i
         sQx24oHXfk6IpuKVf9Vs/hnPQY0//jp14pOdYkAIp0glIqz671cMHzLd7f+BK9u7Zt/R
         TDWw==
X-Received: by 10.43.172.68 with SMTP id nx4mr25814242icc.48.1434984351589;
 Mon, 22 Jun 2015 07:45:51 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 22 Jun 2015 07:45:22 -0700 (PDT)
In-Reply-To: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272365>

On Mon, Jun 22, 2015 at 9:29 PM, Patrick Higgins <phiggins@google.com> wrote:
> I like to use git to remove trailing whitespace from my files. I use
> the following ~/.gitconfig to make this convenient:
>
> [alias]
>         wsadd = "!sh -c 'git diff -- \"$@\" | git apply --cached
> --whitespace=fix;\
>                 git checkout -- ${1-.} \"$@\"' -"
>
> The wsadd alias doesn't work with new files, so I have to use "git add
> -N" on them first. As of a week or two ago, the "apply --cached" step
> now fails with the following, assuming a new file named bar containing
> "foo " has been added with "add -N":
>
> $ git diff -- "$@" | git apply --cached --whitespace=fix
> <stdin>:7: trailing whitespace.
> foo
> error: bar: already exists in index
>
> The final "git checkout" at the end of wsadd truncates my file. I've
> changed the ";" to a "&&" to fix the truncation.
>
> Were there any recent changes to "git apply" that might have caused this?

Probably fallout from this one, merged to 'master' about 5 weeks ago.
I'll have a look at it tomorrow unless somebody does it first

d95d728 (diff-lib.c: adjust position of i-t-a entries in diff - 2015-03-16)
-- 
Duy
