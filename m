From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Silence stderr in parse_commit*() subroutines
Date: Mon, 13 Feb 2012 20:12:04 +0100
Message-ID: <201202132012.04721.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201202111402.31684.jnareb@gmail.com> <7vmx8mfu8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: rajesh boyapati <boyapatisrajesh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:12:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx1Jt-0002qT-QD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab2BMTMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 14:12:08 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37432 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620Ab2BMTMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 14:12:07 -0500
Received: by eekc14 with SMTP id c14so1963903eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=41/4tWgF7xNNw8RDE1nLtdRx57a7Vm+CjObu6Z1eNt4=;
        b=COqc4VgevPWxdcbywDWk6YLx5I4bzj7UEDq7crrV48RGA0MhonYbkkFfdCmX9tCAVr
         qGzDlZnyto0w9a1Avh4vIQTStrR42GAiV1HZn94uPrLKVieBZRCl0bnjt7HzS5h5nzTB
         jWN2PV7DX0E71ECuULn3HD6w/Rk8t6KnmOktE=
Received: by 10.213.28.75 with SMTP id l11mr2855626ebc.47.1329160325869;
        Mon, 13 Feb 2012 11:12:05 -0800 (PST)
Received: from [192.168.1.13] (aeho143.neoplus.adsl.tpnet.pl. [79.186.196.143])
        by mx.google.com with ESMTPS id c16sm64027306eei.1.2012.02.13.11.12.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 11:12:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmx8mfu8k.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190651>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Anyway, here is the patch that should fix those "CGI: fatal: Not a valid
> > object name HEAD" errors for you.
> 
> I have to wonder if it is simpler and less error prone to check HEAD
> before doing anything else immediately after which repository is being
> consulted, and give the same "no history at all yet in this project" page
> for most if not all operations, instead of patching things up at this deep
> in the callchain.

Actually the problem is that there is history (there are other branches),
but HEAD points to unborn (unused) 'master' branch.

But you are right that we should fix underlying issue with invalid
assumption which gitweb uses, that HEAD points to a valid commit if
repository is non-empty.

Though I think leaving safety of 2nd patch could be a good idea anyway.
And 1st patch fixes a real issue, and does not only provide band-aid.


P.S. I will resend those three patches as patch series for easier review,
so they are not tangled in this deep thread.  They should be in 'gitweb/web'
branch in my public forks of git repository on repo.or.cz and github.

-- 
Jakub Narebski
Poland
