From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 01/10] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Thu, 08 Oct 2015 21:19:38 +0200
Message-ID: <vpqsi5lkw1h.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:19:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGjI-00022Y-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbbJHTTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:19:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44491 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755526AbbJHTTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:19:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t98JJb2t020619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 21:19:37 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98JJcEq009937;
	Thu, 8 Oct 2015 21:19:38 +0200
In-Reply-To: <1444295885-1657-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 8 Oct 2015 14:47:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 21:19:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98JJb2t020619
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444936778.56624@osidmn+Ono0Js9eLOLHXTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279267>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -134,9 +134,17 @@ align::
>  	`<position>` is either left, right or middle, default being
>  	left and `<width>` is the total length of the content with
>  	alignment. If the contents length is more than the width then
> -	no alignment is performed. If used with '--quote' everything
> -	in between %(align:...) and %(end) is quoted, but if nested
> -	then only the topmost level performs quoting.
> +	no alignment is performed.
> +
> +if::
> +	Used as %(if)..%(then)..(%end) or %(if)..%(then)..%(else)..%(end).

I guess you forgot to replace .. with ... (I think you agreed with me
that it was better).

> @@ -69,10 +72,16 @@ struct contents {
>  	struct object_id oid;
>  };
>  
> +struct if_then_else {
> +	unsigned int then_atom : 1,
> +		else_atom : 1,

Maybe "then_atom_seen" and "else_atom_seen" would be better names. Or
maybe they'd be too long, I leave it up to you.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
