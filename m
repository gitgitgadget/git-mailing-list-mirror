From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 14:25:01 -0400
Message-ID: <118833cc0510241125y4d97821dxc6ea0ca62f659db4@mail.gmail.com>
References: <867jc336f4.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
	 <86irvmzyq9.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
	 <Pine.LNX.4.64.0510241002180.10477@g5.osdl.org>
	 <435D1963.8070205@zytor.com>
	 <Pine.LNX.4.64.0510241054480.10477@g5.osdl.org>
	 <435D21DE.6080404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 24 20:26:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU70O-00088Z-Mw
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 20:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJXSZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 14:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVJXSZE
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 14:25:04 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:61747 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751238AbVJXSZB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 14:25:01 -0400
Received: by qproxy.gmail.com with SMTP id e12so284058qbe
        for <git@vger.kernel.org>; Mon, 24 Oct 2005 11:25:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JeN6740ayXoCwNGcpX1CPUwVJyzxPwrWqOrMdH9/JcO2MS9TfLL2yM7M0xIyDIp70NabaCt18xPLN+RmXeQ9pFmhMu1v8RtMydUkLhu92hBHbLAyLok/Ps2lvhbHWV6WcLZHBPEENfqMEIEa/DpGeFy+TP1BOZdpM6HxJiPZZnY=
Received: by 10.65.147.11 with SMTP id z11mr620206qbn;
        Mon, 24 Oct 2005 11:25:01 -0700 (PDT)
Received: by 10.65.107.12 with HTTP; Mon, 24 Oct 2005 11:25:01 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <435D21DE.6080404@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10553>

Locale issues:

* Environment strings have unspecified encoding.
* File names ditto.  (Which matters when they get printed together with other
  strings.)
* gecos information ditto.

If, and if only, you[*] call setlocale:

* ctype stuff.
* strtod, printf %[efg]
* Regexps

(Integer parsing and printing seems to be safe in pratice if not in theory.)

If you call system() you also need to watch out for things like Gnu sort
being locale sensitive.

Morten


[*] That would be not just you, but also all the yous behind all the
     libraries you link.
