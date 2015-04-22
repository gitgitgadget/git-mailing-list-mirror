From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH V3 0/2] git-p4: improve client path detection when branches
 are used
Date: Wed, 22 Apr 2015 21:47:42 +0100
Message-ID: <553808EE.8020404@diamand.org>
References: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com> <xmqqegncf5ps.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:48:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl1ZE-0001RB-B2
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbDVUsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:48:16 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36481 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbbDVUsO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:48:14 -0400
Received: by wizk4 with SMTP id k4so192728809wiz.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WAa9LOhc98HbK/+xaw0VevQSr7Pqz0vN3BR+yaoeMHU=;
        b=LOeX0nVVBSx8KoxegZ54mr0ob7N+O+Tahxp7ggWbnz7un/vYq4K6NNfpqA/PurhwDM
         bwVkOx+AodvdqMMNVAFw52UJnuVo8tl0/L61mCNM3BW2lX3+qYJmHlmOgRENLPJevLHn
         bYd9hRKHPfBxjFjOs2WuTv3s1VkDSFxnCerhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=WAa9LOhc98HbK/+xaw0VevQSr7Pqz0vN3BR+yaoeMHU=;
        b=Ra3Qdk5Wdspshi34um5cb6DMjnDplaNJ2bis+QRIoLPnKgKwx7d/afHifNspiGMbck
         8k81PxJ7eImuy3AI/WNpSaryAy5orIm7PDd2UV3zfTRM7lpS/UqhD1FI2oitNF2nqOD3
         iWFvHg4tyNR9shdkE2xESbmUo1GmslOBLIk6YZo7c1HtaJUz6Kp29EGJvtNKHI5ktIh3
         KUImmQGX2FML76pOqrhruWP5jEklNjfZ4esrfL2BPK3QZ/xmi4EFxqKkjECyAdJh+SeD
         QvBPrQwHEJU/lJT1/zPhXsQH3yWHHR0DQdWFwmafcv1SBdN19RykBFHb6LY8hEfWOCSA
         iawg==
X-Gm-Message-State: ALoCoQmjXS8xiSlO+UcDWwQEvSs/TxVrAnicFNb6HuJb0sPgPMvffZWd/ZO4rTmrUDr41LdQzq5J
X-Received: by 10.180.78.199 with SMTP id d7mr9230311wix.94.1429735693815;
        Wed, 22 Apr 2015 13:48:13 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id u6sm8886148wjy.13.2015.04.22.13.48.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2015 13:48:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <xmqqegncf5ps.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267640>

On 22/04/15 18:11, Junio C Hamano wrote:
> Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> The updates introduced in the third revision of these two patches consist only
>> on updates to the commit messages to better clarify what they implement.
>>
>> Vitor Antunes (2):
>>    t9801: check git-p4's branch detection with client spec enabled
>>    git-p4: improve client path detection when branches are used
>>
>>   git-p4.py                |   13 ++++--
>>   t/t9801-git-p4-branch.sh |  106 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 115 insertions(+), 4 deletions(-)
>
> Thanks; will re-queue.  Luke, could you comment?

First off: kudos to Vitor for daring to enter this particular dragon's 
den. The combination of branch-detection and use-client-spec isn't so 
bad, but throwing in the handling of excluding bits of the tree via the 
P4 client spec (like, who would even do that?) makes it into a real mind 
twister!

I've held off commenting as I don't feel I know the branch detection 
code as well as I would like. The change though seems a lot more robust 
now that the search is anchored. Having a test case is always good!

However, playing around with this (incredibly complex and obscure) 
scenario, I'm not yet sure about it.

I created a depot that had //depot/main and //depot/branch, and a branch 
mapping between the two. I cloned that in git using --use-client-spec 
and --branch-detect, and all was well.

I then modified my client spec to exclude //depot/main/excluded, and 
then started adding files in git to the 'excluded' directory. When I 
submit them, I get:

$ echo hello >excluded/f1.c
$ echo hello >f2.c
$ git add excluded/f1.c f2.c
$ git commit -m 'Partially excluded'
$ git-p4.py submit
DEBUG: self.useClientSpec = True
Perforce checkout for depot path //depot/main/ located at 
/home/lgd/p4-hacking/cli/main/
Synchronizing p4 checkout...
... - file(s) up-to-date.
Applying 51f187b Excluded added from git
excluded/c - file(s) not in client view.
excluded/c - file(s) not opened on this client.
Could not determine file type for excluded/c (result: '')

When I reverted this change, it failed differently, and appeared to be 
extremely confused in the way that I think Vitor originally describes, 
getting hopelessly baffled by the client spec layout.

It's entirely possibly I've messed up my manual testing though. I need 
to go and have a very strong cup of tea before I can look at this again.

Thanks!
Luke
