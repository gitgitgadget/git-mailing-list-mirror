From: Dan Zwell <dzwell@gmail.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from
 .gitconfig
Date: Mon, 12 Nov 2007 19:39:28 -0600
Message-ID: <47390050.1020907@zwell.net>
References: <47112491.8070309@gmail.com>	<20071015034338.GA4844@coredump.intra.peff.net>	<20071016194709.3c1cb3a8@danzwell.com>	<20071017015152.GN13801@spearce.org>	<20071022164048.71a3dceb@danzwell.com>	<20071023042702.GB28312@coredump.intra.peff.net>	<20071023035221.66ea537f@danzwell.com>	<20071102224100.71665182@paradox.zwell.net>	<20071104045735.GA12359@segfault.peff.net>	<7v640ivagv.fsf@gitster.siamese.dyndns.org>	<20071104054305.GA13929@sigill.intra.peff.net>	<20071110202351.7b4544aa@paradox.zwell.net> <7vve89f6qy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 02:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irkle-0004ZS-KT
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 02:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611AbXKMBk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 20:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757510AbXKMBkZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 20:40:25 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:3067 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508AbXKMBkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 20:40:25 -0500
Received: by py-out-1112.google.com with SMTP id u77so1638692pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 17:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=Q1DJBhGgD0fKc7egJbNTyrKuWeUQ09dXhJW3c8Dsed0=;
        b=hpzo1yHpQrnhOYbA46dRNsQtQXsx0Ic+ttyiwoy1my+GeKO04ME4bxXe07S2L2QPSTU/8ZCWRDoqKTbTBjhL8ZElkUFwr7DUh70I7NbdM+0bLjRZJ3wUXuv4FDPPRvjN/mjxABqm+K/sQuNjEQg16rqeMQb8IXvQVHwkUxBUsOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oYMUbadLsF7YVTOZ5/5mVgZphES95C6Y9laqPGxijAEBK7qxXOo8t5qvzZ6XcPQyiJ5Jk9sJAkqjH7dnooHOIWQORWzOBkP9KSo/e+aXtuABz1bN+wWWb93fCsnRY4xSg7OoTLs47PGxmzWdcFpGzauQJ3tPjH6YC6/wzA0ykdI=
Received: by 10.35.63.2 with SMTP id q2mr6790023pyk.1194918023040;
        Mon, 12 Nov 2007 17:40:23 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id f57sm11488784pyh.2007.11.12.17.40.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Nov 2007 17:40:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <7vve89f6qy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64741>

Junio C Hamano wrote:
>> +			$fg_done = "true";
>> +		}
>> +		elsif ($word =~ /black|red|green|yellow/ ||
>> +			   $word =~ /blue|magenta|cyan|white/) {
> 
> 	exists $color_name{$word}
> 
> with
> 
> 	my %color_name = map { $_ => 1 } qw(black red ... white);
> 
> at the beginning?
> 
I don't see the advantage of doing it that way. After all, we're pattern 
matching. Does using a hash, an array, and a call to map() gain us 
something? I think a regular expression is clearer. Of course, as Jeff 
pointed out, I should have used a whitespace-agnostic regular expression.
+		elsif ($word =~ /black|red|green|yellow|
+			blue|magenta|cyan|white/x ) {

I agreed with the rest of your suggestions, and will implement them in 
the next round of changes, later this week.

Dan
