From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 07 Apr 2010 09:17:16 -0700
Message-ID: <7v8w8zdypf.fsf@alter.siamese.dyndns.org>
References: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
 <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
 <20100407144555.GA23911@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:17:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXwf-0005tP-PW
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab0DGQRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 12:17:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932539Ab0DGQRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 12:17:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A0EA8203;
	Wed,  7 Apr 2010 12:17:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MJ9cWSJVRoRUestxX7Cm2sQYtv4=; b=PUxEAl
	UStSuLIzLH108Is22GJJxNLnJH/v8PCEFCD+DNSzitq6EphD9gf2wpiQd1SlZmrm
	DgNfx59r4rclpWzgPzhjBX6V71oLnv/VWCjoXrJrCzdp314hpUMNHQ1NW8oToi1z
	+b5I9I6ODzIF1gFbn+U3Z1zRXSTlSiJWFzwEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbNnTELpMywhIXPDTW08vDls2PhDsqFE
	gP2ID0zCMKoITLhZ4rPykpXdF3T35l3MtALqiHTZX8iBBNePi496pnGHSjByMwIf
	UiygMxqcxjCq1CLti/HQZXCIYh3A1mLDX5GnB9QWbKOaBVC8+4MniYjTXxfIybLj
	XXJXGFvlTpY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E92EA8202;
	Wed,  7 Apr 2010 12:17:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93A21A81F9; Wed,  7 Apr
 2010 12:17:17 -0400 (EDT)
In-Reply-To: <20100407144555.GA23911@fredrik-laptop> (Fredrik Kuivinen's
 message of "Wed\, 7 Apr 2010 16\:45\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0CF3E702-4261-11DF-AC85-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144246>

Fredrik Kuivinen <frekui@gmail.com> writes:

> As I mentioned in another mail in this thread, our mutex
> implementation on WIN32 already is recursive.

Good ;-)
