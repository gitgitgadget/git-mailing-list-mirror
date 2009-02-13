From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] When archiving a repository there is no way to specify a file as output.
Date: Fri, 13 Feb 2009 08:38:13 -0800 (PST)
Message-ID: <m31vu2uwb0.fsf@localhost.localdomain>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: <carlos.duclos@nokia.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 17:40:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY14x-0005ox-Ps
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 17:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758424AbZBMQiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756753AbZBMQiR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 11:38:17 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:19724 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbZBMQiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 11:38:16 -0500
Received: by mu-out-0910.google.com with SMTP id i10so540270mue.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Lm5P0V/tLN3xnz+gd0Kb8Em3X8fih7KPu2zz9EuOBDs=;
        b=IiZmUaWuYLT+7CJv71doGX19llkVlGWOJqqhbpeFJHVWmOKObXrqd9vo23gysqDidB
         DPwv/R07imfwLlE3Rzez/E51GRpVBR0QNIvzAI3imSILbQ/LKBREILpl7ZNVqsgCTbRy
         IkbBXWDTpDIbCmX1bt1ZB1XtsSncIidNA21NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=q2nARQWypa44p99fYll3pA4EIqUsjE3F7M6s41zhhqBvLmxBqTcb10iGF5VZSvGU+u
         VGup6KOF478tKnwLHVi+sYoqkygwiyLplVcwWki402d4xRqGMvzxcKW/gH5X7AlOwylm
         WWOHK1EwfCFpyLFo9m1ZjiIsT96kdK1z321zU=
Received: by 10.86.77.5 with SMTP id z5mr368356fga.63.1234543094265;
        Fri, 13 Feb 2009 08:38:14 -0800 (PST)
Received: from localhost.localdomain (abvs153.neoplus.adsl.tpnet.pl [83.8.216.153])
        by mx.google.com with ESMTPS id 3sm3000559fge.42.2009.02.13.08.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 08:38:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1DGcCfk015503;
	Fri, 13 Feb 2009 17:38:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1DGcB9h015499;
	Fri, 13 Feb 2009 17:38:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109757>

<carlos.duclos@nokia.com> writes:

First, the comments below are not indication that this patch is not a
good idea, because in my opinion it is.  This review is about
_technical_ shortcomings...

> Short description:
> ==================
> To enable that I added a new option "--output" that will redirect
> the output to a file instead to stdout.
> 
> Long description:
> =================
>
> When archiving a repository there is no way to send the result to a
> file without using redirection at shell level. Since there are
> situations where redirection is not available, for instance when
> running git inside a continuous integration system which is already
> redirecting the output, I added an option to write the archive to a
> file directly.
>
> In order to do that I added a new option to archiver_args, int
> output_fd, which holds the file descriptor where the resulting
> archive should be written. If no option is specified in command line
> that option defaults to 1 and no behavior change, however if the
> "--output" option is specified and the file was created that file
> descriptor points to the new file. I also modified the write_or_die
> calls to use "output_fd" instead of 1, so they write to the file
> descriptor.
>

There should be separator, e.g.
-- >8 --
to mark where comments ends and commit message begins.
 
> From 10e09bf828c18f2846651262b7f647b630e09872 Mon Sep 17 00:00:00 2001

The above line is not necessary.

> From: Carlos Manuel Duclos Vergara <carlos.duclos@trolltech.com>
> Date: Fri, 13 Feb 2009 16:09:39 +0100

Usually 'From:' is required only if the value from email cannot be
used, either because you send email on behalf of somebody else
(somebody else is author of patch), or because you are sending from
alternate email address.

The 'Date:' header is very rarely required: the one from email should
be good enough in most cases.

> Subject: [PATCH] When archiving a repository there is no way to specify a file as output.
>  To enable that I added a new option "--output" that will redirect the output to a file instead to stdout.

Git commit message conventions (see Documentation/SubmittingPatches)
call for short description or a commit/patch (commit summary) in first
line: that is what it would be in email subject ('Subject:' line
above), followed by a more detailed description.

Your summary (subject of patch) is both too long, and not standalone.
I think the better choice would be:

  Subject: [PATCH] git-archive: Add new option "--output" to write to a file

  When archiving a repository there is no way to specify a file as
  output.  This patch a new option "--output" that will redirect the
  output to a file instead to stdout.

I think however that some of 'long description' above, or perhaps even
whole of it, should be put in commit message itself, and not be only
as a comment (present only in mailing list archives).

> 
> Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>

Why do you use different email address for signoff, and for authorship
('From:' line)?  Was it intended, or was it an accident?

[...]
> From 7cbd0a3edb1cf75b5a0644263e1755fd18a5c37d Mon Sep 17 00:00:00 2001
> From: Carlos Manuel Duclos Vergara <carlos.duclos@trolltech.com>
> Date: Fri, 13 Feb 2009 16:22:21 +0100
> Subject: [PATCH] Updating documentation for git-archive in order to reflect the new "--output" option.
> 
> Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>

First, this should really be together in one, single patch.

Second, there is convention of sending patch series as a _series_ of
emails, eother as responses to cover letter message, or 'chained' so
subsequent patches (emails) are replies to earlier ones.  For better
readibility, and in case some patches get lost or be sorted out of
order by email/news client, there is convention of using [PATCH n/m]
prefix.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
