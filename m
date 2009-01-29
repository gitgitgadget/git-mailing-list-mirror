From: Alec Clews <alec.clews@gmail.com>
Subject: Re: How to install and use a custom merge driver
Date: Thu, 29 Jan 2009 18:00:51 +1100
Message-ID: <49815423.8000902@gmail.com>
References: <497FCC9A.9080008@gmail.com> <20090128061848.GA19165@coredump.intra.peff.net> <loom.20090128T230123-889@post.gmane.org> <20090129032531.GA11836@coredump.intra.peff.net> <loom.20090129T044425-689@post.gmane.org> <20090129050348.GA31202@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 08:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSQux-0008Mz-NW
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 08:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbZA2HBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 02:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbZA2HBB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 02:01:01 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:42558 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbZA2HBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 02:01:00 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8537994wfd.4
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 23:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=p+bWcDCrEmEzNvwxttix8KaMOqspYJD4uqL51VLChaA=;
        b=rCJXM7Xq116xhlW1pPFrCvuH8CVCz7oh0kwgKsQFYutCYPWMcZs0W5DUqmJwtFAA01
         JD0z5MuJqUT64MNKcY09eisidecyICmSQ/+V+RQrVHf/tw/L/wrgCm/9i9lxCfm7+oNw
         jOX/fAaCfAvG1YSU9h3lF2Sx5xoZ39D5Blo7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Rh5uSVO3GKnCafXF9kGY4ssrVB5yFSIgomp1POUG5tIeB0jhWKgU2KvVoAwKZ86x2W
         euunCxO0TPo7uS9jx54UOy/v1QeGcEfoajG4U8h5BYyUo4U5L00jDgFXEPberXC/mco3
         bNtgPsnpAXOfju6/VDSbozKJMizFnUDoQfzIc=
Received: by 10.142.226.2 with SMTP id y2mr319645wfg.26.1233212459254;
        Wed, 28 Jan 2009 23:00:59 -0800 (PST)
Received: from ?120.16.116.217? ([120.16.116.217])
        by mx.google.com with ESMTPS id 31sm25935128wff.23.2009.01.28.23.00.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 23:00:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090129050348.GA31202@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107638>

Jeff King wrote:
> On Thu, Jan 29, 2009 at 04:47:19AM +0000, Alec Clews wrote:
>
>   
> What git version are you using? Can you post a shell snippet that breaks
> reliably?
>   

I used 1.5.6.3 on Ubuntu and 1.6.1.1 on Cygwin.

The problem appears to be spaces around '=' in the attributes file. This 
fails for me


----------8<----------------------------------
commit() {
 echo $1 >file && git add file && git commit -m $1
}

rm -rf repo

mkdir repo && cd repo && git init
commit base
commit branch-master
git checkout -b other HEAD^
commit branch-other

echo '* merge = overwrite' >.git/info/attributes
cat >>.git/config <<'EOF'
[merge "overwrite"]
 name = overwrite using cp
 driver= cp %B %A
EOF

git merge master
----------8<---------------------------------



-- 
Alec Clews
Personal <alec.clews@gmail.com>			Melbourne, Australia.
Jabber:  alecclews@jabber.org.au		PGPKey ID: 0x9BBBFC7C
Blog  http://alecthegeek.wordpress.com/
