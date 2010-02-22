From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Branching a subset of your working tree
Date: Mon, 22 Feb 2010 13:44:32 -0800
Message-ID: <a038bef51002221344ic966a22x939824fa31020bff@mail.gmail.com>
References: <ron1-F4D522.13070422022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:44:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njg50-00085v-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 22:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab0BVVoe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 16:44:34 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48025 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab0BVVod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 16:44:33 -0500
Received: by pwj8 with SMTP id 8so3097858pwj.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 13:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4HN5yxENsf0daSBJ9eP+nUeW4QPvXcXP/Gpkz3a6clU=;
        b=W40f5pXXFV8ZCseV1cihhe7U1wNjGFibA2o39ytqXvQkVZUm3WkacPxkM9EAe1SpmE
         fMbJIxscFa2x1RqpStbvEso2RJlQjVvlQHxKlsdH/VI/H19iwONpq/XT1w+5RBkc58nz
         txZsbOjhYweT8Eq6s0S+qOhvVM/U3Jok2BD7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ExQWDkqJfpLvZSRdsh+V8VFL0HHwnGzCK6f1gpSfZ0SKoGVL568bYo4iPPVZ8bY/q/
         bTipkwP6uKfi43V0A1FN5FoEYehq4NjLxuMBXEaX7PgoHoSFVYyIAIZL4a0DUgnj6u8C
         0WX6ZG7znpTS/sM8yguVYpSH00t3Qw8xwaMtA=
Received: by 10.114.214.21 with SMTP id m21mr4749209wag.213.1266875072344; 
	Mon, 22 Feb 2010 13:44:32 -0800 (PST)
In-Reply-To: <ron1-F4D522.13070422022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140717>

On Mon, Feb 22, 2010 at 1:07 PM, Ron Garret <ron1@flownet.com> wrote:
> What is the recommended way to create a branch that contains a subset=
 of
> your working tree? =C2=A0The use case is creating a distribution bran=
ch that
> will be pushed out to a server and I only want to include files that =
are
> ready to be released.
>
> Thanks,
> rg

Well we did something similar at $dayjob. We had a repository
consisting of code we wanted to release under the LGPL and code we
wanted to keep private.

We ended up using git filter-branch to create 2 new repositories with
commit histories one for the GPL stuff and one for the proprietary
stuff. We then started working on them as 2 separate repositories.

This is possibly a different use case for your situation. We were
happy to wear the fact that our developers would have to re-clone the
2 repos but it sounds like you may want to be able to submit common
code when it is logically complete.

Another suggestion would be to use branches instead of separate repos.
This similar to how git.git is run. i.e. "master" is the stable
branch, "next" is the proving ground for features that have been
cooked sufficiently and "pu" is where new topics get introduced
(disclaimer: this may be an inaccurate representation of how git.git
is _actually_ run but you get the gist). This of course assumes you
are happy for the unstable code to be visible.
