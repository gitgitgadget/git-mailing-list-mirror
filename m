From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] for-each-ref: utilize core.warnambiguousrefs for
 strict refname:short format
Date: Mon, 22 Sep 2008 09:27:17 -0700
Message-ID: <7vk5d4xi1m.fsf@gitster.siamese.dyndns.org>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 18:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhoHK-0006qC-LQ
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYIVQ13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbYIVQ13
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 12:27:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYIVQ12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 12:27:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CFCE62455;
	Mon, 22 Sep 2008 12:27:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 495576244D; Mon, 22 Sep 2008 12:27:20 -0400 (EDT)
In-Reply-To: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Mon, 22 Sep 2008 11:09:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5873FAA4-88C3-11DD-811B-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96494>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 9b44092..e7b7712 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -571,7 +571,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
>  /*
>   * Shorten the refname to an non-ambiguous form
>   */
> -static char *get_short_ref(struct refinfo *ref)
> +static void get_short_ref(struct refinfo *ref, int strict, char **short_ref)
>  {
>  	int i;
>  	static char **scanf_fmts;

As far as I can tell this changing of function signature does not help its
existing caller nor the function's implementation.

Why?  And especially why do this in a patch that does something else?
