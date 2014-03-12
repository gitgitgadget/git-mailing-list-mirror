From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Wed, 12 Mar 2014 15:02:01 -0700
Message-ID: <xmqqob1bjcti.fsf@gitster.dls.corp.google.com>
References: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
	<CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Pawe=C5=82?= Wawruch <pawlo@aleg.pl>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:02:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNrEX-0008MB-IP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 23:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbaCLWCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 18:02:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbaCLWCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 18:02:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16FFE74712;
	Wed, 12 Mar 2014 18:02:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OG/GoMRKxaSdWBL8MaaCo89RS5M=; b=gx9up1
	h0US/P7TPBjKtxt274Lmv/W3dUVLA0ltV822h1JE9AuFCTVDVikxQMqTVrD9zhmC
	r+u5OmpZEaWBSPKlfqHu6AQyhP0oAEnYL5CkjgQwVJOzJcsckAYi8DBxvBsC9pOf
	/poafKLLYUSrx1IlXgb39X3AnpEUXPRWtavAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOA+DhI4i8G3FAPCiIrxvXFRbY4lhL/D
	OhOhq65aExGWKINeKqAzyy9MKE/U3htsQwM5+ldW2T1MimnDIDlLBtKmr6vQHlWA
	BaKzYJl6RmBnhgG1KQvMpolrKuW7KNI4uaHqEGbs37p0ogoHcDq7VrI5Wkjs61FE
	cLrAaFO32OM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0926874711;
	Wed, 12 Mar 2014 18:02:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 552CA74710;
	Wed, 12 Mar 2014 18:02:34 -0400 (EDT)
In-Reply-To: <CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 12 Mar 2014 01:36:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 040265B4-AA32-11E3-A1C5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244003>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +               if (origin && remote_is_branch)
>> +                       printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
>> +                               local, name, origin);
>>                 else
>> -                       die("BUG: impossible combination of %d and %p",
>> -                           remote_is_branch, origin);
>> +                       printf_ln(_(message[!remote_is_branch][!origin][!rebasing]),
>> +                               local, name);
>
> Shouldn't this logic also be encoded in the table? After all, the
> point of making the code table-driven is so that such hard-coded logic
> can be avoided. It shouldn't be difficult to do.

Hmph.  Is it even necessary in the first place?  Does it hurt if you
give more parameters than the number of placeholders in the format
string?
