From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a shallow clone
Date: Thu, 11 Jul 2013 22:53:32 -0700
Message-ID: <7v38rkpbmr.fsf@alter.siamese.dyndns.org>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 07:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWIV-0004Or-1n
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 07:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab3GLFxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jul 2013 01:53:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3GLFxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 01:53:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F43C2A3B1;
	Fri, 12 Jul 2013 05:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pi9eNOmeFDyE
	4GMpMJn89XhaKeM=; b=RjzCOT2WWRIoYO/kg/zuolHL5acYBvJfBdnTTqyE4Mla
	i/VUzz6kCerFYlHYKQY4blO7jy95tfX1NKwZ8SGHhVLwAaNNwYr0v95aW13RYjcL
	lVqxT7v4xSyM9O2lEcjnf5SzVAVox68ybmQGl36D8JaO95ifYXmBg5GxVAxkqFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T8M/tk
	9bv90sWuzFLzgSkX/6y1kSUJydVEHk6/MeQDTM15AQglKPL4S81mFwF8+MENRrqi
	m6jZSO3jkit/qlUH0W8TqFHQVwyj/x9+BFqb2ZEypaw78HHWBuxwffFCayDaVPBP
	Ybleo9sJnxSgP4gWzFT3jTadMjeiOExN14t0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56B1A2A3B0;
	Fri, 12 Jul 2013 05:53:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCA0C2A3AF;
	Fri, 12 Jul 2013 05:53:33 +0000 (UTC)
In-Reply-To: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 12
 Jul 2013 12:37:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6324B956-EAB7-11E2-B7D6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230162>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The document says one cannot push from a shallow clone. But that is
> not true (maybe it was at some point in the past). The client does no=
t
> stop such a push nor does it give any indication to the receiver that
> this is a shallow push. If the receiver accepts it, it's in.
>
> Since 52fed6e (receive-pack: check connectivity before concluding "gi=
t
> push" - 2011-09-02), receive-pack is prepared to deal with broken
> push, a shallow push can't cause any corruption. Update the document
> to reflect that.

Err, what are these lines in builtin/receive-pack.c doing, then?

        int cmd_receive_pack(int argc, const char **argv, const char *p=
refix)
        {
                ...
                setup_path();

                if (!enter_repo(dir, 0))
                        die("'%s' does not appear to be a git repositor=
y", dir);

                if (is_repository_shallow())
                        die("attempt to push into a shallow repository"=
);
                ...
