From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Wed, 23 Feb 2011 08:42:46 -0800
Message-ID: <7vlj16aeih.fsf@alter.siamese.dyndns.org>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie> <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 17:43:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsHnz-0005VF-FL
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 17:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab1BWQnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 11:43:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab1BWQnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 11:43:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A41783370;
	Wed, 23 Feb 2011 11:44:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l/VxjmrVf/6a1Y0mvNcFp07JsUQ=; b=g8hsdB
	kayOV4lzbXnR1Vjo5xAlPOtVFKe9DMLG8eJK48sPP1XZVOKBPyTIgerheIKge2xi
	t8M69fRulAlj55BwVqrkpX6KR+LJndzfQDXgazRSgBFqt8u3njyJeTf5ZnkizViB
	38oB1psVwK1lP3ai5bO8aIYpWThjPD5l9QWlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gy6zqhqtzR5A0eDJx0A9WPK0M0OgtAJK
	XEEldIwIR5zGNL+VN8r4SC0hkkacoxwyZ3+vQTAbgasbdjZevfHRUrK6YoqJeYkD
	kabOA1xVztcG15G7Ttj2SbSZj82AfPIJWubS0FgodMgmfk84GuNSF6VZ3CkI2Eyg
	PTngDagfOa4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 420E2336D;
	Wed, 23 Feb 2011 11:44:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A6153369; Wed, 23 Feb 2011
 11:44:01 -0500 (EST)
In-Reply-To: <20110223045143.GA11846@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 22 Feb 2011 23\:51\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22B34D72-3F6C-11E0-998C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167701>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 22, 2011 at 11:30:41AM -0800, Junio C Hamano wrote:
>
>> > Speaking of Makefiles, one downside to all of this directory
>> > segmentation is that you can't run "make" from the subdirectories.
>> 
>> I had an impression that "make -C lib/" would be one of the goals, iow,
>> when we split the directory structure, the next step would be to split the
>> top-level Makefile so that each directory is covered by its own Makefile,
>> just like Documentation/ is already usable that way.
>
> Ugh. I am not thrilled at the prospect of more recursive make.

Likewise. Notice that I have consistently been unthrilled when people
started talking about splitting the source code tree?
