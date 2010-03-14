From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 16:41:26 +0200
Organization: Private
Message-ID: <87pr37c6eh.fsf@jondo.cante.net>
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
	<7vljdvp16n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 15:41:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqp0l-0002ys-8s
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 15:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab0CNOlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 10:41:40 -0400
Received: from lo.gmane.org ([80.91.229.12]:35338 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab0CNOlk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 10:41:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nqp0b-0002rt-QQ
	for git@vger.kernel.org; Sun, 14 Mar 2010 15:41:37 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 15:41:37 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 15:41:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:8/qcvdDKClyyoY0XHKrFAzXE/0I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142138>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> +sub maildomain_net
>> +{
>> +	my $maildomain;
>> +	eval "use Net::Domain";
>> +
>> +	unless ($@) {
>> +		eval "use Net::Domain";
>> +		unless ($@) {
>
> Sorry, but I don't understand the reason why you need to check the same
> thing twice.  The original you borrowed from seems to be much cleanly
> written; it essentially boils down to:
>
>     if (eval "require Net::Domain") {
>         my $domain = Net::Domain::Domainname();
>         ...
>     }
>
> without need for separate "unless ($@)", nor doubly nested construct.

Code written like that inside if-statements is pretty bad IMHO. It is
very debuggable, whereas using variables would be:

    >> +	eval "use Net::Domain";
    >> +
                Debug("use Net::Domain", $@);
    >> +	unless ($@) {


But that's my code to maintain, I'll do what is needed.
Jari
