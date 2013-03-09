From: Thor Andreas Rognan <thor.rognan@gmail.com>
Subject: Ignore pattern with trailing whitespace in .gitignore is void using
 git 1.8.1.5
Date: Sat, 9 Mar 2013 02:36:32 +0100
Message-ID: <CAMn8hCexsiizsjoXO-ebfpEtZcW7n0dY-jV0q+aLh8U+pbUo9A@mail.gmail.com>
References: <CAMn8hCd6_V2Kq_OUgBFAoOkqqmrTpN_ohcP3wM44qWvQB_8R5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 02:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE8it-0007tu-AL
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 02:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237Ab3CIBgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 20:36:53 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:64890 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab3CIBgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 20:36:52 -0500
Received: by mail-ia0-f172.google.com with SMTP id l29so2063147iag.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 17:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=ihyGWA7a7FTtjD703ehyf115j+1ECg26rmOgR9RNJkY=;
        b=YCuiUN9LiUijkT9NdjNn+7amsfqjoWZsEHbvBP8DUoXkimCGlubcRQm4NTktUTnmRR
         OJMYArUUjVxBur59v3JCi9EO5nMAbex1DnSVGF3AQzVmccGvbmjLj+CgfVgQaWQe3lh5
         zwXfEtpLNFYcdjhy2sNytMa6IBMWZvbZqV/D+5fvNITiMtsadVv7sYPyd+XN7QnNuA/s
         QQ0SBtdowgMMxZD0N2pR+BKZcRf37wZjA4xmvQ9QXYC/6WENCQ/S7myZ96VujxyKCQVJ
         KwDtg+hEgoaGlVOPqqJVbbUhMNmwX/2LZAPBXlYIcRVAy1WrwSfUBTa8hHvj9hDxO4H4
         wrwA==
X-Received: by 10.50.189.170 with SMTP id gj10mr1125789igc.1.1362793012070;
 Fri, 08 Mar 2013 17:36:52 -0800 (PST)
Received: by 10.64.0.38 with HTTP; Fri, 8 Mar 2013 17:36:32 -0800 (PST)
In-Reply-To: <CAMn8hCd6_V2Kq_OUgBFAoOkqqmrTpN_ohcP3wM44qWvQB_8R5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217695>

Hi guys,

Maybe I'm doing it wrong, or maybe it's the intended behaviour,
but I find that a trailing whitespace after a pattern in .gitignore
makes the pattern void with git 1.8.1.5.

It's a subtle error to make, although cleaning undesired commits
from the git history can be educational and fun in itself.

How to reproduce:

$ > mkdir -p ~/tmp/git-ignore-test/ \
&& cd ~/tmp/git-ignore-test/ \
&& touch .gitignore .secret-passwords .secret-passwords.swp \
&& echo ".*.sw? " > .gitignore \
&& echo ".secret-passwords" >> .gitignore \
&& git init && git status

Remove the white space after ``` .*.sw?``` in .gitignore
to see the .swp file disappear:

$ > echo -e ".*.sw?\n.secret-passwords" > .gitignore > .gitignore \
&& git status

You will of course have to temporarily disable your
global .gitignore file if you handle vim swap files correctly there.

I am using git 1.8.1.5 installed with homebrew on os x 10.8.2.
