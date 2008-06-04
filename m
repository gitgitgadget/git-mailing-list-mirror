From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Wed, 4 Jun 2008 22:04:45 +0200
Message-ID: <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
	 <20080604192916.GB17327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 22:06:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zF1-0002gF-OK
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbYFDUEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYFDUEw
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:04:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:19697 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbYFDUEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:04:51 -0400
Received: by wx-out-0506.google.com with SMTP id h29so189944wxd.4
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 13:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=t0jBREl9cuy7JWsHzl4vU5oYwpNr0P8buH6D5oXhzQY=;
        b=BxXTOSTPM8hlPKxhgb5rgpjGbOuXe5CTE4Ih7/P5WTmd08phqLgPe/mkN+9KwiA83k
         9NphwPmFR9482zyMaSQ5dVOXziOoJ8iHU2VMUedoFj/bU5Lqha5fG4aNoeRiuIXoET/n
         /syQEjhONrQfjkc2CjccVINhQggXDC778TPJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=kKk9lEDRSO5lUyc9WVHs5CZrs9CXLye7JZk7sy6xSRyp/J3iv5hscqNU4gE7Z0ktTM
         Kgq+AFI6q4DTyt1QkZJ2yFVkQnx4v1ICDdVGMHRadT/wq7HhnRyTxDyxbGVQc7F6gXUX
         OSbxRwJuJxcMfUySGAtnKaaN+TPO26SBQS3FU=
Received: by 10.70.92.8 with SMTP id p8mr335745wxb.70.1212609890627;
        Wed, 04 Jun 2008 13:04:50 -0700 (PDT)
Received: by 10.70.115.20 with HTTP; Wed, 4 Jun 2008 13:04:45 -0700 (PDT)
In-Reply-To: <20080604192916.GB17327@sigill.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 80361b68ef31534d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83819>

2008/6/4 Jeff King <peff@peff.net>:
> On Wed, Jun 04, 2008 at 08:52:14PM +0200, Jean-Baptiste Quenot wrote:
>
>> Ideally I'd like to feed this list of commits to tig, so that I can
>> watch the commit diff and summary easily and switch from one commit to
>> another.  But tig only behaves as a pager, and does not help for this.
>
> I think there are two issues here, but both are solvable:
>
>  1. You want to see _just_ these commits, but not the whole ancestry
>     chain. In that case, you want to use --no-walk. E.g.:
>
>       tig --no-walk commit1 commit2 ...
>
>     Though it seems there are a few display artifacts. If I do
>
>       tig --no-walk tig-0.1 tig-0.2
>
>     I get the 2 commits I expect, but also two "extra" blank
>     commits at the bottom.

I confirm there are extra blank lines at the bottom.  As many as real
commit lines.

>  2. tig works like a pager when stdin is not a tty. You can work
>     around this by using xargs to give the commits to it on the
>     command line, and then redirect stdin from the tty.
>
>       ... | xargs sh -c 'tig --no-walk "$@" </dev/tty'

Thanks for the suggestion.  However, my list of commits is too long,
the shell errors out with "tig: command too long".  I'd like to feed
tig with a list of commits from stdin, or from a file.

Something like: ... | tig --no-walk -F -

Which means: take the list of revisions from specified file, or here -
for stdin, a la grep.

Cheers,
-- 
Jean-Baptiste Quenot
http://jbq.caraldi.com/
