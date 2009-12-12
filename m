From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] octopus: make merge process simpler to follow
Date: Sat, 12 Dec 2009 12:46:57 -0800
Message-ID: <7vk4wrrkce.fsf@alter.siamese.dyndns.org>
References: <87zl5p1gsp.fsf@jondo.cante.net>
 <1260578339-30750-1-git-send-email-bebarino@gmail.com>
 <200912122056.59297.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdGV-0005De-82
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933438AbZLMB2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbZLMB2p
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:28:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46430 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933420AbZLMB2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:28:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D553EA6EDB;
	Sat, 12 Dec 2009 15:47:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0GapvOnIp9QOi3hs9Ryag4pxkTM=; b=SBqnIH
	8Us9/MCuS4DxB/2LWxWid2Qkwx2vyZxyU6nYhsZ6q1Ne2iZhFg7vPfDhTP2IANd4
	sBeNhaKax4jBlVk+hynIv8mYldHqgytSDEO2yv3oWaa7N4XjJ79oG4Fv6t+0FrMj
	p1fUEXHYDCfURj9mK1lFx//R3NF2T7cit64Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyICiKv2QR6ZeDINnBLAxNm3weoUmsSm
	C2AoTVVkQvNfwamGd1R79Rz+1fG7Rpz//1F4ohDk7JvUdq8Yk981N/lz/Wd6DHNk
	QNq/kxy+uq2AHE60C+d7+RgzBxnfosU/jK41uYWItpNxZeoYFrU451OzEMiwYxFd
	6Hz11qnnQ54=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97F30A6ED9;
	Sat, 12 Dec 2009 15:47:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DE4F1A6ED8; Sat, 12 Dec 2009
 15:46:59 -0500 (EST)
In-Reply-To: <200912122056.59297.j6t@kdbg.org> (Johannes Sixt's message of
 "Sat\, 12 Dec 2009 20\:56\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 828BAB6A-E75F-11DE-9632-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135139>

Johannes Sixt <j6t@kdbg.org> writes:

> On Samstag, 12. Dezember 2009, Stephen Boyd wrote:
>> +	pretty_name="$(eval echo \$GITHEAD_$SHA1)"
>
> 	eval pretty_name=\$GITHEAD_$SHA1
>
> :)

True, and also there can be scripts that call merge-octupos directly
without setting "GITHEAD_$commit", so it would probably need something
like

	: ${pretty_name:=$SHA1}

after that.
