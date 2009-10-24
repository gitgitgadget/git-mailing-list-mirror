From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 11:17:58 +0200
Message-ID: <20091024091758.GF4615@mx.loc>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
 <20091023202524.GE4615@mx.loc>
 <20091023210648.GA23122@mx.loc>
 <7vocnxajj6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vda.linux@googlemail.com, busybox@busybox.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 11:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1cki-0004HK-DN
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbZJXJR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbZJXJR0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:17:26 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33266 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZJXJR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:17:26 -0400
Received: by fxm18 with SMTP id 18so10908714fxm.37
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=bjQhM2ZZStKi1Z3iQkDUwQYzxBtzB3U1jjgAgJZINbc=;
        b=Vft6/RtCA4TkCOq7KV9vjHQsw9NltjJhJKGoYeV4bwTKXmmUmnCczAIHG5WxZyVdzu
         h/J6qT1WmyF4//ajRwt+PTxOKHjgH2Z6myrKdgkWhcfW8LVbOOToTJ/vz9xoeJC+rPFk
         O2onCedXTjjHnCW2dPgKIwHozGXVv5SCFW4Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W8xTv5TK4f2AgJxqS2jYOJgIwmSIShB825PypsdXnn/66TzUpUMi4mXwHW6h+O4kyg
         1T3ClSYkQMtw1cP+zvRUl6X3Thl7lpaxmf1Mswb6+FV1BiKzjIyQSJWXHedccK8g+aPV
         uaKYWGqfOenV/lOFcpIHIUfmYKc6bSMIs8nrI=
Received: by 10.204.150.76 with SMTP id x12mr3552094bkv.30.1256375849759;
        Sat, 24 Oct 2009 02:17:29 -0700 (PDT)
Received: from s42.loc (85-127-251-67.dynamic.xdsl-line.inode.at [85.127.251.67])
        by mx.google.com with ESMTPS id e17sm3975956fke.26.2009.10.24.02.17.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 02:17:28 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.69)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1N1cl4-0000oe-RG; Sat, 24 Oct 2009 11:17:58 +0200
Content-Disposition: inline
In-Reply-To: <7vocnxajj6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131149>

On Fri, Oct 23, 2009 at 02:26:53PM -0700, Junio C Hamano wrote:
>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>
>> On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>>>On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>>>GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>>>on create, 'o' would be --old-archive.
>>>
>>>FYI this was prompted by:
>>>
>>>Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
>>>
>>>diff -rdup git-1.6.5.oorig/templates/Makefile git-1.6.5/templates/Makefile
>>>--- git-1.6.5.oorig/templates/Makefile	2009-10-11 03:42:04.000000000 +0200
>>>+++ git-1.6.5/templates/Makefile	2009-10-23 21:43:06.000000000 +0200
>>>@@ -50,4 +50,4 @@ clean:
>>> install: all
>>> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>>> 	(cd blt && $(TAR) cf - .) | \
>>>-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>>>+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)
>>
>> argh, sorry! --no-same-owner of course.
>
>Either way, your change would break non-GNU tar implementations that are
>properly POSIX.1, isn't it?

I suppose xf - -o would work?
