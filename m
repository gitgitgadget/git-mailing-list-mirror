From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 22:05:34 -0500
Message-ID: <76718490801061905k30c1ac86r51a65165d47807d4@mail.gmail.com>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jon Hancock" <redstarling@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 04:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBiJS-0002gv-V9
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 04:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYAGDFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 22:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbYAGDFh
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 22:05:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:5307 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYAGDFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 22:05:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so12225152wah.23
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 19:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pRCqEvSbhutW4iBOkez0OWTFAbskafMlp2LEc3JCpL0=;
        b=Jtp0r7mn8PcwzjwAP5VU5bApcgUVfNSsqli51N7FGTfZjo9NwvvyE9iVCIH1MHofeDYyaQNKfmZ5qqhotMB6pAaBvyJf/noAAXoqDRv1ZCnl8AbcBNwejHp30PqYp73504egy4oIcJ+XIqgwxRg396vsG0uvkwqLbpBDRWzx0RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWtW252/zfM7pILLXjIOtUNE6GublaNyNq6BjWy7a2hHd/0f8RMeQGcxOo/zfLcPnEDt8PFIEM/sTuGXYczwySnaHEwcf4tJ67oIBglLbYiR0RIkp0k8eAEnfinWEOKy5Di+jmP36zg5k8XyabwAqiYtYEgjEjtHkIo7NY7uWBg=
Received: by 10.114.125.2 with SMTP id x2mr3181358wac.119.1199675134821;
        Sun, 06 Jan 2008 19:05:34 -0800 (PST)
Received: by 10.115.22.18 with HTTP; Sun, 6 Jan 2008 19:05:34 -0800 (PST)
In-Reply-To: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69756>

On 1/6/08, Jon Hancock <redstarling@gmail.com> wrote:
> Additionally, is there
> a simple procedure with git to say: "I want to version exactly what is
> in my working tree.  If I removed something or added something, just
> handle it".

>From http://www-cs-students.stanford.edu/~blynn/gitmagic/ch05.html#id2553633
is the helpful hint:

$ git-ls-files -d -m -o -z | xargs -0 git-update-index --add --remove

I've got the following aliases in my .gitconfig:

alias.addremove=!git-ls-files -d -m -o -z -X .git/info/exclude -X
$(git-config core.excludesfile) --exclude-per-directory=.gitignore |
xargs -0 git-update-index --add --remove

alias.ls=!git-ls-files -d -m -o -v -X .git/info/exclude -X
$(git-config core.excludesfile) --exclude-per-directory=.gitignore

(In 1.5.4, you can replace the two -X's and the
--exclude-per-directory with --exclude-standard.)

j.
