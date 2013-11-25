From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/28] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Mon, 25 Nov 2013 14:42:38 -0800
Message-ID: <xmqqd2low1b5.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-7-git-send-email-pclouds@gmail.com>
	<xmqqtxf0w440.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 23:42:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl4rk-0003WJ-G0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 23:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab3KYWml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 17:42:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab3KYWml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 17:42:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D9795387E;
	Mon, 25 Nov 2013 17:42:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dac6FRafZp6bwNFqaUcPdiIcV/g=; b=FcK2+f
	3Cn2jgjhvwxvcYm6nlhaph81sswlO8dFNqVdspr3YbAD525qu8cTmx/rGUdG4aoq
	weCzu5pTic0T0NiXreX2HDuGKEUKyRShfPxPkxIe1DRHr7I8pn1smcTZj2sgKAQG
	/OICuogqyQ14JxTtrZszMxvo3hCzALTNqwaZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=edd4IU9n6xSPtf8Nn3PQmdSnM3aDEtTw
	0hZp+b+/tRQjnRX9Ionnk4GGjx8aVXXn0wnP8hMJhpxwNukyf4XAHIIP3lmUOyY6
	Pf8DxeLtgoVFCI9BjIZ9S7XcbILpBMrvKJDZEPDQLXe4YQwc7MTpNxUYGbPsaE0J
	K/J105MND4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E95C5387D;
	Mon, 25 Nov 2013 17:42:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA0925387C;
	Mon, 25 Nov 2013 17:42:39 -0500 (EST)
In-Reply-To: <xmqqtxf0w440.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Nov 2013 13:42:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E38193C2-5622-11E3-BD3E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238363>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps a preparatory patch needs to rename the structure type to
> object_name_list or something.  And then we can make the variable
> names, not typenames, responsible for signalling what they mean,
> i.e.
>
> 	get_remote_heads(...
>         	struct list_of_objects *extra_have,
>                 struct list_of_objects *shallow_points);
>
> when we introduce the new parameter.

Yuck, and these are not "list-of-objects", either.  They are
"list-of-object-names".
