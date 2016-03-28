From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Mon, 28 Mar 2016 07:35:59 -0700
Message-ID: <xmqqa8li1xgw.fsf@gitster.mtv.corp.google.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
	<CAKqreuyrENgmB+a7eAHNx9fA4RsQu2PwjLV1wc2z7=kzNTseUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 16:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akYHB-0007dE-3n
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 16:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbcC1OgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 10:36:12 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbcC1OgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 10:36:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 188D34F069;
	Mon, 28 Mar 2016 10:36:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DQebdaruXTQh
	Bqd3/5KWAXu2610=; b=N1yZvxUyZPiRGpu0rbVD1ntgHS7v3OuelC466DPHKK5/
	+hwz+Ekb+OXeWrcg/dZkzKoVlfPihHNtkPgHQyFK64vw6m8F0N9klPFN9oXV9cqt
	KyA8VNfsX54SmsHAz80PG9SYVzFjLvnSv0ZHR6xin27EHkmkCYCmZ7fYf/m8aWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Vuswg1
	v4pckPdVzcT/GAE9IO6kk9JJPdwR1CuNN+oPYvKEzfauBCGGMdug/uYSfFtIBN89
	HQECrIJL/I8mtbj8oYmx82vzcx0fUABn4WfCfCw2hy6l5do3vNKOLa67n1TePxMI
	ec3xIGFJkw2nUfIsD/5xpdIw4eOvtdoyRf2+4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0EE3E4F063;
	Mon, 28 Mar 2016 10:36:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7FC4C4F062;
	Mon, 28 Mar 2016 10:36:08 -0400 (EDT)
In-Reply-To: <CAKqreuyrENgmB+a7eAHNx9fA4RsQu2PwjLV1wc2z7=kzNTseUw@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Mon, 28 Mar 2016 21:37:55
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68FDEDC8-F4F2-11E5-BDA9-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290036>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

> Excuse me, but I could not find
> `Documentation/technical/api-strbuf.txt` in master branch. Do you
> refer to the header of `strbuf.h`? In which, I learnt how to
> initialize the strbuf and how to take use of it when I began to
> use it.

Ah, yes, it was a relatively recent development that usage text from
the former was moved to the latter.

> If there is also a note about whether I should release it
> and how do it, such as:
>
> For every strbuf that has been initialized and buffer of it has
> not been detached with strbuf_detach, you should release the
> resource by strbuf_release.
>
> It will save me (maybe others) much time to explore the entire method=
 list.

While it may not hurt, it sounds somewhat extreme and funny me, as
it sounds as if you are saying "for every pointer variable that
points at a piece of memory allocated with malloc(3) and friends,
you must free(3) them after you are done".

The way _release() refers to its internal resource usage could be
improved, I guess.  "Release ... the memory it used" may not click
as freeing the memory to some readers.

 strbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index f72fd14..a783f09 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -82,7 +82,7 @@ extern char strbuf_slopbuf[];
 extern void strbuf_init(struct strbuf *, size_t);
=20
 /**
- * Release a string buffer and the memory it used. You should not use =
the
+ * Release a string buffer and free the memory it used. You should not=
 use the
  * string buffer after using this function, unless you initialize it a=
gain.
  */
 extern void strbuf_release(struct strbuf *);
