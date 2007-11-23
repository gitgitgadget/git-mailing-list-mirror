From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH 4/5] Let git-add--interactive read colors from	configuration
Date: Thu, 22 Nov 2007 23:32:16 -0600
Message-ID: <474665E0.1010104@zwell.net>
References: <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045606.0232fc2d@paradox.zwell.net> <20071122121836.GG12913@sigill.intra.peff.net> <7v63zu3r7h.fsf@gitster.siamese.dyndns.org> <20071122223050.GC3620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 06:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvR9t-0002KS-1E
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 06:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbXKWFci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 00:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbXKWFch
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 00:32:37 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:47596 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbXKWFch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 00:32:37 -0500
Received: by py-out-1112.google.com with SMTP id u77so8300522pyb
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 21:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=rGBr4lfPZ46eg0CYgZI+6VmpBts7Z/2NiFOLmFraSXM=;
        b=jncMUbCEk5Cm3Tm2AK5AMbiMdmmHM4fQxG57vE/rhYSz0u3EiUDgy1a0aDJgC8G4ZL01W5tsO0puWR/oso25y7pbgzvJnVbAgakEqBOS6qXngYQ1SrGIm+6LhUpiFAmbkTHf578l/Hh7Rva0adfd4VpPDM6sPL/d8ccKKlDnKKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=GnwHkJqc1bI6B5+FcLfJDYhtrO7nWtGq7tC66zi2RATuy0+/BzMNQzsGOmouCQHh46nRBveD8n7Em8PBLFSZzSyjGtb6csJHlrFs2EhMlMk/LttCvVhdg4Yey5KWgwOYWfWesids6BrgwtP+QJVZZEpMqFEMG9qnejPsvan7qg0=
Received: by 10.35.65.17 with SMTP id s17mr11313218pyk.1195795956107;
        Thu, 22 Nov 2007 21:32:36 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id n29sm3899375pyh.2007.11.22.21.32.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Nov 2007 21:32:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071121)
In-Reply-To: <20071122223050.GC3620@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65872>

Jeff King wrote:
>>  (2) What should be the second parameter in the form to default
>>      to true?  '1'?  'true'?  Any kind of "true" value in Perl
>>      should be accepted?
>>
>>  (3) Same question as (2) but for defaulting to false.  Any kind
>>      of "false"?
> 
> Hmm. I am tempted to say "yes, any true or any false value" in that the
> point of config_* is to convert git config values to native perl
> representations. OTOH, the moral equivalent of
> 
>   config_color('my.key', 'bold red');
> 
> is probably more appropriately
> 
>   config_bool('my.key', 'true');
> 
> so I am fine doing it that way, as well (though I think it makes us
> duplicate the "translate these strings into bools" code into perl).
> 

As you said, config_* converts git values to perl values. However, that 
conversion needs only be done for strings in .gitconfig. Is there any 
reason why the caller of the function would need to pass a string 
"false"? I just don't see the need for conversion of any kind.

Further, I think that we could return the default variable directly, 
without parsing it at all. It would be much simpler, and there would 
need to be no special cases for dealing with undef or 'false'. It's a 
perl function, being called with perl arguments, so a user should not be 
that surprised when 'false' does what perl says it should do.

Dan
