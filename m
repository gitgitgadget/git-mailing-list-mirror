From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 16:52:54 +0200
Organization: Private
Message-ID: <87iq8zc5vd.fsf@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net>
	<m34okjkpq0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 15:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqpBq-0008A8-Dp
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 15:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758319Ab0CNOxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 10:53:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:50056 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758307Ab0CNOxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 10:53:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqpBh-000875-Hr
	for git@vger.kernel.org; Sun, 14 Mar 2010 15:53:05 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 15:53:05 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 15:53:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:GNs41Hn7L/CgbVYR7qVzIDq3xGI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142139>

Jakub Narebski <jnareb@gmail.com> writes:

> Why this duplication?  You have 'eval unless eval unless', with 
> 'eval unless' twice.

A typo after rafactoring the function into 3. Thanks.

>
>> +		    my $domain = Net::Domain::domainname();
>> +		    $maildomain = $domain
>> +			    unless $^O eq 'darwin' && $domain =~ /\.local$/;
>
> I'd like to have a comment about the above line: why it is necessary?

I have no idea. It is used in Perl library Test::Reporter, so I trust it
is necessary for MAC OSX.

>> +	$maildomain;

> It is a matter of style, but unless function is a very simple one, the
> preferred way is to use explicit return statement, i.e.
>
>    	return $maildomain;

In Perl, the last statement's result is the returned value from a
function. Compare:

    $ perl -e 'print  if $_ = do{ 1; }'
    1

Yes, it's a style issue. I don't personally use "return" at the end of
simple functions in Perl.

I'll add the "return".
Jari
