From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 6/7] Add a "--clone" option to "stg branch"
Date: Thu, 1 Dec 2005 21:05:32 +0000
Message-ID: <b0943d9e0512011305v3299f27au@mail.gmail.com>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
	 <20051129220949.9885.51533.stgit@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 22:08:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehvcg-00006w-0D
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVLAVFe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbVLAVFe
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:05:34 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:39711 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751725AbVLAVFd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 16:05:33 -0500
Received: by xproxy.gmail.com with SMTP id i30so360322wxd
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 13:05:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r4nN/pNz66tX7PaCZrg9ktgFm5Gt6ZW37YT/l958VNgb3Y+vaNl5YnPcbp0dpy/1ApNlB0FfuPx2XANyaMt7n70pa7yTTikxEw++UpzMUe48zO3+8URVxNMEcKtBbsqEhV6QXkPms05fJRJyAwtrJfZTxzlMTfGbM98Vga+UIxo=
Received: by 10.70.118.12 with SMTP id q12mr2469680wxc;
        Thu, 01 Dec 2005 13:05:32 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Thu, 1 Dec 2005 13:05:32 -0800 (PST)
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <20051129220949.9885.51533.stgit@dexter.citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13073>

On 29/11/05, Chuck Lever <cel@netapp.com> wrote:
> Cloning a branch means creating a new branch and copying all of the
> original branch's patches and its base to it.  Like creating a tag,
> but this also preserves all the StGIT patches as well.
[...]
> --- a/stgit/commands/branch.py
> +++ b/stgit/commands/branch.py
[...]
> +        print 'Cloning current branch to "%s"...' % clone

I would put a comma after this line and add sys.stdout.flush(). So
that 'done' is shown on the same line.

[...]
> --- a/stgit/stack.py
> +++ b/stgit/stack.py
[...]
> +    def clone(self, target_series):
> +        """Clones a series
> +        """

Wouldn't it be easier to do a recursive copy at the directory level
(.git/patches/<branch> into .git/patches/<clone> and
.git/refs/bases/<branch> into .git/refs/bases/<clone>)? Is there
anything that could go wrong if we do this?

--
Catalin
