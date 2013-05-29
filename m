From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex
 support is broken?
Date: Wed, 29 May 2013 10:41:30 +0700
Message-ID: <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Misty De Meo <misty@brew.sh>
X-From: git-owner@vger.kernel.org Wed May 29 05:42:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXH6-0006ex-Re
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934102Ab3E2DmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:42:03 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39119 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020Ab3E2DmC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:42:02 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so2917127obb.8
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OzT+AY9JtNt+dip8s4mu+kXymgg5MVpGw2zN5aBlIFg=;
        b=qcK2AeG1jNyzj7p5bUyRpXbfArhnbeNzn+B3o3jpnf3DxrJ6IEay4hGHiAiVHxCsga
         r6Z3LYZRy6Jj0vzEplHCKG86Wq3LSavMyGiUE63vfhfsgZ6kPTtJS9bRrYUQ5vlJ2tTd
         ryJmHyrWzmyV2wym01wBp0FgI1YEQeWNS8ul+fpY2AKL2bEKXFxSV5CTAa66lwfiVKHv
         baogNHSlfQ+Xyck6YYKlSuNDKG95XzBBpgKw6n0lejDYxrQtkWt2/jcBVpwr2qaJoCvp
         VrNKX+cq8o50XSPJx3PPE87ctjom1RsDyVAjZSHQKKe0tEgXpbkpod3tCST08lY5U3IH
         5vEQ==
X-Received: by 10.60.149.231 with SMTP id ud7mr435461oeb.119.1369798921196;
 Tue, 28 May 2013 20:42:01 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 28 May 2013 20:41:30 -0700 (PDT)
In-Reply-To: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225713>

On Wed, May 29, 2013 at 12:54 AM, Misty De Meo <misty@brew.sh> wrote:
> Hi,
>
> Gitignore parsing no longer seems to work properly in git 1.8.3.
>
> One of my repositories has the following gitignore:
>
> /*
> !/.gitignore
> !/Library/
> !/CONTRIBUTING.md
> !/README.md
> !/SUPPORTERS.md
> !/bin
> /bin/*
> !/bin/brew
> !/share/man/man1/brew.1
> .DS_Store
> /Library/LinkedKegs
> /Library/PinnedKegs
> /Library/Taps
> /Library/Formula/.gitignore
>
> In 1.8.2.3 and earlier, this works as expected. However, in 1.8.3 I'm
> seeing every file in /bin/ being marked as an untracked file.

The changes in this area since 1.8.2.3 seem to be Karsten's (I'm not
blaming, just wanted to narrow down the problem). The patterns of
interest seem to be

!/bin
/bin/*
!/bin/brew

Without "!/bin" v1.8.3 seems to behave the same as v1.8.2.3. Can you verify it?

> I asked about this in #git, and was told that the culprit was the
> regex support; apparently recompiling without regex support fixes the
> specific gitignore issue. However, this doesn't seem to have been
> reported anywhere on the mailing list that I can see. I was also told
> that the issue is OS X-specific, and doesn't happen on other
> platforms.

Puzzled. regex has nothing to do with gitignore (glob does). How do
you recompile without regex support? Setting NO_REGEX? I'm on Linux
btw, no chance of touching OS X.
--
Duy
