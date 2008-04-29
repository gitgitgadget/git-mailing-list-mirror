From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: bug: git-diff silently fails when run outside of a repository (v1.5.4.2)
Date: Tue, 29 Apr 2008 18:03:08 -0500
Message-ID: <3c6c07c20804291603q4fbe957eq3e3da39d4a2e29c0@mail.gmail.com>
References: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com>
	 <7vabjc5l3r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:03:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqyrf-0002Yz-58
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYD2XDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYD2XDM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:03:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:39170 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYD2XDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:03:11 -0400
Received: by wr-out-0506.google.com with SMTP id c48so254858wra.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nYfutjPyTqit6Iyf8PwMDTepOx1gppgTGT5jJIhUijQ=;
        b=px4Ts1JYCvE1YQpT2ri3lrUWmzGxlcHxJAPLob0VS62xnMoP/C7yR+mu598QhhWbdqpnL86tmjVdOAIYP6EHv8U83wQUjRY6Kkkn3fB7fVtQdICJY000hEEI1FJaEE0TXuuChqD08NKcWw47uZ92WYwpRAZxFgPlR4y79bOtyYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o7QbpqkKDP0zXllhrv2P5eDgTVGqs4W7t7He0bbKhzCnyTnoVwffaZh6W7CuGQIJJCH8IHarNPB3DSt+tVUywePAzF3TPmhGKfmD6G5ZVHZD8wM4i/h8fgNnheJMNbq2fF6eKJZiYxaak/9Nx2lUq3nMCTKRDMmjlEGViI58mo8=
Received: by 10.115.75.1 with SMTP id c1mr22245wal.84.1209510188769;
        Tue, 29 Apr 2008 16:03:08 -0700 (PDT)
Received: by 10.114.92.7 with HTTP; Tue, 29 Apr 2008 16:03:08 -0700 (PDT)
In-Reply-To: <7vabjc5l3r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80764>

Oh, I didn't realize that.  It doesn't seem to be mentioned on the man
page, though I can't necessarily claim that I would have seen it if it
had.

Even so, this seems like a bug.  If I do this:

    $ cd /
    $ git-diff

there is no error message and no error status.  A diagnostic would be
very helpful.

Mike



On Tue, Apr 29, 2008 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Mike Coleman" <tutufan@gmail.com> writes:
>
>  > At least in version 1.5.4.2, git-diff silently fails when not run
>  > inside a repository.  It should give an error diagnostic, especially
>  > since "no output" would otherwise be a meaningful response.
>
>  Unfortunately this does not have enough information to go by, as unlike
>  many other programs, "git diff" contains a hack to be usable as a better
>  (for certain definition of "better" I may not necessarily agree with) GNU
>  diff replacement when run outside a repository.
>
>  i.e.
>
>         mkdir -p /var/tmp/junk
>         cd /var/tmp/junk
>         rm -fr .git ;# make sure it is not a repository
>         echo >a hello
>         echo >b world
>         git diff --color a b
>
>  is supposed to work.
>
