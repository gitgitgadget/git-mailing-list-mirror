From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [RFD] Expanded Pretty Format Placeholders Proposal
Date: Thu, 17 Mar 2011 22:00:06 +0000
Message-ID: <1300399206.2004.22.camel@walleee>
References: <1299804441.6220.1.camel@walleee>
	 <1300395454.2004.9.camel@walleee> <7vvczh1lco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 23:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0LEx-0002uZ-6C
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 23:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab1CQWAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 18:00:14 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45484 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab1CQWAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 18:00:12 -0400
Received: by wwk4 with SMTP id 4so560868wwk.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=IcQHjZSrJflysYkCmR28fVwG2V6H1EmngNUxg6E/qZM=;
        b=bt62dsxZLgvDvinS7Qh209XsqaAmdffD738hhkAELKPKm/zQlDC2HR61UtjWqjftRm
         lPE3Ym6xMGAIxp0WtW8k0zFBweRlk3gOrmbbArGwheAdXY3RC/AKNB9w8i2hWKICdcKl
         Hqtw7F42uOWypsaxhA8h23tOfxnEzJwlJVGMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=rQXGMF9Pphe+LP+qMrzwOAfT5zsYlN9JnJia0SJn/oZl4lNv4+qNL3OO9BC6Up7sgJ
         45G9D47R+CDasgWG+xBuuzutVLK8mSaG8xa8MapEA/UjLtv+hWsjG9cBin3J08jM125J
         zlCVQegudWUvmEjk58+pnE50i4F1VXQdYkD3g=
Received: by 10.227.140.77 with SMTP id h13mr278272wbu.217.1300399210598;
        Thu, 17 Mar 2011 15:00:10 -0700 (PDT)
Received: from [192.168.0.2] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id y29sm917515wbd.21.2011.03.17.15.00.08
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 15:00:09 -0700 (PDT)
In-Reply-To: <7vvczh1lco.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169283>

On Thu, 2011-03-17 at 14:35 -0700, Junio C Hamano wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
> 
> > On Fri, 2011-03-11 at 00:47 +0000, Will Palmer wrote:
> > ...
> >> 	%(foo-condition: %(format: %H, aka %h), %H )
> >
> > of course, this conflicts with the need to embed a literal ")" within a
> > sub-format. The simplest option for this would be to either allow %) as
> > an escape, as with %%. Even simpler, of course, would be %x29, but this
> > seems needlessly obscure. The only objection I have to %) is "It's
> > ugly". To me, %(format: "this is a paren: )") is easier to read, but
> > that would just be moving the problem around, adding the necessity of
> > the just-as-ugly-or-moreso %", or alternatively C-style \" and \\.
> > So I think that %) will be the best option.
> 
> I somehow had an impression that you will be using "" to quote strings to
> protect leading or trailing whitespaces, and if you were to support double
> quotes anyway, \" and \\ become a very natural thing to do (so does your
> "close parenthesis inside dq").

I do have double-quoted strings implemented, but in trying to break the
big-ugly-POC patch down into more-manageable changes, I questioned the
need for it when %x20 or the "magic" space-if-nonempty might do just as
well for most cases, so I took it out of the initial patch.

I admit that double-quotes do feel quite natural from a C perspective,
even if they do go against the conventions we've already established for
escaping things in pretty-formats. I'll see about adding double-quoted
string support in a single patch in the series, so it can be evaluated
independently, and accepted/rejected on its own easily.
