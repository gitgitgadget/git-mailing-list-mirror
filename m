From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] tests: use "env" to run commands with temporary env-var settings
Date: Wed, 19 Mar 2014 12:55:06 -0700
Message-ID: <xmqqfvme2cbp.fsf@gitster.dls.corp.google.com>
References: <244379@gmane.comp.version-control.git>
	<1395168845-1972-1-git-send-email-unsignedzero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tran <unsignedzero@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQMa6-00063W-O3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbaCSTzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:55:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaCSTzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:55:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7C0A74F6A;
	Wed, 19 Mar 2014 15:55:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/1dFVir0Jt7gGUFSb+qjJC3GQY=; b=Gu/FOp
	9fUD6LDUQx9mDFI40U96CfJnUUrodYw534AM2tqIUs/8Rz5Aia+vbSwk9Rh5JQkA
	ggeeTQ4RWXAX1GoSlCSyfmI2f48sl0sNV9muu6AnjzQJf55o44zWnfTubQADoXZg
	fS+AMKUwuPo4dn+DmKmf/wphxfBA47NmFXVTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e+QP7UvQEV8iBKJihXyiipIy7+5Srbyh
	JmjxtGMH/HMVI6fJA+Q/d2U7Z6aS8H/q2/z0kQc66DdjJZgTrvL1accvt26Op13e
	9h0ozLRa5ZDXz7cY7FEz1lRAMFUXM2elsgZ/MFkkVoFSVBx9igmivgmsA4fH/dt5
	fX6qDocdQ6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A615474F69;
	Wed, 19 Mar 2014 15:55:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2C9B74F64;
	Wed, 19 Mar 2014 15:55:07 -0400 (EDT)
In-Reply-To: <1395168845-1972-1-git-send-email-unsignedzero@gmail.com> (David
	Tran's message of "Tue, 18 Mar 2014 18:54:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5F47513C-AFA0-11E3-AD5E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244486>

David Tran <unsignedzero@gmail.com> writes:

> Originally, we would use "VAR=VAL command" to execute a test command with
> environment variable(s) only for that command. This does not work for commands
> that are shell functions (most notably test functions like "test_must_fail");
> the result of the assignment is retained and affects later commands.
>
> To avoid this, we assigned and exported the environment variables and run
> the test(s) in a subshell like this,
>
> 	(
> 		VAR=VAL &&
> 		export VAR
> 		test_must_fail git command to be tested
> 	)
>
> Using the "env" utility, we should be able to say
>
> 	test_must_fail git command to be tested
>
> which is much short and easier to read.

Looks familiar ;-) but it seems the changes from the original you
took it from all look worsening, not improvements, to me.

>>Isn't GIT_CONFIG here another way of saying:
>>
>>	test_must_fail git config -f doesnotexist --list
>>
>>Perhaps that is shorter and more readable still (and there are a few
>>similar cases in this patch.
> I'll ignore this for now. If needed I can make another patch to resolve this.

Yes, I think that is sensible.  And it does not have to be done by you.

> Hopefully this should be all of it.

Seems to be well done.  Thanks.
