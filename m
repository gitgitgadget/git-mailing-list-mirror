From: "aaron smith" <beingthexemplarylists@gmail.com>
Subject: Re: git push question.. error: Unable to lock remote branch refs/heads/master
Date: Wed, 31 Dec 2008 00:22:31 -0800
Message-ID: <d7ac1a680812310022j3d57a81fk1fe15c4640fd5d70@mail.gmail.com>
References: <d7ac1a680812310017o4316b719qae5af166a95d9940@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 09:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHwMw-00014p-NS
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 09:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYLaIWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 03:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYLaIWe
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 03:22:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:51491 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYLaIWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 03:22:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5191902rvb.1
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 00:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=O76BjWM+oHu2epBFYQHuXZxJ8poMredL+NO+DyaKozc=;
        b=nqdKXIDidCGAXZQo6BBQ/OY8suPdnkeavKV1GabVeaIlrbl0VFwCdnTKsvgIKPZG+H
         PBDa3dU6vOmZWNv9FrsrJeBOI1gDPjX1r1l9eZ4eUDAyeiNOh7eklJmrTFirl9lqPxE4
         3+RaZdxytUWlLDwUkkiXFu/Fzm08BcB3qohXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CPI8t/9v3aE9uEqitBp4GeIdDQ0ytE3p0skvHc6I2LSpPSgzflP3nec5y94cIugnD2
         jq1C+fUqfbSYozc2K7SN7o58WnvjQiSS9FATVHq714mmfw+svU91OdPlXQQWXgGo1eoE
         DhTlTMjXfkZT5IiKBoeLdJgJ4wmV+6y6g9lW8=
Received: by 10.143.6.1 with SMTP id j1mr6446321wfi.152.1230711751940;
        Wed, 31 Dec 2008 00:22:31 -0800 (PST)
Received: by 10.143.115.3 with HTTP; Wed, 31 Dec 2008 00:22:31 -0800 (PST)
In-Reply-To: <d7ac1a680812310017o4316b719qae5af166a95d9940@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104257>

Oh Shit, I just figured it out. I had a friggin .htaccess file in
root, that was screwing things up. Sorry for any annoyance!



On Wed, Dec 31, 2008 at 12:17 AM, aaron smith
<beingthexemplarylists@gmail.com> wrote:
> Hey All,
>
> First, i've looked all over for a solution to this, and can't seem to
> get it figured out. Here's my setup:
>
> centeos
> apache 2
> webdav
> git 1.6.1
>
> I went through most of the git config over http text file instructions
> (http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt),
> just for the quick and dirty. Here's what I have in my http conf:
>
> <VirtualHost *:80>
>    ServerName www.codeendeavor.com
>    DocumentRoot /var/www/vhosts/codeendeavor/
>    DavLockDB /var/logs/httpd/webdav/davlock
>    <Location "/guttershark.git/">
>      DAV on
>    </Location>
> </VirtualHost>
>
> So, I have a bare git repo here:
> /var/www/vhosts/codeendeavor/guttershark.git/ (I used: mkdir
> guttershark.git; cd guttershark.git; git --bare init). And I've turned
> on webdav for that location.
>
> I created the DavLockDB directory: mkdir /var/logs/httpd/webdav/davlock
>
> And I've updated permissions on the git repo, and the webdav lock to
> apache:apache. And when it still didn't work, I updated the
> permissions on the git repo to 777, and on the davlock.
>
> I'm not sure what would be going on. I searched through the servers'
> empty git, and my local git repo for a lock file. But don't see
> anything.
>
> I don't have authentication on it yet so if you want to try and push
> to it, feel free.
>
> After all that. here is how I interact with it:
>
> $git push origin master
> Unable to lock remote branch refs/heads/master
> error: failed to push some refs to 'http://codeendeavor.com/guttershark.git/'
>
> Anyone have any idea?
>
> Thanks a bunch!
>
