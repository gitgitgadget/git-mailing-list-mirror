From: "Johnny Lee" <johnnylee194@gmail.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 23:05:17 +0800
Message-ID: <488807870901060705m49419ec1he14aace5caaa3d89@mail.gmail.com>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
	 <20090106072253.GA9920@coredump.intra.peff.net>
	 <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com>
	 <20090106080300.GA10079@coredump.intra.peff.net>
	 <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sitaram Chamarty" <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 16:07:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDVy-0002VR-RE
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbZAFPFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZAFPFU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:05:20 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:56190 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZAFPFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:05:19 -0500
Received: by gxk6 with SMTP id 6so6172754gxk.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NcHsL6LH6qt1nsiqU9+m408nGHrZmyHlefgDZuacS+I=;
        b=P53X5L66cOPBGUHc3EDVwg/Ys76hpyWdF5cISVR64Wr32kgpEBGcBxYd80jtEvOHsR
         vpzA1SicN+/tGRe70sh9GZ/spNnvOzbuZCdkx2WqzTTFEqyNiMcles6yWMXZUNuYesu7
         kxNLLoSqT0weneboyjQaCiAu0YLIcPYwGY94c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U1sobK83E24nUBUBZPLNJyPCSnJztgs0N2q5Y8t8FW0oPXe6jlnl8LG3k5LFePjvvD
         r3I/bZtIpCcJyQR72qE/1irtTiHANNd6Vu/Uqj60qf65hOrHBXIq+IznanrT7U7is+NX
         xzgpLHeFxMc+37ekpUJu4TGVFB5Hu+K/dqRGE=
Received: by 10.142.156.19 with SMTP id d19mr9197665wfe.190.1231254317126;
        Tue, 06 Jan 2009 07:05:17 -0800 (PST)
Received: by 10.143.15.1 with HTTP; Tue, 6 Jan 2009 07:05:17 -0800 (PST)
In-Reply-To: <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104689>

Copy that.

Thanks Sitaram.

We also plan to do it in this way, just a small wondering that it
looks a kind of workaround instead of a more graceful solution.

Regards,
Johnny

On Tue, Jan 6, 2009 at 7:57 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 2009-01-06, Jeff King <peff@peff.net> wrote:
>> If you are going to have multiple users sharing a repository, generally
>> they should be in the same group and the core.sharedrepository config
>> option should be set (see "git help config", or the "shared" option to
>> git-init).
>>
>> I've never used that personally, though. I have always just used POSIX
>> ACLs, with a default ACL on each directory giving access to everyone.
>> E.g. (off the top of my head):
>>
>>   for user in user1 user2 user3; do
>>     setfacl -R -m u:$user:rwX -m d:u:$user:rwX /path/to/repo
>>   done
>
> If you're not worried about the finer-grained access control
> that acl(5) gives you, just do what "git init
> --shared=group" does:
>
>    git config core.sharedrepository 1 # as mentioned above
>    chmod g+ws .git
>
> Now set the group to something (I use "gitpushers" ;-)
>
>    chgrp -R gitpushers .git
>
> amd make sure all your users are part of that group.
>
> Works fine for small teams...
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
we all have our crosses to bear
