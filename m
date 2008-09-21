From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sun, 21 Sep 2008 12:49:08 +0200
Message-ID: <200809211249.10016.jnareb@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com> <7vzlm21n83.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 12:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhMYC-0007ON-IP
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 12:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbYIUKtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 06:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYIUKtX
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 06:49:23 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:53027 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYIUKtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 06:49:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1091001fkq.5
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=S6uXZChzGari3ju6ZNaZ9dE9mY8YB9WHPoTTEZZewD8=;
        b=UU3z1mMgDqqh+KSxa6bXx+Cq1yVU2Pvx32+eBtcq4DFbxfWcpdmP837uLA9memeNfe
         6LjYDXOKMSSSK/V46jUG0Rs8P4Fy1H44QUWHapICjpJf9tcfKUWuXEI3wfxN3CPfXZgn
         4pkN3UOKRhOdXheiAxkE4s+qpZYKPBtaQVod4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=C1muTVsc7bwpvJHSv45IZ2vKgh855Vs5/yU7FqegvWCa1Utti74Swn12I4KMFZesSH
         ICZ6BV5wGffRrLCt42nueWRKkrMiAnXQqOZjno0I4PP0uXiM7Iu4Vu4+T9TDuuGfSWZV
         jqbNTrEX/cGL31SBOx2RToALGUbzgU7EJRrSQ=
Received: by 10.181.14.13 with SMTP id r13mr1605373bki.42.1221994160387;
        Sun, 21 Sep 2008 03:49:20 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.200.201])
        by mx.google.com with ESMTPS id 31sm757204fkt.3.2008.09.21.03.49.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 03:49:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96388>

On Sun, 21 Sep 2008, Nguyen Thai Ngoc Duy wrote:
> On 9/21/08, Junio C Hamano <gitster@pobox.com> wrote:

> >  How would that --narrow-match that is not stored anywhere on the
> >  filesystem but used only for filtering the output be any more useful than
> >  a grep that filters ls-files output in practice?
> 
> Well, it works exactly like 'grep' internally.
> 
> >  I would imagine it would be much more useful if .git/info/attributes can
> >  specify "checkout" attribute that is defined like this:
> >
> >         `checkout`
> >         ^^^^^^^^^^
[...]

> >  Then whenever a new path enters the index, you _could_ check with the
> >  attribute mechanism to set the CE_NOCHECKOUT flag.  Just like an already
> >  tracked path is not ignored even if it matches .gitignore pattern, a path
> >  without CE_NOCHECKOUT that is in the index is checked out even if it has
> >  checkout attribute Unset.
> >
> >  Hmm?
> 
> Well I think people would want to save no-checkout rules eventually.
> But I don't know how they want to use it. Will the saved rules be hard
> restriction, that no files can be checked out outside defined areas?
> Will it be to save a couple of keystrokes,   that is, instead of
> typing "--reset-sparse=blah" all the time, now just "--reset-sparse"
> and default rules will be applied? Your suggestion would be the third,
> applying on new files only.
> 
> Anyway I will try to extend attr.c a bit to take input from command
> line, then move "sparse patterns" over to use attr.c.

First, I think that this was Junio asking for discussion more than
for changing the design.

Second, while unifying the "check the match" part of gitignore,
gitattribute and sparse checkout would be IMVHO a good idea, I'm
not sure if trying to use/reuse attr.c literally would be a good
idea, at least not without larger surgery.  AFAIK, IIUC gitattributes
have some limitations, one of which that they are read from working
area (and there is no API for reading from tree); although this could
be enough for `checkout' attribute, which is not that different in
work from `smudge' attribute, or `crlf` attribute.

-- 
Jakub Narebski
Poland
