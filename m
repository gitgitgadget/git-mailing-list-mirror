From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sun, 25 May 2008 00:23:27 +0200
Message-ID: <200805250023.27440.jnareb@gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <m34p8o4ijg.fsf@localhost.localdomain> <20080524195753.GB3745@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Govind Salinas <blix@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 00:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K02AK-0006Cs-BJ
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 00:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761841AbYEXWXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 18:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762089AbYEXWXg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 18:23:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:31611 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761667AbYEXWXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 18:23:35 -0400
Received: by ug-out-1314.google.com with SMTP id h2so141398ugf.16
        for <git@vger.kernel.org>; Sat, 24 May 2008 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=aodMZvAzR4ccevb2Dz3B79olEhvjL5WAwT8L0Oi727Q=;
        b=UC/VTYtvBDH48cxjJ45db6tyTO5SYkc70r7TUJ+kM/+is29CSeHvrf7CcTrehTeSapaIpipvHbOOgooUsGT6VkyuEa7fNCen/5xhq6SfkcDSelPcWaHpJwptwSkWmjFGyF1V7miP1fakYcTiuEPqUm4zOGp6rUgi2HV86qR+mWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pBVwH6GpjXiFEN8/L1FbpCH09JE8uyHosoIdn/Fe1FO8x5OZ7bLlklAh2YigfGSLXYJRVWZjupV5cqB25H+EXEStH33+RMbshqbrnWWYGHpRGcYAwtm/6ThFnnWU2Ft7o0DD/ZrtXBGspJHwV7O05hN4d+jP/TqtCujNOJ9+bno=
Received: by 10.67.116.11 with SMTP id t11mr2973322ugm.61.1211667813151;
        Sat, 24 May 2008 15:23:33 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.233.1])
        by mx.google.com with ESMTPS id y37sm7967454iky.8.2008.05.24.15.23.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 15:23:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080524195753.GB3745@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82836>

On Sat, 24 May 2008, Dmitry Potapov wrote:
> On Fri, May 23, 2008 at 06:07:34PM -0700, Jakub Narebski wrote:
>> 
>> On the other hand the a..b and a...b notation is matter of convenience
>> (it is easier to use than "b ^a" or "a b --not $(git merge-base a
>> b)"); perhaps allowing a..b and a...b notation for git-diff was an
>> error... but it makes copy'n'paste easier...
> 
> I believe that the error was how these operations were defined for diff.
> I would rather expect to 'git diff a..b' to produce the accumulative
> patch of 'git log -p a..b', but currently 'git diff a..b' is equivalent
> of 'git diff a b', and this is redundant and confusing. 

I think "git diff a..b" and "git diff a...b" (which is cute hack) were
created to allow copy'n'paste from git-fetch result messages, not only
to git-log but also for git-diff; note that in case of git-fetch
messages a..b is always fast-forward (a = merge-base a b).

I think that both solutions for "git diff a..b", be it "git diff a b"
or "git diff $(git merge-base a b) b" can be argued for, soe historical
reasons (a...b was added later) and backward compatibility wins.

> As to 'git diff a...b', it would be nice if it showed three way diff.
> At least, it is how I would define them if I were writing some
> front-end. 

At least "git diff --cc a...b" and "git diff -c a...b", i.e. diff as
if there were a merge... although now that I look at it it seems to
be more difficult than on first glance.

-- 
Jakub Narebski
Poland
