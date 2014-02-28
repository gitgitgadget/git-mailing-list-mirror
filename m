From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/pack-objects.c:write_pack_file() replace tmpname with pack_tmp_name in warning
Date: Fri, 28 Feb 2014 12:05:24 -0800
Message-ID: <xmqqob1rt33v.fsf@gitster.dls.corp.google.com>
References: <1393604774-19480-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 21:05:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTga-0008Lu-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 21:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbaB1UF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 15:05:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbaB1UF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 15:05:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1A5A709C3;
	Fri, 28 Feb 2014 15:05:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+p7PiOBEKiO6IIAZWo5KdE+8RC0=; b=jYNS18
	cYTabc8M7BNHATie9kpbd6gJLqkQwVVIYVJauoWDev74N1iYSeaXM+FBUMJXSlab
	19uHz4ryOo8plD9I4rRRBOb1wSU8BZJyoDDAMFem3n4XITr/Z/6+8gM6sanp68dw
	xBMdCcUgNx782G+N6h7qffXNKko8o9cXAleV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rpinardTl4U6xE6SxHUTQnqtDSjJTp/5
	PYpbRhHQoluHodObICJiTHEKo21KBBat63IkzlJOX4eWGFU+GFMYzawzPLCL6OED
	EmnmsePYMn88aWAYFOawRBxcjcJ/ubeFiJSmiPVLnvU6ZBmpMK76bydQimyFZ0wg
	eXBdfsQtghI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5620709C2;
	Fri, 28 Feb 2014 15:05:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 882DD709BE;
	Fri, 28 Feb 2014 15:05:26 -0500 (EST)
In-Reply-To: <1393604774-19480-1-git-send-email-sunheehnus@gmail.com> (Sun
	He's message of "Sat, 1 Mar 2014 00:26:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA296998-A0B3-11E3-9DA7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243013>

Sun He <sunheehnus@gmail.com> writes:

> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
> The tmpname is uninitialized and it should a bug
>
> Please ignore the former patches about this with wrong format.
> I am sorry to cause a jam in your inbox. ^_^
>
> In the end, I wanna thank Michael Haggerty who give me help.

If you look at "git log" output, you would notice that people write
something like

	Helped-by: Michael Haggerty <mhagger@alum.mit.edu>

before your S-o-b: line for a case like this.

We can see that you are replacing tmpname with pack_tmp_name in
warning without you writing on the subject line.  The commit log is
where you explain *why* that change is the right thing to do.  And
that is totally lacking in this message.


>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..4922ce5 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -823,7 +823,7 @@ static void write_pack_file(void)
>  				utb.modtime = --last_mtime;
>  				if (utime(pack_tmp_name, &utb) < 0)
>  					warning("failed utime() on %s: %s",
> -						tmpname, strerror(errno));
> +						pack_tmp_name, strerror(errno));
>  			}
>  
>  			/* Enough space for "-<sha-1>.pack"? */
