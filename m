From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Tue, 18 Nov 2014 13:28:54 -0800
Message-ID: <xmqqsihgtcyx.fsf@gitster.dls.corp.google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
	<546B2CE0.6020208@alum.mit.edu>
	<CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
	<546BA21C.9030803@alum.mit.edu>
	<xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
	<546BB722.5020901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:29:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqqKi-0001ER-ER
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbaKRV3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:29:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932079AbaKRV3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:29:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 198011FC64;
	Tue, 18 Nov 2014 16:29:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xw4dtztv2yoPF5owXUd77aqnIPQ=; b=c3OnUd
	JwHzNPS2vj38VoyxL0sMGLmxxSMxGY5qWLJSvhSmb+bfVgoo7N1aDVmCu+e/Z/Bz
	3tXVRrFJD/WgWX+dU/nL1uLJnFocrDTFMdiLS6VM4zxroT9I0f/CMd0eoYmiah1/
	GnLha+pAVNOzfW0d4/DnPTPMafbsMUfPgAbNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eMCS2Uq9jVmjBx+8LWpqbKASw+yE9NLH
	iA7xjh5bqvInzYLUK9JN++Thx03ZrC+dxIUf3QVIKSrHKg/eIyT7GTx5HImGfT2w
	dbJvh/qfajt+2EIAh2WrSBzUlBnOwNv3OqcRxhnF4V7MVsob2q6b5MCowFxjqAGF
	dTBDugG62yo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F1191FC63;
	Tue, 18 Nov 2014 16:29:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AFF11FC61;
	Tue, 18 Nov 2014 16:29:02 -0500 (EST)
In-Reply-To: <546BB722.5020901@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 18 Nov 2014 22:16:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA8018FE-6F69-11E4-BDE3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Sorry, but I lost track---which one is inside and which one is
>> outside?
>
> By "inside" I mean the code that would be within the reference-handling
> library if we had such a thing; i.e., implemented in refs.c. By
> "outside" I mean in the code that calls the library; in this case the
> "outside" code would live in builtin/reflog.c.
>
> In other words, I'd prefer the "outside" code in builtin/reflog.c to
> look vaguely like
>
>     expire_reflogs_for_me_please(refname,
>                                  should_expire_cb, cbdata, flags)
>
> rather than
> ... (written as a client of the ref API) ...

OK, I very much agree with that.
