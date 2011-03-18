From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Deleting a Bare Repo
Date: Fri, 18 Mar 2011 16:36:41 -0500
Message-ID: <4D83D069.1050206@gmail.com>
References: <AANLkTimaQ3dyXDJgY_Ys19jpNXx07vK2qNLQ_8Cp8NKi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sean B. Palmer" <sean@miscoranda.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0hLn-0001d0-5R
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515Ab1CRVgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 17:36:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42613 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab1CRVgq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:36:46 -0400
Received: by yxs7 with SMTP id 7so1763384yxs.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cwN9mMrmEBMjWgFyUNgnvVugt/Qz45ZVEgOwtbJXLtU=;
        b=daqJV9TfaIEzzpW49CUMO0o8v8IUkFhYn+mma8XeOYPLH/EyqV9PWKSPMrmxOQqS/s
         uWplalkg7uDHz8K06PWGaehT8Nf+DCgZOf7OA1BbyLjQvlao67aEV8uPESXc8rAGyZmE
         qZN2TvH8sVtllj4sGxlQVtR4QuXTsk09gTgQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=MY1v4ZX8pCZ1bRxwtmA4HU+4gvJyXnzgZsAStwCHcBtz1QKcKcGMq6tD5W6OyBnndi
         WFwaazlZqJzhrlpdMWF197IjwLUprdmmcL7ns86fC8sU4KUvngg4WlqU8Yh2phDUm1hw
         yJ3THJMix4O4vG3Gv37f7HHbhVaQbgJ7l3+7s=
Received: by 10.90.9.26 with SMTP id 26mr1726043agi.50.1300484205754;
        Fri, 18 Mar 2011 14:36:45 -0700 (PDT)
Received: from [172.25.2.144] ([67.63.162.200])
        by mx.google.com with ESMTPS id 6sm507556anx.20.2011.03.18.14.36.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 14:36:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTimaQ3dyXDJgY_Ys19jpNXx07vK2qNLQ_8Cp8NKi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169367>

On 3/18/2011 10:26 AM, Sean B. Palmer wrote:
> I'd like to delete a bare git repo, but I want to check that (a) it's
> being used as the actual git bare repo, e.g. if $GIT_DIR is set, and
> (b) that it is actually a git repo. Using rm -rf .git/ doesn't seem
> safe for these reasons, so is there a command in git itself to do
> this?
>
> I've been going through the man pages without success.
>
here is a partial list of considerations and inqueries:
* there is not a git command to delete a repo.  rm -rf is how you do it.
* git repo's are not aware of who has cloned from them and/or is 
pulling/fetching from them.
* if there is a git-daemon-export-ok then that means it was setup to be 
pull-from via the git:// protocol.  however, that doesn't mean anyone is 
actually pulling from it.
* check the config file and see if its setup as a mirror.  if so, 
investigate its mirror.

if you are talking about manual deletion you could:
* cd to the bare repo and do a git-status.  if it returns a status then 
it's a working repo (not necessarily a referenced repo).
* analyze it in gitk and see if anyone has pushed to it recently.
* rename it and see if anyone complains.

v/r,
neal
