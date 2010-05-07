From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 15:35:43 -0400
Message-ID: <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com> 
	<alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 21:36:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATLI-0000sd-FK
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066Ab0EGTgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:36:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35305 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758118Ab0EGTgF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:36:05 -0400
Received: by gyg13 with SMTP id 13so842409gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=e7xyQX+V+pLYkevBVSx0OS2rSaWqKt/E300+tXaeMEA=;
        b=Bww+d6VqX7mGPmGitg4QFATuNXFNvwlT9bLjIVkuy2du3SoB2oEAcWoEmEDx8renSf
         6uDBixXhrrRtwTLUtI0wae+WzHmtKB8uQRr6OOBndJnN2Ro5CGtYsXtINYMrn+9/2G4Q
         vaUyqGv0wNqu3L2juOihFj9Pa24Eqk7svjA9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kugMrVGmlH5FKcI5KFIHy3tuU9vE0xPe2JqewT4yqRsWnU2s9o5l+u+hjiYlXuOw62
         tuFtqVqN/TuYqSh8U6ZXQEbmoU6rV0fLFx+GQ/E2s+SKFBBhCDsrqJLYXZZByDu8Eh2g
         3QBenQUBZ3qXR9quMhQHJH6KyNQfdIca5JpbU=
Received: by 10.150.237.9 with SMTP id k9mr4004917ybh.155.1273260963165; Fri, 
	07 May 2010 12:36:03 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 12:35:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146562>

On Fri, May 7, 2010 at 3:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> Unfortunately this option wouldn't be as flexible as Eyvind's current proposal.
>
> Oh, absolutely it is.
>
>> What his method allows is to mark some files in a project as "these
>> should be the native EOL style" and others as "these should be left
>> alone."
>
> But that's what a .gitconfig would too. We _already_ have that
> .gitattribute thing to then distinguish particular pathname rules. It's
> just that currently .git/config is needed to _enable_ it.

Hmm, I don't think we're saying the same thing.  There are two
separate settings here:

1) Whether a project has files that should be EOL-converted
automatically (we seem to all agree that this is set in
.gitattributes, whichever attribute is used).

2) Whether a particular person wants those particular files to be
EOL-converted, and what to convert them to.

The existing semantics of core.autocrlf just don't let you express #2
in a useful way.  If I set --global core.autocrlf, it turns it on for
*all* projects, not just ones with the .gitattribute set.  If a
project has a .gitconfig inside that sets core.autocrlf, then it's
really just redundant with #1.  If I set .git/config on a particular
project, it works, but it's far too easy to forget (and there seems to
be no way to set this per-project at clone time, and setting it
*after* cloning causes git's index to get confused).

Eyvind's proposal is deceptively simple because it simply makes it
much less error prone for users to express something that's already
*technically* possible, but in practice, is very very frequently done
wrong.

Avery
