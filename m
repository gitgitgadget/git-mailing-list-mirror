From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-allocation-growing.txt: encourage better variable
 naming
Date: Sun, 06 Jan 2013 12:29:33 -0800
Message-ID: <7v38yenjgy.fsf@alter.siamese.dyndns.org>
References: <20130106152716.GB2396@pacific.linksys.moosehall>
 <1357486505-21357-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trwqy-0007Md-ER
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 21:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab3AFU3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 15:29:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3AFU3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 15:29:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FC41AE28;
	Sun,  6 Jan 2013 15:29:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WlQrIMf47VBXygy9D22AOliATdo=; b=Szq5lm
	28nR3ab/NlZMFUgoKAKgkIG7IR0AyHCv1ZsxYnJMKvDoshGnDWPIz7/pBhndMYYU
	Pqoj2kq6QSNbyzO5FU1tN3ZOcvNMrMKTV2TYSkVqolVnmg8T23ntiTZ4MH+pCKDX
	LlDCf4bYdb81f04K/Ygy5/1V9BAWBKROY/DOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZV730eKJygZrT/pHWh4EjCqsQL/TCTMh
	ArAX2wwSLfUgMk8o2jJA8bdfJ57lp3x4XcnJZJ7NrtayEqcrcHJrCF2TwCRr8lz2
	2pWyZBpBBqZO20WBp8MuzjLZ5jk0uxRrUeapc8tB4MPEaozzNODAp71naB/XZ6Q3
	uLa0vFyGIAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E659AE26;
	Sun,  6 Jan 2013 15:29:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5A8DAE25; Sun,  6 Jan 2013
 15:29:35 -0500 (EST)
In-Reply-To: <1357486505-21357-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Sun, 6 Jan 2013 15:35:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C94FBC40-583F-11E2-ABF1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212837>

Adam Spiers <git@adamspiers.org> writes:

> The documentation for the ALLOC_GROW API implicitly encouraged
> developers to use "ary" as the variable name for the array which is
> dynamically grown.  However "ary" is an unusual abbreviation hardly
> used anywhere else in the source tree, and it is also better to name
> variables based on their contents not on their type.

Sounds good.  To follow "not type but contents", a further rewrite
with s/array/item/ is even better, no?

I can obviously squash it in without resending, if you agree, or you
can point out why item[] is not a good idea and array[] is better.

>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  Documentation/technical/api-allocation-growing.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
> index 43dbe09..3894815 100644
> --- a/Documentation/technical/api-allocation-growing.txt
> +++ b/Documentation/technical/api-allocation-growing.txt
> @@ -5,7 +5,9 @@ Dynamically growing an array using realloc() is error prone and boring.
>  
>  Define your array with:
>  
> -* a pointer (`ary`) that points at the array, initialized to `NULL`;
> +* a pointer (`array`) that points at the array, initialized to `NULL`
> +  (although please name the variable based on its contents, not on its
> +  type);
>  
>  * an integer variable (`alloc`) that keeps track of how big the current
>    allocation is, initialized to `0`;
> @@ -13,22 +15,22 @@ Define your array with:
>  * another integer variable (`nr`) to keep track of how many elements the
>    array currently has, initialized to `0`.
>  
> -Then before adding `n`th element to the array, call `ALLOC_GROW(ary, n,
> +Then before adding `n`th element to the array, call `ALLOC_GROW(array, n,
>  alloc)`.  This ensures that the array can hold at least `n` elements by
>  calling `realloc(3)` and adjusting `alloc` variable.
>  
>  ------------
> -sometype *ary;
> +sometype *array;
>  size_t nr;
>  size_t alloc
>  
>  for (i = 0; i < nr; i++)
> -	if (we like ary[i] already)
> +	if (we like array[i] already)
>  		return;
>  
>  /* we did not like any existing one, so add one */
> -ALLOC_GROW(ary, nr + 1, alloc);
> -ary[nr++] = value you like;
> +ALLOC_GROW(array, nr + 1, alloc);
> +array[nr++] = value you like;
>  ------------
>  
>  You are responsible for updating the `nr` variable.
