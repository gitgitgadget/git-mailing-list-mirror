From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed, 06 Nov 2013 12:32:07 -0800
Message-ID: <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Nov 06 21:32:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve9lw-0006OW-Cd
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937Ab3KFUcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 15:32:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423Ab3KFUcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 15:32:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F22E64EE15;
	Wed,  6 Nov 2013 15:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ip0CQLKwlqnh
	9XLeOBWAMGqH5D0=; b=C1j9qiKmqJ/r1RMRhe9kaNbI5YOP22Wqv0EzNUCAmNml
	k48kvFBPmQC1rm4p4zsmXXxPLxAKXqTsPag5+7aYwTnKCrAPxEUNAVot9v1f5ePU
	E3nMJPSeIn2fhsNX+4PaI1gNBxJRIfZRMQRbz8yC6VmWloVk4LysQFbPq9b/E3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qfaxzl
	iq/NGuFjM4bfEGnisM4xToZep97IlQ/EMQtsP/f0D7z9crLbKZ574gGfk+ZlSy4X
	3Q48DE7hMd5wZhTJjc4vEvJsJ0AQSmpwmaFaG574FAzFXV1cXYHeHox4xjEPKDwb
	S2Kv7SB7ZYKaKDPD2RZeIYaOzy1w9P9Paa1tk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28CE4EE14;
	Wed,  6 Nov 2013 15:32:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 423CA4EE12;
	Wed,  6 Nov 2013 15:32:09 -0500 (EST)
In-Reply-To: <1383750263-32495-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Wed, 6 Nov 2013 16:04:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 825C5B18-4722-11E3-B07E-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237367>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Hi all,
>
> This comes as a result of the discussion starting at [0] about
> git-push assuming that a server will always support thin packs. Most
> out there in fact do, but this isn't necessarily the case.
>
> Some implementations may not have support for it yet, or the server
> might be running in an environment where it is not feasible for it to
> try to fill in the missing objects.
>
> Jonathan and Duy mentioned that separate patches for receive-pack and
> send-pack could let us work around adding this at such a late stage,
> so here they are. The second patch can maybe lie in waiting for a
> while.

I'll queue these for now, but I doubt the wisdom of this series,
given that the ship has already sailed long time ago.

Currently, no third-party implementation of a receiving end can
accept thin push, because "thin push" is not a capability that needs
to be checked by the current clients.  People will have to wait
until the clients with 2/2 patch are widely deployed before starting
to use such a receiving end that is incapable of "thin push".

Wouldn't the world be a better place if instead they used that time
waiting to help such a third-party receiving end to implement "thin
push" support?
