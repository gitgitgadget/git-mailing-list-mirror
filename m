From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Found possible branch point, then "Use of uninitialized value $u
 in substitution/concatenation"
Date: Fri, 6 May 2016 10:27:44 +0200
Message-ID: <CAP8UFD0k0Kx306S3y-Kd5328j0MDNL+ewCJvXbsJ1nzsJYRdtg@mail.gmail.com>
References: <CALZdSA_pDy=B-bgB-vjpi1yjgtse_-07ewXSX0_GsYhLfOUbzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Thierry Suzanne <thierry@yellownemo.com>
X-From: git-owner@vger.kernel.org Fri May 06 10:27:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayb71-0007QS-DO
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 10:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbcEFI1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 04:27:47 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38232 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcEFI1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 04:27:46 -0400
Received: by mail-wm0-f48.google.com with SMTP id g17so65400371wme.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=AB1M+zx12ON2FSuUOdNyMcQB2GgqyrqVOQZmF/9+CgU=;
        b=GLJYRCfF8HXVVkumwzMqw1/NKCEOFMMSoFJdklAkeZLALfXM5euJwyDolbxElD0wkx
         h8ZexF7ZZuhHD0SDYOWEXo5j81FRHuSV2kcc5KY9PB7QCZB5NfBbt/l0KfE41ZK7/Py+
         yFq32ktiU6Yt77fHr1bDa7+Bdt+UR3eme1VV263SP/Z+tlHC/E3sa+35bbRMdlF5j6SB
         ie7GiXd3KXjgKasHrBX0oVgh2gUQGvAcqvAPs6pLtjztvLGdsChd0P76kpUjuhgkuH7K
         RcJ2zEvLZMBfRMWkCBaetJTnMq70XgE7cFSdnPa6rFk4gak11HCDyF7Lj2xf85pw2TAM
         mm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AB1M+zx12ON2FSuUOdNyMcQB2GgqyrqVOQZmF/9+CgU=;
        b=TPWQN1sHtHsDqV+E8h/tsd8LskQ88hW9IOBFdK9aIKAGTx/n4B0VuTcNS3jFZJeQyU
         HT7Jy9EGKHNJRgPzFmDpPu9Lk147HORUBsu8/UESQCJ4Eni4rRGsgbSSEDWwInBzdT5t
         WzsyJg7i/dPcDuM7dGrCjJeQu+1AjWrj+5CDqTZ7MKL1+G8YfMu+wapP9qRTNe2cbBsx
         NetSctBmGxdj4ge+YBjR84ddRKt8UWQP9cLL0XCJxlb+bgEcFNlO0Zr5HR4ae5qYIsNm
         MKzeP4U6lgXrtYKZo3gGAC6PteIeAyt1VMbeLODvlI0t5CzHU6WpeXZXuum2T98yARIa
         4pnQ==
X-Gm-Message-State: AOPr4FVDKzFryqCn1elD7ooK7gZbxoV/K71+NmJZn/proLlMuH8rzH88gqxBM7MOf7q0OUL0Vz2LAuitL4pKOA==
X-Received: by 10.194.117.70 with SMTP id kc6mr20305369wjb.94.1462523264458;
 Fri, 06 May 2016 01:27:44 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 6 May 2016 01:27:44 -0700 (PDT)
In-Reply-To: <CALZdSA_pDy=B-bgB-vjpi1yjgtse_-07ewXSX0_GsYhLfOUbzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293753>

Hi,

On Thu, May 5, 2016 at 12:43 PM, Thierry Suzanne <thierry@yellownemo.com> wrote:
>
> Looking at svn.pm, I can see we're in find_parent_branch() which
> outputs the message "Found possible branch point". It then calls
> other_gs($new_url, $url, $branch_from, $r, $self->{ref_id});
>
> which itself calls:
> Git::SVN->find_by_url($new_url, $url, $branch_from);
>
> which calls:
> resolve_local_globs($u, $fetch, $globspec);
>
> and resolve_local_globs is where the error is thrown on line 100/101:
> my $u = (::cmt_metadata("$refname"))[0];
> $u =~ s!^\Q$url\E(/|$)!! or die
>
> I made a mistake in my command line for sure, so this might not be a
> bug, I'm just emailing all this if someone think it could be handled
> differently or a better error shown.

Yeah, there is a die() calls above and also one on line 101, so it
looks like $u could be checked between line 100 and line 101 and die()
could be called if it is not properly defined.

Could you send a patch to do something like that?

Thanks,
Christian.
