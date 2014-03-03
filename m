From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Mon, 03 Mar 2014 10:34:49 -0800
Message-ID: <xmqqr46jqgfq.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
	<xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
	<CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXha-0005fp-5x
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbaCCSex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:34:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbaCCSex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:34:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882BA6F380;
	Mon,  3 Mar 2014 13:34:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FbchhrYDwEmPxpG0+X+hODov5cw=; b=jC5mdf
	MDfjYbrXcbrUdQyrw8+ZGuS2XewwhUKH+hZV17I3Ihls1amjA1tMgVoIuwgaxIjp
	fA8YiC2TVwkkVrqxYpKuWmnLp9ihnY5mLxgKQKayKP2KtwEh/N5oN4NlmnMyIgQd
	mRt6pJNTFnkvwA3azDB2+/8HW1SCJq8NRzVXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAzHsRtFTpGYGsRFl4vPOBkTuecVysza
	wr3fwYw9FBcjJxpy1IKSFznpV6Wz58LbDoI4C065W4BOtepieVeARZCzaK29aPKg
	gkurt+WiW1lE44mGNSTapnzs6P2DDA29/s5fwQtRByrrKuQd2eC3LP/UlWd2/WoQ
	TTuESWyzDMM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 333F16F37F;
	Mon,  3 Mar 2014 13:34:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ACD26F37C;
	Mon,  3 Mar 2014 13:34:51 -0500 (EST)
In-Reply-To: <CAL0uuq3eWnLz3=wiexSsJgArUYx95EjLMDWyDvQb9=_ieQUvBA@mail.gmail.com>
	(Jacopo Notarstefano's message of "Sat, 1 Mar 2014 12:31:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 81C73C0E-A302-11E3-8217-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243248>

Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:

> Here my proposal differs in that I have no way of knowing which label
> is good and which label is bad: I blindly accept two distinct labels
> and bisect with those. I gave an example of this behaviour above.

I think you fundamentally cannot use two labels that are merely
"distinct" and bisect correctly.  You need to know which ones
(i.e. good) are to be excluded and the other (i.e. bad) are to be
included when computing the "remaining to be tested" set of commits.
