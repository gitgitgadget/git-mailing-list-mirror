From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Thu, 04 Oct 2012 18:52:23 -0400
Message-ID: <506E1327.1070602@gmail.com>
References: <CAGAhT3kofdaQEye9QHnvFhAAzoQqZtR7d5UzbxU+zEdkAHVfuQ@mail.gmail.com> <506CB3B5.808@gmail.com> <CAGAhT3mVn-W5P-n_YeafZ_7bntkJGArJ3o6+dA5GO_H44=KHFg@mail.gmail.com> <506DA7AE.50005@gmail.com> <CAGAhT3k=T0SGngMQkbXHqNfh-=LUb71C7CSrWXP2wsAgc8Tb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJuHV-0003Qq-UJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254Ab2JDWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 18:52:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61231 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab2JDWw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 18:52:27 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2268193iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=L0Bioa7TpMlshUddrl8qNmidrL++/wlVVK8LrTCuYEQ=;
        b=J57GfmUCvc52VdDosVE29/Rwiiw3/5eI06/Mx0J0vplm/x1RwiSCwJMvL2PFKaKlrr
         A6QzY9MfqxYlGudjroAQO7Nao3eruOZL4+DQaDlAjWi9nHzhNbnOLneoDFZ9MEcfTcuy
         nvyiD79SlC3xC/DsCFtftfnKoV+Ct6+PkGpJWOILDWyrGj4BfFmiiYUhqXdLA0GV1UxB
         G5aNyyVC02s7qLhBXEC0L2Ri4/2NCDy83HOFOF9XGbf2eDReVFntwu2U8exKouYgoDHS
         k0qk5o9r+HttHSo+vs9rhGpPyfrv4UUrECuLHGcCMgaNWbihu4QhN+570IvMMaVNH6hG
         LcJQ==
Received: by 10.42.84.69 with SMTP id k5mr5792172icl.5.1349391146905;
        Thu, 04 Oct 2012 15:52:26 -0700 (PDT)
Received: from [192.168.1.112] ([66.207.196.114])
        by mx.google.com with ESMTPS id gw10sm7240537igb.17.2012.10.04.15.52.24
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 15:52:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <CAGAhT3k=T0SGngMQkbXHqNfh-=LUb71C7CSrWXP2wsAgc8Tb8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207054>

On 10/04/2012 05:09 PM, Alexander Kostikov wrote:
> Full script is uploaded to
> https://dl.dropbox.com/u/10828740/rebase.log  Here is the last page:
Judging from that log, I'm pretty sure "rebase" is failing at 
"format-patch". I was able to reproduce the issue you're having: 
"rebase" finished and modified the branch even though it actually failed.

"rebase" is not catching that error. I'll try to come up with a patch to 
fix it later tonight, so that "rebase" will fail correctly. And when it 
does, you'll be able to do "rebase --abort" to go back to your original 
state.
