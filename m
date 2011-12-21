From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Big Mess--How to use Git to resolve
Date: Wed, 21 Dec 2011 17:44:59 -0600
Message-ID: <4EF26F7B.90206@gmail.com>
References: <1324125130643-7103964.post@n2.nabble.com> <86iplf2oy5.fsf@red.stonehenge.com> <1324147247781-7104493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hs_glw <greg@hra.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 00:45:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdVqP-0005jB-3r
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 00:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab1LUXpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 18:45:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58484 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab1LUXpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 18:45:03 -0500
Received: by ghbz12 with SMTP id z12so5169416ghb.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 15:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KwBHtFLkJQAASwkqBKUEIEl4eft51FIcgWRrQ11d6hw=;
        b=ZTEi1sZMx6fut8U4nafCzXYkZ2PrxL+Gq5eRhyxxJRM5I8+9fLj4a8PcuMu9E67JIA
         nZYiYMLnxBGBoVDNzDNaINilKQO7Jxwlg90G+doJ9sCxcVcV9mV0PgiOQE+NvHoPNMhg
         rsHSzjeCdoD/zYGGg93TeLgVmvc4W/1bYPpxQ=
Received: by 10.236.139.199 with SMTP id c47mr12128274yhj.113.1324511102435;
        Wed, 21 Dec 2011 15:45:02 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c10sm11600269yhj.2.2011.12.21.15.45.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Dec 2011 15:45:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1324147247781-7104493.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187591>

On 12/17/2011 12:40 PM, hs_glw wrote:
> Randal, thank you for the comprehensive answer.

Note that Randal's solution leaves with a branch named Release that has 
the history of the generic version of your software, and various 
custom(er) branches that fork from the Release branch...

On 12/17/2011 6:32 AM, hs_glw wrote:
> Some clients have customizations of the code, some have version 5 of
> the software others have 5.2, 5.5 etc.
>
> My goal is to pull all the different versions in, put them all
 > together, and create a master version of the software that runs for
 > all clients.

Note that you don't have to make everyone run the same version. At my 
shop we maintain dozens of concurrent divergent versions and that is the 
main reason we chose git.  We can maintain a generic version (which most 
clients run) and also custom branches (for clients wanting to pay for 
customizations) forked off of the generic branch.  The custom branches 
can periodically have the generic branch merged in to obtain the generic 
fixes/enhancements.  You can also merge the custom branches into the 
generic branch if you want those custom features included in a new 
release of the generic branch.

> There will still be some files that are completely unique to each
> client (style sheets and logos for instance).

If your logos are graphical files they are likely considered 'large 
files' and are likely binary files in the context of git.  It is 
recommended you maintain these in a separate repository to keep them 
from bogging down your main repo (performance and storage).  You can 
make the logo repo a submodule of the main repo (source repo).  This 
would then make your main repo a 'super project' (contains submodules) 
in git terminology.  Alternatively, I think your source repo and logo 
repo can just both be submodules of a super project.

We are working on implementing this so some of what I said is 
theoretical.  Custom branches in combination with submodules seems like 
it could get pretty unwieldy if not managed properly.

Some things to look into.

v/r,
neal
