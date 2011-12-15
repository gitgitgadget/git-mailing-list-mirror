From: Hao Wang <billhao@gmail.com>
Subject: Re: process committed files in post-receive hook
Date: Thu, 15 Dec 2011 00:19:08 -0800
Message-ID: <4EE9AD7C.5080107@gmail.com>
References: <loom.20111210T111457-837@post.gmane.org> <4EE94783.1010805@gmail.com> <4EE95523.9030702@gmail.com> <20111215072301.GC1327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb6X8-0007r1-GJ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 09:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307Ab1LOITO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 03:19:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63354 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab1LOITN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 03:19:13 -0500
Received: by iaeh11 with SMTP id h11so2455171iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 00:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-tagtoolbar-keys:content-type
         :content-transfer-encoding;
        bh=jTs03Nw7rwYtLJUgiLRLdBJO71sjJai11oZVtGDM8Ws=;
        b=Skar1huLxh1jqFcp1AInUdjgOLf4RhVuSaBQ0Oa5OHNKbn3bcs/3Wcck+BVw5xuLsT
         +PzoiFNnwPunY47atyZbqNnnq1Jc4dt+basYPAW898B1mS98RiYIzvhpZQu66IHzmPaP
         TPZORl6mHrXRYRUpCMTjFJDORA49s0c/8tMAs=
Received: by 10.50.85.136 with SMTP id h8mr2264562igz.56.1323937152822;
        Thu, 15 Dec 2011 00:19:12 -0800 (PST)
Received: from [192.168.1.5] (cpe-76-170-238-136.socal.res.rr.com. [76.170.238.136])
        by mx.google.com with ESMTPS id x18sm18598791ibi.2.2011.12.15.00.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 00:19:11 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111215072301.GC1327@sigill.intra.peff.net>
X-TagToolbar-Keys: D20111215001908915
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187196>


> If you are scripting, we usually encourage the use of "plumbing"
> commands whose output is guaranteed not to change ("show" is a
> "porcelain" command intended to be used by end-users, and it's possible
> that its behavior might change from version to version).
>
> The plumbing command to get a directory listing for a tree is "git
> ls-tree" (try the "--name-only" option for terse output, and use "-z" if
> you want to be robust in the face of filenames with funny characters).

Jeff, thank you for the information. This is really helpful.

>> # get a list of rule files using git show
>> def getRuleFileList(rev):
>>      # run git show
>>      p = subprocess.Popen(['git', 'show', rev], stdout=subprocess.PIPE)
>>      p.wait()
>>      if p.returncode != 0: return None # error
>>
>>      # parse output
>>      i = 0
>>      filelist = []
>>      for line in p.stdout.readlines():
>>          filelist.append(line)
>>      p.stdout.close()
>>      return filelist
>
> Doesn't this put "tree HEAD:foo", as printed by "git show", at the top
> of your filelist? Another reason to use ls-tree.

Yes, the first two items ("tree HEAD:foo" and an empty line) are removed 
later from filelist.

Hao
