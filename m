From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Tue, 13 Mar 2012 10:51:33 -0700
Message-ID: <7vy5r4wfru.fsf@alter.siamese.dyndns.org>
References: <4F5E3298.5030502@seap.minhap.es>
 <7vk42pr3c7.fsf@alter.siamese.dyndns.org> <4F5F41FF.4000204@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 13 18:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Vsr-00044q-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 18:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759099Ab2CMRvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 13:51:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906Ab2CMRvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 13:51:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CCC56098;
	Tue, 13 Mar 2012 13:51:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=56zvdgiJeKZk+H8mlQQNZLz74NM=; b=a5CiTl
	SNm9SFdC9dqcIZekHEJzRIl4t0TuYtPvSfzxZqBAjMfPbvvgZr7BqtdMnhFiWECe
	OQLugIxs6aoiemZb0FnvGkeF6/WWjLVHCM/EyzP9D7eFpH5ndvKm+aQlXIA75yTZ
	Fv7fvQX+sbovIRh7SxMT+WXn50YzWlXbc0hO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xdC0URG0RxsaeeBpXsq5MNvuOr+S3yJt
	fOiXGxQ8pH1U9Z4js3n/OusrHfkDn4mM0QVzzfFzOUkuzzSAXrJJjigQ/cKsOKOs
	SdEbI3w0Kuy0NVD/oBUMSnaIshTtrH3JvShQUxAAw/hvtJ/h2CAuorPA2A7+Vdq3
	ikZvX7Y6Hy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 842286097;
	Tue, 13 Mar 2012 13:51:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F23F56096; Tue, 13 Mar 2012
 13:51:34 -0400 (EDT)
In-Reply-To: <4F5F41FF.4000204@seap.minhap.es> (Nelson Benitez Leon's message
 of "Tue, 13 Mar 2012 13:47:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CCB767A-6D35-11E1-8367-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193046>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 03/12/2012 09:06 PM, Junio C Hamano wrote:
>> Whatever new token you use, please keep AUTH as a substring of it.
>> 
>> We may want to retry a request to deal with intermittent failures on
>> the server side or the network between us and the server; HTTP_RETRY
>> would be a good name to signal such condition after we see a failure
>> response from the library.
>
> HTTP_REAUTH and HTTP_AUTH_RETRY seems like the same thing, so imo not 
> deserving the rename, maybe Jeff can suggest a better name as he was
> who suggest the rename.

Either has AUTH as a substring in it, and leaves a door open for us to
later introduce HTTP_RETRY to tell the machinery that drives cURL library
to retry the request, so in that sense I am OK with either, but as your
log message said, we want to make it clear that this is not about doing
the authentication again (re-auth) but retrying the authentication, so
HTTP_AUTH_RETRY would be more logical name.
