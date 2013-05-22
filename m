From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Tue, 21 May 2013 22:13:22 -0500
Message-ID: <CAMP44s3uEaG3Y+cVoKhCA-f+hi1VZcCpXO5bYCQLvANDdvYwRA@mail.gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 05:13:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UezUh-0001UF-BK
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 05:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab3EVDNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 23:13:25 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:54512 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3EVDNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 23:13:24 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so1462656lab.9
        for <git@vger.kernel.org>; Tue, 21 May 2013 20:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eCD8mhbfz43/Dp+mmGLkkM8aRRIH2bKjMMYYfBa+kTw=;
        b=Os/VlUfShXL37UoNqT6hZG8AE+3lKg/Pkr1Mk4iKaYQ+tP7rI1f8mCgcj4xmgnoRMy
         j4JDTr/2xJt/z1Q4etq3rE2RmRdYvJ5+Sf/v2o6RmtAgqH2/k5aVcRjJPilD6ExjsU4K
         B7Z0JffONiD5j6uvWENmNYSi4OCNWq6rpRPjxNQogBQmVMs5S9Y/QZNFwj2ibNWAFpjP
         saIjIzZxwLxxd/2VUuba65+XEF/7tMsftUAdpkj49oWfjkZUy3gbZlG1LXpasgCTKGfh
         bFg/Rkvt8tyCJ/gXYGhh7g8w1Ueoy5SQCMazX4eMcdwusCZIPvjTkVnR/th8K8g9Esi8
         0Bow==
X-Received: by 10.112.63.169 with SMTP id h9mr2971287lbs.135.1369192402858;
 Tue, 21 May 2013 20:13:22 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 20:13:22 -0700 (PDT)
In-Reply-To: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225124>

On Tue, May 21, 2013 at 3:54 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently the __git_ps1 git prompt gives the following error with a
> repository converted by git-svn, when used with zsh:
>
>            __git_ps1_show_upstream:19: bad pattern: svn_remote[
>
> This was introduced by 6d158cba (bash completion: Support "divergence
> from upstream" messages in __git_ps1), when the script was for bash
> only.  Make it compatible with zsh.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

This patch is fine by me. I would like to see an example of how to
trigger the issue with a standalone command in the commit message, but
it's not necessary. It would also make sense to address the comment
from Szeder that does raise questions about other places in the code
where 'array[ $foo ]' is used, maybe there's a caveat we are not
considering, or maybe your use-case did not execute that code.

And finally, I don't recall seen 'set -a' used elsewhere in the code.
If memory serves well, we have replaced 'local -a foo=value' with
'local -a foo\nfoo=value' before to fix zsh issues, I think that would
be safer.

But this patch is needed regardless, that, or the patch that broke
things should be reverted for v1.8.3.

Thomas, if you don't have time, let me know and I can take a look.

Cheers.

-- 
Felipe Contreras
