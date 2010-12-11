From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for
 -X/--strategy-option
Date: Fri, 10 Dec 2010 20:35:37 -0600
Message-ID: <20101211023537.GA12161@burratino>
References: <20101211005144.GA6634@burratino>
 <7vvd319h50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 03:36:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRFJo-0002eC-Pj
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 03:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab0LKCf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 21:35:59 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43394 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab0LKCf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 21:35:58 -0500
Received: by ywl5 with SMTP id 5so2438839ywl.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 18:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p68Kbe/UkxuXfhbXxQ8pQiGWh7xhlCTcbp0IEz/lGLQ=;
        b=aLN2qsUVJE/KpF6a1h1U6cVW1janfYajEYnTvV2IX98C5xCm6MBakn4GoLCCz7/PAZ
         UyhfP9MC0oUMLpRaLeCHhqTWItZDcOem3+mmpzKE43z2CiJEQ5z6iirip3wW4utl+e92
         wFcTOveEB/srCdaZ5lEblzpLwNBiNN3ZWfdTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ox0HpIVdqUlpge7NUK041gP1OGkyF/iB4+n6oqaW5txrdi4o056t5UwDDpbdTONTnt
         p6gE5wsAwTG4Bk3rmXaYBteitqlGZn6RhZI2X/Mxb4+jXI2Srjtf3hqauKIDFfFh8p3A
         tlcUJymjxEjwrM3bSuWKO3UPZrAvHp/5diLrk=
Received: by 10.236.103.133 with SMTP id f5mr3450789yhg.14.1292034958178;
        Fri, 10 Dec 2010 18:35:58 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id q8sm2337146yhg.1.2010.12.10.18.35.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 18:35:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vvd319h50.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163457>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> 	$ git revert -Xrenormalize old-problematic-commit
[...]
> I guess this can also take "ignore whitespace", which might be a better
> option for this particular use case?

Suppose in olden days you checked in files with \r\n line endings and
now you have switched to \n (attribute "crlf" or "text"), and in
between there was a day in which the line endings were switched.

Now you notice that old-problematic-commit is broken.  If that commit
removed lines (which had \r\n line endings), then even with
-Xignore-space-at-eol, "git revert" will add them back verbatim.  By
contrast, "git revert -Xrenormalize" would add them back in such a way
as to follow the current line ending style.
