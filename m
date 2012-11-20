From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 11:28:39 +0100
Message-ID: <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
	<20121119151845.GA29678@shrek.podlesie.net>
	<7vk3thxuj2.fsf@alter.siamese.dyndns.org>
	<20121119225838.GA23412@shrek.podlesie.net>
	<CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
	<7vlidxuowf.fsf@alter.siamese.dyndns.org>
	<20121120073100.GB7206@shrek.podlesie.net>
	<20121120075628.GA7159@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Felipe Balbi <balbi@ti.com>,
	git@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 11:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tal4Y-0006Aw-UT
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 11:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab2KTK2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 05:28:41 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56452 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab2KTK2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 05:28:40 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5742277oag.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IjwdzgeDTrhjcVFSXRg/uG8xSJPi1eHrz/uaVJbYPvM=;
        b=KIRup+t3UuqE/VDT7yuVdGHFEhrtpha1ACRDd4jg1UcfQ+rkvGyfJiZfqIx+4zInQu
         MZkElu1YEj8yE1b+Ns2BHUEKsKNPF4mR630yOn3W9BRvfCdYUd8OQjttq6/pUQ67Wr+H
         n/Gz5GLKAyP/UhWYROy3IY+6HNSlZBmLpi2Ofd8fhbAFA81bFZjFTFRzdzmwPP7u9uce
         oUeuFkKI7Jb/J0102Ef/l2MMeNKUbYmIPi0r3mVTK6zTdDpDrPaZD+69b79lCOekr1H1
         qNTdSU4bMLUjzWN1sQnbpLK76vEQOuWhLxiRJw2TTuhLfnUAfjDkC1ILUFAp/DHaxF7a
         ojDg==
Received: by 10.60.6.38 with SMTP id x6mr3178254oex.9.1353407319655; Tue, 20
 Nov 2012 02:28:39 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 20 Nov 2012 02:28:39 -0800 (PST)
In-Reply-To: <20121120075628.GA7159@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210089>

On Tue, Nov 20, 2012 at 8:56 AM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -925,8 +925,11 @@ sub quote_subject {
>  sub sanitize_address {
>         my ($recipient) = @_;
>
> +       my $local_part_regexp = qr/[^<>"\s@]+/;
> +       my $domain_regexp = qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
> +
>         # remove garbage after email address
> -       $recipient =~ s/(.*>).*$/$1/;
> +       $recipient =~ s/^(.*?<$local_part_regexp\@$domain_regexp>).*/$1/;

I don't think all that extra complexity is warranted, to me
s/(.*?>)(.*)$/$1/ is just fine.

Cheers.

-- 
Felipe Contreras
