From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git-send-email: allow edit invalid email address
Date: Mon, 26 Nov 2012 15:50:30 -0800
Message-ID: <7v7gp7q5yx.fsf@alter.siamese.dyndns.org>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
 <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
 <7vobikthpp.fsf@alter.siamese.dyndns.org>
 <20121126173318.GA12101@shrek.podlesie.net>
 <7vhaocotsd.fsf@alter.siamese.dyndns.org>
 <20121126233337.GA31100@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:50:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td8Rs-0006hv-VE
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab2KZXue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:50:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076Ab2KZXud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:50:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E574F9D6F;
	Mon, 26 Nov 2012 18:50:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oRQy9OuL6IXJvXqTOMUyDozST0Y=; b=MlSP2b
	qaG4ypORAZ/1cY7n1mgrT/g5Xes7uXE+bYo5X4W5bAP7Wkbp3qjcBowdqQUBuBam
	OcBIqddCCmayfumGi7t29/n8dl4K74db70g0NuW3Qqh5o2T8c6/emEjVIhWxlXiX
	VCzgFOmF1YkChr+cHu5Hi4LlGQvoqDjdFw/iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EzYTSALREPiV85VOspDAVUO8D7e5v/cu
	92SYM3sSBIBD9rp48fEsCNfGW0CF4DtWq/uAr5pynJKIHjJX18lJeWYEKUEtdOmz
	csY1CILYNnJ/OrcnHWyfcCcKSZR17qQcEIEaMYBUPVRSWE/zg/zMqeicepu4jLxS
	cGQ2sJgVvO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D14D99D6E;
	Mon, 26 Nov 2012 18:50:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AF369D6D; Mon, 26 Nov 2012
 18:50:32 -0500 (EST)
In-Reply-To: <20121126233337.GA31100@shrek.podlesie.net> (Krzysztof Mazur's
 message of "Tue, 27 Nov 2012 00:33:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1091C2F6-3824-11E2-95A5-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210518>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> On Mon, Nov 26, 2012 at 02:58:58PM -0800, Junio C Hamano wrote:
>> Krzysztof Mazur <krzysiek@podlesie.net> writes:
>> 
>> >> Not having this new code inside "elsif (/^e/) { }" feels somewhat
>> >> sloppy, even though it is not *too* bad.  Also do we know this
>> >
>> > ok, I will fix that.
>> >
>> >> function will never be used for addresses other than recipients' (I
>> >> gave a cursory look to see what is done to the $sender and it does
>> >> not seem to go through this function, tho)?
>> >
>> > Yes, this function is called only from validate_address_just()
>> > to filter @initial_to, @initial_cc, @bcc_list as early as possible,
>> > and filter @to and @cc added in each email.
>> 
>> Thanks; when merged to 'pu', this series seems to break t9001.  I'll
>> push the result out with breakages but could you take a look?
>> 
>
> Sorry, I tested final version only on an ancient perl 5.8.8 and it really
> worked there. The third patch is broken:
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9996735..f3bbc16 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1472,7 +1472,7 @@ sub unique_email_list {
>  	my @emails;
>  
>  	foreach my $entry (@_) {
> -		my $clean = extract_valid_address_or_die($entry))
> +		my $clean = extract_valid_address_or_die($entry);

Ah, ok, I wasn't looking closely enough.  Thanks for a quick
turnaround.  Will requeue and push out.

>  		$seen{$clean} ||= 0;
>  		next if $seen{$clean}++;
>  		push @emails, $entry;
>
> Krzysiek
