From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 14:18:11 +0800
Message-ID: <46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	 <7vabpliz13.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 07:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir69O-0000nD-Kz
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbXKKGSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 01:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbXKKGSO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:18:14 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:46059 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXKKGSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 01:18:13 -0500
Received: by py-out-1112.google.com with SMTP id u77so548042pyb
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 22:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yU6b+PP1S8gr+xxISc+duVUnp9MGlucvVLX+3UZksmw=;
        b=FxXD/sZFzC0+TasJR1TySyonf3PDUq6LRKjItp6kyXaHp1jPcDyguhw4Mk9adDc2XWuLYVzHYOXyjUOwrn/csDWkkS4aKhzxvxecsiluNCqJqWX0aGxUE6HDd5CNJ4Mh9s66GKqAhRTSn0FxLjVoplulCP8deemQRDb+pg6k/gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVqPVszW+RHv+uRgtskVLn1LEoJWsjdsCJ0cSdOE3ebUe1qPfRiqRTbbrJCnzuQcA5tbRWcIkP+CL7GawHhQYEyp6r0k6qZFPDnhPi/KzOC2YpCyMOaCIFrdVCR2OFyTIbC4L1y5knehKPIOfPwVW7p7eDs/Pf4MiFnh7+dAIiU=
Received: by 10.35.132.9 with SMTP id j9mr312423pyn.1194761891700;
        Sat, 10 Nov 2007 22:18:11 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 10 Nov 2007 22:18:11 -0800 (PST)
In-Reply-To: <7vabpliz13.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64412>

On Nov 11, 2007 5:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  * I think everbody preferes to have "On branch master" at the
>    very beginning

Reasonable.

>
>  * As I understand it, in the real life use,
>    the superproject can stay behind from the tip of subproject
>    and rebind it to a different commit only when there are
>    significant changes of the subproject that need to be there
>    to allow the other parts of the superproject (either
>    superproject itself or another submodule) to use the features
>    and/or fixes the submodule updates provides.

I think it's this kind of case in most open-source project. However,
in a company environment, superprojects may be not so super. A
superproject may bind very tightly with submodules (such as the html
template files which change very frequently) and the developer of a superproject
and its submodules may be the same guy(s). In these cases, a long list
of commits
for submodules are expected be reviewed when commiting the superproject.
>
>    And I think it is more important to give the birds-eye view
>    of the supermodule itself first, when you are helping to
>    prepare a commit message for the supermodule.
>    and then continue "Notable changes in submodule A are ...".
>    And the new part you are adding would help the user to write
>    the latter description.
I agree.
>
> I also find "<<< lines then >>> other lines" format very hard to
> read.  Maybe formatting it like this would make it a bit more
> readable and more space efficient?
>
>         # * sm1 354cd45...3f751e5:
>         #   - one line message for C
>         #   - one line message for B
>         #   + one line message for D
>         #   + one line message for E
>         # * sm2 5c8bfb5...ac46d84:
>         #   - msg
>
I have struggled between these two kinds of presentation and finally
choose the '<<<' one.
IMHO, '-/+' one each line will distract and less space/size efficient
(100 '+/-' for 100 lines of messages).

However, it's not a big matter. I'll change the presentation if
everyone prefers the
patch-like one.

> Note that if you swap the order and move this at the tail
> (perhaps before "Untracked files:" section, if you do not have a
> decent .gitignore set up), you can also lose the "submodules
> modified: sm1 sm2" line and the blank line before it, which
> would make the output even shorter without losing any useful
> information.
>
So following is ok?
        # On branch master
        # Changes to be committed:
        #   (use "git reset HEAD <file>..." to unstage)
        #
        #       modified:   sm1
        #       modified:   sm2
        #       modified:   sm3
        #
        # Changed but not updated:
        #   (use "git add/rm <file>..." to update what will be committed)
        #
        #       modified:   file1
        #
        # Submodules modifiled: sm1 sm2 sm3
        #
        # * sm1 354cd45...3f751e5:
        #   - one line message for C
        #   - one line message for B
        #   + one line message for D
        #   + one line message for E
        # * sm2 354cd46...3f751e7:
        #   - one line message
        # * sm3 354cd47...3f751e8:
        #   Warn: sm1 doesn't contains commit 354cd45
        #
        # Untracked files:
        #   (use "git add <file>..." to include in what will be committed)
        #
        #       file2
        #



-- 
Ping Yin
