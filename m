From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Sat, 18 Aug 2012 13:36:04 -0700
Message-ID: <7vfw7krl8r.fsf@alter.siamese.dyndns.org>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com> <7vboj5gqqo.fsf@alter.siamese.dyndns.org> <loom.20120818T162226-852@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pkl-0004Ks-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab2HRUgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:36:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2HRUgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:36:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBC4D9940;
	Sat, 18 Aug 2012 16:36:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pKTb6xtkjHsvGOQjOHk5De5ww4k=; b=vnSZBe
	0Vavz4uAyo05KIbwNdMey6h8EBZuKOjY84N8hTqB2kqY5peZB+Q7PgG+K4B5PkiK
	6QGa0A+P5C7DzdGAljakF3P+UPdjFAye9vPya7TNMrrQI/TL1DJUMOLWat3K+yBY
	agAxvg2sAyw6qQ6uRGiedrScAU4ZYnReTR5rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mtbDYKqWAEUp3sowAf2I970oQT+hS0M5
	iOsCchrX4XdGrtA6kf/omFZTdnCiOZRgEkiV2m6wa3Sh0P2eCxtg2mxmx6bke5Pe
	lBeOvXxKZRcVh7L9cuEsmgnfflLdjuuZGSapawi0b0cbYXTRlatHQIDjILtvOYs+
	ygG2nlLfnZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9607993F;
	Sat, 18 Aug 2012 16:36:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44436993E; Sat, 18 Aug 2012
 16:36:06 -0400 (EDT)
In-Reply-To: <loom.20120818T162226-852@post.gmane.org> (Michael Haggerty's
 message of "Sat, 18 Aug 2012 14:41:11 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55CE0522-E974-11E1-8ABE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203696>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I can work around the problem by using "--root=/run/shm". 

I do not necessarily think it is a work around.

A low-impact approach may be to update the part that parses --root
option to do

	root=$(...)
        root=$( cd "$root" && /bin/pwd )

or something.
