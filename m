From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git filter-branch --directory-filter oddity
Date: Tue, 3 Dec 2013 17:58:45 -0500
Message-ID: <CACPiFCLY+nS1S=-x6WA4wHJtMcAf_ks18b6YVhiJjJSZtRKK7g@mail.gmail.com>
References: <CACPiFC+nCj8VMqb+aK-C5gMyX6R0dDba1U1U49KTktF3WDQ9ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 03 23:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnyvu-0001MF-QT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 23:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457Ab3LCW7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 17:59:07 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:39131 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab3LCW7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 17:59:05 -0500
Received: by mail-ve0-f179.google.com with SMTP id jw12so11297781veb.10
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 14:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=1B2PPx/CSOWKTpwHH8i1OkLVQs7LTjXzyBOA8lKVdwU=;
        b=Ho7drLIocjKbVBZZWjHBvHm1AvA0GWGV7jO+7yLvINnHNaIPGNbP+Dfw1rN+kyApqt
         PbIyl9/qhK/EZahDcLoxBbmU4hN/Iinkb3m15r6SBAkB7TJA8/8njrnDazCsifYjx4ZA
         d9KlnwdTo6bv9X0WZauwCcKFgWlkgzc2MYOPTCgOfYvfm5baSQ60WGabxMWjdMeRnzd+
         m7AJsyWfZYC/NHdE4DUK164djLeSE6h4oaH4Yp95qAf8fr1PQXzKjd5SaEGO8jyl7lUa
         bSMl0b9wh3qiVIzAFh0S/iS89clX0aVWRaZj0drYQvHzieKV00RekVJ4Y1JZvHaSrzni
         9t8Q==
X-Received: by 10.58.100.244 with SMTP id fb20mr56755670veb.6.1386111545181;
 Tue, 03 Dec 2013 14:59:05 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Tue, 3 Dec 2013 14:58:45 -0800 (PST)
In-Reply-To: <CACPiFC+nCj8VMqb+aK-C5gMyX6R0dDba1U1U49KTktF3WDQ9ZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238743>

On Tue, Dec 3, 2013 at 5:44 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> As they have not been skipped, they are fully fleshed out. By this, I
> mean that we have the whole tree in place. So these 22 commits appear
> with foo/bar pulled out to the root of the project, in the midst of
> 1500 commits with a full tree.

IOWs, I am experimenting with something like:

git filter-branch -f -d /tmp/moodle-$RANDOM --prune-empty
--index-filter "git ls-files -z | grep -zZ -v '${dirpath}'  | xargs -0
--no-run-if-empty -n100 git rm --quiet --cached --ignore-unmatch "
^v2.1.0 $branches
git filter-branch -f --prune-empty --subdirectory-filter ${dirpath}
^v2.1.0 $branches
git filter-branch -f --commit-filter
"~/src/git-filter-branch-tools/remove-pointless-commit.rb \"\$@\""
^v2.1.0 $branches

perhaps the docs for filter-branch imply, to me at least, that it's a
DWIM tool. I am surprised at having to roll my own on something that
is fairly popular.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
