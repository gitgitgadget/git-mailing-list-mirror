From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Tue, 19 May 2009 09:48:07 +0200
Message-ID: <200905190948.09378.jnareb@gmail.com>
References: <20090517153307.6403.73576.> <m3r5ylk347.fsf@localhost.localdomain> <7vfxf18szq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 09:48:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6K3j-0003JU-Qv
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbZESHsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 03:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbZESHsP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:48:15 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:57225 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZESHsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 03:48:14 -0400
Received: by gxk10 with SMTP id 10so7226950gxk.13
        for <git@vger.kernel.org>; Tue, 19 May 2009 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pccNqpCTUyYJjTuB7qHgUSlbSP7JY0aqdlyav26IWRo=;
        b=CLg32ueUuSkdvNfTLdLfp0QgglZwEUeR2iI47nJVGIjJnPXHX7TH9AgLeGYDPfpvpO
         P8Iw/D1OeRWLl9d5KjNJVt0b8/5Yg1N+szUlSXg07KSAj94y/AsOmQjJScosyQbYWb3Q
         0PmdHenv+8iEqp3VN78HTgl6lboXMdGT5cXZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Wu0npKTEyyUkV0Zyg+nfNkScJN+B4p5qRCG0qoBEiBM0MRhGPvl1R0WzcKrLuDbbvS
         ADvMdy4tUOyvtPrBMFovPXnn7IX69HDOjbd5H8rEa55jU1jI6mcuj0gQXZVCZzimAUTk
         SKcNz7O6JvlfmxYrjLXfrsZPEPXWTJ0pTDfTk=
Received: by 10.90.92.16 with SMTP id p16mr2444047agb.87.1242719295531;
        Tue, 19 May 2009 00:48:15 -0700 (PDT)
Received: from ?192.168.1.13? (abwi178.neoplus.adsl.tpnet.pl [83.8.232.178])
        by mx.google.com with ESMTPS id 40sm9204912aga.63.2009.05.19.00.48.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 May 2009 00:48:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxf18szq.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119501>

On Tue, 19 May 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > First, I have always thought that you cannot push arbitrary SHA-1
> > (arbitrary commits) in git; you can only push via refs. Isn't it true?
> 
> No.

Oh. I must have mistaken it with the protection in the opposite side:
git-fetch doesn't allow fetching arbitrary SHA-1 (arbitrary commits),
isn't it?

Side note: I wonder if any other DVCS has such shotgun of^W^W a feature ;-)

> > Second, the "refs/replace" mechanism has the advantage over grafts
> > that it is sanely transferrable. Whether "04a8c^2"^{replaced} exists
> > on remote side depends on if other side has the same replacement, or
> > if you push replacements in the same push.
> 
> The reason why replace mechanism could be cleaner than grafts is because
> reachability traversal and transfer do not obey replacements, and local
> ancestry traversal will if there are refs/replace entries.
[cut]

Thanks for an explanation. So "refs/replace" is sanely transferrable
because it can be transferred using local reachability only (without
replacements turned on), isn't it?

As I understand the problem with replacement rules is that it cannot be
treated simply as 'extended SHA1' syntax; the replacements must be done
only for local operations, which probably means opt-in, and pushing it
down to the commands itself... well, that or marking commands as local
or remote...

-- 
Jakub Narebski
Poland
