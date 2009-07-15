From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: git-am: fix maildir support regression for
	unordered headers in emails
Date: Wed, 15 Jul 2009 18:19:26 +0200
Message-ID: <20090715161926.GA12935@vidovic>
References: <20090714122354.GA13806@vidovic> <2433101adeafddeab78815083446552ff3ea9f49.1247636959.git.nicolas.s.dev@gmx.fr> <7vljmqflti.fsf@alter.siamese.dyndns.org> <20090715125419.GA21811@gpk-lds-007.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 18:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR7Cv-0001Qq-Ap
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 18:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbZGOQTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbZGOQTi
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 12:19:38 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:37384 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbZGOQTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 12:19:37 -0400
Received: by ewy26 with SMTP id 26so4163524ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RbFGkA39jh+xabhNvnqHHYHvzRFKttI36E3KPca/jTo=;
        b=jL+7K39+iEAg8G5GGPAbvqq5o8/H8N+UwZKhogb5/eLToOs96Bn7tJfGPaR9FkE0oR
         sXHZmUUyE2mX0V/V/wE1+KA8eo4oh26XX1K7iLp0QYHBEcix77e09DopvYR0Rg0AOXK4
         s6EDC3nw3rpzU2e2i5sojqWuz6XOcMRVCjktY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ToHD/84efZPfFprNYqX+TClzye892MAQXqa4pXNJUIwugvTj7iPAQmj/fn2vw8OppC
         kLCQfWa5b0n6qbzgTGhaXtmVtXOYuW03KnlRUlVaajTXHdt5PjyUVPUvx7vGoKe1eOol
         EnuuGBgsdRwwoPsfeLXqdDZaqxowKta6SERu4=
Received: by 10.210.81.9 with SMTP id e9mr8346900ebb.68.1247674775923;
        Wed, 15 Jul 2009 09:19:35 -0700 (PDT)
Received: from @ (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 28sm1509670eye.6.2009.07.15.09.19.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 09:19:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090715125419.GA21811@gpk-lds-007.cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123326>

The 15/07/09, Derek Fawcus wrote:
> On Wed, Jul 15, 2009 at 12:27:05AM -0700, Junio C Hamano wrote:
>
> > It is unclear what you meant by "verbatim email".  A verbatim e-mail
> > in mbox begins with "From " header that is already covered in the existing
> > code long before support for stgit/hg was added.
> 
> I believe he is referring to the claimed support for maildir format boxes.

You're right. In a maildir each email is the file as is.

> > But I am not convinced that I understand what _problem_ you are trying to
> > solve in the first place.
> 
> Assuming it is maildir support,  then there is no 'header' as such in the
> file which can be detected.

True.

>                              One could try and detect that the contents
> are structured as an RFC822 message (but with local line ends),  or one
> could try and detect that the file is within a maildir folder.
> 
> It seems this patch is taking the former approach and trying to ensure
> the file consists of header fields.

You're perfectly right. I think it's the best approach because if the
files are moved to another folder (the repo?), they are still valid
patches.


-- 
Nicolas Sebrecht
