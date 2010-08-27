From: Elijah Newren <newren@gmail.com>
Subject: Re: git pull --rebase differs in behavior from git fetch + git rebase
Date: Fri, 27 Aug 2010 12:46:53 -0600
Message-ID: <AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>
References: <4C772A01.5030207@workspacewhiz.com>
	<alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>
	<4C77DE60.6020809@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Olszewski <cxreg@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 20:47:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op3xT-0001zx-Mh
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 20:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab0H0Sq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 14:46:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45997 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab0H0Sqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 14:46:55 -0400
Received: by fxm13 with SMTP id 13so2190873fxm.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZxDvWccCv+BF0lwOTJwaFJ10/Jrd8dKcdOgdxr+DR5E=;
        b=LeoXutSYMPe2JpSyU6lp7pxs99vjhyNYCXjBTh3++R/VMcMYYU1AJzAz5pbFIRYEex
         2Evs7spbbxmoaEjczEue3BvfxFG//UNKAiNsz9a4ZoS8G+vw3tXsan9qpCd0mdmAEpUb
         NnnrDmQwYBh9HKcS0fmBZOnpUUb12jHYruMXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e3d0yYxgrOmkZlBeQ4r26Axq23ZCN7uNdmELvh+bEu647H0oWn0iChufE5m7qOSctW
         BVX6twUglan4BvfJEjM6aX6Bm8ukotpZqA7zDly+pmA2BuV7Rw7nGAbOdofT5wYp8HiF
         kyAtfNP086kF5L1+6RKq+XELvgLiO+4/Oqnms=
Received: by 10.223.105.197 with SMTP id u5mr1020383fao.14.1282934813885; Fri,
 27 Aug 2010 11:46:53 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Fri, 27 Aug 2010 11:46:53 -0700 (PDT)
In-Reply-To: <4C77DE60.6020809@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154614>

On Fri, Aug 27, 2010 at 9:48 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
>> The main difference between "git pull --rebase" and "git fetch && gi=
t
>> rebase @{u}" is that "git pull --rebase" will attempt to use the ref=
log
>> to find a suitable "upstream" candidate instead of assuming your
>> tracking branch is the upstream itself. =C2=A0This is intended to he=
lp
>> recover from upstream rebases, but has adverse effects sometimes, wh=
ich
>> commit cf65426de should help with.
>
> Unfortunately, commit cf65426de helps only a little. =C2=A0The 'git p=
ull
> --rebase' reports "Nothing to do" and moves the master branch to
> origin/master, leaving behind the commit needing to be rebased.
>
> What else might there be to try? =C2=A0I would like to help with a re=
pro, if
> possible.

Try modifying the git-pull script; change the last line from
  eval "exec $eval"
to
  echo "exec $eval"
=2E

Is the output of the form
  git-rebase --onto XXXX YYYY
or
  git-rebase --onto XXXX XXXX
?

With cf65426de, and from what I'm guessing from your description, I'd
expect the latter.  And, I'd assume the latter is equivalent to
'git-rebase XXXX', but you say that's not the behavior you're getting.
 Finding out which of my assumptions is wrong may help you debug the
issue.
