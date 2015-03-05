From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Possible bug with git-rebase and post-rewrite hook
Date: Thu, 05 Mar 2015 15:05:44 +0100
Message-ID: <54F862B8.2040901@gmail.com>
References: <54F86040.8060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 15:05:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTWPQ-0003lz-31
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 15:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbbCEOFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 09:05:48 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33781 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974AbbCEOFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 09:05:47 -0500
Received: by widem10 with SMTP id em10so36395393wid.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=7E83n04gD5jo6fozv4aslAqW8BPzpZo2/JVne4o5KuE=;
        b=BpK9VRrLpJOXDSXqmXaHU8OAL8t/v9epvKoRbZW5fY5T5cq/BAbJ1gAWk/OSaRei0W
         25yiO22fKCjBO0I0SoRDk3ZcrPz3Hhj35LAFw5+9kzCe0iV585/swRbk0E/K8Tch+vfh
         WYJSdlBh/g6BbqOh6Wm5xe6ljLr6cgdckT9ttMF4GK9xoAipuSMDr33KYCDYwg4g8MGS
         XfALMJcCgeUa0o9xxpCOdez/uIB+T7Q4KQ8Y1Dt0WIEbMOqByc/z6us/8dZ00IMNdxa1
         abWNLPoFeZvRE7wv/TBQfiph+32zbuUjBu84M7p3amH9Amgq/k0fDZXQkFsOOmM1bFmN
         +LHw==
X-Received: by 10.194.172.9 with SMTP id ay9mr19051922wjc.2.1425564345941;
        Thu, 05 Mar 2015 06:05:45 -0800 (PST)
Received: from [192.168.0.10] (gem13-1-78-228-1-221.fbx.proxad.net. [78.228.1.221])
        by mx.google.com with ESMTPSA id bd3sm11803066wib.17.2015.03.05.06.05.45
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 06:05:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F86040.8060205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264835>

oops, I forgot to say that this happen with git 2.3.1.

On 03/05/2015 02:55 PM, Francis Moreau wrote:
> Hi,
> 
> I have a suspect case which happens when rebasing a branch.
> 
> I'm using the post-rewrite hook and during certain circumstance, my hook
> is called by git-rebase with wrong parameters: <old-sha1> argument is
> not related to <new-sha1> one.
> 
> This actually happens when git-rebase stops and reports:
> 
>   The previous cherry-pick is now empty, possibly due to conflict
>   resolution.
>   If you wish to commit it anyway, use:
> 
>       git commit --allow-empty
> 
>   Otherwise, please use 'git reset'
>   rebase in progress; onto 2889531
>   You are currently rebasing branch 'foo' on '2889531'.
> 
> 
> If I decide to skip it by doing 'git rebase --continue' then I get the
> issue when my hook is run.
> 
> BTW, I find that the message is not really clear since it tells me to
> run 'git-reset' in the case I want to ignore this empty commit. I'm not
> sure that 'git-reset' is really helping in that case (my index is clean)
> but 'git rebase --continue' would have been more appropriate IMHO.
> 
> If I do 'git commit --allow-empty' then there's no issue when the hook
> is run.
> 
> Thanks.
> 
