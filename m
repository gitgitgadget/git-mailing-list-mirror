From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/22] lockfile: use strbufs when handling (most) paths
Date: Wed, 02 Apr 2014 10:16:12 -0700
Message-ID: <xmqqbnwjwt2b.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:55:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeSt-0000xS-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbaDBRQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:16:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbaDBRQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:16:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D7A6780C7;
	Wed,  2 Apr 2014 13:16:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xDAYetoj7+oyd966SqnnC2dFihk=; b=G5mrvK
	OOnWVlm6LkZVlYNyb401oU29MixSzA/JyAHzV622ZF2KsovIDw7La0IUXyIcFDUu
	5IJ5tGssWyVnjbacihBaafPN359F3hB7/+ULwfc3n20LQ1gWGvjViOEL5i+ZXK0r
	p12KhNjh+aC4QUvF4DARldG9s7BYKsrZFNVpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0gTwdlZvl9yCIwF7rsqoWbf2bd63aOV
	LeqZICakWKxFC9xiQ/mPLR3GPaDDI+8Gv05I5ucfDZJHl1J+c1BusKKj/tcVlFZl
	hOkGadasDPNwBxJNf+I0EIUXNwchgC8LeRXQnI3zc7NmBTf/taXliLXd1Ns0TjFw
	nvqf1kJOyVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 446A7780C6;
	Wed,  2 Apr 2014 13:16:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ABB6780C4;
	Wed,  2 Apr 2014 13:16:14 -0400 (EDT)
In-Reply-To: <1396367910-7299-15-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 1 Apr 2014 17:58:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7EA89B54-BA8A-11E3-BEF5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245727>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change struct lock_file's filename field from a fixed-length buffer
> into a strbuf.

Good.

As I allued to in a review on an unrelated patch, I do not think it
is a good idea to name the lock filename field "lock_filename" in a
structure that is about a lockfile, though.
