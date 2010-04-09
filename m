From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git rebase command and docs questions
Date: Fri, 9 Apr 2010 23:23:23 +0200
Message-ID: <l2nfabb9a1e1004091423te78b692btd8bbb03785f94a16@mail.gmail.com>
References: <h2j76c5b8581004091149y9f5f93a8o5f11b3ffc657623@mail.gmail.com> 
	<r2mfabb9a1e1004091337w8ec2b721y3a5082d5e0f5925c@mail.gmail.com> 
	<7vhbnk1gc6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:23:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LgE-0002xF-1f
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757818Ab0DIVXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 17:23:46 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:38071 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757817Ab0DIVXp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 17:23:45 -0400
Received: by yxe1 with SMTP id 1so1568917yxe.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SMPs5l9lwe3ArpnOMbJrZ6rEob4kM0gkCPTzGyIld4A=;
        b=qpHSwVhe1g7Fay6CKimhcph8iLGIyrIl2qgARh6Qqnq+U02jAZjyql1Yup3ww+2HNU
         V18EqhVa+jDW+v34skxJ54zZMabi3CToyMhhe+IDiZr2NJTwB9dibsdq6jWaOaPjyhKZ
         WOaKSlXEuOEydftnH/9Kvm1wBLzUToCKW8EDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SdD+Oc8bj7zCaPm+v73vW7ORrZmmUpYtJLORRNjjCoZiUpkC2UAAuMIXSLKJZXpP5t
         mPVoIuI2kCEDMnQYiBgw7aBEaPjLcKohfOXgI5Al3FuPDw4y01DgItFLM48IDveHp8fm
         sweKgO7hAr9fPp/Nx33wETAp5gcviRzlPxVhw=
Received: by 10.100.206.13 with HTTP; Fri, 9 Apr 2010 14:23:23 -0700 (PDT)
In-Reply-To: <7vhbnk1gc6.fsf@alter.siamese.dyndns.org>
Received: by 10.101.128.17 with SMTP id f17mr629718ann.173.1270848225013; Fri, 
	09 Apr 2010 14:23:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144473>

Heya,

On Fri, Apr 9, 2010 at 23:11, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, re*base* means "change the base to _this one_"; the above is mor=
e
> like "replay these on master", which is often a useful operation but =
is
> different.

Yes, I guess that's true.

> If you _had_ your "replay" command, the workflow for this would be:
>
> =C2=A0 =C2=A0$ git checkout -b maint-fixes origin/maint
> =C2=A0 =C2=A0$ git replay origin..fixes

True again.

> Before somebody else makes useless noises, "cherry-pick" could be a g=
ood
> command in the existing UI set to do that kind of thing.

I still think the UI for --onto is awkward. At the very least it should=
 be:

git rebase --fork-at=3Dorigin origin/maint fixes

Or something like that. Since currently you suddenly have to specify
an argument to --onto that was previously positional. Does that make
sense?

Case 1:
git rebase origin fixes
git rebase <new_base> <tip>

Case 2:
git rebase --onto origin/maint origin fixes
git rebase --onto=3D<new_base> <fork_point> <tip>

I know that in the --onto case <new_base> is not an argument to
--onto, but that's what it looks/feels like. Said differently, it's
just _really weird_ that a new argument (for a different mode) shows
up between two other arguments. It should either be at the beginning,
or at the end, but in the middle is just awkward, no?

So another solution might be to change the position of the
<fork_point> in the --onto case.

--=20
Cheers,

Sverre Rabbelier
