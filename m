From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Mon, 19 Nov 2007 23:52:50 -0800
Message-ID: <7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 08:53:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuNvL-0006ss-TS
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 08:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866AbXKTHxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 02:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbXKTHw7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 02:52:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41759 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbXKTHw6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 02:52:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7C8B22F0;
	Tue, 20 Nov 2007 02:53:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B5A195CF9;
	Tue, 20 Nov 2007 02:53:16 -0500 (EST)
In-Reply-To: <1195470026-7389-1-git-send-email-ask@develooper.com> (Ask
 =?utf-8?Q?Bj=C3=B8rn?=
	Hansen's message of "Mon, 19 Nov 2007 03:00:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65531>

Ask Bj=C3=B8rn Hansen <ask@develooper.com> writes:

> Signed-off-by: Ask Bj=C3=B8rn Hansen <ask@develooper.com>
> ---
>  git-send-email.perl |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 65620ab..530b456 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -557,8 +557,11 @@ sub sanitize_address
>  sub send_message
>  {
>  	my @recipients =3D unique_email_list(@to);
> -	@cc =3D (map { sanitize_address($_) } @cc);
> +	@cc =3D (grep { my $cc =3D extract_valid_address($_);
> +		      not grep { $cc eq $_ } @recipients
> +		    }
> +	       map { sanitize_address($_) }
> +	       @cc);
>  	my $to =3D join (",\n\t", @recipients);
>  	@recipients =3D unique_email_list(@recipients,@cc,@bcclist);
>  	@recipients =3D (map { extract_valid_address($_) } @recipients);
> --=20
> 1.5.3.5.561.g140d

How did you prepare and send this patch?

I see 7 preimage lines and 11 postimage lines, although the hunk
header claims otherwise.

Did you edit the patch in Emacs diff mode or something?
