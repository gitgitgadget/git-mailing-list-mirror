From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/22] lockfile: also keep track of the filename of the file being locked
Date: Wed, 02 Apr 2014 10:19:04 -0700
Message-ID: <xmqq7g77wsxj.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-19-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeSx-0000xS-0e
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbaDBRTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:19:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbaDBRTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:19:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD60A7820B;
	Wed,  2 Apr 2014 13:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4spACqA9US2JZJqxsJ6zMiR/mQA=; b=JopZ/x
	I2OW9qShv5tUWhkSVDg0zksUxmUD3QbA0TM8FAxpGfeX9r0qqKohxY+QIwZiakbh
	i7LKOWr07zXTc9dYV2x/MTUcNOr7yprvOVmBp+j8Wxe3IPWYUBeR6xfL0a/U5xnX
	7RHEObDJSl2GOGnZec4aGaoLHLMu0eTPJ5/mA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8/63C1436juE8saCPf8tCYE4mFU7S4P
	zkIZRk97C+x3MpKEev8N3oDd6WzezhzkWbgdevB0+o0BCWRaGEEoxniGjtd0vSWX
	F/Tfsug20B24yOWBs8tk39UQvYGEZFSIWcIXSVWiuuK/o8xnNdvNzJk4frHflcaG
	1QR1rWWU6VM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39CE7820A;
	Wed,  2 Apr 2014 13:19:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAD6578204;
	Wed,  2 Apr 2014 13:19:06 -0400 (EDT)
In-Reply-To: <1396367910-7299-19-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 1 Apr 2014 17:58:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E555E8AC-BA8A-11E3-8933-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245692>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This reduces the amount of string editing gyrations and makes it
> unnecessary for callers to know how to derive the filename from the
> lock_filename.

Hmph.

Is it worth duplicating the whole thing?  If you are planning to
break the invariant lock_filename === filename + LOCK_SUFFIX in
future changes in the series, it is understandable, though.
