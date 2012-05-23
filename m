From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 13:53:07 +0200
Message-ID: <CAMP44s0jLdNo89+c7+fBSokdxhCvPRnRKfhgVKnziMmv0vySXw@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<CAOnadRGgduprp_Dbjzf_TsyQQQjivzKxCgUq4y_HevvtKd7h7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed May 23 13:53:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXA7v-0001mq-LO
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 13:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab2EWLxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 07:53:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56728 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab2EWLxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 07:53:09 -0400
Received: by lbbgm6 with SMTP id gm6so4993262lbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=24H47otLiMc+7zdHFyhxlnFDn229iUpNxqPcFv22pOE=;
        b=Y0imAoksSEqgJgHGTlxlpB1aBTSkZaXhw9qIzY1Ikz4E/LXdgjbFztYR0mJEheT22j
         3rGVW53BNqVF2+4G9s0sqKCi7ZBlwt6j9vrgvWEyG7ChxYIbcVd7rcaBXKnN+trM8myi
         KCP68JLLNEzOOOXUEmMjs0W3OQ1HuIHPZ4gejqivIL3lHF1ruJ90g1JQdWCt0PECwMCM
         wtow3q0CA26PCTWQwLuxBUClxago1FmFMP4oKYCvALLF/rtxmSSGsgbq5OY4XNvLfevy
         hb6HnHO0iZeTdX2eA8zfuOUvdX/y9MEJ3E1yth3RYA1oCq0cfU0ge9rqNzl9F3EQWYdl
         FrKA==
Received: by 10.152.108.38 with SMTP id hh6mr26467777lab.28.1337773987800;
 Wed, 23 May 2012 04:53:07 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 23 May 2012 04:53:07 -0700 (PDT)
In-Reply-To: <CAOnadRGgduprp_Dbjzf_TsyQQQjivzKxCgUq4y_HevvtKd7h7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198280>

On Wed, May 23, 2012 at 12:27 AM, Ted Pavlic <ted@tedpavlic.com> wrote:
>> The solution, proposed by Kerrick Staley[3], is to split the git script
>> in two; the part that deals with __git_ps1() in one (i.e.
>> git-prompt.sh), and everything else in another (i.e.
>> git-completion.bash).
>
> Seems like this solution has popped up on lots of forums for about
> every Linux distribution around the time the new bash completion was
> introduced. I'm not sure Kerric Staley deserves sole attribution
> (sorry Kerrick; I mean no offense).

I didn't attribute it to him, I merely said he proposed it, which he
did, I did not make any statement about him being the sole author of
this idea.

I don't recall this solution for this problem being proposed in this
mailing list by anybody else though. And I don't think it's relevant.

> Moreover, every time the subject of splitting __gitdir out comes up, a
> side discussion about all of the complications that could cause comes
> up... and people give up and hope that the folks upstream (i.e., here)
> will come up with a better solution.

This is the reply Kerrick got to his suggestion from Jeff King:
http://article.gmane.org/gmane.comp.version-control.git/194230

I also agreed, and so did Jonathan Nieder:
http://article.gmane.org/gmane.comp.version-control.git/194950

So I don't see what you mean by those side "discussions" I recall
Junio objecting to this, but the split was meant to solve another
issue (zsh).

> If it was so simple to just split __gitdir out, I think it would have
> already been done.
>
>> The only slight issue is that __gitdir() would be duplicated, but this
>> is probably not a big deal.
>
> That seems ugly. I know that splitting __gitdir out is also ugly, but
> I know that there are going to be a lot more people who use git
> completion than git_ps1. Consequently, in a duplicated __gitdir
> scneario, I worry that __gitdir will receive more attention and may
> relatively quickly diverge in implementation if not very careful in
> approving patches. Moreover, a __gitdir of the future may not be
> atomic and will pick up side effects and become impossible to manage
> in two places.

Perhaps, but it wouldn't work worst than the current __gitdir(). And I
haven't heard any better suggestions yet.

> So maybe a split out "git-gitdir.sh" that both files include would be
> "better." Either that or the functionality of "__gitdir" gets pulled
> into git itself. (perhaps a git-gitdir added to the main git
> distribution)

I like the idea of 'git gitdir' (or 'git dir'), and I dislike the idea
of 'git-gitdir.sh'; people would need to copy one extra file, and
probably edit multiple files.

>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> As the patch is from you, there's no need to sign off on it too.

Yes I do, according to Linux guidelines[1], and that's what I've been
always doing in the git mailing list.

Anyway, before going straight to a negative attitude, why don't we
wait for more comments before making any conclusions?

Cheers.

[1] http://www.kernel.org/doc/Documentation/SubmittingPatches

-- 
Felipe Contreras
