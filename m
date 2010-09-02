From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 1 Sep 2010 23:35:00 -0500
Message-ID: <20100902043500.GF29713@burratino>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
 <20100830023812.GA4010@burratino>
 <20100830024020.GB4010@burratino>
 <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 <7v1v9e803a.fsf@alter.siamese.dyndns.org>
 <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 06:37:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or1Xn-0006C0-4j
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 06:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab0IBEgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 00:36:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60618 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab0IBEgx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 00:36:53 -0400
Received: by yxp4 with SMTP id 4so1630444yxp.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BWGUFxxM5tP9LIRts84xToNk5Ca2KmhoJLIXMXRbifU=;
        b=rYQUT9SE51GuaEQDaBuwUV5HK6IkYOLrdUP+sgjXpTscvWW/gyvbLbO2Cu6O1pExW5
         vsykR6p/XPPz+73iUihha0RTHtEG+zjyLiCHdvYSzlY2s6EaU60sYZxqAgTTNhjguKoq
         2ymlQcCih7RFzklg0QaofQd0dFkLsmrDI/iiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Vb5Q3A2RWJzK+CtDbj90MEcX6N40L+ELeK6cJwGGeIRhCOgaP1Pjv6HJrXStNomSeF
         P9gY3kG4OpxpYpaArSicG+CxpPMYYqTKd4nyXso11BiA1cIZkoTOvwUdVaNva0UvqMuX
         rBQyxhp1zhj2hrYLUGfLVZxlNVs6HjSlQ0be4=
Received: by 10.150.7.14 with SMTP id 14mr4721927ybg.215.1283402212530;
        Wed, 01 Sep 2010 21:36:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id d5sm483247ybi.21.2010.09.01.21.36.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 21:36:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155103>

Thiago Farina wrote:

> All patches should just fix real problems?

Yes.

> I think it just makes more sense, since *all* other commands are in
> builtin/ and it's own files.

I was careless before and was not even thinking about

 BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))

Sorry.

With that line in mind, what Junio wrote in the "what's cooking"
message makes a lot of sense.  A good direction to go in long term
might be to freeze the list of built-ins installed to $gitexecdir in
some clean way and avoid adding new ones.

Would you be interested in working on that?  That would solve a
problem (turning back the tide of scripts that use git- commands,
without breaking compatibility) that some people are interested in.
The hardest part would probably be to make sure commands like
"git help version" work properly.
