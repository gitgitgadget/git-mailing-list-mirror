From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Sat, 19 Feb 2011 01:10:36 +0100
Message-ID: <4D5F0A7C.1080507@gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com> <20110218022701.GA23435@elie> <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com> <20110218092518.GB30648@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqaPV-0002PC-QK
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679Ab1BSAKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:10:49 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60505 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755977Ab1BSAKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 19:10:47 -0500
Received: by wwa36 with SMTP id 36so4354423wwa.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=is0j6ps+81dn/WdIkene52MOZaU5ytG3zBqtz9ur7V0=;
        b=iFUTPqzTZQL5ftBT59pkfa+yHLdKhu32iGnMYYgRkOsVed7YotwVUXNfi3iZE0DGzG
         9rLh0ONGPCgUdiS2BQI7uGHnQ7EH9SyjMWEACUogr3siBdLcH7HNquuQhYumofz4U9zk
         hNa5HN9oGDSmvoL6LDnvQzKXNZrGR4kzx4SJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pgT/KE/J6fScZs1adsc2y6j/3PAmMuArI8i0X6QFkjEm6B2r5oeEYbl/VFgMbsewvY
         C39HQDkTnL31ySaNH3AKSkZvxuVLtrVjW/ta+jwJLjf1n3UM9Ja3mgrJfnHkr5LggTEa
         4TmjFQhmWMw+fyMALy275i3nryHkklh/0zarc=
Received: by 10.227.145.17 with SMTP id b17mr1229722wbv.152.1298074245034;
        Fri, 18 Feb 2011 16:10:45 -0800 (PST)
Received: from [192.168.1.101] (akw69.neoplus.adsl.tpnet.pl [83.26.26.69])
        by mx.google.com with ESMTPS id u9sm161449wbg.18.2011.02.18.16.10.43
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 16:10:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110218092518.GB30648@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167235>

W dniu 18.02.2011 10:25, Jonathan Nieder pisze:
> Thanks again for both of your help.  I've put up an updated series at
> 
>  git://repo.or.cz/git/jrn.git flatten-source

Thanks, I like the idea of cleaning the working tree.

I'm not really happy with current layout. In general it is hard
to find anything. Usually I can do "grep term category". In this case
it's not possible because there are no categories. Sources, tests, 
build scripts, objects, user and tech docs are all mixed with each other
and placed in (almost) random locations.


My suggestions - put each category in their own dir/name space:

- sources - developer related files you can hack 

- technical/developer documentation like format descriptions, 
  coding guidelines etc.

- end user documentation like command documentation, howtos, faqs etc

- build result - objects, final binaries, generated documentation etc 
  The advantage besides unclutterting is possibility to have sources on
  read-only medium.

- test sources, probably with test scripts

- build scripts where possible, for example cat-texi.perl,
  install-doc-quick.sh etc

- leave important documentation in top level: 
  * "readme" - introduction/index of repository 
  * "install" - installation instructions,
  * "news" - what's new in this release
  * license etc

The categories may be split into more subdirs if needed.
Some other top directories are of course also needed.


> Changes since the series sent to the list:
> 
>  - put headers in libgit/ with the source files.  I don't
>    know what I was thinking before.

I'd either keep all headers with sources, or put all headers in a separate
directory structure.

As for other changes in jrn.git:

- no need for git.c in top dir - if one wants to hack git then git.c
  is not enough, and the other people don't need it.

- using links is not portable, not all file systems support them
  (the RelNotes link)


Just my .02c

-- 
Piotr Krukowiecki
