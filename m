From: David Aguilar <davvid@gmail.com>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 21:06:32 -0700
Message-ID: <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
References: <20120913170943725232.01d717ef@gpio.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jens Bauer <jens-lists@gpio.dk>
X-From: git-owner@vger.kernel.org Fri Sep 14 06:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCNAw-0005EQ-9v
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 06:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899Ab2INEGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 00:06:34 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36498 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab2INEGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 00:06:33 -0400
Received: by vcbfo13 with SMTP id fo13so3417442vcb.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 21:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hM44S5zOMSoy/33hVbqk1EnDumpN0dpXa87SAdkja1w=;
        b=XWhvh3tWf64zzA+ebDCa3LHDp5UVTTvRteE1/GXGMnIk+oImnls3GJduyYLzaZVBhr
         g8JM7wR6zqsZBahqFZTGxgiBjHP/3Mq/wnoUhzKhIju3UnTTmMn3udaJ3VrzQkFlyGi1
         NDvYktVm9P5nWv4fQx9A1VBixwlRC1C44RbmT0O2CrSrBSqsavUF5YNtYBeeuyjJfMti
         Ll4arEGUk2gUjHre7OszU+y4KJ3OUPw8fHvitA5asyILWtO9aeqUJDNhuA5/g8mEH7D+
         ad/PHT7Z9Y8bclFbOJBsw61NmrpE+snwQzCOWnYOrTgRzRh9+HW5yHXk6eS1tWjEJ1mS
         Br/w==
Received: by 10.52.16.180 with SMTP id h20mr714729vdd.83.1347595592767; Thu,
 13 Sep 2012 21:06:32 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Thu, 13 Sep 2012 21:06:32 -0700 (PDT)
In-Reply-To: <20120913170943725232.01d717ef@gpio.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205448>

On Thu, Sep 13, 2012 at 8:09 AM, Jens Bauer <jens-lists@gpio.dk> wrote:
> Hi everyone.
>
> I'm quite fond of git, and have used it for a while.
> Recently, I've started making printed circuit boards (PCBs) using an application called OsmondPCB (for Mac), and I'd like to use git to track changes on these.
> This application was originally written for the old Mac OS (Mac OS 6 to Mac OS 9.2).
> The old Mac OS does not use LF, nor CRLF for line endings, but only CR.
>
> I've read that git supports two different line endings; either CRLF or LF, but it does not support CR.
> Would it make sense to add support for CR (if so, I hereby request it as a new feature) ?
> The alternative is to ask the developer if he would change the file format, so that new versions of his software would change the files to end in LF, but he'd have to be careful not to break compatibility.
> If the software is to be changed, this would not fix similar issues that other people might have.

Do you mean that you want automatic conversion from CR to LF?

What's about just storing the files as-is,
with no conversion at all? (this is the default git behavior)

git doesn't really even support LF.  It stores content as-is which
means LF works just fine.  git prefers to not mess around with the content,
but we do have autocrlf to help folks stuck on windows.

If you need to, you can use .gitattributes to add a clean/smudge filter
that does this conversion for you.

See the "filter" section for an example:

http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

If you're serious about wanting that feature then we'll
happily review any patches you might have.  That said, I don't really
think it's a common enough case for git to natively support, so
I'd recommend going with the .gitattributes filter.

good luck,
-- 
David
