From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Using git-replace in place of grafts -- and publishing
 .git/refs/replace between repos?
Date: Sun, 16 Sep 2012 04:42:29 +0200
Message-ID: <CAP8UFD0sfBGT9OaGuS9OF68rdhoe1PTM4gYxE78z+NjTApF9Sw@mail.gmail.com>
References: <CACffvTp4qnHc3RHKDotEfvshVDqGtTX6eh6Fr-bmJSMUvTFN6g@mail.gmail.com>
	<7vvcffyzfh.fsf@alter.siamese.dyndns.org>
	<CACffvTroMt-s7X_DV9AHerzKdgz+xABXTd91aTUc2BtYO7QxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 04:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD4om-0007ta-3C
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 04:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011Ab2IPCmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 22:42:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60205 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab2IPCmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 22:42:31 -0400
Received: by wgbdr13 with SMTP id dr13so4704356wgb.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7JI/O1U9OeiBW/VRlGLM90CovJjPwS8DH/yc6oGutXo=;
        b=DcVEPkXhY8Ary1+RK//9AiVTJkrAx1Ygj552Z/4NBXzliUoYvzs1O4pVXw5in5SZNo
         kFhRNmd3JzltSb7nLnLElUlxm5PpnjjhTEMM9RH+o9BEdhsszmipoU6vEfY1vPjo7W7O
         MBB8Fn9jZQT8DBNCIPUy1lRoOgw/nylUuBXIT3UY4xjUd2hPuq8XpcLztdaMlHgMoscf
         mybLQBwNc37qyPxmXN/P008jj0ZqYFd/zh77fXIGOeC4CWTWD2Zrmd3y05qlJZldC4xV
         ++gN9wy3QZEDD2dohgoE0aGlpHFW+1y35c0ayEnPC9YCces56on9ynD1r0h0Bd2ErAmW
         opYQ==
Received: by 10.180.105.163 with SMTP id gn3mr7584518wib.2.1347763349718; Sat,
 15 Sep 2012 19:42:29 -0700 (PDT)
Received: by 10.223.87.80 with HTTP; Sat, 15 Sep 2012 19:42:29 -0700 (PDT)
In-Reply-To: <CACffvTroMt-s7X_DV9AHerzKdgz+xABXTd91aTUc2BtYO7QxCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205589>

Hi,

On Sat, Sep 15, 2012 at 11:49 PM, David Chanters
<david.chanters@googlemail.com> wrote:
> Hi,
>
> On 15 September 2012 18:21, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Assuming that they do, pushing the replacement ref makes the
>> replacing object available in the pushed-into repository, so
>> they will *not* rely on your repository.
>
> This makes sense.  But it is more the mechanics of what happens with
> needing to update the "fetch" line for the remote in .git/config I am
> more puzzled by.
>
> For example, if I have two repos -- repoA and repoB, where repoA
> contains the replace refs for repoB -- if I clone both repos with the
> intent of wanting to look at the two histories, what must I do in
> repoA to fetch the replace refs in the first place?
>
> I've tried:
>
> [remote "origin"]
>         fetch =
> +refs/replace/*:+refs/heads/*:refs/remotes/origin/*:refs/replace/*

Could you try the following:

[remote "origin"]
        fetch = +refs/replace/*:refs/replace/*
        fetch = +refs/heads/*:refs/remotes/origin/*


> But this results in:
>
> % git pull
> fatal: Invalid refspec
> '+refs/replace/*:+refs/heads/*:refs/remotes/origin/*:refs/replace/*'

Best,
Christian.
