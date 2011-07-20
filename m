From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Wed, 20 Jul 2011 20:25:55 +0700
Message-ID: <CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
References: <20110720182438.3c40cf1d@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Jul 20 15:26:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjWnI-0003KP-MA
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 15:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643Ab1GTN01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 09:26:27 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:51817 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab1GTN00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 09:26:26 -0400
Received: by fxd18 with SMTP id 18so1822575fxd.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HtKrwAvaQQKfnItcWSnVrmu48tZ4jEP1/2XQmV6k9Co=;
        b=pEcPbCPrugXKcEpmdohE/tfgEeSTYpHxsxG36tMIcAGM6TEEL8ZtBvMve9dZLSIPjk
         n7T2Xa/cNRipWPKVBv1fWyOYxVn/5T6LXVYK3OCncLR2sTsu4W8w22O2niMnEwzqN8LM
         Z4rLUEinycSQ05R+YlBEnqW7JteA/n9wr/IL8=
Received: by 10.204.42.72 with SMTP id r8mr2110516bke.239.1311168385218; Wed,
 20 Jul 2011 06:26:25 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Wed, 20 Jul 2011 06:25:55 -0700 (PDT)
In-Reply-To: <20110720182438.3c40cf1d@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177536>

On Wed, Jul 20, 2011 at 7:54 PM, J. Bakshi <joydeep@infoservices.in> wrote:
> As a result whenever there is a commit , it updates the related folder in filesystem.
> Say a commit at svn->mysite-repo->dir1->trunk->src ==> modify ==> /var/www/demo/dir1
>
> Can I do the same in git with multiple worktree ? possible ?

Using multiple worktree with the same repo won't work in git because
the repo also have worktree-related information. But you can create a
central, bare repository, then make several clones from that. Each one
is checked out with different branches. You work on a clone and push
to the central repo. The post-commit hook in the central repo will do
pull from it, for example

for site in dir1 dir2 dir3; do
    cd /var/www/$site && /usr/bin/git pull
done

Also have a look at git-new-workdir in contrib directory of git
repository. I don't use it but you might find it useful.
-- 
Duy
