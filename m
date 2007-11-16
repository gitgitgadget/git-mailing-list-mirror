From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Fri, 16 Nov 2007 02:00:24 -0600
Message-ID: <473D4E18.3060006@zwell.net>
References: <473D3593.9080806@zwell.net> <7vfxz61yox.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 09:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isw96-0002Fk-6R
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 09:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbXKPIBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 03:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbXKPIBb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 03:01:31 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:41617 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbXKPIBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 03:01:30 -0500
Received: by py-out-1112.google.com with SMTP id u77so4053184pyb
        for <git@vger.kernel.org>; Fri, 16 Nov 2007 00:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=UH8md64wTi9+nEBNOqQvLvJIy5y5C8Zj7zt0LnkFA0I=;
        b=EdUmDmkfhR875WtVwyT9mrZtFE9mGZr/MOC7rAmzRuPSkoWinzL+nzOOgSD5h7/ZSWd0jT8jcX9bP0KzctFFpTTpy59td768QJp2bkcgIQtxQKD9jtApYy5rDzmjCjeSLK0NfBG27zVptHQ/PaU/eNqR59BkZKR0jP44tl20buo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=sv17pLH4YHsu9k+SKQQItMV1TVeAmQguAuW8e4PuJUwViI1ZCk4lBnloTrAQRBWi2KVeo5AxVPyCiTR3p0Qgr4+PMEZUo+1YyyZ5ifF7I08omLXor2uHz02i4mX5BJS1nV8bgZx59QcDPOfffaL97e8W04LtfNt82KA1yvsMA7M=
Received: by 10.35.109.2 with SMTP id l2mr1845537pym.1195200089267;
        Fri, 16 Nov 2007 00:01:29 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id f57sm6381414pyh.2007.11.16.00.01.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Nov 2007 00:01:26 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <7vfxz61yox.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65202>

Junio C Hamano wrote:
> I did not examine the callers but my gut feeling is that it
> would be simpler and cleaner to always return () without
> checking the context.  In scalar context:
> 
> 	sub null {
>         	...
>                 return ();
> 	}
> 	my $scalar = null();
> 
> would assign undef to $scalar anyway.
> 
> I generally try to stay away from functions that changes their
> return values depending on the context, because they tend to
> make reading the callers to find bugs more difficult.
> <snip>

That's reasonable. I'll resend this as part of the git-add--interactive 
color patches. This can be cherry-picked out, but some of the other 
stuff I want to do depends on it (a helper function that I wrote, 
config_with_default($repo, $key, $default)).

Dan
