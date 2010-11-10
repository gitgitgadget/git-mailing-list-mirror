From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Wed, 10 Nov 2010 14:06:50 -0600
Message-ID: <20101110200650.GA13439@burratino>
References: <20101110170819.GA3031@gnu.kitenet.net>
 <7v1v6thrzc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 21:07:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGx0-0008GD-GT
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab0KJUHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:07:15 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63146 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab0KJUHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:07:13 -0500
Received: by bwz15 with SMTP id 15so1127696bwz.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 12:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MTVQozFW+R8pPuuU3FU4vLrE5S6G9JP3qnfYIqAdV5E=;
        b=pIuvfW8/sdE0bP3UozEJp1kvw7vZcnGkBCiFmlrBGAD16JJEt+4WSCv3Ysps6q3O4N
         kHDBREGUyzK1Qmq13UBqAc/F/fc6s6FALNAr8vzyh7Oq3Q7LG7t5o0/PEq5O1cF02v8Y
         wvShHz6hQ8M/+q5wty0pa+iv1QlIJdt7y6vF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=da0jfhDE2x+cDUNYY0CIAMqBbi5/4pkrrk24JpTjQkznZg7TfzQ2lPYHzoppH62p0s
         sSDUqFvhB7n+RcSEtITUaQRszniVDg/Bm/lU+dXkss0hwlR2qMAOKVCyQPBmSuEz4m81
         5hyHR9pHBbRjIhWQ7l18RTrH0q3LH1qSa0mvc=
Received: by 10.204.115.73 with SMTP id h9mr39792bkq.52.1289419632708;
        Wed, 10 Nov 2010 12:07:12 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id y19sm535882fau.41.2010.11.10.12.07.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 12:07:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1v6thrzc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161179>

Junio C Hamano wrote:
> Joey Hess <joey@kitenet.net> writes:

>> I've noticed that if I make a pre-commit hook change the files that are
>> staged, those changes are not reflected in the commit message. For
>> example, if a pre-commit hook git add's somefile, the commit message
>> won't reflect that. I guess prepare-commit-msg is being run before
>> pre-commit for some reason?

I'm guessing it is to allow cancelling a commit before a costly
pre-commit hook runs.

> My intention was that Documentation/githooks.txt would document things
> that are allowed (e.g. "applypatch-msg" explicitly says "The hook is
> allowed to edit the message"), and anything that is not specifically
> allowed is not.
> 
> "Is it kosher" is a difficult question to answer, as something may not be
> allowed but there may not be an enforcement mechanism to deny it, iow, it
> may happen to work by accident.

In this case, isn't it only a half accident?  For example, I think
v1.5.4-rc0~78^2~12 (builtin-commit: fix partial-commit support,
2007-11-18) taught git to support this a little better.

That said, I would be interested to hear the use case, since modifying
staged content on the fly for a commit sounds a little crazy. :)
