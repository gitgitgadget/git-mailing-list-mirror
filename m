From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 10:33:55 +0100
Message-ID: <200812181033.57360.jnareb@gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com> <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com> <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 10:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDFGn-0002Tq-2q
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 10:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYLRJcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 04:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYLRJcy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 04:32:54 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:42061 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbYLRJcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 04:32:53 -0500
Received: by ey-out-2122.google.com with SMTP id 6so42280eyi.37
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 01:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FlfG8130NMHr3TW88OmGkT8ZejtL6Pml/nBn0rgQk30=;
        b=GCGxviqjnPtLuzFPQk+ppq4WHC3qNNhcOPS3rSXC3A373uY3bs80JaSM+v0jyqPept
         3R8WheO/GQj6ksjRUgIqVyg5lZG1BNbElZuUVRmoT3UbWcn4JXPCiPJfuX8kWPqu3ivd
         82Nvi+h0fq/GpkrYD0mMmM9fD0z2Czk1mUTYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=A3uK0hPXGhFMnL0HWjpseVJ8ma9GV+8vInrgyRNTNxTKJPAJZakSg3HmDdo3XkNGjR
         /uuLXFLreYvlz4NOM368QHokGgScxBgDfI337QR+3gc/qwr0HJBQT7/1/fqLTYYfL0Tb
         opLu1O1d3/mNw10EnAhHbXGpFKq/JoccAudwA=
Received: by 10.210.78.16 with SMTP id a16mr1968418ebb.187.1229592771663;
        Thu, 18 Dec 2008 01:32:51 -0800 (PST)
Received: from ?192.168.1.11? (abve54.neoplus.adsl.tpnet.pl [83.8.202.54])
        by mx.google.com with ESMTPS id 10sm1547210eyd.56.2008.12.18.01.32.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Dec 2008 01:32:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103450>

On Thu, 18 Dec 2008, Junio C Hamano wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
> 
> >  sub git_commitdiff {
> >  	my $format = shift || 'html';
> > +	my %params = @_;
> > ...  
> > +			if ($params{-single}) {
> > +				push @commit_spec, '-1';
> > +			} else {
> > +				if ($patch_max > 0) {
> > ...
> > +			}
> > @@ -5625,6 +5635,10 @@ sub git_commitdiff_plain {
> >  
> >  # format-patch-style patches
> >  sub git_patch {
> > +	git_commitdiff('patch', -single=> 1);
> > +}
> 
> Hmm, if you are changing the interface this way, wouldn't it make more
> sense to also do this?
> 
> 	git_commitdiff(--format => 'patch', --single => 1);
> 	git_commitdiff(--format => 'html');

The first argument (format) is _required_, second is _optional_;
I'd rather use named parameters trick only for optional parameters.
Because with more than one optional parameter function call begins
to be cryptic; also flag (boolean) parameters are more readable
when used as named parameters.

-- 
Jakub Narebski
Poland
