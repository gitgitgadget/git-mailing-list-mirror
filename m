From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sha1 lookup and GIT_USE_LOOKUP
Date: Wed, 08 Jun 2011 11:55:42 -0700
Message-ID: <7v62og2lw1.fsf@alter.siamese.dyndns.org>
References: <BANLkTintTECbO5X3VMvzHdGgyKmLKe65YE=0mX6Ahj5wutCJ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Pegon <pegon.marc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNv0-0002cv-Fz
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1FHSzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:55:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1FHSzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:55:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4C205A3B;
	Wed,  8 Jun 2011 14:57:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97KFYb89rbzy/gFp4Vd/2sA/+nc=; b=M1rKBb
	aT3EEGMV541aYn87DPslMeM2hT/pP4dE160YDNVYcpiqSt0/Kdz+mZ+gG0ERR8RK
	kuiqOI+Z+0cLg4T7cjGNffIt1gFdKMwjBzNoNZKY6jL//vwRoOFe5PzpA21ANGpi
	WQRN4AV4Q7aDRuAtI6rUeX6AGuCua21u6C7i0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cIeiSG+oVZ8YM9UIdEYXNz6mPrtFAKBf
	APt7pjvGvNvo6OIPKsfnvlG7WSEkatRhvvXZ4/yGkA/McQfEWNh1AhlHQZ80YpI7
	skfSj+I3jrkV71BVNMoagIYHf7R/lOcSvCq5pdzDlyq9V+M8Rib9ilvjaLGF8m4y
	g7ne27KyT2U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B5445A36;
	Wed,  8 Jun 2011 14:57:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A7FE85A32; Wed,  8 Jun 2011
 14:57:53 -0400 (EDT)
In-Reply-To: <BANLkTintTECbO5X3VMvzHdGgyKmLKe65YE=0mX6Ahj5wutCJ0Q@mail.gmail.com> (Marc
 Pegon's message of "Wed, 8 Jun 2011 20:31:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38B02F86-9201-11E0-8B84-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175441>

Marc Pegon <pegon.marc@gmail.com> writes:

> Since this environment variable is not set by default, git will always
> use a simple binary search, won't it ?

Yes.

> Also, when searching for a sha1 given a sha1 prefix, among packed
> objects, find_short_packed_object also does a simple binary search.
> Wouldn't it be simpler to just use the sha1_entry_pos method ?

Unknown ;-).

The environment variable is there exactly for people like you who are
interested in finding out which one yields better performance by
benchmarking.  Once we can get a convincing result, we can either
deprecate the more involved sha1_entry_pos() if it turns out to be not
worth it, or we can always use it if it turns out to be significantly
better.

Thanks.
