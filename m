From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Unresolved issues #2
Date: Tue, 09 May 2006 12:40:09 +0100
Message-ID: <1147174809.2794.12.camel@pmac.infradead.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 13:40:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdQZh-0005uN-5k
	for gcvg-git@gmane.org; Tue, 09 May 2006 13:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWEILkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 07:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEILkR
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 07:40:17 -0400
Received: from canuck.infradead.org ([205.233.218.70]:21226 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932366AbWEILkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 07:40:15 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FdQZY-00063c-OF; Tue, 09 May 2006 07:40:13 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19834>

On Thu, 2006-05-04 at 01:15 -0700, Junio C Hamano wrote:
> 
> * Message-ID:
> <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
>   Content-type charset for send-email (Bertrand Jacquin)
> 
>   The output from format-patch by default is unmarked, which
>   means the commit message part is UTF-8 (by strong convention),
>   and the contents of the diff is whatever the contents of the
>   file is encoded in.

Email without a Content-Type: header is supposed to be ASCII. If it
contains 8-bit characters, it's invalid. It'll be interpreted by
different systems in different ways -- not necessarily as UTF-8. Some
may even just reject it, on grounds of RFC non-compliance.

>   David Woodhouse did a patch to allow specifying charset on the
>   command line (and default to UTF-8) which is a move in the
>   right direction, but Bertrand's system seems to have trouble
>   with it.

I thought Bertrand then confirmed that he was having trouble _before_
applying my patch, too? His response when I asked it it appears without
my patch was "[it] appear without in 1.3.1 and I can't seed mail with
too. Also, 1.2.4 work fine here (without patch)."

>   I think if we were to do this we probably need to teach
>   format-patch to optionally do multi-part.  We may not
>   necessarily want to mark the payload to be in the same
>   encoding as the commit message (not that git-apply cares -- to
>   it, the payload is just 8-bit unencoded text, but we would
>   want to protect it from getting mangled by e-mail transport). 

I'm not sure about that. The payload is patches, isn't it? That's just
text, too -- we aren't going to deal with diffs of binary content very
well _anyway_, are we?

Obviously, there's nothing to stop people from storing binary blobs in
GIT, but unless you want to start sending actual _blobs_ as attachments
instead of sending patches, I think there's no need to play with MIME
multipart stuff.

I've no particular objection to it, but it's a separate issue to
Bertanrd's. That's a bug-fix, while multipart is an RFE without much
point, IMO.

-- 
dwmw2
