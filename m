From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 04 Aug 2007 12:08:30 -0400
Message-ID: <46B4A47E.5030901@gmail.com>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site> <46B4A2B0.9080208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMBB-0004BI-Bc
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbXHDQIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbXHDQIe
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:08:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:4926 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbXHDQId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:08:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1080483wxd
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 09:08:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NfSifYl4MsFg1n1OvIzuLb55od24tzx3qQNFVqWdmXm7Eji97e16xvx3tj+ucecR5NHGIPZR+Hy3Fb3tVC9w8HGHN97PGWSXUIFH3xukfUezORiZSoK2rwEM2qMoYGwi3JKLpEw5yUWc9QNxCZSSwPXcyjNY3x91P1QPPhaHrAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=F/1AgURyhkZwXrsrGTItVFelLe7WY4WdtSKCBj4pEV+Y6/+ILMKOn1qCkFJkBtQktsNg/rxspCA/zExjyXNxv3jVmfAvqnClcqPrP7fUpkQCwDqXj8VX/8/mKrgxTCw8nAfo9ApP0wCUAn34VqLqGpnn1ZIQe2NsVhO+FWrj9us=
Received: by 10.70.9.8 with SMTP id 8mr6963950wxi.1186243712801;
        Sat, 04 Aug 2007 09:08:32 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 3sm4749496wrh.2007.08.04.09.08.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Aug 2007 09:08:32 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <46B4A2B0.9080208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54874>

Mark Levedahl wrote:
> Johannes Schindelin wrote:
>> Could it be that you did not find this commit by bisecting the 
>> issue?  I highly doubt that said commit changes anything in the build 
>> process.
>>
> git>git bisect good
> 6490a3383f1d0d96c122069e510ef1af1d019fbb is first bad commit
> commit 6490a3383f1d0d96c122069e510ef1af1d019fbb
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Thu Aug 2 15:10:56 2007 -0700
>
>    Fix work-tree related breakages
Sorry - I hit send too fast on the previous mail. The relevant build 
lines are:

GIT_INDEX_FILE=`pwd`/.quick-doc.index
export GIT_INDEX_FILE
rm -f "$GIT_INDEX_FILE"
git read-tree $head
git checkout-index -a -f --prefix="$mandir"/

After this commit, git checkout-index does not write the man files into 
$mandir, before this commit, it does.

Mark Levedahl
