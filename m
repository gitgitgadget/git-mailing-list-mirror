From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Do not autosquash in case of an implied interactive
 rebase
Date: Tue, 29 May 2012 11:41:10 -0700
Message-ID: <7vvcje4ypl.fsf@alter.siamese.dyndns.org>
References: <1337867575-7212-1-git-send-email-vfr@lyx.org>
 <1337867846-5336-1-git-send-email-vfr@lyx.org>
 <7vehq8tajh.fsf@alter.siamese.dyndns.org> <4FC3428F.4060202@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue May 29 20:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZRM9-0002bO-UJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab2E2SlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 14:41:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064Ab2E2SlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 14:41:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47CD08065;
	Tue, 29 May 2012 14:41:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=viu9vmQXJMFs8JZ2S0ZHF2N7GRI=; b=lMOiqC
	e3lhB+wpnPQgAxq/tt/pmzgPQP/Js/t0Jd5rX8igJW5Cr9pNP34L5uxo5Og/W2JW
	S3Qn3oDB4KNWJnH4japyXe2X87ZfuDjoK83ckXyf1wtaGP5erokh1uQgUTR35VQO
	mVFCOlJ/u1+q0GB8TJbyGJceEIPspMVK++yWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yermeRXBDBZFV0QDFj6mWudGOzlhcjdW
	+piihEkyf8b9MPDb9JQB4FnsrYuBZuPufdcIxyX2mtA9kpoEAxHD7rMC6oC9yPJd
	cdVf9v+z3LAjell3g8wtjI4WPq4E1M+tqtnyiFNsfimxgXxvOczHSPsFnZ5HY8b3
	vNuHiSw+imY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECB48064;
	Tue, 29 May 2012 14:41:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB98D8062; Tue, 29 May 2012
 14:41:11 -0400 (EDT)
In-Reply-To: <4FC3428F.4060202@lyx.org> (Vincent van Ravesteijn's message of
 "Mon, 28 May 2012 11:17:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCEFD856-A9BD-11E1-B309-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198748>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Op 25-5-2012 19:50, Junio C Hamano schreef:
>> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>>
>>> The option to autosquash is only used in case of an interactive rebase.
>>> When merges are preserved, rebase uses an interactive rebase internally,
>>> but in this case autosquash should still be disabled.
>>>
>>> Signed-off-by: Vincent van Ravesteijn<vfr@lyx.org>
>> Hrm, what if the end user said "git rebase --autosquash -p" explicitly
>> from the command line?
>
> The option "--autosquash" is designed to have no effect whenever
> "--interactive" is not supplied.

Ahh, Ok.  I somehow thought "rebase --autosquash" implied "-i".
