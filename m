From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Wed, 28 Oct 2009 20:20:04 -0700
Message-ID: <7vpr86dgyj.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-27-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 04:20:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3LYn-0003VV-Nz
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 04:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbZJ2DUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 23:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbZJ2DUN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 23:20:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655AbZJ2DUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 23:20:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE7E6B887;
	Wed, 28 Oct 2009 23:20:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lb5NYOfo5+EQiXIJU+T0SZ+3xXk=; b=SxrDlu
	latUZTgYJMxJOUrzsgBI0ZGU87HnbuXynM8IvTSohUXW/oHwM6SKRJv4YIkjdtBk
	C1fp90qy0t6V2d7rFexwtnPBtkdn5sQYvOYLbceR1ibtfhN0iGPbZp4TcUdEpHpW
	kbXa9GKvXsImELjMWuWP7qzjUE80yqjU6NExk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kvFw0TkqnnCGGavR9YZhg/Qp2ZoqqT7M
	LF8xa7nU62xiSkQ4YFvUa31qvBvxa7yloD8X8L2XsR39LaQ1wc94aOTf5igF8z3p
	6YHg8vJ6BmBDmHSh/IBzL9gp+giZ2ck2GFg+PB6Dz3AoWBnUTzeG/QIJ8BLk3KgW
	8beEWRvizb4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE156B886;
	Wed, 28 Oct 2009 23:20:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D56E36B885; Wed, 28 Oct
 2009 23:20:08 -0400 (EDT)
In-Reply-To: <1256774448-7625-27-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Wed\, 28 Oct 2009 17\:00\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F901B972-C439-11DE-9FE1-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131550>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +test_expect_success 'clone http repository' '
> +	GIT_CURL_VERBOSE=1 git clone $HTTPD_URL/git/repo.git clone 2>err &&
> +	test_cmp file clone/file &&
> +	egrep "^([<>]|Pragma|Accept|Content-|Transfer-)" err |
> +	egrep -v "^< (Server|Expires|Date|Content-Length:|Transfer-Encoding: chunked)" |
> +	sed -e "
> +		s/
> //
> +		s/^Content-Length: .*$/Content-Length: xxxx/
> +	" >act &&

This chomped line is so unlike you---what happened?

Also, when the last downstream is sed, why would you even need two egrep
process?
