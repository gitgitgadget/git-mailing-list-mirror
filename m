From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Wed, 17 Sep 2008 23:31:30 +0200
Message-ID: <200809172331.31972.jnareb@gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail> <200809171107.35826.jnareb@gmail.com> <fcaeb9bf0809170649w418f4af5x3055c04994c694dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 23:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4dj-0005el-Gi
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYIQVbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbYIQVbh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:31:37 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:50836 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYIQVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:31:36 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1698688gvc.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1rEwGETQacWNLQnX3g5sFkCpWYtyiI+8XDjD6TITBDM=;
        b=SLAhBkQIZY46fda6zTQ0Et8iAgapV590b3r/r6tGjY0jy7LPMxNx7lmb7jTUtrvC4J
         XiPh+1/8vbbnm1jW//r79NNz5oxWKI/Ll6jZQYjnTrC4/rWTniMwRyOjrggYE9HEaCGc
         eXvOtt9yREVxGt6pCQC5dzLaFtiVI4fJ9zCZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uZnLv7IxnQVF8uNUoj+NYLmYklquz9yOYDEyxxDD9trur6zYyvWbeXObOCBNGZU9ah
         mhB0rV5FzFauG+f/KjN21h4YcsjyLiq9EWU3lmGiOyIPx+Cr+ovZ8nXbH/C9s4XcaQ0b
         nEHaUD8QLymjsRgrZ9rWMfklFfhs3aRTVtf+A=
Received: by 10.103.193.13 with SMTP id v13mr2236390mup.7.1221687094838;
        Wed, 17 Sep 2008 14:31:34 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.173])
        by mx.google.com with ESMTPS id g1sm16274031muf.8.2008.09.17.14.31.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:31:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809170649w418f4af5x3055c04994c694dc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96145>

On Wed, 17 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/17/08, Jakub Narebski <jnareb@gmail.com> wrote:

>>
>> Well, what I wanted to ask is if --remove-path starts from fully
>>  checked out repository, for example if
>>
>>   $ git checkout --remove-path=some_large_file
>>
>>  would checkout all files _except_ 'some_large_file'.
> 
> No, there is no negative spec. Like I said above, --remove-path is to
> remove some files based on the given spec.

So "git checkout --path/--add-path/--remove-path" is porcelain
interface to use (git-update-index is plumbing)?
 
>>>>  And is <pathspec> matched against full pathname, or like .gitignore
>>>>  rules, i.e. as full pathname if it has at least one '/' in it?
>>>
>>> like shell wildcard, full pathname must match. On my way back home, I
>>> thought I should have removed mention of "pathspec", which behaves a
>>> little bit different.
>>>
>>> Also those specs are relative to working directory though, so if you
>>> are in b/c and want to match d, you only need to type --add-path=d
>>> instead of --add-path=b/c/d. Will add this to doc.
>>
>> I would have thought that you follow the same rules (perhaps with
>>  exception of !path excluding rule) like for gitignore and gitattributes.
> 
> Um.. never thought of gitignores/gitattributes rules before. It's a
> good idea all narrowspec/gitignore/gitattributes using the same rules.

Perhaps you would be able to even reuse some of implementation?...

-- 
Jakub Narebski
Poland
