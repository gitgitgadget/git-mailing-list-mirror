From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Thu, 9 Jan 2014 00:54:54 +0100
Message-ID: <CALas-iiX1=LAJQ_LsayhxB2zQTYVd5jxpVvOLOpdgHBW10ci1A@mail.gmail.com>
References: <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com> <20140108010504.GE26583@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 09 00:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W12y9-00061a-0j
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 00:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbaAHXzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 18:55:17 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:39745 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757768AbaAHXzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 18:55:15 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so2494834obc.20
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 15:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pOkXWp878wI8sjApJ7FELGGncQNJQp2U7jDN4irsZgs=;
        b=uwV+JcqP3CpClNJrBfvD3uk79WWw0sHozk20KHlBoFijVC5hT+vMyr4sfDBWfrFf2K
         G3FjOOA5lAJjpebus+CGhYQsn9DNcrudCkIKFT5aT53zqXJG55YrAk3MYCUZ7lz9DS0X
         N1kK06iE1ynS1jDl9LRq/AWiztzPqpFUIirQ9qlicB7ttgncD57QZRdSkdaLWD+QlmmB
         xq7+klUqJ0qs7z9eAdIyjJO6nQqXtkNsNXMmPz4zxG1USV3xrCaCEG12E+XQSgFTnGum
         hjzEgQ9BZ+9sAQMvE8Cw8j3Y69xkjbQgGkKlfb1MOmlwaPzllaEdrzlewf+91AkO9ZRA
         sH+w==
X-Received: by 10.60.56.137 with SMTP id a9mr55967oeq.75.1389225314680; Wed,
 08 Jan 2014 15:55:14 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Wed, 8 Jan 2014 15:54:54 -0800 (PST)
In-Reply-To: <20140108010504.GE26583@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240231>

2014/1/8 W. Trevor King <wking@tremily.us>:
> I also prefer 'checkout' to 'head', because 'checkout'
> already exists in non-submodule Git for switching between local
> branches.
>

Reasons I would loosely support 'git submodule checkout'
--------------------------------------------------------------------------------
1)  It's true that 'git submodule checkout' would also often run 'git checkout'.

Reasons, as an user, I seriously would *not* like 'git submodule checkout'
-----------------------------------------------------------------------------------------------------
1) 'git submodule checkout' would also touch '.git/config' and
'.gitmodules', and I don't like much the idea of a 'checkout' command
touching config files. It looks dirty.
2) Having 'git checkout', 'git checkout --recurse-submodules' and
finally 'git submodule checkout' is too much for me.

Also, in my proposal, 'git submodule [tobedecided] --attach' would
also merge orphaned commits by default, and 'checkout' is not about
merge.

Reasons I would fervently support 'git submodule head'
----------------------------------------------------------------------------
1) It tells immediately that this command is about HEAD of the
submodule, and will take care of it. Newcomers would loveit if they
don't like their HEAD state;
2) "head" is unspecific enough to admit it can also touch
'.git/config' and '.gitmodules'.

Said this, it seems Heiko[1] proposed a similar syntax and the only
difference was about names, not behavior of the command to be added
(if we eventually take this path, ofc).

> On Wed, Jan 08, 2014 at 01:17:49AM +0100, Francesco Pretto wrote:
>> # Attach the submodule HEAD to <branch>.
>> # Also set ".git/config" 'submodule.<module>.branch' to <branch>
>> $ git submodule head -b <branch> --attach <module>
>
> I prefer submodule.<name>.local-branch for the submodule's local
> branch name.

I think this was still part of your original misunderstanding about my
"git submodule head". This command would touch 'branch' property
anyway because '-b <branch>' would still be the remote branch, even in
the case you have a 'local-branch' property (maybe to be coupled here
with a --local-branch <local-branch> switch).

Greetings,
Francesco

[1] http://marc.info/?l=git&m=138913435216349&w=2
