From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5] gitweb: ref markers link to named shortlogs
Date: Mon, 25 Aug 2008 04:44:22 +0200
Message-ID: <200808250444.23305.jnareb@gmail.com>
References: <200808221501.54908.jnareb@gmail.com> <200808250153.31697.jnareb@gmail.com> <20080825020502.GQ23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 04:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXS5L-0005rS-Ug
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 04:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYHYCob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 22:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbYHYCob
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 22:44:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:60817 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYHYCoa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 22:44:30 -0400
Received: by ey-out-2122.google.com with SMTP id 6so146810eyi.37
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pZbIx3wJsqa5wR8fj9mZ3JMcZLBPkZArbmtQnxsG2w4=;
        b=e0r7xs4DHVULcKSdSIDziSrzNW2KWsKAens1nyDYfvVvwdWpr5FPVKWKXtLZ7KkKZh
         HCotTSj1BGy2xFko2S2EAdVNXZYRaaQw5W+ZvEw5VGVwTIb2f9I9fczVh9KGYhrCTeSw
         M8Waw+64hqiIKPfdDddmMqRA/tzGkjZNQUuM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YZ/cc1FnfWqdq6CBVUBqwK2pp+uDaBv9wOSl0q7jJYZBfs05YDiIvuKuifiCjWQTdV
         CqeXew8GjdZeJgfadNqLH09KZXV0OkhpeZZphZnR6W3sy/mnf0SYoy/xPtid3PfdHKER
         lnYW7/cKB5gJ2sH7eCo35rMjN7cyGj4DmKnIo=
Received: by 10.210.71.12 with SMTP id t12mr5903564eba.36.1219632269282;
        Sun, 24 Aug 2008 19:44:29 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.185])
        by mx.google.com with ESMTPS id c22sm3712701ika.1.2008.08.24.19.44.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 19:44:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080825020502.GQ23800@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93588>

Miklos Vajna wrote:
> On Mon, Aug 25, 2008 at 01:53:30AM +0200, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > We strip leading "refs/" in git_get_references(), so $ref does not
> > contain it. I'm not sure of one has to use refs/heads/aaa and refs/tags/aaa
> > to distinguish between tag and head with the same name, or heads/aaa and
> > tags/aaa is enough.
> 
> You can have both heads/master and refs/heads/master, then heads/master
> is ambiguous.
> 
> Given that git fsck will not barf on such a configuration, I think
> gitweb should handle such a case as well.

What I wanted to say was that I am not sure if current

+                     $markers .= " <span class=\"$class\" title=\"$ref\">" .
+                             $cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"),
+                                                    hash=>$ref)}, $name) .
+                             "</span>";

is enough, or should gitweb use

+                     $markers .= " <span class=\"$class\" title=\"$ref\">" .
+                             $cgi->a({-href => href(action=>( $indirect ? "tag" : "shortlog"),
+                                                    hash=>"refs/$ref")}, $name) .
+                             "</span>";

or equivalent (not stripping "refs/" in git_get_references).

P.S. We are interested _only_ in refs shown by git-show-ref.
-- 
Jakub Narebski
Poland
