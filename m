From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 0/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 09:23:59 -0700
Message-ID: <xmqqk2jt36u8.fsf@gitster.mtv.corp.google.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:24:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asYRh-0001oV-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 18:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933310AbcDSQYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 12:24:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932482AbcDSQYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 12:24:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B3E9B12614;
	Tue, 19 Apr 2016 12:24:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FDJbGaakDEjAEqb6vlH151IJ2N4=; b=QOLfV4
	OdAC/aEVZiHvX+KRek5fPi/b9XB80kjPPHbGsPXyuZCY2DhE8g5fBYlzBOkSoF4F
	Mys17g5TCeBemTh3PK5RIpqI2p7KZmZ+UOwQSs6Df00cBQRQrjCzHz4EQyHQzvJ+
	kUywKDe3chhNYL3jhEaIKJWd4ob2wsDe6CEio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DUtBr1v+JWNEgsPy2zGNqILVCJvjuV5x
	2AWbLvzN8XLeYTaq+46NeEz4xzqS82IkR1oyJ0LcUcpSWRceKvfxokpBlNIBk/Pt
	qbSpPfGU/OdYaUi33qYOe8UvtNokydAJCgC+7tPXQYFdoHlGHj70VhpyU1DdfFGm
	LrAL5Fw8Bbc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BEBB12613;
	Tue, 19 Apr 2016 12:24:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 798C812612;
	Tue, 19 Apr 2016 12:24:00 -0400 (EDT)
In-Reply-To: <1461079290-6523-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 19 Apr 2016 08:21:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FAD7FE8-064B-11E6-836D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291878>

Stefan Beller <sbeller@google.com> writes:

> Thanks Jeff for pointing out issues in the comment!
>
> Thanks,
> Stefan
>
> diff to origin/jk/diff-compact-heuristic:
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5a02b15..b3c6848 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -515,12 +515,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>  		}
>  
>  		/*
> -		 * If a group can be moved back and forth, see if there is an
> +		 * If a group can be moved back and forth, see if there is a
>  		 * blank line in the moving space. If there is a blank line,
>  		 * make sure the last blank line is the end of the group.

I guess this is mine to blame.  Thanks for catching and rerolling.

Will re-queue.
