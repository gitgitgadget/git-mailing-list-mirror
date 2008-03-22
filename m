From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: How to rewrite author history
Date: Sat, 22 Mar 2008 06:11:12 -0700
Message-ID: <216e54900803220611v5aa5e9d5q86da249480be3c91@mail.gmail.com>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com>
	 <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com>
	 <2008-03-22-10-29-23+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Samuel Tardieu" <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sat Mar 22 14:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd3Vp-0005N8-RL
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 14:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbYCVNLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 09:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbYCVNLN
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 09:11:13 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:61206 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbYCVNLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 09:11:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2234301wah.23
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QGgYG6cI6mrY+q9Dhe32FK/d6BAMvNVZ1pMd2lSJAJY=;
        b=c4gY6DIF/k9d0XZqeVT1ByA+d/4yxuHxHkEw2rSAk4dbFb66nJzF6aN82a64ekIw7oaaMiYULHLGzI9N84sYLPAChTlhKPNg8j4f9lLTr6klgDHeG8I2n/GorxaYN4ZT4P/2c96j6q2eVFI1EA3CkFsMdkXE4XaX8e1h/b4dYF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nV8aIIaZ45JOSMnibxHFW9EYYJaikL8ENwssE+judnnq6KkCN8omKBTFKT3nNLM5AEl6BwwcrP4OvQUeNY6sLnMHuw5N14tGCG7cYjVz9lbauHjGJLl2j0t1w7arJEFCHaKx/D1/48Fuyh9pwa59nCzoNDNVFNfLpmKIA2eR3fY=
Received: by 10.114.179.1 with SMTP id b1mr7947790waf.42.1206191472240;
        Sat, 22 Mar 2008 06:11:12 -0700 (PDT)
Received: by 10.114.94.20 with HTTP; Sat, 22 Mar 2008 06:11:12 -0700 (PDT)
In-Reply-To: <2008-03-22-10-29-23+trackit+sam@rfc1149.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77802>

Thanks.  Re-importing from SVN isn't an option any more, but I ended
up with something like this that seems to have worked.

git checkout master
git-filter-branch --env-filter '
if [ "$GIT_AUTHOR_NAME" = "andrewarnott" ];
then
export GIT_AUTHOR_EMAIL="andrewarnott@gmail.com"
export GIT_AUTHOR_NAME="Andrew Arnott"
fi
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
'

And I did this for master, and my v1 and v0.1 branches.  I'm concerned
though, that since I changed the names of all the objects by doing
this, did I somehow make my branches incompatible with each other?
Will there be any problems in the future sharing commits or merging
across branches as a result?

Thanks.

On Sat, Mar 22, 2008 at 2:29 AM, Samuel Tardieu <sam@rfc1149.net> wrote:
> >>>>> "Andrew" == Andrew Arnott <andrewarnott@gmail.com> writes:
>
>  Andrew> I imported my git repo from an SVN repo, and the authors have
>  Andrew> email@SOME-GUID for their email address rather than their
>  Andrew> actual one (probably courtesy of Google Code hosting).
>  Andrew> Rewriting history and changing all the commit hashes isn't a
>  Andrew> problem at this point in development, so how can I do a
>  Andrew> massive search-and-replace to replace several specific author
>  Andrew> emails with the valid ones?
>
>  If you can reimport it, you can use the "--authors-file" of "git svn".
>
>   Sam
>
>



-- 
Andrew Arnott
