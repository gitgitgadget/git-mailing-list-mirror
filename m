From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: export correctly marks larger than 2^20-1
Date: Tue, 13 Jul 2010 13:31:27 -0500
Message-ID: <20100713183126.GA2458@burratino>
References: <1279021908-21291-1-git-send-email-harinath@hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Raja R Harinath <harinath@hurrynot.org>
X-From: git-owner@vger.kernel.org Tue Jul 13 20:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYkHG-0006NJ-DI
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 20:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab0GMScQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 14:32:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56906 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab0GMScP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 14:32:15 -0400
Received: by pwi5 with SMTP id 5so2416514pwi.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DnEdGHXQSnN87QRBPMe8bS3fkoXgVIT3HFQduy+Q0v0=;
        b=Lb4ytcMZ2MrQrJQY7y5ikazb7Qfzo5m6iDrtLNkojG5Vsh5lqvhmsfgGn2ELh3JTMM
         EV7iH73h/+2DoFhDd/OTVMpSjdUt5lH5BGEWRS8a0jpk3cLP/2m+x4idSE/w7n7fxfho
         v34km6Qin0SedwWykA8mMJJvZs+icQAeIs08Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PpAKRkENY5iYiXodQRr1qYA4GBcf80cW/uftKpxfnFP12m6C8fkm1oX2F3dF2TJkpi
         r7VbyvGGOhLqm6FpTtpyYypZQjOqIwAXHqqhZ4GUMUyCKKlru3owRBW1imVWv88HAGWv
         NpM90RJ7INwlwfLA1cylLawUP9/CeHOHFHAfo=
Received: by 10.142.225.8 with SMTP id x8mr18943724wfg.289.1279045934128;
        Tue, 13 Jul 2010 11:32:14 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm26144433ibh.4.2010.07.13.11.32.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 11:32:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279021908-21291-1-git-send-email-harinath@hurrynot.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150906>

(+cc David, who I think mentioned wishing for something like this)

Raja R Harinath wrote:

> Subject: fast-import: export correctly marks larger than 2^20-1

Thank you!  That would be a very good thing.

> dump_marks_helper() has a bug when dumping marks larger than 2^20-1,
> i.e., when the sparse array has more than two levels.  The bug was
> that the 'base' counter was being shifted by 20 bits at level 3, and
> then again by 10 bits at level 2, rather than a total shift of 20 bit=
s
> in this argument to the recursive call:

I haven=E2=80=99t read or grokked that code you are changing, so I can=E2=
=80=99t
comment on the substance of your patch.  In case no one with such
knowledge turns up, could you give a quick summary of what the
existing code does and why?

Barring that, v1.5.0-rc4~14^2~61 (Added option to export the marks
table when fast-import terminates., 2006-08-25) might be a good
starting point for a person looking to understand.
