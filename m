From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 21:32:29 +0200
Message-ID: <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211180559.GC19749@coredump.intra.peff.net>
	 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
	 <20090211184429.GA27896@coredump.intra.peff.net>
	 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
	 <20090211191445.GU30949@spearce.org>
	 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
	 <20090211192245.GA28832@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKqa-0001L4-30
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbZBKTcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbZBKTcc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:32:32 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:48978 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbZBKTcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:32:31 -0500
Received: by bwz5 with SMTP id 5so522855bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wl1tp5h6rfk65r/DuIkHN+6z7gCEfFlA2WnHrFkcczs=;
        b=sL2YAgquMT2ZVgc9DIzuVPEK3O2/XWRVZE4UzHswEbQoW9uGX0Zyp3KQkiwla15NHF
         S8bYqljYkxYdAbIzfyo8gF+ukRG4LRytDSOUjdRIF2OBVcbZQKALm2cd5meYaLjoaTiC
         SEEKC/bB0hRlgHhTx0fpAnPvSUV7cOKR5tyQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hR4+D3QBYC97gBnRwBx9LdeYaYdqk4yRHBaWPq5V6rUzMS/6LK/coDhLX1uWkf/zn6
         ML94lAVKmMb2x6dnkqZZ0UeJwSBv7NhgC+/h7TOPDiMe1JasGVWnKz39FuAoQB7vgYtX
         nmMY/LqVVeJMGdi6e8Q73AenJLiM883Q/fsHA=
Received: by 10.181.52.14 with SMTP id e14mr366549bkk.47.1234380749865; Wed, 
	11 Feb 2009 11:32:29 -0800 (PST)
In-Reply-To: <20090211192245.GA28832@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109511>

On Wed, Feb 11, 2009 at 9:22 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 11, 2009 at 09:20:51PM +0200, Ciprian Dorin, Craciun wrote:
>
>>     But I find it easier to just create a bin folder and drop my
>> scripts there... (For example git-branch-import that takes a new
>> branch name and an URL and creates the branch with no ancestry and
>> knows http, ftp, svn, tar.{gz,bz2}, zip, etc...)
>
> I don't see what is per-repo about that. That is, why not put it in a
> PATH directory accessible by all repos. And if there is some
> repo-specific data, you can have the script read it from the current
> repo by "git config".
>
> -Peff

    Well, it is per-repo because I've left out to tell you that the
git-branch-import command I use to track non-git source code
distributions for other projects... And my command constructs the
branch name in a certain way...

    Anyway, I don't see why it's wrong to have such a bin folder per
repository... Let's for a moment assume that there is a use case for
such a thing, I'm wondering what is wrong with this solution from a
Git perspective???

    Ciprian.

    P.S.: It seems that indeed setup_git_directory_gently (or
something in the setup system) is kind of broken if I call it twice...
So I'm trying to solve the problem from another angle... It seems that
setup_paths is called only from git.c, builtin-receive-pack.c,
upload-pack.c and shell.c... Thus I'll just work-around the problem by
adding the bin path only when it is called from git.c (which it has
worked for almost a year...)
