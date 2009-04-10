From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified branch-name
Date: Thu, 9 Apr 2009 21:19:09 -0400
Message-ID: <200904092119.10520.mlevedahl@gmail.com>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com> <7vhc0x1gvh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 03:20:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls5QH-0007xy-IK
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 03:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbZDJBTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 21:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756532AbZDJBTP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 21:19:15 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:25356 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbZDJBTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 21:19:14 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1067224qwh.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 18:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HnptIu5eZAqKYpuRjQj+AIRpCCoSCM7G+Bu9C13WoQY=;
        b=WNXuJR4Osh7afCB46r+kYVgbDad1F5dH66Mfu/g2hd9jtGtvzvzB2ARgM9zEue1bJc
         TD5TaQOz/OF6ohCR9282nOrB36hTsLesKjmQ7UBveSk5extbUNMPzwSKWICBQwUHsGtF
         gBpEHaqA0w4QzCXHqP7/d0eyVrb9+pI52Fspw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ei3l611M4BGBuAKkk56zjK8p0CdmsmVw1ywoCMHRHcMTeKuDoiVqN5v9F2PCY6OSGj
         45NkwSBTLXpQkPKZx3aEf0Rru1FUPGQyJOKHJwdn7f9X+v20WNMx0qNmVKke1Kaq1fgn
         cOgzaVrZSrPhODGlWiWoiKlLVD9CEM/WOO90M=
Received: by 10.224.2.84 with SMTP id 20mr3640081qai.3.1239326353403;
        Thu, 09 Apr 2009 18:19:13 -0700 (PDT)
Received: from hplap.localnet (pool-173-79-135-88.washdc.fios.verizon.net [173.79.135.88])
        by mx.google.com with ESMTPS id 26sm1097308qwa.22.2009.04.09.18.19.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 18:19:13 -0700 (PDT)
User-Agent: KMail/1.11.1 (Linux/2.6.27.21-170.2.56.fc10.i686; KDE/4.2.1; i686; ; )
In-Reply-To: <7vhc0x1gvh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116231>

On Thursday 09 April 2009 20:39:46 Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
> > This change allows, for instance
> > 	git branch -d refs/heads/foo
> > to succeed. Without this patch, the code just assumes that the
> > given branch name should be appended to "refs/heads" or
> > "refs/remotes", thus attempting (and failing) in the above case
> > to delete "refs/heads/refs/heads/foo"
>
> Your logic is broken.
>
> Why doesn't the user simply say "git branch -d foo"?  The command takes
> "the branch name", not "arbitrary ref name".

1) git branch -d refs/<whatever> used to work,  I haven't bisected to find 
when this stopped working, but the change broke one of my scripts, so this is 
not new behavior, it is restoration of previous behavior.
2) If I create branch  refs/frotz/bar , how do I ever delete it?

Also, the following all work
3) git branch refs/heads/foo
4) git branch -m refs/heads/foo refs/heads/bar 
5) git  [checkout|pull|push|fetch|show] refs/heads/foo

So, why is "git branch -d" so special?

Mark
