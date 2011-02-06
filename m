From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Add --suppress-to
Date: Sun, 06 Feb 2011 12:28:09 -0800
Message-ID: <7vr5bkx606.fsf@alter.siamese.dyndns.org>
References: <1290272809.27951.30.camel@Joe-Laptop> <m2mxp3zr88.fsf@igel.home>
 <1290286877.31117.15.camel@Joe-Laptop> <4CE84FF3.2070906@pcharlan.com>
 <1290294365.31117.40.camel@Joe-Laptop>
 <7vmxowq6gz.fsf@alter.siamese.dyndns.org>
 <1290807268.11971.310.camel@Joe-Laptop>
 <7vk4jzpq8h.fsf@alter.siamese.dyndns.org>
 <1296949208.4133.66.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 21:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmBDb-0005Nb-3s
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 21:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab1BFU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 15:28:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1BFU2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 15:28:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBB66324A;
	Sun,  6 Feb 2011 15:29:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CAdsuTcQD2rqaEPIXp/UyFsF82g=; b=O4xj06
	YNcVTvRmuoPWNd8UiMYuydVINVyFzu+LFiPAitzt/Jw9A/WsnmwuX0qCafWOn+rd
	ElwTWooDMkCVrIdGW/vRG+Fm0F7XnAJ0GsKGgNm1Uajj+h1+6beE7Wc7xREDudzC
	2hDqkuh68kjP2R5GXmVWGdhXpM24OtpFUzGgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BilwyfiP+s67xra0+p77u8GWpTy2Pddg
	Y6zFkxFfYi4qVTZSGBpNvSceIW0wqSZBKRu9NbfnHDCCLJTP5jgrQdX4V9+4gJQt
	qYmjCr25jj7CMUyPk3cAwuvq5W/lNqVuCPcVVMnXsO+Zq2kBBELdie8chBktkIIw
	S81QQcBBbd4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA5063241;
	Sun,  6 Feb 2011 15:29:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BDBDD323F; Sun,  6 Feb 2011
 15:29:06 -0500 (EST)
In-Reply-To: <1296949208.4133.66.camel@Joe-Laptop> (Joe Perches's message of
 "Sat\, 05 Feb 2011 15\:40\:08 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0A36AB6-322F-11E0-8BCF-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166197>

Joe Perches <joe@perches.com> writes:

> +- 'author' will avoid including the patch author
> +- 'self' will avoid including the sender
> +- 'tocmd' will avoid running the --to-cmd
> +- 'bodyto' will avoid including anyone mentioned in To lines in the
> +   patch body (commit message) except for self (use 'self' for that)
> +- 'all' will suppress all auto to values.

Is there a definition of what an "auto to value" is somewhere?  "auto cc values"
was sort of understandable as there is no word "cc" (other than 1/1000 litre ;-)
and what it meant was guessable from context, but it took me a few seconds
to realize you meant "To:" with this.

> +--
> ++
> +Default is the value of 'sendemail.suppressto' configuration value; if
> +that is unspecified, default to 'self' if --suppress-from is
> +specified.
> +
>  --suppress-cc=<category>::
>  	Specify an additional category of recipients to suppress the
>  	auto-cc of:

Hmmm, from a cursory look I don't see how bodyto is handled and where.

> @@ -1201,6 +1227,9 @@ foreach my $t (@files) {
>  			}
>  			elsif (/^To:\s+(.*)$/) {
>  				foreach my $addr (parse_address_line($1)) {
> +
> +				    next if $suppress_to{'author'};

Is "To: somebody" in the output guaranteed to name the author and nobody else?

> +				    next if $suppress_to{'self'} and $author eq $sender;
>  					printf("(mbox) Adding to: %s from line '%s'\n",
>  						$addr, $_) unless $quiet;
>  					push @to, sanitize_address($addr);

> @@ -1269,7 +1298,7 @@ foreach my $t (@files) {
>  	close $fh;
>  
>  	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
> -		if defined $to_cmd;
> +		if defined $to_cmd && !$suppress_to{'tocmd'};
>  	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
>  		if defined $cc_cmd && !$suppress_cc{'cccmd'};

I think it is about time to make this a bit more readable by explicitly
using if statement, not statement modifiers.
