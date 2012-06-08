From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 08:34:55 -0700
Message-ID: <7vr4tpddgg.fsf@alter.siamese.dyndns.org>
References: <4FD0D375.9060902@web.de>
 <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD1162C.50405@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, tboegi@web.de,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:35:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd1DK-0003uW-4s
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761273Ab2FHPe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 11:34:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757781Ab2FHPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 11:34:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB288DE5;
	Fri,  8 Jun 2012 11:34:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oZCX73+FCeHR0YQTHtoATooVTEc=; b=xKvl2u
	ghtlUCN5MvmbO7PocsaajWFwL/R1HtTjzfQmL62N4UMdgIq/U/vC4a4SiPVwiaas
	LE8WnkjjrBOHmCU7cxbijuINTAmZr3E+SHPiXxJACeBO/j8CtRzgQDh70hTyTD2L
	2aMPBK3kezgIYouIlw7xOFhZ69e64f0swEY+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u+8dZAKHBOEeCeadwPCJzOmZlfhfYKJJ
	d4zWEWRvp/SoISe4VKrPw/5Zdv90WCvfyaM2SyN3asSfN5IuBXijL9bfzPwAtwhn
	YicRC+iTp1DJXHUhtX8cUNQRLU+71FCdKQZ6ozmF9wqgEnvRnwIsbVyZw8cNcDVI
	9hDYKyKeq9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D109A8DE3;
	Fri,  8 Jun 2012 11:34:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 688108DE2; Fri,  8 Jun 2012
 11:34:56 -0400 (EDT)
In-Reply-To: <4FD1162C.50405@kdbg.org> (Johannes Sixt's message of "Thu, 07
 Jun 2012 22:59:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8001E48A-B17F-11E1-AC67-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199505>

Johannes Sixt <j6t@kdbg.org> writes:

> How about this?
>
> 	{
> 		first=t
> 		while read -r insn rest
> 		do
> 			case $insn in
> 			pick)
> 				test -n "$first" ||
> 				printf "%s" "$cmd"
> 				;;
> 			esac
> 			printf "%s %s\n" "$insn" "$rest"
> 			first=
> 		done
> 		printf "%s" "$cmd"
> 	} <"$1" >"$1.new" &&
> 	mv "$1.new" "$1"
>
> together with:
> ...

This is my favorite version among the ones I've seen so far.
