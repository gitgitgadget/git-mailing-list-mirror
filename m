From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Wed, 12 Mar 2014 11:31:19 -0700
Message-ID: <xmqqmwgvmfpk.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
	<xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
	<CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com>
	<xmqqr46jqgfq.fsf@gitster.dls.corp.google.com>
	<CAL0uuq0LpQTQPeNVJgKGS2YLTT0gi_BM0wi02c0EP+kvBE4DyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNnw6-0004uP-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 19:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125AbaCLSbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 14:31:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbaCLSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 14:31:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04BD971C7D;
	Wed, 12 Mar 2014 14:31:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RFQBmkHgghKYW+P+alklbcWqRCQ=; b=sCx7ZM
	5SSj+2joMnawSThsDTUvTJtMwo2RSx+2nBBRM9w6i35L5+/p+IIFBA1koJLzMms8
	EQJQIyj7Fl5YvUbMbdSG0DmdsduqLcKVlApy1yJevQto0zPX8jXqVc8amGgr8l7W
	Al3J37lF1+5wsULc/SrIOH3YtCToFVds+oetk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rYWQ3/2RFGwp4Gkuhg3yO5QLl0mX8Gmc
	GM4UJgb4TQZOsQfvAL6JkiNL67cTf6UdOnKHJgDQnYlSTTNcwvPLcWOnv18b5m1o
	RnNyNoVTloQu5B1TaEqRVe2Et5TNGEhPO/CAi36xw5eHcXoPxKS49+2MNw5yfYzv
	vkfMtdYLBpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC45F71C7C;
	Wed, 12 Mar 2014 14:31:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8EAD71C79;
	Wed, 12 Mar 2014 14:31:20 -0400 (EDT)
In-Reply-To: <CAL0uuq0LpQTQPeNVJgKGS2YLTT0gi_BM0wi02c0EP+kvBE4DyA@mail.gmail.com>
	(Jacopo Notarstefano's message of "Wed, 12 Mar 2014 02:32:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82138F32-AA14-11E3-B3CC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243956>

Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:

> On Mon, Mar 3, 2014 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think you fundamentally cannot use two labels that are merely
>> "distinct" and bisect correctly.  You need to know which ones
>> (i.e. good) are to be excluded and the other (i.e. bad) are to be
>> included when computing the "remaining to be tested" set of commits.
>
> Good point. Yes, this isn't viable.

But if you make them into --no-longer-X vs --still-X, then it will
be viable without us knowing what X means.
