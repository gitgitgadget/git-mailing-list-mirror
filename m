From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] notes: attach help text to subcommands
Date: Fri, 08 Jun 2012 07:49:23 -0700
Message-ID: <7vd359eu4s.fsf@alter.siamese.dyndns.org>
References: <7vobowmjwr.fsf@alter.siamese.dyndns.org>
 <1339145776-20495-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 16:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0VH-00032z-JA
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab2FHOt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 10:49:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2FHOt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:49:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 199558292;
	Fri,  8 Jun 2012 10:49:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45AOOkiI3iKnh7+cJyw1DqaVSrg=; b=SfOtnZ
	PFQZW7TISHoOIeQbR07gJInsWD0mkKv5YtyhCrlEIdSh4QFlMmWROlMhr26UMnnn
	bdA59pcz8uMup/0bt/4x3bLvQ8mo0IJKmhZHdqLg+9aGZ2ZEoVcRH0J9Qi0ioTI7
	v97lmhYaWVR6pB9xdDBXt/RqiQsJ/kjmne3fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PvJTCpp2r0RSostpJwguEPmHoCXNfzcZ
	nO5ApjHq2hXtqZ+ZbJy6kDbDQFQIWlzNmlgllYgwK+WuTON5qEPOQqkWLcXrApbO
	HZ8Uv+GnSt15ce5hprpv5NCizeg4mpTen6JRvJk7rOkarePTvYcmH4rPR6j0exsh
	a2HQh8P8IMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1094F8290;
	Fri,  8 Jun 2012 10:49:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B718828F; Fri,  8 Jun 2012
 10:49:25 -0400 (EDT)
In-Reply-To: <1339145776-20495-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 8 Jun 2012 14:26:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24541B68-B179-11E1-8E96-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199496>

Ramkumar Ramachandra <artagnon@gmail.com> writes:


> +	string_list_insert(&subcmds, "list")->util = &util[0];
> +	string_list_insert(&subcmds, "add")->util = &util[1];
> ...

If you make "struct subcommand" to contain entry's own name, you
could simply do this, no?

	for (i = 0; i < ARRAY_SIZE(util); i++)
        	string_list_insert(&subcmds, util[i].name)->util = &util[i];

Perhaps append all and then sort once at the end?
