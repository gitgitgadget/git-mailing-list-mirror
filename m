From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 10:13:45 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1111161008430.19479@tvnag.unkk.fr>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com> <CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com> <7v1ut9uglb.fsf@alter.siamese.dyndns.org> <CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
 <CALUzUxrM8o1uahQgSFUuvZ0mSPxG_zVQ9awOantRM2A8kkbbtA@mail.gmail.com> <CACf55T5cp1ko45DCufcRXm=EeZd1-x+aYasvbzjDXkQH31u5VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 10:14:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQbZb-0001XT-N4
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 10:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab1KPJN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 04:13:57 -0500
Received: from giant.haxx.se ([80.67.6.50]:53017 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771Ab1KPJNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 04:13:54 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id pAG9DkgZ024822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Nov 2011 10:13:46 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id pAG9DjOE024817;
	Wed, 16 Nov 2011 10:13:45 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CACf55T5cp1ko45DCufcRXm=EeZd1-x+aYasvbzjDXkQH31u5VA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185531>

On Wed, 16 Nov 2011, Dmitry Smirnov wrote:

> Unfortunately, I cannot see, why problem occurs. The only indication is
> * Connection #0 seems to be dead!

That means libcurl wanted to re-use an existing connection, but it seems to 
have died in the mean time and therefore it has to create a new one and 
reconnect instead. I suppose that is the first indication that something isn't 
quite right.

> Is it possible that curl sends the request in plain text?

I'd say that isn't very likely and you could easily snoop on the network to 
figure that out for sure.

> And according to tcpdump, why git/curl sends the request before Server 
> Hello?

curl will send the HTTP request once the TLS negotiation has completed as told 
by the TLS library. I believe you said you're using GnuTLS, are you using a 
recent version?

This is not a transfer layer (curl/HTTPS) bug I recognize, but I can of course 
not rule out that there's a bug somewhere in there!

-- 

  / daniel.haxx.se
