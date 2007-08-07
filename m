From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 21:55:20 -0400
Message-ID: <46B7D108.20606@gmail.com>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>	<11864401942772-git-send-email-mdl123@verizon.net>	<Pine.LNX.4.64.0708062349460.14781@racer.site>	<7vzm149s8s.fsf@assigned-by-dhcp.cox.net> <46B7B10F.4060402@gmail.com> <7vhcnc9lpm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ren Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 03:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIEIP-0003z3-9h
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 03:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764226AbXHGBzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 21:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764173AbXHGBzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 21:55:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:47152 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764134AbXHGBzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 21:55:24 -0400
Received: by wr-out-0506.google.com with SMTP id 36so556380wra
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 18:55:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MlGUIVQ7Dnacyf9K0/WLYex9lyaVOGoEyzDhLCalzYjg8+AuNZ9oSDf2ZyFTmsI6hr+CGCRosDnzG5JMxK6pveLmsUGWctEouQKDm3Dw+/cFcSFXxSimLhBzJSRWmB2tMsBC7D9PpxspvEZCi1NSMZ+ThisovTK5x6QfsNEDS30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Kwk5GRAU4dFxLRxsBN5L7UQeGyTPkRKIVfRQsDZq4rZfVklxq9UWL3Pb2jBTz3MPYOLf2ti0QKOF/Lk7ijF3tWC7Jg/euPjPhreikhn7t3UJyquL5vDsyh0YUZZWQ7RrwcraZS7+kDqfIuRIUXr0MUpALkBRlKguz8D3CFupe8g=
Received: by 10.90.49.1 with SMTP id w1mr5409738agw.1186451723064;
        Mon, 06 Aug 2007 18:55:23 -0700 (PDT)
Received: from ?192.168.100.118? ( [72.66.124.87])
        by mx.google.com with ESMTPS id 6sm8513738agd.2007.08.06.18.55.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Aug 2007 18:55:22 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <7vhcnc9lpm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55197>

Subject:   Re: [PATCH] (Really) Fix install-doc-quick target
To:        Junio C Hamano <gitster@pobox.com>
Cc:        Johannes Schindelin <Johannes.Schindelin@gmx.de>,Mark 
Levedahl <mdl123@verizon.net>,Git Mailing List <git@vger.kernel.org>,Ren 
Scharfe <rene.scharfe@lsrfire.ath.cx>
Bcc:
Reply-To:
Newsgroup:
-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
Junio C Hamano wrote:
 > Mark Levedahl <mlevedahl@gmail.com> writes:
 >
 >
 > How does this sound?
 >
 > ---
 > diff --git a/Documentation/install-doc-quick.sh 
b/Documentation/install-doc-quick.sh
 > index 07d227f..bc170f0 100755
 > --- a/Documentation/install-doc-quick.sh
 > +++ b/Documentation/install-doc-quick.sh
 > @@ -24,10 +24,10 @@ git read-tree $head
 >  git checkout-index -a -f --prefix="$mandir"/
 >
 >  if test -n "$GZ"; then
 > -    cd "$mandir"
 > -    for i in `git ls-tree -r --name-only $head`
 > +    git ls-tree -r --name-only $head |
 > +    while read path
 >      do
 > -        gzip < $i > $i.gz && rm $i
 > +        gzip "$mandir/$path"
 >      done
 >  fi
 >  rm -f "$GIT_INDEX_FILE"
 >
 >

Maybe this instead, many fewer gzip invocations, happily overwrites the 
old man pages already installed...

---
diff --git a/Documentation/install-doc-quick.sh 
b/Documentation/install-doc-quick.sh
index 07d227f..45f78fa 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -24,10 +24,6 @@ git read-tree $head
 git checkout-index -a -f --prefix="$mandir"/

 if test -n "$GZ"; then
-    cd "$mandir"
-    for i in `git ls-tree -r --name-only $head`
-    do
-        gzip < $i > $i.gz && rm $i
-    done
+    printf "$mandir/%s\n" $(git ls-tree -r --name-only $head) | xargs 
gzip -f
 fi
 rm -f "$GIT_INDEX_FILE"
