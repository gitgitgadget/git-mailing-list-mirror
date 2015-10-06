From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Clarification on Submodule/Subproject naming
Date: Tue, 6 Oct 2015 15:05:24 -0700
Message-ID: <CA+P7+xotGb8y2M0sjXmOmG0FofJtn_wsg3ASo-K62Ea9hk2mkQ@mail.gmail.com>
References: <CAGZ79kYyagjxyV0Da3FW3zWuJ+wD=FTPvzYebV7ER4TjTnMXpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 00:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjaNL-0003T7-6q
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 00:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbbJFWFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 18:05:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34124 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbJFWFo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 18:05:44 -0400
Received: by igcpb10 with SMTP id pb10so98251863igc.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 15:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YW1beWJFPD6CBN/PYqxeqQ/Tr13jtfF6Kpa4/rLLdC4=;
        b=qyR2sjUcrpoyOUIVEKgtlf2nWe3V8LM74ezcXbnj11rlE/ookROiP3IyfJ4NOOy2DS
         PYr3cPS33eSg1rsfY6NVAeJfe8U/l2EGkDUh8Hwx6qIYvxbZ4TmkTfOK4SUDFOuqS/SJ
         GyrMd+7Wp/lzyRTGPVaU/tNmkWQKL6sYK++DPjzEGoM8uABlQNaqo6w9bz7t1aJjD0J1
         /sGFB9w7AH5TEYjQbmNBpibSW50gjVHjpRt/VjdpGrBiuv9fT/mP+IE6utnUbR7eQqPl
         nSU861DZLO/8hyvNENs8fi/gsXUQ9wUSSLVnN7mMFTuVb0ddyCKXf4oEzixBQU7Pq1i3
         53iA==
X-Received: by 10.50.64.211 with SMTP id q19mr17618951igs.73.1444169143997;
 Tue, 06 Oct 2015 15:05:43 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Tue, 6 Oct 2015 15:05:24 -0700 (PDT)
In-Reply-To: <CAGZ79kYyagjxyV0Da3FW3zWuJ+wD=FTPvzYebV7ER4TjTnMXpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279167>

On Tue, Oct 6, 2015 at 3:00 PM, Stefan Beller <sbeller@google.com> wrot=
e:
> So a discussing started in a Gerrit change [1] if we want to name it
> submodule or subproject.
> We decided to stick with the git core convention of naming it
> subproject for now.
>
> But that lead me to the question: What is the difference of a
> submodule and a subproject?
>
> As far as I can tell they are synonyms (internally also called
> GIT_LINK, but we never expose that to the users), where the term
> submodule was coined later in the game, subproject being there as the
> first term introduced in version 1.5.
>
> So is it worth to unify that same concept hiding between two names?
>

I think it would be worth trying to sync up at least documentation if
possible, and maybe even change the diff core output, but that depends
on whether we think changing that would break anyone? I'm not sure who
it would hurt to just start using "submodule" instead of "subproject"
there?

> Looking through the code we cannot switch to submodule as the literal
> string "subproject"
> is used for diffs in the plumbing layer.

Is there a strong reason we can't just change the diff layer to
"submodule" here? I'm not sure who or what that would hurt.

>
> But getting rid of submodule is also not easy, as there is
> git-submodule.sh as a direct command.
>

I think we should stick to submodule as that is the name of the
command as well as the general term understood by most users.
Subproject is the older name that was used before submodule.

> So then there is also git subtree, which "allow subprojects to be
> included within a subdirectory of the main project, optionally
> including the subproject=E2=80=99s entire history." (the man page)

I think the term subproject used here is used in a general sense, and
not in the specific sense used elsewhere.

>
> So can I understand a subproject as either a submodule or a subtree ?
> If so would it make sense to add an entry to gitglossary to state tha=
t
> subprojects are generic term for
> having some kind of structure? (a subdirectory containing independent
> stuff could be considered a
> subproject. i.e. We could make contrib/examples the historic-git subp=
roject ?)
>

In terms of git diff core, subtrees are not shown as "subproject" in
the diffs at all, so I think in that sense subproject there is just an
artifact of what got used in the past.

> Any advice welcome!
> Stefan
>
> [1] https://gerrit-review.googlesource.com/#/c/70948/
