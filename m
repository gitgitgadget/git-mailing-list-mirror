From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Adding default remotes to a bare repository
Date: Thu, 10 Feb 2011 16:03:37 -0600
Message-ID: <4D5460B9.9070300@gmail.com>
References: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>	<4D5437C4.6000401@gmail.com> <AANLkTimg0YZ7eQ=hsxqSYJPipahLpiqZqSVkFz25=A2k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:06:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PneeR-00082Y-4K
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080Ab1BJWGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:06:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45961 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560Ab1BJWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:06:04 -0500
Received: by gyb11 with SMTP id 11so812173gyb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CAzzHrZlwyWgKPb2cEmFN43eQRRUXKH+b6Szuaaig+Q=;
        b=gC8mwzPsxYIPLi10a1q9KUKysOhZE7BnPX3jbCXiuAu7d5X6yS9B9ec8WcEIe9LTZd
         /v69q8SvDKXyFH8IyMKlIdjiRXDVZOWmqeYkUO0opwLDJf/Qz7TyqKweEE27PdzqO48Q
         VsK+S1vZPgRVo1vCYjiVQpbt1YGCzagsQTg+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vOxjOMojRcUJxfVKxBXzm+mmgni95ptIALNWTTj1YJcLcUyQ3CVwOXL4Pc6N6Zi531
         VPX9vcFX651VBByRzIyfS/oOL4XRp0M2TsTKN+q8inbhQ4N4l89APCKMirUFZQt/fZtm
         sZKC+jWtWD/v7tp74byIKJcl0KRlHQ1RJhAsU=
Received: by 10.90.84.7 with SMTP id h7mr3298982agb.55.1297375561203;
        Thu, 10 Feb 2011 14:06:01 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c7sm47951ana.17.2011.02.10.14.05.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 14:06:00 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTimg0YZ7eQ=hsxqSYJPipahLpiqZqSVkFz25=A2k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166504>

On 2/10/2011 3:24 PM, Francis Moreau wrote:
> On Thu, Feb 10, 2011 at 8:08 PM, Neal Kreitzinger
> <nkreitzinger@gmail.com>  wrote:
>> You could write a script that does the clone and then adds the remotes.  We
>> have a "menu" written in bash scripts and it does the clones and adds the
>> default remotes automatically.  So instead of just doing "git clone", people
>> would run that script to do the clone and add the remotes.
>>
> Sure.
>
> But I'm wondering why cloning operation can't import the remote
> branches of the cloned repository.
>
> Actually I'm wondering the same thing for hooks. If a repository setup
> some hooks, can't these hooks be installed by default in the new
> repositories ?
>
you can do some hook setup automation using git templates.  see the 
--template option of git-clone manpage and 'template directory' section 
of git-init manpage.  There is some big reason why they don't let you 
inherit hooks from the origin repo of the clone repo.  I think its 
basically because you could have security risks or compromise git 
integrity/workflow with hook inheritance.  If you look in the newsgroup 
people have talked about this alot before.

As far as your request for automatic remotes, a flaw in your logic may 
be that you think the functionality you want would let you clone from an 
already-setup clone (1) which points to remote (a) then the new clone 
(2) would point to the remote (a) of clone(1).  Not so.  When you make a 
clone it does get an automatic remote to the repo it was cloned from.  
This is called 'origin' remote.  Therefore, clone(2) has an origin 
remote to clone (1).  Your idea on automatic remote setup is in direct 
conflict with the way git currently does automatic origin remote setup.  
You can't do both because that would turn in to a real mess pretty 
quickly.  Perhaps what you want is just "cp -r", ie. "cp -r clone-1 
clone-2".  then the clone-2 repo will have all the remotes and hooks of 
clone-1 and point to the same origin remote (a), but will live in a 
directory/working-tree called "clone-2".  "cp -r" will give you an exact 
duplicate thats totally functional, but occupying a different namespace.

hope this helps.

v/r,
neal

v/r,
neal
