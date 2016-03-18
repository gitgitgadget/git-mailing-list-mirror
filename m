From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Code reorgnization
Date: Fri, 18 Mar 2016 12:59:25 +0700
Message-ID: <CACsJy8AmrdVeB95RUbVPamM7DMxFKRJ9REd0SN_oq_4HEb6E9g@mail.gmail.com>
References: <20160317111136.GA21745@lanh> <20160318052447.GD22327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnU8-00035p-SX
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587AbcCRGAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 02:00:00 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32879 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbcCRF75 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:59:57 -0400
Received: by mail-lb0-f179.google.com with SMTP id oe12so82010750lbc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ExgholPwAwxXd2BMyOemc3CzErzEQwfP9d3Z6BneCuI=;
        b=Nge799zNCqyFHPLTqXBjBNS01FPTCC0/w41HAkOndL9e6SmVULf4Memxi0o9PhKFo9
         smzE9JuTO2qsAM8OuJiVNoPrysvWmk6T2WKWgHqHs8UCzaUr+azjzDra/kD/M9cknd+o
         IazJXfkGbPXJvj8PHdsQIrHimxWLMZgbOGr4JVy3AVn9OOKpVdwdO4v41jQX5GtSA+0C
         rIp+z/UMLFazpM8yDbnL3Khu7kXqA0xdXYs/TCocPzJ4537xWKNyZUwsA1Ert9h3R+Pd
         YgWmyCT8blsvseAGEPlWDUI7swCSpQRug4Ets5hOhls8adti5HPZjo3nM5fGylb6om+O
         a5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ExgholPwAwxXd2BMyOemc3CzErzEQwfP9d3Z6BneCuI=;
        b=mErOenZP9EbFOhf2FKextOZRFsp3DglgcU5q8jjnnA0bXuGnButYLDzpMVxtQypr0e
         pl7v8uMVCNttcSLoG1O5g9UtGNRdMWQ8e3m93JdPB7g/irlJihyGRUiStpitvFB26+Df
         dlbBW/FrKp1ydxU8i817yc83P09SNWWEGBWVXWx6rSQw01j3OFbxEafMb1qs4QgsESf8
         /ny4AL76exVllJRXT85kBEefAtyK1E1hKYF755PePmXQCYAFbuNv3Vol4hYaDoUk3tyn
         c7oSUKMmVjpbX6wgkBVre6QsrxZAGDig05XpfGy232GmS32Nn3n8ILk5O18G0C093iTb
         hmbA==
X-Gm-Message-State: AD7BkJL5Kh1JurmBduGnMtZuzU+bxpj7dQ54KjfITyPef3r35hGoEMvU911kjxmPEo6/o5uYoK3KCFQuibR7qQ==
X-Received: by 10.112.171.163 with SMTP id av3mr5047468lbc.145.1458280795274;
 Thu, 17 Mar 2016 22:59:55 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 22:59:25 -0700 (PDT)
In-Reply-To: <20160318052447.GD22327@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289198>

On Fri, Mar 18, 2016 at 12:24 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 17, 2016 at 06:11:36PM +0700, Duy Nguyen wrote:
>
>> Git's top directory is crowded and I think it's agreed that moving
>> test-* to t/helper is a good move. I just wanted to check if we could
>> take this opportunity (after v2.8.0) to move some other files too. I
>> propose the following new subdirs
>
> I guess I don't really see the "crowded" problem, but perhaps that is
> because I am more or less familiar with where things are in git's code
> base. I suppose if you were looking for a "utility" function, you might
> look in "util" and therefore have a smaller set of files to check.
>
> But I think we also run into the opposite problem: I am looking for some
> particular function, but I can't find it, because I am looking in "util"
> and it is in some other directory. And when files move around, it makes
> history harder to follow (maybe that is because git sucks and we need to
> make it better, but certainly I run into mild annoyances with the
> builtin/ rename when digging in history).

Yeah, for finding a particular function, I just "git grep" (or rgrep
from emacs) if I fail to locate it after the first guess. We have this
problem nowadays anyway. Besides builtin, we also have ewah, refs and
some more subdirs.

> And you have a similar problem when creating new files. Which slot do
> they go in? What if they could feasibly go into two slots?

Everything goes to topdir (or later on "src") by default and only goes
to "lib" when it's _obvious_ that it's disconnected from git (i'm
talking about the "lib/src" layout).

> So there can be friction either way. In practice I find I just use ctags
> to jump to the functions I am interested in, and I don't care that much
> about filenames.
>
> The reorganization that _would_ be more interesting to me is not files
> in directories, but rather functions in files. I wish everything were
> designed more as modules with a pair of matching ".c" and ".h" files,
> with a public interface defined in the ".h", and messier, private stuff
> in the ".c". But we have some real dumping grounds:
>
>   1. cache.h has the declarations for at least a dozen different
>      modules; besides being hard to navigate, it causes more frequent
>      recompilation than necessary.
>
>   2. a few of the .c files could probably be split (e.g., dir.c is where
>      all of the pathspec code lives, even though that is used for much
>      more than filesystem access these days).

Heh.. that's what I wanted to do (or at least discuss) after files are moved :)

> Splitting those up would _also_ introduce friction (and actually worse
> than whole-file renames, because finding code movement between files is
> an even harder / more expensive problem).

.. and this is why I did not raise it in the first mail.

> But I feel like it would buy a
> lot more in terms of code clarity, and in reducing the scope of code
> which has access to private, static interfaces.
-- 
Duy
