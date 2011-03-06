From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Sun, 06 Mar 2011 14:40:05 -0800
Message-ID: <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org> <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMcq-0003gO-8B
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab1CFWkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:40:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab1CFWkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:40:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5DFD142C7;
	Sun,  6 Mar 2011 17:41:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R0r0FJn2tmkCZe7ZlUDOkPvARRg=; b=mO05Aj
	s5djNxVDZRBonTRdlvMk0ntDBbOh0oU0korSvsgPpDvXKJiUANmv30LpqMuoIsYa
	w35iFM1M+kV/NIzIFADOXlhTeinTGwmIoxgkRkTuoAtRcQZVV5kpr7Z1UKqcaqCk
	E2+SyRAfEtmkl+n5M2BJ0ACP/w6o6w+WuZAUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNA6eqICaY1Uc5iEZHwhggoOLCFfWNb1
	4z3nRPf2GjlQmfEL3dWQgrpkZ4xl1u9ih+ad6ZzSvTYLOzMCIp4QGEqBjnTV3vWB
	EdjwPabO6DYaFSVeiYaYUHXBIz6ed5RIlgjNGzkxgu+zADYzHNspVsd/kMlYRYCQ
	C8E0y92aGfI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DA1942C6;
	Sun,  6 Mar 2011 17:41:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E226A42C5; Sun,  6 Mar 2011
 17:41:32 -0500 (EST)
In-Reply-To: <7vsjuz520w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 06 Mar 2011 14\:15\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5329CAC-4842-11E0-814E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168545>

Junio C Hamano <junio@pobox.com> writes:

> ...
> So here is my exercise for preparing the new code for upcoming i18n.
> Does it look sane?
>
> Do we want a new wrapper similar to _() that would easily make this into a
> noop under NO_GETTEXT in the proposed i18n infrastructure?
>
>  builtin/apply.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index a231c0c..f084250 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2644,7 +2644,10 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
>  			if (apply_in_reverse)
>  				offset = 0 - offset;
>  			fprintf(stderr,
> +				ngettext(
> +				"Hunk #%d succeeded at %d (offset %d line).\n",
>  				"Hunk #%d succeeded at %d (offset %d lines).\n",
> +				(offset < 0 ? (0 - offset) : offset)),
>  				nth_fragment, applied_pos + 1, offset);
>  		}
>  

If we were to do i18n, we would probably need to include something like
the following in the early fast-tracked part of the series, perhaps as
part of the e6bb27e (i18n: add no-op _() and N_() wrappers, 2011-02-22)



 gettext.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gettext.h b/gettext.h
index 6949d73..1510c5d 100644
--- a/gettext.h
+++ b/gettext.h
@@ -23,4 +23,10 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 /* Mark msgid for translation but do not translate it. */
 #define N_(msgid) (msgid)
 
+static inline const char *ngettext(const char *msgid, const char *plu, unsigned long n)
+{
+	/* fallback ngettext() without using libintl */
+	return (n == 1) ? msgid : plu;
+}
+
 #endif
