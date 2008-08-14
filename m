From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 12:26:49 -0400
Message-ID: <48A45CC9.5040708@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814151451.GA10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 14 18:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTfgW-0005sV-NA
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 18:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbYHNQ05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbYHNQ05
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 12:26:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:46676 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYHNQ04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 12:26:56 -0400
Received: by qw-out-2122.google.com with SMTP id 3so44042qwe.37
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=dIpVNKGO+p9TxXa2aD8bNEJg+1DQcPVBJ0CUiN6bgO0=;
        b=sHWv4I9KZGcMefJyjKXTYxehfqzj9aItp7INa/NFwn9jKp4/W5p+9T26DzxmoHVzu1
         fYxBOCXs6k/mE1qy/vGIDnNJuY6oiZPna3fV6l11Bryazoj08PT+dIb4kQjxO61vYNoe
         km/TSjGT4778eZbNrDxCYa6+WmYFmu5warZ70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=uXdJb5e4xN9E16TA77ZngwkWkzNdydo2cgm1UFlTLpq0Ce8FnwcixsUOt08y/myyYq
         pEEQmrrR5M4PsbwD6LVbZ1eA1fRouaRaHrQU47n/nQ8Y89pp551Wmq6NmE4UNB586A+3
         0MzJcsyWDtq/BwLJRDx/nkiYVo9wDZme8Rldo=
Received: by 10.214.81.3 with SMTP id e3mr1393727qab.92.1218731214678;
        Thu, 14 Aug 2008 09:26:54 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 26sm3018079wrl.38.2008.08.14.09.26.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 09:26:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080814151451.GA10544@machine.or.cz>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92368>

Petr Baudis wrote:
> Are you aware of progress.c:throughput_string()? It would make sense =
to
> use the same code in both instances.

I was not. After reviewing it, it is limited to its purposes (who's got
transfer speeds in TiB/s?), but consolidating the human-readable-ness i=
s
a good idea.

> I'd prefer you to keep using binary units instead of the ambiguous
> prefixes, since we should keep our output consistent and I believe th=
ey
> usually end up to be the least confusing choice. (Otherwise, don't yo=
u
> want to use "bkM" instead of "BKM"? I never really know.)

In general, "b" would be supplied as a part of the suffix, so that is n=
o
longer in the prefix list.  The distinction comes with kilo vs. kibi.  =
In
an earlier email reply, I mentioned a flag to denote SI versus binary
periods.  In common nomenclature, Kilo (1000) is designated 'k', while
Kibi (1024) is designated 'K' (the 'i' after the 'K' is supplied by the
suffix if desired).  Thus, if the user wants binary, they'll get the ca=
pital
'K', and if they want SI, they'll get the lowercase 'k'.

Sound reasonable?

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
