From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Exclude a directory while merging
Date: Thu, 30 Jul 2009 16:42:24 +0400
Message-ID: <20090730124224.GC27178@dpotapov.dyndns.org>
References: <C696F858.CEB0%vdidenko@Getcollc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Vlad Didenko <vdidenko@Getcollc.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 14:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWUyc-0006ZD-1V
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 14:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbZG3MnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 08:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbZG3MnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 08:43:09 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:65413 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZG3MnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 08:43:08 -0400
Received: by ewy10 with SMTP id 10so703384ewy.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6qVNWwZAX9Q+S49idnff8RzTkI4XUVvybKjf5gZq2Qk=;
        b=oYIN8JH0QsPmi3YjWc2XhIv9ofoIGh9/9DilhTjGdbfhXgZ1NcEY5xqwUiGWUHDdPU
         Lz/6BU7r2O6tINbR+5eBpn8Ivt74QO184ipsY/g0xs5SIA2xGygf2c70JJxs83bp14TR
         XYnyQl2IAHyGOrFZnu2SHqlWlBGyiSTxaaX7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=psZbT4058h+K1IBmIp3T8oOpnhfTcEj47Mhakdg3JutDflOYa6zouCsedrKrsq86iF
         yiYMWNbsgT+FttKq/xKtM5RNwSbyOiosIr0K6ugHtpXG4egKMUgl/FMj/JRrJ+idAkyx
         EvUbznqlCkFvvvv9iEbkTYPLD3MxYa41PQHVc=
Received: by 10.210.61.8 with SMTP id j8mr1367220eba.75.1248957788546;
        Thu, 30 Jul 2009 05:43:08 -0700 (PDT)
Received: from localhost ([91.78.51.135])
        by mx.google.com with ESMTPS id 5sm2088991eyh.6.2009.07.30.05.43.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 05:43:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C696F858.CEB0%vdidenko@Getcollc.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124461>

Hi,

On Thu, Jul 30, 2009 at 07:12:24AM -0500, Vlad Didenko wrote:
> 
> Is there an easy way to exclude a directory from a merge operation.

You cannot merge some directories but not other, but you always can
discard any changes during merge.

> Specifically:
> 
> We have a "master" branch. We also have an "other" branch. There is a
> directory XYZ in the other branch which is not in the master. I need to
> merge everything but XYZ into master. Something like that:
> 
> git checkout master
> git merge other --exclude XYZ

I have not tried, but it should be like this:

git merge --no-commit other
git checkout HEAD XYZ  # or 'git rm XYZ' if XYZ does not exist on master
git commit

NOTE: Git will consider all changes including the directory XYZ as
already merged into master and will not try to merge it later (unless
there are some other changes to that directory).

Dmitry
