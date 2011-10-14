From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bundle: add parse_bundle_header() helper function
Date: Fri, 14 Oct 2011 11:14:55 -0700
Message-ID: <7vsjmvzbhc.fsf@alter.siamese.dyndns.org>
References: <7vpqi034l0.fsf@alter.siamese.dyndns.org>
 <7vliso34gc.fsf@alter.siamese.dyndns.org>
 <CABURp0otqxeKjLe-Rk3htZRa0M7+rerfrbVrXx-7Dr1tK3tTTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Phil Hord <hordp@cisco.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:15:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REmHe-0002mN-Cs
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab1JNSO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 14:14:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457Ab1JNSO5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 14:14:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12BC4695D;
	Fri, 14 Oct 2011 14:14:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zJ/NPQCH9f5L
	jpQ5xFzrVtDA4ic=; b=PihD/JbQ32AV9tK2EVJUv8DDllSrjk6/YYwySHinZCK7
	JI+Imtn0J73vbpRsfTnPRm/Nlr3oi3ResrUTGb8btpIFNmnlj70TnoBWB5y5LZkQ
	r8mxuHnfLq2A+dHmx3QrHteH53LWPq6cEMIhBDxoO31GpMeSBRXnhtu4EGinfb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oPgySe
	hTa9tci/WKzEzhfHxRx1rZINf3BZoHvJ2k4luax3+uFtShQxkNUDTezXl0/qQxfu
	RMVgJ0zG98dSpO54kn/xTzWvQNJIdQ6FGu4KXKwEUs0NjeHTEDE7kZ4kk2LfKJfe
	vbXnjRwlb8uoW67CTPgmw7PwIDmRkCDDFLdc8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC2F695C;
	Fri, 14 Oct 2011 14:14:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93A79695B; Fri, 14 Oct 2011
 14:14:56 -0400 (EDT)
In-Reply-To: <CABURp0otqxeKjLe-Rk3htZRa0M7+rerfrbVrXx-7Dr1tK3tTTg@mail.gmail.com> (Phil
 Hord's message of "Fri, 14 Oct 2011 08:59:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BD8214A-F690-11E0-A8A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183592>

Phil Hord <phil.hord@gmail.com> writes:

> On Thu, Oct 13, 2011 at 6:35 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Move most of the code from read_bundle_header() to parse_bundle_head=
er()
>> that takes a file descriptor that is already opened for reading, and=
 make
>> the former responsible only for opening the file and noticing errors=
=2E
> ...
>
>> =C2=A0* It generally is a bad practice to base a non-RFC patch on an=
 RFC one,
>> =C2=A0 but in any case here is how I would do the is_bundle() helper=
=2E
>
> I didn't label it RFC,...

I was referring to the fact that _my_ 2/2 you are responding to was mea=
nt
to be applied on top of _my_ 1/2 that was marked as RFC.
