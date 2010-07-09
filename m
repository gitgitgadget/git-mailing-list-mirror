From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] lib-rebase.sh: fake-editor.sh: Allow checking of
 non-comment lines in $GIT_EDITOR
Date: Fri, 09 Jul 2010 15:30:31 -0700
Message-ID: <7vtyo8l248.fsf@alter.siamese.dyndns.org>
References: <1278652843-30872-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 00:30:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXM5n-00071d-Lm
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 00:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab0GIWal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 18:30:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab0GIWak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 18:30:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 344BAC3F24;
	Fri,  9 Jul 2010 18:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3hwjWBZ88gkub7MpgKfy1jVMBh8=; b=bhG5x7
	pHxlHmK8rq8ve66OW0cLQkBC1oUR+3pkDxi6+tZw2zICm57Awsn7geS3I/yOt+Yb
	r3wNsaZjCBxQES6fllxH9Qb8BtpZYBURuIvBjYxhQR2bOcy0YBrmvuHhNirJqoW/
	97x2nc0jBXO2JH5LfeuvvU6eGynAZWGCjou2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lf+ZOZkYY1rS+dvhC1HUegIDFf/55fIR
	3sw1FXHchLoECUn9O7TtivSUhMgPkF8oeCxaJcHh6znAbqE0mG1+RLMtwH0IAYTg
	7lu9ig4Z7mjl9OPvUJqn6IFcGm8ShcQ8keeMz1LOz7wj0sfTH9q61/T1ZRKkEcCL
	4jtnRCPnI4A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0301FC3F22;
	Fri,  9 Jul 2010 18:30:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49070C3F21; Fri,  9 Jul
 2010 18:30:33 -0400 (EDT)
In-Reply-To: <1278652843-30872-1-git-send-email-ayiehere@gmail.com> (Nazri
 Ramliy's message of "Fri\,  9 Jul 2010 13\:20\:42 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98920C44-8BA9-11DF-9E92-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150694>

Nazri Ramliy <ayiehere@gmail.com> writes:

> +			sed -i "s/^\([a-z]\+\) [0-9a-f]\+ /\1 $REPLACE_COMMIT_ID /" \

This is not portable. Escaping an ERE element with a backslash does not
make it suitable for use in BRE that sed uses.

Do we use in-place replacement anywhere else with sed?  I don't think it
is portable, either.
