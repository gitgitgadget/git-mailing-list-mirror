From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid perl in t1300-repo-config
Date: Thu, 28 Jun 2007 09:41:43 +0200
Message-ID: <81b0412b0706280041i535efdf0r87e552551b796044@mail.gmail.com>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
	 <7vmyykog4e.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 09:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3odQ-00079p-Cs
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 09:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760286AbXF1Hlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 03:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759780AbXF1Hlq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 03:41:46 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:6751 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760228AbXF1Hlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 03:41:46 -0400
Received: by ik-out-1112.google.com with SMTP id b32so403127ika
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 00:41:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Es6460inglccds43BdsWwO6eLipeqIFWeD1yjVUi9KBdKBbZD7B1Mnwyl6Fhlo1833n5GVACZBSY3enK8/wSLjFJs+WNpQJQrExi3r7yshdC+TvCdxFk3kXOsirxB7S3mIPmPeOuWl4Yhl8SxSf7ypSOYcWlY/gfv18z5WlA0Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kGN39AA4XOYOZQy4HUFW9rVW0hpJ6uN8MCdkPXBdn/Odc7AKvvCXGHx0Y2JU/ourzh02zh/3Q7eD+2zpivYQ5tan3tB4JQDRFXyh93w2OX6+dxzUYurUlIUFWLEAhkv4AiPIAQaeg7dKccB10zwgd6/irSUAKLpyQi9cPVl94DI=
Received: by 10.78.190.10 with SMTP id n10mr712609huf.1183016503664;
        Thu, 28 Jun 2007 00:41:43 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 28 Jun 2007 00:41:43 -0700 (PDT)
In-Reply-To: <7vmyykog4e.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51086>

On 6/28/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > It fixes the test on system where ActiveState Perl is used.
> > It is also shorter.
> > ...
> > -git config --null --list | perl -0ne 'chop;($key,$value)=...
> > +git config --null --list | xargs -n1 -0 echo 'Key:' > result
>
> This now makes us rely on "xargs -0", which is probably much
> less portable than Perl isn't it?

Dunno. Have yet too meet a system where it doesn't work.
That said, SUSv6 does not mention it.

> Maybe postprocess "git config -z" output with "tr '[\000]' 'Q'"
> or something so that the comparison of the result does not have
> to worry about NULs?  I dunno.

Will try that.

> By the way, is it possible for gmail users to avoid attachments
> when sending patches in?

No. The message text is unpredictably garbled
