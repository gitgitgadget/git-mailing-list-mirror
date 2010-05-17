From: Chris Packham <judge.packham@gmail.com>
Subject: Re: stupid error - is there a way to fix?
Date: Mon, 17 May 2010 11:57:12 -0700
Message-ID: <AANLkTimFZ1GCBIf9y8Gkz-AnG-TmvWU_WXfjgw1olmKi@mail.gmail.com>
References: <AANLkTin32LGzfA79XYfivdun0EwWTs8p_yBeR030_2N2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 20:57:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE5VF-0004CC-Oe
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 20:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab0EQS5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 14:57:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40671 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab0EQS5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 14:57:14 -0400
Received: by vws9 with SMTP id 9so2023627vws.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HcEyWGiljXHxNdo9h+uIvtEo3BEXnt4K7orrhGUash4=;
        b=Q8GjpM6FXcQvu//4Gf7C9h1K5nvpj2q4Bf3IhsrMZOFqYg07Rl5fxDH7qHaCeW61St
         zUA/EdlhbjuI1kSw6lhbOZUJgZXnmpqEAVxY9s9BdItGBkx8/p3hU6qoZoUljrfghmnl
         qoU8ICVe4bY6v3djC4XT2kD/X483RdPBZmGWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=o6A3TTGiQg1fZbgRdGLizTJWZHmnKmGdC2DaVqpgnnY22Gj0tAT0Q2cDVYkA4R5bPK
         j8SrKB9N8EmxCFu50lIcpYJ+0sebW7cj0vyL9VpViVcnPiFXoPnOv2Pss1ZojvPde78Y
         z7xJTgJx3+ds80LjqdmssqUnVFxKMH6KTG9xw=
Received: by 10.229.217.20 with SMTP id hk20mr1222208qcb.95.1274122633225; 
	Mon, 17 May 2010 11:57:13 -0700 (PDT)
Received: by 10.229.2.26 with HTTP; Mon, 17 May 2010 11:57:12 -0700 (PDT)
In-Reply-To: <AANLkTin32LGzfA79XYfivdun0EwWTs8p_yBeR030_2N2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147251>

On Mon, May 17, 2010 at 11:32 AM, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> Wanted to share some Admin nightmares;)
>
> Is there a way to correct a stupid error when few commits were made
> under username Your Name and the same kind of stub email address
> instead of normal name?
>
> Thanks,
> Eugene
> --

There are a few ways (that I know of) to fix this.

If you haven't pushed yet you can use "git rebase -i" [1] and edit the
commit with "git commit --amend --reset-author" to fix up your local
branch. Note that --reset-author is a fairly recent addition to git
but the --author="name <email>" option is available for older
versions.

If no-one has cloned/pulled from that repository you can use "git
filter-branch" [2] with an environment filter to update the name.
Using filter branch (or anything else that re-writes history) is a
last resort as it will cause problems for anyone that has cloned your
repository.

The preferred, non-destructive, method would be to include a .mailmap
file [3] which can be used to remap authors names and email addresses.
Some of the git tools can be told to ignore the mailmap so that stub
email address will still be visible if people know where to look but
thats usually fine unless you _really_ want to hide an email address
for some reason.

---
[1] http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html#_interactive_mode
[2] http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html
[3] http://www.kernel.org/pub/software/scm/git/docs/git-shortlog.html#_mapping_authors
