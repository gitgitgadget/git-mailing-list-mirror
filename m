From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] merge-recursive: add hint for translators in
 handle_change_delete()
Date: Mon, 06 Aug 2012 12:07:58 -0700
Message-ID: <7va9y7zvn5.fsf@alter.siamese.dyndns.org>
References: <1344189332-27082-1-git-send-email-ralf.thielow@gmail.com>
 <1344276224-11876-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trast@student.ethz.ch, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 21:08:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SySev-00064Z-QD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 21:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab2HFTIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 15:08:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932380Ab2HFTIC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 15:08:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 664108DAF;
	Mon,  6 Aug 2012 15:08:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UFChHzwSv6YaWbKqEf+N9iiuOxY=; b=FydBPK
	JZxjD+kwZaIc1ZpP9d1z3YaHZLMqM0SEJPwThU+lXWDtxZ2//wB9MqR60zwiZdaV
	x2RptbDPWVYvtRLUtaJsROoF2RuW/X0duNrxwzqd7tzy85/wLmi6cNU5wuuVzKVf
	g/HkVa9O4bEpKTdZ817LufwpZDZk5eeE1ZL14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ro+Aj54xp398gHSnQb1+i+WJLDUkI//x
	AcX9haU8D/gPFOhLwgmY5kOp3luk/J2Le810DKFMOxD4WDdy1VktY9JcDcdN9D1G
	1KR5SO5vDneY6+lEvAc9fQtZI/SsjY8sbTfL4IXkAag9gqmLiLzrpZvXh5e5K20I
	0DsvSpGaMU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45BFF8DAE;
	Mon,  6 Aug 2012 15:08:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65D368DAC; Mon,  6 Aug 2012
 15:08:00 -0400 (EDT)
In-Reply-To: <1344276224-11876-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Mon, 6 Aug 2012 20:03:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A3A8AE6-DFFA-11E1-82B6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202976>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The outputs in handle_change_delete() contain a lot of placeholders.
> This could end up in confusion to translators. Add a hint for translators
> that they can easily understand it without study the code.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> The first version did only explain the first and the
> fourth placeholder. Junio pointed out that the others
> could still confuse translators. This second version
> explains now all placeholders. It differs to Junio's
> suggestion in a modified header and an optional part
> for the other messages.
>
>  merge-recursive.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 8903a73..ca58dcd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1035,6 +1035,20 @@ static void handle_change_delete(struct merge_options *o,
>  		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
>  	} else if (!a_sha) {
>  		if (!renamed) {
> +			/*
> +			 * TRANSLATORS: The next four messages have many
> +			 * placeholders.
> +			 *
> +			 * CONFLICT (
> +			 * %s=<translation of noun "rename" or "modify">/delete):
> +			 * %s=<name of the path being merged> deleted in
> +			 * %s=<name of a branch> and
> +			 * %s=<translation of verb pp "renamed" or "modified"> in
> +			 * %s=<name of a branch>. Version
> +			 * %s=<name of a branch> of
> +			 * %s=<name of the path being merged> left in tree[.][at
> +			 * %s=<name of the path beeing merged was renamed to>.]
> +			 */
>  			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>  			       "and %s in %s. Version %s of %s left in tree."),
>  			       change, path, o->branch1, change_past,

In general, it is a poor strategy to carry already translated words
around and insert them into messages to form translated sentences,
so the way the translation is done for this part of the code needs
to be rethought.

But without such a rewrite, I think this would be good enough
band-aid.

People experienced in i18n should look into a longer term solution,
though.

Thanks.
