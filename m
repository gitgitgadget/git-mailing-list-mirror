From: Fabian Schmied <fabian.schmied@gmail.com>
Subject: Re: git-svn performance
Date: Sun, 19 Oct 2014 11:38:16 +0200
Message-ID: <CABBCAivMYZJ-b2CFuCxBPRBYRkhJ_sKMBRHkenfqjpJbYcx5vw@mail.gmail.com>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
 <20141019003256.GA18532@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 11:38:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfmwt-0001Qq-IZ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 11:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbaJSJii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 05:38:38 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:34472 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaJSJig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 05:38:36 -0400
Received: by mail-yh0-f51.google.com with SMTP id t59so1607776yho.24
        for <git@vger.kernel.org>; Sun, 19 Oct 2014 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D2vWhQkvoq0IsZs86J+tQ81vx50fXxtnHDBaMTeUJq0=;
        b=eI9nE8dYWj04zIgekMleuQcGXVSX2lzz/RJ1LMfrgSRfBPT7E/4Gc0qQw3koo2y6S3
         LmhuNRtlnTrBVNKj7ssZDpe8A4jeQ4piCQHhdw+oXHtG1aDqCq2Va9Zc5sY6V7c79DDz
         CivgTthrvEJ/p2xOTdxRHoejBx0N32Zo9po7eiBb7twDXa1eb8SNBLaTQzyTv9qWQ66x
         GVpbBfk1Jcki4AycK29WDd4hq8aYPLlvP2waS+rM1lrVdHB0IMzyEHWPtvKcqprkd8sE
         lPjyYtJKuKfcjsPa2La93mQs/IzhXCiL1yOy8Vd+yHKu5+/GM1O6IC8J0wanmkR0zAyU
         PPNQ==
X-Received: by 10.236.210.108 with SMTP id t72mr2281166yho.116.1413711516162;
 Sun, 19 Oct 2014 02:38:36 -0700 (PDT)
Received: by 10.170.188.149 with HTTP; Sun, 19 Oct 2014 02:38:16 -0700 (PDT)
In-Reply-To: <20141019003256.GA18532@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 19, 2014 at 2:32 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Fabian Schmied <fabian.schmied@gmail.com> wrote:
>> Hi,
>>
>> I'm currently migrating an SVN repository to Git using git-svn (Git
>> for Windows 1.8.3-preview20130601), and I'm experiencing severe
>> performance problems with "git svn fetch". Commits to the SVN "trunk"
>> are fetched very fast (a few seconds or so per SVN revision), but
>> commits to some branches ("hotfix" branches) are currently taking
>> about 9 minutes per revision. I fear that the time per these commits
>> is increasing and that indeed the migration might not be finishable at
>> all.

[...]

>> Is there anything I can do to speed this up? (I already tried
>> increasing the --log-window-size to 500, didn't have any effect.)
>
> Can you take a look at the following two "mergeinfo-speedups"
> in my repo?  (git://bogomips.org/git-svn)
>
> Jakob Stoklund Olesen (2):
>       git-svn: only look at the new parts of svn:mergeinfo
>       git-svn: only look at the root path for svn:mergeinfo
>
> Also downloadable here:
>
> http://bogomips.org/git-svn.git/patch?id=9b258e721b30785357535
> http://bogomips.org/git-svn.git/patch?id=73409a2145e93b436d74a

[...]

Thank you _very_ much, the performance increase is tremendous: from,
ATM, 15 minutes per commit (with large merge-infos) down to 15 seconds
each. This means that instead of taking weeks, the migration will now
complete in hours! Memory consumption might be a bit higher, but not a
problem for me at all.

(I didn't apply the two additional patches you supplied, only the two
ones linked above.)

Thanks again, you saved my deadline :)
Fabian
