From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to keep git-fetch from running out of memory?
Date: Sun, 15 May 2011 13:25:22 -0700
Message-ID: <7vboz3pv7x.fsf@alter.siamese.dyndns.org>
References: <BANLkTinnOTr+PUzBMpx1DLcxs8CVWjy33A@mail.gmail.com>
 <BANLkTinRkePRMQzQS7k=3bSTxTJRVpG39Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kartik Agaram <ak@akkartik.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 15 22:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhsg-0007fB-PV
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab1EOUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:25:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab1EOUZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:25:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 227985076;
	Sun, 15 May 2011 16:27:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJAiXl77fT8yy/D6fOgwJwAPa98=; b=rwFmDa
	qgzF/7lG1CNtGODEtDSXahpg9FQRMPHwEU9V38v3xyo/cQ0/cNdeY2ghgRwt9qv3
	U63JLFL6FnwwmrHqzaT4n6HmHdZh104dhL9cILWEmudsMIfYJrddFbr1KwhMAtzE
	ja+jO7L77g+Bd6U73c5t24Niu7oQ5/uw6fSCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I1x3FxDhhWutmsUqvva3AciT46JIuPav
	ZaB8OwqFCZw9LJRPeJnjgythK6peXiCWvWFKGrgItD2T4Gi9K77XLONY7V/NNj7D
	gnF2edzLE5f6yuB9bNWmm76VImQrLBszueeg0ugDOL+ZAR1O5tQzjNS22+C8WjLj
	eQCX2UdZSgk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBA9F5075;
	Sun, 15 May 2011 16:27:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 85F685071; Sun, 15 May 2011
 16:27:30 -0400 (EDT)
In-Reply-To: <BANLkTinRkePRMQzQS7k=3bSTxTJRVpG39Q@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 15 May 2011 12:13:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C481942E-7F31-11E0-96F0-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173661>

Shawn Pearce <spearce@spearce.org> writes:

> However, that may still be insufficient. A big object must still be
> allocated in memory in order to compute its SHA-1.

I wonder if we can stream this?
