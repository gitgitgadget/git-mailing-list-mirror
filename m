From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rebase -i reword runs pre-commit hook with curious results
Date: Thu, 02 Feb 2012 10:39:55 -0600
Message-ID: <4F2ABC5B.2030608@gmail.com>
References: <jgcc3q$mvl$1@dough.gmane.org> <4F2A2286.3090808@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 17:40:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rszi8-0004ML-N7
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 17:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab2BBQkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 11:40:00 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56153 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab2BBQj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 11:39:59 -0500
Received: by ggnh1 with SMTP id h1so1309175ggn.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=H4MJ7gsOPRk6n3z2X9GkxW+A0nRoAD9okMTSwxH43ds=;
        b=E8wLug7vg3Q71D7y/aqA5xPEH+73bcPMtYd21tR2vznCdr4OT22uaEv1dXvM5OkpAC
         0GRgGD/Bvmau58XsdPbcSLLGHtOn2DTxMsZSijo6At/54+5oAIbBA3mbtt8/ZGNW4bk5
         TxSgqPMJyjJpIPPy+Oi1pq14QzEl6OQg0e5MM=
Received: by 10.182.159.70 with SMTP id xa6mr3273327obb.1.1328200799252;
        Thu, 02 Feb 2012 08:39:59 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p3sm235700obm.9.2012.02.02.08.39.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 08:39:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.26) Gecko/20120129 Thunderbird/3.1.18
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F2A2286.3090808@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189655>

On 2/1/2012 11:43 PM, Andrew Wong wrote:
> On 12-02-01 4:50 PM, Neal Kreitzinger wrote:
>> I'm confused on why and/or how interactive rebase runs the pre-commit
>> hook
>> when doing the reword command for commit (a).
> When you do a "reword" in "rebase -i", it basically does a "cherry-pick"
> of that commit first, then it does a "commit --amend". And your
> pre-commit hook should've been run during the amend.
>> IOW, the pre-commit hook does not get the same results as if I were
>> doing a
>> commandline git-commit of a modified index.
> Does your pre-commit hook work when doing a "commit --amend"? I'm not
> sure if you can actually modify the author (or committer) date from
> inside a pre-commit hook.
(We have a comment on "line 1" in our source with $User:$ $Date:$ 
keywords that the pre-commit hooks expands to insert "whoami" and "date" 
values to effect a user-datestamp at commit time.  We do this to enforce 
conflicts on same-file edits.)  Now that I understand that the 
cherry-pick takes place first to effect the transfer of the tree content 
and then a subsequent git-commit --amend of "no changes" takes place to 
effect the reword opportunity, the behavior makes sense now.  (We use 
git-commit --amend to reword commit messages also.)  The pre-commit hook 
runs prior to commit message editor just like commandline git-commit 
--amend (and plain git-commit).

thanks!

v/r,
neal
