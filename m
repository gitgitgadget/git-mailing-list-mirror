From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Tue, 2 Jan 2007 23:29:14 +0100
Message-ID: <e5bfff550701021429j1587949fgfe19effcaf74e6df@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701022219050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vps9xrs9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 23:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1s8e-0003Z0-P9
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbXABW3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbXABW3Q
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:29:16 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:3581 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964998AbXABW3P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:29:15 -0500
Received: by py-out-1112.google.com with SMTP id a29so3272315pyi
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 14:29:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HokkpS0VPr4D+tCRfTV6f/6xbqHbcBccDHmSHRN+FGL6zWpZLi30Zhc2+rcMC7wi+Aw14ZNvy/nHfmUqQxmFFZVwpLMCzxIVOiPsXyRw0psJHUB0n3NumKz2ie7JUzDPmkxGWOq90sxyA2UuzezUu+kM+lRb+FgzgvrJM7di8RQ=
Received: by 10.35.39.13 with SMTP id r13mr38565051pyj.1167776954379;
        Tue, 02 Jan 2007 14:29:14 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 2 Jan 2007 14:29:14 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vps9xrs9y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35834>

On 1/2/07, Junio C Hamano <junkio@cox.net> wrote:
>
> > And Marco has to fix the header parsing anyway.
>
> No question about that.  If iconv() punts, qgit will see
> "encoding" header to deal with even when the re-coding is in
> effect.  I think it may be a sensible thing for qgit to replace
> the log message and show "log message in this encoding, which
> cannot be shown in this window" instead in such a case, but that
> is up to Porcelain.
>

Yes, git-rev-list output is stored in memory as a big chunk of row
bytes, conversion
to utf8 (the internal format used by Qt string class) is done _only_
for displayed items, just
before to show them to user so is not performance critical. I agree
with Junio, that info could be used to teach Qt string conversion
function how to handle the data. Something like:

         convertWithCodec(const char* data, codec* codecName)

So perhaps if Qt is better then iconv we could display a good log
message anyway.
