From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Wed, 15 Oct 2014 20:08:33 +0700
Message-ID: <CACsJy8AmBr2YTJkVw4BDD95RVE91EEBtEyakOpb77NDXaVBzJA@mail.gmail.com>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de> <20141014203114.GB8157@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 15:09:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeOKG-0005bG-CG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 15:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbaJONJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 09:09:06 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61358 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaJONJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 09:09:05 -0400
Received: by mail-ie0-f182.google.com with SMTP id rp18so1143544iec.27
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yl+s97BHH8k6ZK73bhni2ZoyhNqdtbS7uCm/PFqzz4w=;
        b=Gm2IHgbkI9gTYLaokPkLI4sfAR5CuOyZfeTZuGFz9WiqPT/zw9GmK/hxnxdcdI2lz7
         dsnJP3XVkgHsWvArZLOe2BfZOURzo+GtxZIizmSQdS1Ro0Z2WFvGkLVt61CLCKQtGBbi
         TjXsOav00BRANPqiVuBIdBH9uiM0VJbvnudBpVgkyA1bRb5VU5mMxwzqQ5vdnKZxMUBj
         SSIsv7b0acGbtOLOR4T5YVEh2htV/HCL+X3Y/cnFUPGbEkcCxHpFyrtOh+bo5Xvl5TCj
         MFn+G6cDEuoGmCB661H0ZlADXhJUuBJquvgcatJadKkEOC0wr6mLqyCk91NWu8lozij+
         qCVA==
X-Received: by 10.107.8.152 with SMTP id h24mr1806123ioi.84.1413378545034;
 Wed, 15 Oct 2014 06:09:05 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Wed, 15 Oct 2014 06:08:33 -0700 (PDT)
In-Reply-To: <20141014203114.GB8157@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 15, 2014 at 3:31 AM, Max Kirillov <max@max630.net> wrote:
> On Tue, Oct 14, 2014 at 07:09:45PM +0200, Jens Lehmann wrote:
>> Until that problem is solved it looks wrong to pass
>> GIT_COMMON_DIR into submodule recursion, I believe
>> GIT_COMMON_DIR should be added to the local_repo_env array
>> (and even if it is passed on later, we might have to
>> append "/modules/<submodule_name>" to make it point to the
>> correct location).
>
> Actually, why there should be an _environment_ variable
> GIT_COMMON_DIR at all? I mean, gitdir is resolved to some
> directory (through link or environment), and it contains the
> shared data directly or referes to it with the commondir
> link. In which case anyone would want to override that
> location?

It's how the implementation was built up. First I split the repo in
two and I need something to point the new/shared part.
$GIT_DIR/worktrees comes later to glue them up. Keeping it an
environment variable gives us a possibility to glue things up in a
different way than using $GIT_DIR/worktrees. Of course the odds of
anybody doing that are probably small or even near zero.

Still consuming the rest of this thread. Thanks all for working on the
submodule support for this.
-- 
Duy
