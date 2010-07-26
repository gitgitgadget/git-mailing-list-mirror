From: SungHyun Nam <goweol@gmail.com>
Subject: Re: git bundle bug?
Date: Mon, 26 Jul 2010 16:25:48 +0900
Message-ID: <4C4D387C.8040200@gmail.com>
References: <i2jaue$f7a$1@dough.gmane.org> <AANLkTincXfdZehvVjVjtfvbuM-Jim5Tvtm9Yy=s8-fMR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 09:26:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdI4c-0006xA-TJ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 09:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab0GZHZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 03:25:55 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54250 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab0GZHZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 03:25:54 -0400
Received: by pzk26 with SMTP id 26so875541pzk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PPu000OMgT0T2cKvkzv23guxMcw7dBZyCzWgZBUHvjQ=;
        b=CNN7ydm307zPuoBiop3KW7k6+2o2GTo9h7CV4Hd0Xw6KNAZ4XuuxjR+MnUHAKtQAUO
         8+hyIzToYqD9sQuL+6AhTGhFFsbi2Ap6nx+4HNDpZ3NG10tEHtCxpGQq4tV9rUv8WV2v
         0dWY9gIoXMDPfx3eL2OoZ4aiR2da4fstCAJ/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fWiipzNIdnMVoskIKtsbJID90ioW9lkbaio20icQZIZDpSXAojVYj1Deh4gKmm/FGa
         d+2lC4gDUFpOR1rdpliCgXqzfvkL1BHoVj4RCL5oAqGXe1QMREnv61++twngTwC9NB4j
         FbkLCitJL/nveT8p24KVcGSASFGPjEM9YJv+8=
Received: by 10.115.15.18 with SMTP id s18mr10644537wai.5.1280129153487;
        Mon, 26 Jul 2010 00:25:53 -0700 (PDT)
Received: from [210.181.13.12] ([210.181.13.12])
        by mx.google.com with ESMTPS id x9sm6114490waj.3.2010.07.26.00.25.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 00:25:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ko; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <AANLkTincXfdZehvVjVjtfvbuM-Jim5Tvtm9Yy=s8-fMR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151813>

Avery Pennarun wrote:
> On Mon, Jul 26, 2010 at 2:45 AM, SungHyun Nam<goweol@gmail.com>  wrote:
>> In a current 'git' source tree, next command does not includes
>> refs/tags/v1.7.2.
>>     $ git bundle create ~/git.bundle v1.7.1..master
>>
>> After applying the git.bundle, now 'git version' does not
>> show 1.7.2, but...
>>     $ git version
>>     git version 1.7.1.772.g64fdc
>
> 'git bundle' only includes the tags that you specifically tell it to.
> It's kind of like 'git push' that way.  If you do:
>
>     git tag -s mytag
>     git push origin master
>
> You don't expect origin to contain 'mytag' just because you pushed 'master'.
>
>> I hope the 'git bundle' includes all the tags when I use 'master'
>> or 'HEAD'.
>>
>> Well, I could use v1.7.1..v1.7.2.  But want to use simple script like:
>>     $ git bundle create ~/git.bundle lastbundle..master
>>     $ git tag -f lastbundle master
>
> That kind of magic would require 'git bundle' to look at all your tags
> and see which ones lie in the range lastbundle..master.  And even that
> isn't perfect, since you might have added a new tag that points before
> lastbundle but was added *after* lastbundle.  So every bundle you
> created would need to include *all* your previous tags.
>
> Nevertheless, if you wanted to create a bundle that includes *all*
> your tags, but not any of the objects leading up to lastbundle, this
> works:
>
>     git bundle create ~/git.bundle --tags lastbundle..master

It worked fine with:
     git pull ~/git.bundle --tags master:master

> Note however that it will include tags even if they *aren't* part of
> master.  That is, if you have tags pointing at branch 'next', all the
> objects for those tags will *also* be included.
>
> Have fun,
>
> Avery

Thanks,
namsh
