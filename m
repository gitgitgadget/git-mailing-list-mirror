From: David Aguilar <davvid@gmail.com>
Subject: Re: Is there a specific reason that git gui does not respect comment
 lines added by a git hook?
Date: Sat, 29 Jan 2011 14:45:30 -0800
Message-ID: <20110129224528.GA7676@gmail.com>
References: <AANLkTingTLM8MCEBdS_4OAE5DU1L4xndRzQMq_gdvKaL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: Wilbert van Dolleweerd <wilbert@arentheym.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 23:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjJU6-0003Wa-KM
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 23:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab1A2Wl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 17:41:29 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41468 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab1A2Wl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 17:41:28 -0500
Received: by gxk9 with SMTP id 9so1538882gxk.19
        for <git@vger.kernel.org>; Sat, 29 Jan 2011 14:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=GWNQsfJXSprlfHcIj/M2/aXpXuzknGBp0ES0jnnYxOk=;
        b=KlRwXjO6WeRoEN1nTrRrTfRMYHCLKg8Qj7yLVlEM5hf5QNDOszO6eZpY6VvqdwbJVo
         Pi7N3Jvdukc9TB++UgpOP3veazTqcsHVDvd4m4WtgFOAbo9fuWf34FahHZzZx8UpQN7M
         3KMKgk2IaTkz1ZSrABemGPNVN9Vb03WeBG7gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S0/6GMj7bPZXDpBvUgFV8mak3gWhMMSDJTP8J5NHK5sK0RX7Yix8UqwKYA0s0nQgck
         oChYjkx88vC/ygjbsctJAsA30Z9hZfE9ggGObjNXwYcKgrYh/KhI8TRWSs81KZSta6vM
         +1H7aZb7n+fPC+s7oDY3Fj1/ywtrLANVCTe3k=
Received: by 10.100.121.11 with SMTP id t11mr2781426anc.64.1296340886837;
        Sat, 29 Jan 2011 14:41:26 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id b19sm23664021ana.27.2011.01.29.14.41.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Jan 2011 14:41:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTingTLM8MCEBdS_4OAE5DU1L4xndRzQMq_gdvKaL@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165672>

On Wed, Jan 26, 2011 at 11:14:28AM +0100, Wilbert van Dolleweerd wrote:
> Hello,
> 
> I've written a prepare-commit-msg hook [...snip...]
> I'm using comments in the commit message to give additional
> information to the user. For example, when the Team Foundation Server
> is not available, I add the following comment to the top of the commit
> message.

I have the impression that you're running into this behavior
because this information is at the top of the commit message
(line 1).  Users then fill in the actual message on the
lines below this, I presume?

Try to see what happens if you set it up so that users fill
in the commit message above the auto-generated comment.
I have a feeling that it only strips out '#' lines after
it's read in the commit message proper.

I haven't read the code so I'm not certain of this, but it seems
like that is what's going on.  Also, "git gui" uses plumbing
commands underneath the hood and does not actually call
"git commit" directly.  That might help explain this subtle
difference in behavior.

> Because the line starts with a # sign, it is not added to the actual
> commit message...when using git commit. If I use git gui, the above
> comment appears in the git gui interface but *is* actually added to
> the git commit message when committing.
> 
> Is there a specific reason that git gui is actually adding lines
> starting with a # sign? I was expecting it to ignore those lines.
> 
> -- 
> Kind regards,
> 
> Wilbert van Dolleweerd
> Blog: http://walkingthestack.wordpress.com/
> Twitter: http://www.twitter.com/wvandolleweerd

-- 

		David
