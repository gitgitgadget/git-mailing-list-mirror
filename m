From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 01/10] gitweb: Print to explicit filehandle (preparing for caching)
Date: Sun, 7 Feb 2010 22:32:06 +0100
Message-ID: <201002072232.07378.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net> <0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557.1264198194.git.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 22:32:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeEjt-0004wP-Br
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 22:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab0BGVcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 16:32:15 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:36360 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0BGVcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 16:32:14 -0500
Received: by fxm3 with SMTP id 3so6767164fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 13:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mWbFgzwgDnz1WeoxSufLKwwP4qwHHs2jdwPQWSxlrRo=;
        b=fK4urItKl7Yrft1wRVpHgWb3ee/vGkfNMSbVb1qlCrd7wVhloLWvcen7rN10Uc3YZ8
         89wDYR0FLi4MjtlQXH3larAeEvoDdJBXH85mHKVD7LKHHG6aBUvfiDHtdhGEbAqcF92r
         6/B49wEnhhc1x51gtTRQJhIMFiyPR4P4VSaWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=rkduW48vZAds06hkU4RlOp7rDUIDL6uus+LNvBhVwUTnLnET/X5pnes4F1//BJfBJ8
         Fks9eKqjQA16V7/4z18+44fVjfwKfOO14mLHd8zT3iHNw2GBiwzkkhA6BvjEDD7krQ63
         q3EzuQSASbGXGFXJaTSIzvFDSWmVtgb7jedgk=
Received: by 10.223.97.219 with SMTP id m27mr2001313fan.16.1265578333264;
        Sun, 07 Feb 2010 13:32:13 -0800 (PST)
Received: from ?192.168.1.13? (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id p9sm5605379fkb.14.2010.02.07.13.32.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 13:32:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557.1264198194.git.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139257>

On Sat, 23 Feb 2010, Jakub Narebski wrote:

> This means replacing
> 
>   print <something>;
> by
>   print {$out} <something>;
> 
> and
> 
>   binmode STDOUT, <layer>;
> by
>   binmode $out, <layer>;

[...]

> This patch was written _before_ comment from Junio that it would be
> better to simply use
>   print $out <something>;
> and do not try to be too clever.

Actually 'print FILEHANDLE LIST' form is an example of indirect object
syntax in Perl (which for filehandles was present before there were
objects in Perl).  In indirect object notation the "first argument"
must be a name, a scalar variable, or a block (like {$out}).  If instead
of $out there would be something more complicated, we would have to
use block form ('print {$out[$i]} <sth>', for example).

-- 
Jakub Narebski
Poland
