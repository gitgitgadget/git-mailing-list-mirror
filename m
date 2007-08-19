From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sun, 19 Aug 2007 20:57:09 +0200
Message-ID: <e7bda7770708191157v54c2c2a3k8e17208a1d5b6dc9@mail.gmail.com>
References: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
	 <7vfy2pn9eb.fsf@assigned-by-dhcp.cox.net>
	 <e7bda7770708111703u40f89c1fx17bfac4b9aed9d2e@mail.gmail.com>
	 <7vfy2plfb4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 20:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMpxa-0002es-EV
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 20:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbXHSS5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbXHSS5M
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 14:57:12 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:19819 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbXHSS5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 14:57:10 -0400
Received: by rv-out-0910.google.com with SMTP id k20so826969rvb
        for <git@vger.kernel.org>; Sun, 19 Aug 2007 11:57:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k/pbQ5gISCuROt5pCAqKIWgO+UDjJLsgjeLEvxda8sLuVI/Ba66zi07xaSGNnBr+UAY4olgJRvLSW41xHIMN3gPb/ppt9nWekoK1sbCQDe+eDQqfzKWxSLYQXEdZXg5rC74px3PJTnkELVGYFFoynb2HndoaRI0qIoMZlbaWcHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MWikH9Gk1jPUs8nz4ODLJIGbP53UnbIHREKALQouJverRXQ4z8R3ZrRvijum0x8Fc1dqSaWQ8U13SKDMuCgPU76A+58rvM8fHZTjoD81Y/wDnJ9nIr2wbUfF1gOwgx1+LhV7DAZRk8nQzGUvwnnnfe9BTPNDCrELKDJgYOGwyX4=
Received: by 10.114.60.19 with SMTP id i19mr2409351waa.1187549829746;
        Sun, 19 Aug 2007 11:57:09 -0700 (PDT)
Received: by 10.114.180.20 with HTTP; Sun, 19 Aug 2007 11:57:09 -0700 (PDT)
In-Reply-To: <7vfy2plfb4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56138>

On 8/12/07, Junio C Hamano <gitster@pobox.com> wrote:

> unnecessary work), you may want to add a more lightweight
> built-in command to do so.  Perhaps...
>
> -- >8 --
> Subject: ls-tree --check
>
> You can run "ls-tree --check" to make sure that all necessary
> objects exist in the repository to complete a tree object.  This
> may be useful to make sure that the subproject commit bound to a
> superproject index can be checked out in its entirety.

This looks good, and the subproject part of it should be trivial to
implement but i'm struggling with applying your patch.

If I copy the whole mail with headers (I get them with a menu item
"show original" in gmail web client), paste it into a file ("*p in
vim) I get the following:

$ git apply junio.mail
Adds trailing whitespace.
junio.mail:103:#define LS_CHECK 32
Adds trailing whitespace.
junio.mail:112: "git-ls-tree [-d] [-r] [-t] [-l] [-z] [--check]
[--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-i
sh> [path...]";
Adds trailing whitespace.
junio.mail:120:         } else if (ls_options & LS_CHECK) {
Adds trailing whitespace.
junio.mail:121:                 if (S_ISGITLINK(mode))
Adds trailing whitespace.
junio.mail:122:                         /*
error: patch failed: builtin-ls-tree.c:16
error: builtin-ls-tree.c: patch does not apply

git am gives me similar behaviour.

$ git am junio.mail

Applying submodule update - don't run git-fetch if sha1 available

Adds trailing whitespace.
.dotest/patch:14:#define LS_CHECK 32
Adds trailing whitespace.
.dotest/patch:23:       "git-ls-tree [-d] [-r] [-t] [-l] [-z]
[--check] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]]
 <tree-ish> [path...]";
Adds trailing whitespace.
.dotest/patch:31:               } else if (ls_options & LS_CHECK) {
Adds trailing whitespace.
.dotest/patch:32:                       if (S_ISGITLINK(mode))
Adds trailing whitespace.
.dotest/patch:33:                               /*
error: patch failed: builtin-ls-tree.c:16
error: builtin-ls-tree.c: patch does not apply
Patch failed at 0001.
When you have resolved this problem run "git-am --resolved".
If you would prefer to skip this patch, instead run "git-am --skip".



Is the "-- >8 --" -line something git-apply looks for?

Short of manual patching, abandoning the web-client or switch to
another mail-account, is there any simple way to get around the above
issues ?    [I'm trying to do this on windows/msysgit]


Thank you for good support on this list!

//Torgil
