From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string-list: remove print_string_list, since it is not 
 used anymore.
Date: Mon, 11 Jan 2010 14:51:50 -0800
Message-ID: <7veilwb6gp.fsf@alter.siamese.dyndns.org>
References: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
 <alpine.DEB.1.00.1001112252040.4985@pacific.mpi-cbg.de>
 <7v3a2ccmrg.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001111722150.10143@xanadu.home>
 <a4c8a6d01001111434j18b77b88j525b9acb47c7e100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:52:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUT7K-0001mY-8K
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab0AKWwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994Ab0AKWwF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:52:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0AKWwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:52:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9390F90F86;
	Mon, 11 Jan 2010 17:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nYzKsm8BqbNLDMf+gbqleLVpKh0=; b=GFBjVU
	RFrOzbEuS8wO4yBaF1zf+NyfDZprNJHOpBaeUCga0bXT5b4R9mdlFAkkDAXn5+8V
	8PhSvVF3DH7ipZazYHOc6HiwHoaQUitoFR1QrPLyz3ptr4OK77Dks8Nc4+3d+5Is
	1vkg+3yyLt10EL8+COvdzZvhMwDwfpNCQQnAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8iNEOsGmYywuz4cxhzIEDg+BVayWeEj
	3Y8YIxtJiVI87g6mdp0VroVReIMkV2a6UqqkPu1LaUjCvaJ/NKZUuE7afmYB13cw
	6yd9crvIvojSLQTeLeK+l22qWKSOBAfMbfyfgIaCAPvci1ptOSQLN8ErTWaIOYmV
	9A2HpPv5kGs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DB9D90F84;
	Mon, 11 Jan 2010 17:51:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4168A90F7E; Mon, 11 Jan
 2010 17:51:52 -0500 (EST)
In-Reply-To: <a4c8a6d01001111434j18b77b88j525b9acb47c7e100@mail.gmail.com>
 (Thiago Farina's message of "Mon\, 11 Jan 2010 20\:34\:02 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC580F14-FF03-11DE-9ACC-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136677>

Thiago Farina <tfransosi@gmail.com> writes:

> I can add the comment if Junio is ok with it. Something like this:
> "This functions is for debugging purpose only. Please, do NOT remove
> it."

Something like this should suffice, as I think "Please blah" is just
superfluous.

I don't know if I like "#ifdef DEBUG" better, though.  It will still let
you say "call print_string_list(...)" in your debugger session, and people
wouldn't muck with it even if there is no caller.

diff --git a/string-list.c b/string-list.c
index 1ac536e..793e619 100644
--- a/string-list.c
+++ b/string-list.c
@@ -139,6 +139,7 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 }
 
 
+#ifndef NDEBUG
 void print_string_list(const char *text, const struct string_list *p)
 {
 	int i;
@@ -147,6 +148,7 @@ void print_string_list(const char *text, const struct string_list *p)
 	for (i = 0; i < p->nr; i++)
 		printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
+#endif
 
 struct string_list_item *string_list_append(const char *string, struct string_list *list)
 {
diff --git a/string-list.h b/string-list.h
index 6569cf6..8598257 100644
--- a/string-list.h
+++ b/string-list.h
@@ -12,7 +12,6 @@ struct string_list
 	unsigned int strdup_strings:1;
 };
 
-void print_string_list(const char *text, const struct string_list *p);
 void string_list_clear(struct string_list *list, int free_util);
 
 /* Use this function to call a custom clear function on each util pointer */
