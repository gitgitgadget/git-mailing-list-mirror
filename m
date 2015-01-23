From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git submodule first time update with proxy
Date: Sat, 24 Jan 2015 11:13:51 +1300
Message-ID: <CAFOYHZAiZkXqSkso+=Eh_THEkh+qi9k8xWsP0yt1dbw5ymwDDQ@mail.gmail.com>
References: <CAHd499BEmV2zeosE9th59QTWPA0CPsU8eyHnONhsZqEb=bH+rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:14:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmUJ-0002kT-23
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbbAWWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:13:53 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42665 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbbAWWNw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:13:52 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so8240948pab.12
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 14:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kfPihVjGcSdCxoX9nctSz9uV+7UkanoEyoi7sDSk3DY=;
        b=Qaezj67n6gPJ5yTU7eQASoAXB6pqXjjS6Mzp0id/dj02hShxIbHbVYPP271cXr/8FP
         q477UFyBvS/QlqfWZ38d0D/gbGjsGh/Rh9WRZgyWgZfucW+Lf1UWtiI0skOCVgTlppem
         +yM/jie9qgyCOgkq1ccB+c2WF1OkjG1yegk8otMYEzMFOQPmk1IsDngCjpOb/5OzE/RI
         Sd2loCxp9fEvJu1poNDEl9fPgET3sgSwtL3343NkS8mFzaxnosmnXjXdV5OJniu+78qg
         LwnWmw6i61rkJMyla/EkfPBHR4zgTrJB8WZL3yf6pKclxPV4YJJwb/JKlyhyzZptpZbw
         ZJrQ==
X-Received: by 10.70.101.198 with SMTP id fi6mr14636858pdb.5.1422051231889;
 Fri, 23 Jan 2015 14:13:51 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Fri, 23 Jan 2015 14:13:51 -0800 (PST)
In-Reply-To: <CAHd499BEmV2zeosE9th59QTWPA0CPsU8eyHnONhsZqEb=bH+rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262967>

Hi,

On Fri, Jan 23, 2015 at 3:50 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a submodule using HTTP URL. I do this:
>
> $ git submodule init MySubmodule
> $ git submodule update MySubmodule
>
> The 2nd command fails because the HTTP URL cannot be resolved, this is
> because it requires a proxy. I have "http.proxy" setup properly in the
> .git/config of my parent git repository, so I was hoping the submodule
> update function would have a way to specify it to inherit the proxy
> value from the parent config.

Your not the first to suggest it and you probably won't be the last.
It is hard to decide _which_ config variables, if any, should
propagate from the parent. What works for one use-case may not
necessarily work for another.

> How can I set up my submodule?

Probably the easiest thing would be to make your http.proxy
configuration global i.e.

  $ git config --global http.proxy ....

If you don't want to make it a global setting you can setup the
submodule configuration after running init but before running update
i.e.

  $ git submodule init MySubmodule
  $ (cd MySubmodule && git config http.proxy ...)
  $ git submodule update MySubmodule
