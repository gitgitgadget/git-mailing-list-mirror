From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] Add treap implementation
Date: Thu, 12 Aug 2010 15:44:20 -0700
Message-ID: <7v8w4bpi2j.fsf@alter.siamese.dyndns.org>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino> <20100809215719.GA4203@burratino>
 <20100809221734.GE4203@burratino> <7vhbizu4nq.fsf@alter.siamese.dyndns.org>
 <20100812221115.GJ2029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjgVs-0006ie-47
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090Ab0HLWog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:44:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934000Ab0HLWof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:44:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3544CC795;
	Thu, 12 Aug 2010 18:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=18AuV36vd1vBzuw+JkrW9TRbXZo=; b=ZBWtYk
	QDV0mQO+YhHsYABeZ5275pFlGxpWhgvKtYbGaQg+ruI8AWN26pRZPgR+OVkSro3q
	KD2N5gFu6Ej3gZU2qLoSqu5yvVa8OSwnM3D9zRh+ZHN4Az5D8ykpQhQgOrNcjC+J
	vyOGJZpD0oLa76StAx/+Dicce8VDnHSmHL+FU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pBN8n0rUPEi/gMOFt0OIdxHMxAZCfp8H
	UjN82wW9AWem9GIIuttUIyf3lliZcKHXjaol0fJJhUoyLJTaOPzFVSjMSRBb3zaC
	ylgkCqELTTNWLNQ6uEc3VRmuQRs99FaO0Cuez4gTl5zrgDdpwbbFQu6vxBMDITmY
	di+9zvz47AU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE05CC792;
	Thu, 12 Aug 2010 18:44:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D3EACC785; Thu, 12 Aug
 2010 18:44:21 -0400 (EDT)
In-Reply-To: <20100812221115.GJ2029@burratino> (Jonathan Nieder's message of
 "Thu\, 12 Aug 2010 17\:11\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A1A8564-A663-11DF-B10D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153437>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/diffcore.h b/diffcore.h
> index fed9b15..05ebc11 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -98,7 +98,7 @@ struct diff_queue_struct {
>  		(q)->queue = NULL; \
>  		(q)->nr = (q)->alloc = 0; \
>  		(q)->run = 0; \
> -	} while(0);
> +	} while (0)

This is a _bad_ one.  Thanks.
