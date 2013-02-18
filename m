From: Thibault Kruse <tibokruse@googlemail.com>
Subject: Re: git clone tag shallow
Date: Mon, 18 Feb 2013 09:26:43 +0100
Message-ID: <CAByu6UWO=kUOvJ_YcPG9bo+XVZ5hSxRQpyEaUMcVxa=sXt_EMw@mail.gmail.com>
References: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
	<CACsJy8Dso-g7foyJhpY20DNrY11PA8ZZUmP6JXxsiJ_Ggbt_KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7M44-0004E9-T8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 09:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab3BRI0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 03:26:45 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40101 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab3BRI0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 03:26:43 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so5506917oag.22
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 00:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kdPY5CxFLUoSc/cgQYFxEjeEQhNs24xylVfFJL06NAY=;
        b=Ho8+e721pzZtRzCqoFkptXdlXksZcGUXFt3JFwQc3GOyc49lTRVx2bM/+1U+FE82Cp
         gYff8uBbPzkAiRV6CEPItYcG/dVZt2o+SjNV8/JQG4Gg0XcbXo6ByMYSh887iNAHpqEZ
         xGTGcs4EdNfMenNXYyvAJfzORq4i3husXFhdv+j6cN0L4k4AAldiNy+uH5rRcJw1JPc3
         QFwrWoikKo/3Hvt1iqAI1pOHqg6x+3f2eskCGuaztNjN6oA4HPOVCCkFUdCtjiEQAuyE
         KyVSobwujRCvogSS5R+4YufxgozfJVhaAmiHjD6hn8U+0X8Qi1Ga5hPZQ4ouYqNUnEuk
         UxCA==
X-Received: by 10.60.21.101 with SMTP id u5mr5859508oee.71.1361176003259; Mon,
 18 Feb 2013 00:26:43 -0800 (PST)
Received: by 10.182.251.165 with HTTP; Mon, 18 Feb 2013 00:26:43 -0800 (PST)
In-Reply-To: <CACsJy8Dso-g7foyJhpY20DNrY11PA8ZZUmP6JXxsiJ_Ggbt_KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216442>

Hi Duy,

Looking closer at the rest of the docs, I guess it is consistent, but
not terribly helpful.
Throughout the docs (--help and man), it is never very clear what
objects a command
may accept or not. here is what I get from it:

Whenever a command description involves "<branch>" this can, depending
on the command, refer to
1) a name that, when prepended with "refs/heads/", is a valid ref,
2) a name that, when prepended with "refs/heads/" or "refs/tags", is a
valid ref,
3) a name that, when prepended with "refs/[heads|tags]/", or unique in
"refs/remotes/*/" is a valid ref

Now in the docu I don't see a nice distinction between 1), 2) and 3).
I could work on a patch if someone
tells me how to clearly distinguish those cases.

Example for 1)
git clone --branch <branch>    in git 1.7.x
Example for 2)
git clone --branch <branch>    in git 1.8.x
Example for 3)
git checkout <branch>    in git 1.8.x

I would like the docs to relate to those e.g. as
1) git clone --branch <local-branch>
2) git clone --branch <local-branch-or-tag>
3) git checkout <commit-label>
or something similar, in the future. But I wont create a patch before
having some blessing on the labels to use.


On a related note, what would help my use-case would be an extension
to git clone such
that git clone [--deep] accepted also most other kinds of commit
references, such as SHA-IDs.

Such that
git clone --deep --branch 2h134vjvbc
would work. Is there a plan to introduce that as well?

cheers,
  Thibault


On Mon, Feb 18, 2013 at 7:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 18, 2013 at 2:13 AM, Thibault Kruse
> <tibokruse@googlemail.com> wrote:
>> Hi all,
>>
>> I notice that using git 1.8.3, I can call
>> git clone repo1 repo2 --branch tagname
>> with a tag, not a branch. Is this going to be a stable and documented feature?
>
> There is a test for --branch=tag in t5601, so I say it's supported. If
> the document is not clear, patches are welcome.
> --
> Duy
