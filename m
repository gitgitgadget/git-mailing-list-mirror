From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured output
Date: Sun, 11 Apr 2010 13:34:59 -0700 (PDT)
Message-ID: <m3y6gtg24x.fsf@localhost.localdomain>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
	<20100411113733.80010.3767.julian@quantumfyre.co.uk>
	<7vy6gtonwt.fsf@alter.siamese.dyndns.org>
	<91d4c9c4ecdd32166bedb6dc0bd007d6@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Eric Raymond <esr@thyrsus.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 22:35:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O13s8-0003fK-15
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 22:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab0DKUfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 16:35:06 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64171 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab0DKUfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 16:35:04 -0400
Received: by bwz19 with SMTP id 19so55648bwz.21
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=M45eQ3iTofnbLVpHAYOgp5x52+w/Lprk1XSiZ2Ni4sk=;
        b=PRbFd3xbQkghuAD6p+GhoyU/tCHkKWDV2/0CGDQpitD7RhyzAgkSRd5ckmY5VDpjVD
         fkRmvKxwBVBP4maOK9mtuOJ/lVVmZscB1aLsgImcXehqUGJ6rXVwi10BOx4UJe5vpwKw
         1Vyz/tnyCVJluT3iTOIuMlLESsbUA5BwKAkvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=UHOV6U7o6qTMogUBNYb5bXaGyHdkth4iwqeiXxKb1sDNR3G6sZIcXlLH7Nrl4JWG8t
         bni6WpwIrdnSWSa/5BnWbzkt8W+nzhjMavFtlnRLZ9uyjwxnHheHWEM0lUjrEMGP9v30
         +lnXCLFv0YpP2399QWHK/xVQ8IIq22h9qXLXU=
Received: by 10.204.15.23 with SMTP id i23mr3674102bka.106.1271018100694;
        Sun, 11 Apr 2010 13:35:00 -0700 (PDT)
Received: from localhost.localdomain (abwq147.neoplus.adsl.tpnet.pl [83.8.240.147])
        by mx.google.com with ESMTPS id 16sm1466336bwz.5.2010.04.11.13.34.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 13:34:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3BKYIkk012873;
	Sun, 11 Apr 2010 22:34:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3BKXpRA012859;
	Sun, 11 Apr 2010 22:33:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <91d4c9c4ecdd32166bedb6dc0bd007d6@212.159.54.234>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144681>

Julian Phillips <julian@quantumfyre.co.uk> writes:
> On Sun, 11 Apr 2010 11:16:18 -0700, Junio C Hamano <gitster@pobox.com>
> wrote:
>> Julian Phillips <julian@quantumfyre.co.uk> writes:
>> 
>>> Add a library that allows commands to produce structured output in any
>>> of a range of formats using a single API.
>>>
>>> The API includes an OPT_OUTPUT and handle_output_arg so that the
>>> option handling for different commands will be as similar as possible.
>> 
>> I was hoping that the existing low-level -z routines (e.g. "diff-* -z")
>> follow similar enough patterns to have a corresponding output-z.c and be
>> handled inside output.c library.  But that is not a requirement, just
>> "would have been nicer if the original were written that way".
> 
> As the API currently stands, I don't think it would be possible to
> recreate the existing output of -z, as the separator between values is not
> constant.  I haven't really looked into whether the output is completely
> incompatible with structured output though (i.e. could -z be supported by
> adding one or two functions to the API?).

What about the new(ly) proposed -Z output in one of its variants,
namely with single NUL ("\0") as field separator, and double NUL ("\0\0")
as a record terminator?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
