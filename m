From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 14:45:22 +0200
Message-ID: <200806031445.23002.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <m34p8a2173.fsf@localhost.localdomain> <b77c1dce0806030503r55c95d73t5ff244821f76cf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 14:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3VuJ-0002jg-7v
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 14:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbYFCMpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 08:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYFCMpi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 08:45:38 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:61099 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbYFCMph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 08:45:37 -0400
Received: by gv-out-0910.google.com with SMTP id e6so219891gvc.37
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=k2tV/JoaVRIPtJjtksFKJ1sEWfi4qjTdDGI62A09/+4=;
        b=HVCyQ8csAGvsdKPu/AjBfoidCJX6qb6cu7yoZDUgkJr9cVMnDllU0VkPo5xQutPRquVI2podQqJW0uCMi2Nk4xm4KO1T1Qerv+rKNQk74FyffOgtS0zD6QWAsI37ySHInOn9dGov2/B7K+dgS1aARkSyN04E5ksoFdGZFRK1OuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pvHjnLDf8lB7NexQEEzDfdQs8HN+918oLupnDKvuPcYWiwBxaYcUkgpIyGDrnSUUTvy/KqVliTgZ2qlWKKuGoaao2DP82c+IvYH6IrjXuXPK61UQHJE9pQ6d4ecE0UQMrK2QywoNpi7U/FZ6OmZsV+v89CDLWJFsO/oursje3jE=
Received: by 10.125.107.19 with SMTP id j19mr746292mkm.91.1212497133444;
        Tue, 03 Jun 2008 05:45:33 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id k9sm6729788nfh.23.2008.06.03.05.45.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 05:45:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0806030503r55c95d73t5ff244821f76cf1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83648>

On Tue, 3 June 2008, Rafael Garcia-Suarez wrote:
> 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>> Rafael Garcia-Suarez wrote:
>>>
>>> -             open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
>>> +             open (my $dd, "-|", git_cmd(), "rev-parse", '--revs-only', "$full_rev^")
>>>                       or die_error(undef, "Open git-rev-parse failed");
>>> -             my $parent_commit = <$dd>;
>>> +             my $parent_commit = <$dd> || '';
>>>               close $dd;
>>>               chomp($parent_commit);
>>>               my $blamed = href(action => 'blame',
>>
>> I'd rather remove this, correct it, or make it optional (this is very
>> fork-heavy).
> 
> Not sure how to do the same thing in pure Perl.

I was thinking about extending git-blame porcelain format (and also
incremental format, of course) by 'parents' (and perhaps
'original-parents') header...

> We could however cache the results of git-rev-parse, since the same
> rev is likely to appear many times in the list.

...but starting with cache of git-rev-parse results, or optionally
allowing extended sha-1 syntax (including <hash>^) in hash* CGI
parameters in gitweb would be a good idea.

But as I wrote, I'm fine with the patch as it is now.
-- 
Jakub Narebski
Poland
