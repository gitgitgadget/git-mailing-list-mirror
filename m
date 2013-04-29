From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Sun, 28 Apr 2013 20:25:03 -0700
Message-ID: <7v7gjmow6o.fsf@alter.siamese.dyndns.org>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
	<CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
	<7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
	<CACsJy8CT8r7ebE_q5ET+oicTY0NM4LAt1B61xwqfL8tLKc-4OA@mail.gmail.com>
	<CAJDSCnPt=wgT0UQirahvTyen9w_v4XTn0ABHJVCLeKLmC8BsHQ@mail.gmail.com>
	<CAJDSCnN_Va7r2BMLYSbsSzoUNs6YfYfihatb-u4jJw25w8qvZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Heemskerk <mheemskerk@atlassian.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 05:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWeiU-0007Yl-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 05:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab3D2DZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 23:25:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756674Ab3D2DZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 23:25:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 505B511D7C;
	Mon, 29 Apr 2013 03:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMX1Cjv+BGPzesVl5EF0E5zd7WM=; b=n3Jd6y
	z68yHHDlOdXnLXZBPZJbo34m8gP++Ki6QbZjv9HJQcpNmCKztROcNVcWH3gqQKCu
	cCEBblOfGoFdtXSdL0+SYFpk4CoNC0mKtvTYk2+PA3j4ak2fyXNR2V8SinWx7snG
	VvLX809YTEc2L562VehjyCvIvSkMFi4SYP14o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xptxft5Ey13JsXE45D0jcbpRDa22wmod
	vpZPu3ZisY4qxyW6Hq/szp6BmlodzSmg66PuvttLtWh0itJ8T8b3V/pPm2hoj0Ml
	WUhK7Y2kjtIH5/j75jVSwtXYpdA7981HvJAUMYCVjopY7eqaMfT/urLxPfI9JnAE
	o8/tTvbHqA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4397111D7A;
	Mon, 29 Apr 2013 03:25:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9450511D79;
	Mon, 29 Apr 2013 03:25:04 +0000 (UTC)
In-Reply-To: <CAJDSCnN_Va7r2BMLYSbsSzoUNs6YfYfihatb-u4jJw25w8qvZg@mail.gmail.com>
	(Michael Heemskerk's message of "Sun, 21 Apr 2013 11:08:27 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 624D16D8-B07C-11E2-B4B3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222761>

Michael Heemskerk <mheemskerk@atlassian.com> writes:

> Re-sent to the mailing list because the original was bounced (HTML subpart):
> ...
>
> With the patch applied, the server ignores the shallow line mentioned by
> the server and will not send a "shallow" or "unshallow" line for it back to
> the client. This scenario is not explicitly described in pack-protocol.txt
> but I'd be happy to add it to. I'll also update the comment to cover this
> aspect.
>
> As Duy pointed out, it doesn't cause problems in the current C Git
> implementation: the client adds a new entry to the shallow file for each
> "shallow" line it receives from the server and removes an entry for each
> "unshallow" line it receives. Any current shallow object that is not
> mentioned by the server is still marked as shallow after the fetch.
>
> I think that's how it should be: it should be the client's
> responsibility to track
> the list of objects it only has in shallow form. It should not rely on
> the server
> to tell it what that list is. Again, an extra line or two in pack-protocol.txt
> would help to clear this up.
> ...
>> > I do not seem to find the patch you are responding to, so I do not
>> > know how the patch handled the unshallowing part, but the impression
>> > I got from reading the log message quoted is that the patch was not
>> > even aware of the issue.
>>
>> I can't find it on gmane.org either. Patch quoted below.

OK, the change the patch text shows looks sensible to me.  Can you
resend it in full, with the log message, your sign-off, and Duy's
"Reviewed-by:", so that it can be applied?

Thanks.

>> On Sat, Apr 20, 2013 at 8:05 PM, Michael Heemskerk
>> <mheemskerk@atlassian.com> wrote:
>> > diff --git a/Documentation/technical/pack-protocol.txt
>> > b/Documentation/technical/pack-protocol.txt
>> > index f1a51ed..b898e97 100644
>> > --- a/Documentation/technical/pack-protocol.txt
>> > +++ b/Documentation/technical/pack-protocol.txt
>> > @@ -228,8 +228,7 @@ obtained through ref discovery.
>> ...
