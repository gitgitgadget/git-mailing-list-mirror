From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How to replace master branch of a repo with that of another
 totally unrelated repo?
Date: Fri, 6 Aug 2010 13:37:22 +0530
Message-ID: <20100806080720.GB31901@kytes>
References: <AANLkTiksJd-VfiP2Wzz-FsZoJk8djWyuxgweQpy6WaPB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: PCMan <pcman.tw@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 10:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhHzG-00081e-3m
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 10:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760675Ab0HFIJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 04:09:00 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36104 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab0HFIIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 04:08:55 -0400
Received: by pxi14 with SMTP id 14so2841680pxi.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iVv3Ml1WMPnK2Hsd5nyzxhCx26zl5vPPN7G0TtdMg4w=;
        b=qciqrj8xoZM775J9Lxr8EwtMKSJ1FeLSATDPmJJQTDOp7uE7jGcN1b/vmv1ffnzEbG
         9JUA4eLGtIvi/U7+ZlUQQIeIvJF9yQNdjidrbXmpz4zrei8Ve5PUrt21nBwX4JxmB127
         sK4yZYoBjuxxEHyCbOztOk84o5iBCvsLqZIYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ulnYAF2W68ymUMH8+uqRNyq5k/VG8+L8j84PJlYctKOkLHwhWAvF8vhd5xzs+Qud9Z
         5K4dzgkWW2lzr6Ay0yXyQJv33GmuKnAGMEZJBhKEvsn89fOm8A8NGj4nFIW6tbhmZKcX
         ncsCWtgheiVQHyHUgIxH707+az/1snehvgwJ4=
Received: by 10.142.158.13 with SMTP id g13mr10047698wfe.232.1281082131306;
        Fri, 06 Aug 2010 01:08:51 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm1116939wfa.10.2010.08.06.01.08.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 01:08:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiksJd-VfiP2Wzz-FsZoJk8djWyuxgweQpy6WaPB@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152769>

Hi,

PCMan writes:
> I want to rewrite a program totally from scratch rather than branching
> from current one.
> So I created a new repo for it and do the development there.
> Now it's finished and I want to replace the old program with it.
> Is it possible to replace the master branch of the old repo with the
> code in this new repo?
> I want to move the old code to a separate branch for backup, and
> replace the master branch with the master branch of the new repo.
> Since git rm -r * than git add all new files will lost history of new
> repo, it's not an option.
> The old repo is a public online repo used by multiple users. So just
> renaming the repo won't work since the users who pull code from the
> old repo will get troubles.
> What's the best strategy for smooth migration in this case?
> I'm not able to find the answer on Google.

In your old repository:
$ git checkout master # Switch to branch master
$ git checkout -b backup # Create a branch backup of master
$ git remote add new <new_repository_url> # "new" is the name of the remote
$ git fetch new # Fetch all the objects from the remote "new"
$ git checkout master # Get ready to rewrite master
$ git reset --hard new/master # Use `reset --hard` with extreme caution
$ git checkout backup # Your backup is safe here
$ # Done!

-- Ram
