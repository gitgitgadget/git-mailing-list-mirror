From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Thu, 23 Jul 2009 22:13:43 -0700
Message-ID: <7v8wievf20.fsf@alter.siamese.dyndns.org>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
 <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 07:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUD6d-00043d-49
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 07:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbZGXFN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 01:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbZGXFNz
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 01:13:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZGXFNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 01:13:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E2C5D11A87;
	Fri, 24 Jul 2009 01:13:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 47AC911A86; Fri,
 24 Jul 2009 01:13:48 -0400 (EDT)
In-Reply-To: <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu\, 23 Jul 2009 17\:33\:49 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6E19D6A-7810-11DE-9330-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123900>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/commit.c b/commit.c
> index a47fb4d..ef8e911 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -262,7 +262,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
>  		    bufptr[47] != '\n')
>  			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
>  		bufptr += 48;
> -		if (graft)
> +		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
>  			continue;

Hmm, what is this "if it is negative" check for?  I did not see it
mentioned in the proposed commit log message.
