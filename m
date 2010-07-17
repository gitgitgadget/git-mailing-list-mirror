From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2010, #03; Fri, 16)
Date: Sat, 17 Jul 2010 10:24:35 -0600
Message-ID: <AANLkTimCVgxc9TEujm9ih1fRm6UKUcRwD6DNf59bZgSh@mail.gmail.com>
References: <7vaapqr6a7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 18:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaABt-0002wr-Tj
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab0GQQYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 12:24:37 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38044 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab0GQQYh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jul 2010 12:24:37 -0400
Received: by vws5 with SMTP id 5so3546196vws.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=go9sbTSS8TZf9eK7pOW/uNhr3Lr8waHW+3dbelbPReI=;
        b=f1ao574uYx8K4y88t4KhtQ5Qi+jEq5db8OsMPdkiStlQQng095Hpv1YhBgUTcaQBy3
         HfXd4p0L8lt+LNWNZ80pm5B8u4qSDUvqp57InTc8kAqQ1cSSQ1/kQ+eGps8FuAvY/KHA
         CL+nXnNkt5rldvmmi1hUxbO1EDBMcIlrd1WUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jVJGXjOpmEzNGpxSXNOHFwvn2tCGIgxTjiwmMZYURg6CGjt+Bh7Nmor9rTYnbUT3wb
         MrhRtvSMsIP/r+JdLDRJOrQf0aQNT5QZ654vw4T0LhYtfEUiE5zarSwrSRW42+3ub2E4
         3O1JwJ+0CmwGPQgbh9xXapgILztW6nhC0V8hk=
Received: by 10.220.75.148 with SMTP id y20mr1535845vcj.4.1279383875948; Sat, 
	17 Jul 2010 09:24:35 -0700 (PDT)
Received: by 10.220.99.211 with HTTP; Sat, 17 Jul 2010 09:24:35 -0700 (PDT)
In-Reply-To: <7vaapqr6a7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151192>

Hi,

On Sat, Jul 17, 2010 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> * en/fast-export-fix (2010-07-07) 2 commits
> =C2=A0. fast-export: Add a --full-tree option
> =C2=A0. fast-export: Fix dropping of files with --import-marks and pa=
th limiting
>
> Seems to have breakage in test 9350 (possibly others but I didn't loo=
k).

The patch series works on top of maint or master, but not on top of
next or pu.  The existing tests pass, but the new one it adds breaks
because (1) this new testcase depends on the full output of
fast-export (and in particular the order of printed filenames) and (2)
the "fix output order of D/F changes" from the below series (which
underwent some modifications after the original submission of the
above series) changes that order.

> * en/d-f-conflict-fix (2010-07-09) 6 commits
> =C2=A0(merged to 'next' on 2010-07-14 at 2b2a810)
> =C2=A0+ fast-import: Improve robustness when D->F changes provided in=
 wrong order
> =C2=A0+ fast-export: Fix output order of D/F changes
> =C2=A0+ merge_recursive: Fix renames across paths below D/F conflicts
> =C2=A0+ merge-recursive: Fix D/F conflicts
> =C2=A0+ Add a rename + D/F conflict testcase
> =C2=A0+ Add additional testcases for D/F conflicts

One fix is fairly trivial -- just change the testcase to use the newer
file output order.  Alternatively, I could modify the new test to not
depend on the full output of fast-export.  I'll do the latter and
resubmit.

Sorry about this problem; I should have retested the combination of
the two series after modifying one of them.

Elijah
