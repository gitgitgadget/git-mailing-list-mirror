From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: Bug: Segfault when doing "git diff"
Date: Wed, 28 Oct 2015 15:24:25 +0300
Message-ID: <5630BE79.40708@gmail.com>
References: <5630B876.7080407@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: vleschuk@accesssoftek.com
To: "Mathias L. Baumann" <mathias.baumann@sociomantic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:24:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrPmN-0003HD-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 13:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbbJ1MYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 08:24:31 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33182 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbbJ1MY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 08:24:28 -0400
Received: by lbbec13 with SMTP id ec13so4388387lbb.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=LnhHXgDqO9+6AE2RoReyYwGnJGdPeIySjJpG77pGLTY=;
        b=wCQ3qHTylBZTlpZCxyztnkJZ6A8TJ2jgfzX+VUTIUD8EkZXio1fIYkNfMTL60t/DHy
         f4MBeb9cdPOWSvcntKOPBaWp5vpo4Y1YLFqRxb8okSY4S/YEZDL3TO/VFcVcfTFYH5ly
         hYQOH8+qNev1yojS0nJjjFVI6vUGQmonYHJzZxTUSllujvC5gb29OapYcKcu+430VekV
         I1u8HHv0VR6QFmYDkAbJWF53wW3sCM++kOzN26CBVS2bceuQW66UsdjtcgJ4f28K+QqH
         Eo0ajm1qDOZCtybJ3JYA5t1QOSwQNPdBNCZ4hCCM3N5n73dHyjjmtBDH/YtOpES8XWJC
         BZDw==
X-Received: by 10.112.218.42 with SMTP id pd10mr23251889lbc.114.1446035067068;
        Wed, 28 Oct 2015 05:24:27 -0700 (PDT)
Received: from [192.168.1.101] (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id ug9sm7771099lbb.22.2015.10.28.05.24.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 05:24:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5630B876.7080407@sociomantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280361>



On 10/28/2015 02:58 PM, Mathias L. Baumann wrote:
> Hello dear git devs,
>
> I just stumbled upon a segfault when doing just "git diff" in my repo.
>
> I managed to create a minimal repo setup where the bug is reproducable.
>
> The problem seems to be a mix of having an untracked submodule and 
> having set an alternates file for one submodule.
>
> Attached you'll find my setup that will reproduce the problem. Simply 
> run  'git diff' in bugtest1.
>
> In case the attachment is refused, I also uploaded it here:
>
> http://supraverse.net/bugdemo.tar.gz
>
> cheers,
>
>     --Marenz
Hello Marenz,

I have just tried to reproduce segfault with the provided archive:

[del@del-debian bugtest1 (master)]$ git diff
diff --git a/submodules/bugtest2 b/submodules/bugtest2
--- a/submodules/bugtest2
+++ b/submodules/bugtest2
@@ -1 +1 @@
-Subproject commit cd0b9ee2946d2df3626943347332a4d86f93b126
+Subproject commit cd0b9ee2946d2df3626943347332a4d86f93b126-dirty

No segfault occured. I am using

git version 2.6.2.308.g3b8f10c

Could you please specify which version of git you are using and also try 
to reproduce it with latest 2.6.2?

--
Victor
