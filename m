From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: log -S with evil merges
Date: Mon, 12 Jul 2010 01:39:50 -0500
Message-ID: <20100712063949.GA6301@burratino>
References: <20100710194838.GA2315@burratino>
 <7v39vpfcte.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYCh6-00014i-Ok
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab0GLGkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 02:40:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52374 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375Ab0GLGkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:40:40 -0400
Received: by iwn7 with SMTP id 7so4323028iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MlZRgaaYa2qjjsfnVYfo3YQpmgtGaTRaOMgcftGCqSc=;
        b=FLHd0SjwBhBUWX83nrXm1AWehzFvFOVeMOja8lliU26qCRZwkoQYRBM0sv8kVKPwzn
         +vIMzzCxebs8za/OTSjuQ6IgkxxqTkMAo13YZEUC7kG0OAz3DepN8pBPCGN/t7x1ZzmQ
         r7GvC2kPgxCDI750xFezVFvwXq3CFHw5pUN9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HBCEOoATRWfMvWt3PtL3G9h2bQlbKOEt/P8/ZD93yH+bI1ZZ7hjN3HBXCfcMRdom3K
         GAx3BHTwW30Znuy/Jg2TbTr7ENuOxHYhSGDrcBHbBWGEE/Sq+fLnbWw8Qdia0jFgzHRF
         68Fz/xGgpdhEgLohyVpG/b79HzWHBJYU8ORUU=
Received: by 10.231.36.9 with SMTP id r9mr13406499ibd.105.1278916839350;
        Sun, 11 Jul 2010 23:40:39 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm18206732ibb.8.2010.07.11.23.40.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 23:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39vpfcte.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150798>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  ; git log --oneline -c -S'UE_ALWAYS' --follow builtin/reflog.c
>>
>> does not work --- it mentions _all_ merges.  Why?
>
> I don't think --follow, which is merely a checkbox item, is friendly to
> most other git features.

Hmm, leaving out the --follow makes it behave again.  Thanks for the tip.

> Does it even show diff with the corresponding
> file at the commit where filename is changed?

 $ git tag lt/deepen-builtin-source 81b50f3
 $ git diff --raw --follow lt/deepen-builtin-source^! -- builtin/reflog.c
 :100644 100644 7498210... 7498210... R100	builtin-reflog.c	builtin/reflog.c
 $ git diff-tree --abbrev -c --follow v1.7.2-rc0~122 -- builtin/reflog.c
 a660534e06147f8867d6c9b6c41025427a7b5c6c
 ::100644 100644 100644 f732156... fafb740... ebf610e... MR      builtin/reflog.c

Looks good to me...
