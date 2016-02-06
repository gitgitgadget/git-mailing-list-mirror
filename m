From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Sat, 6 Feb 2016 18:53:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602061850460.4476@tvnag.unkk.fr>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com> <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com> <20160202232952.GA6503@vauxhall.crustytoothpaste.net> <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
 <xmqq60y3dout.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 18:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS74I-0001MT-EA
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 18:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbcBFRyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 12:54:35 -0500
Received: from giant.haxx.se ([80.67.6.50]:44433 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbcBFRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 12:54:22 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.15.2/8.15.2/Debian-3) with ESMTPS id u16HrvTx007549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Feb 2016 18:53:57 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id u16Hrt0H007513;
	Sat, 6 Feb 2016 18:53:56 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <xmqq60y3dout.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285700>

On Fri, 5 Feb 2016, Junio C Hamano wrote:

> OK, as Brian said, that use case would need to be in the log message, at 
> least.  I am curious, though, if you can give just a random string to 
> username, or at least that must match what the underlying authentication 
> mechanism uses.
>
> Brian, I can see how this would work in that use case, but I haven't 
> convinced myself that the change would not affect other existing use cases 
> that are supported--do you think of any that would negatively affect the 
> user expeerience?
>
>> Even more, there is no other way to let libcurl to use GSS-Negotiate 
>> without username in URL.
>
> Asking lubcurl expert about that might not be a bad idea; Cc'ed Daniel 
> Stenberg.

It is correct that libcurl needs a username to trigger the use of HTTP 
authentication - any HTTP authentication - due to how we once designed the 
internals for this - but when using GSS-Negotiate the actually provided user 
name isn't used by libcurl for anything so it could be a fixed string or 
random junk, it doesn't matter as long as a name is provided.

-- 

  / daniel.haxx.se
