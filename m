From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 06:04:41 -0500
Message-ID: <20110620110440.GA29270@elie>
References: <4DFF19C4.5070003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 13:05:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYcHq-0001ge-D5
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 13:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab1FTLEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 07:04:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61057 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab1FTLEu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 07:04:50 -0400
Received: by iyb12 with SMTP id 12so1863473iyb.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kfdtVqzfJgKBbtZI+9WGhm0U+BjsDebjO6ArBjFyny8=;
        b=JwJyacVDoHvblN/rZ+vvcofQtC5udshJVTENo/6JQR2Ln6KROD791myIB/ShqFDl28
         kUvJCGgintmRHvgkvjJLIji0y/Z077Vpf/ALJEI+zzQCkoQdo1Pd4xZVx72fPBT27wci
         d1gj0j9bpLlH90i3kgfsOp2l/wTQcQ5n4NIXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tg0zcZwBx/d4AGNfSguwDBhKE9NKJ8L5rmeH6kQBSkAoGsjKjcT23IrD3yADjRAnqI
         VQeWp9+xhMjylZ/c7ECnT+I/UhnwfTb6YvfoxByNJx+UeVxpB6lo0o6EjC38iNLsDuS5
         IaqU4RPU6bsebUIWezY4Gr0zv11zJ3idjdJYM=
Received: by 10.42.150.8 with SMTP id y8mr6061482icv.471.1308567887693;
        Mon, 20 Jun 2011 04:04:47 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id w11sm3126070ibw.58.2011.06.20.04.04.46
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 04:04:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DFF19C4.5070003@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176062>

Hi Michael,

Michael J Gruber wrote:

> echo "a\"b\n\"c"
> a"b
> "c
>
> t7810.87 breaks with dash because of this. Escaping the \n does not make
> the test work with both either.

This seems to have slipped by because testing it requires USE_LIBPCRE
to be set.  Thanks for catching it.

> So I'd like to know which one's right
> and (independently) how to make it work for both...

Both are right.  The simplest fix is to use printf, as in

	printf "%s\n" "a\"b\n\"c"

See [1] and [2].

Regards,
Jonathan

[1] http://www.gnu.org/s/hello/manual/autoconf/Limitations-of-Builtins.html#echo
[2] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
