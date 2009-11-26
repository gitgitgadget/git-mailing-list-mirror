From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Thu, 26 Nov 2009 01:59:47 +0100
Message-ID: <200911260159.48311.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911260028.19383.jnareb@gmail.com> <7vpr76m8dx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSiC-00069r-0T
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759886AbZKZA7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759349AbZKZA7o
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:59:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:59888 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759462AbZKZA7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:59:43 -0500
Received: by bwz27 with SMTP id 27so219023bwz.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sQP+S3Iidv7EX9r3/5ygFp2kTNAjnBIzniMffO8HYYg=;
        b=nbqCPuNWEuU9CUmxnyJWpgWtUp+wopl66OqyDUf/hQm5wrQ6tYBZwl7YtEhtw8ZChi
         iLRGwc1m7SIIqtmAKVkqM/BjVmgPUkoP/yJVLvKDWkJoyJ5h54UEjXfBJGCnXlIA/Aks
         CAuLRbZZ7Xx8WWmD9tUwN9b/MAlhmP7M3FeXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=frCWBETNou+D1Dj+xyWHRu9JcL2MDyq+PIyFEFZjXgqASfM8QCWUQKJvbVpyiAFozH
         dXvVZaO+qqx9qSDZyQGfmf9Pdg7nHdasyhy7yXSlJHO+Nnk7BhldT/OhMF2EBQEkKbAJ
         /SOLsLgBSNp8WKetEwZIiM22aylQNwX7k/UEM=
Received: by 10.204.49.79 with SMTP id u15mr715129bkf.117.1259197189172;
        Wed, 25 Nov 2009 16:59:49 -0800 (PST)
Received: from ?192.168.1.13? (abvf67.neoplus.adsl.tpnet.pl [83.8.203.67])
        by mx.google.com with ESMTPS id z10sm223459fka.0.2009.11.25.16.59.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:59:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vpr76m8dx.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133747>

On Thu, 26 Nov 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Below there is request-pull with reordered series, unless you want me
> > to resend this series as a set of patches, as reply to this email.
> 
> It is too late for that, as they are already in 'next'.  I do not think it
> is necessary nor desirable, either.
> 
> With the "Create links" commit, you are _adding_ a new link that leads to
> a new feature with known breakage, not _replacing_ a link that leads to an
> existing working implementation with one that does not work for some
> people, no?

No.  The "Create links" commits make existing 'blame' links, which till that
commit always lead to non-incremental 'blame' action, now lead to new
'blame_incremental' action (if JavaScript is enabled).  So the result is
that we _replace_ links to 'blame' view by links to 'blame_incremental' view.

> Merging everything else but not merging that commit does not make any
> sense.  It won't give any wider exposure to the feature, and is no better
> than carrying the entire thing in 'next' (or 'pu') post 1.6.6.
> 
> A follow-up patch to add a gitweb configuration switch that disables the
> non-working view by default but allows site owners to enable it in order
> to help improving the feature would be a sensible thing to do.  As long as
> that patch is solidly done we can merge the whole thing to 'master' in the
> upcoming release.

But if it is already in 'next', then I'll try to come up with patch which
makes JavaScript-ing links (replacing links with JavaScript to equivalent
actions utilizing JavaScript, currently only 'blame' -> 'blame_incremental')
configurable.

-- 
Jakub Narebski
Poland
