From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git-send-email: allow edit invalid email address
Date: Mon, 26 Nov 2012 14:58:58 -0800
Message-ID: <7vhaocotsd.fsf@alter.siamese.dyndns.org>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
 <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
 <7vobikthpp.fsf@alter.siamese.dyndns.org>
 <20121126173318.GA12101@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:59:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td7e2-00027x-4v
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 23:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465Ab2KZW7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 17:59:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116Ab2KZW7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 17:59:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB1B0A337;
	Mon, 26 Nov 2012 17:59:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OpmCC2jr1i8lT1FyPSVDbIGdjQ4=; b=HQ3N1B
	FGvfF/sK1I2kw0HMR4ZXQms+yoTTHrLnpw1nhCBFmriPpgwZNqSvDaM54KWu6MLF
	5J5jBfuW2iHBVvdrCmvfPWl6nQK5onVWIFzjwvbTJhB+bCaCnigtFCNZiiBiTAic
	x8h9rV6bqaLIqJQ5iE1GZJGRZxythZvok6fsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D/LLzb4lnDgF0JvytHgbr04FypMBp9sy
	YhJRd3ERZyhT72bv6jKPqEBNfVfOCTy1XoqoUvClVFlxWJIYKeBEGYf5Bd1PPzLh
	hTCjc2keMganzGn5zxtKizPM1+fiE8ows/O7UqyYsmHzzeXH+2RZuiVcC8eyk8nN
	lzXoiPklxzU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A74C7A336;
	Mon, 26 Nov 2012 17:59:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03A88A331; Mon, 26 Nov 2012
 17:58:59 -0500 (EST)
In-Reply-To: <20121126173318.GA12101@shrek.podlesie.net> (Krzysztof Mazur's
 message of "Mon, 26 Nov 2012 18:33:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD7A92DC-381C-11E2-8E98-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210509>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

>> Not having this new code inside "elsif (/^e/) { }" feels somewhat
>> sloppy, even though it is not *too* bad.  Also do we know this
>
> ok, I will fix that.
>
>> function will never be used for addresses other than recipients' (I
>> gave a cursory look to see what is done to the $sender and it does
>> not seem to go through this function, tho)?
>
> Yes, this function is called only from validate_address_just()
> to filter @initial_to, @initial_cc, @bcc_list as early as possible,
> and filter @to and @cc added in each email.

Thanks; when merged to 'pu', this series seems to break t9001.  I'll
push the result out with breakages but could you take a look?


Test Summary Report
-------------------
t9001-send-email.sh                              (Wstat: 256 Tests: 102 Failed: 77)
  Failed tests:  4-7, 9-10, 12-13, 15, 17-21, 23-29, 31-33
                35, 37, 39, 41, 43, 45, 47, 49, 51-58, 61-88
                91, 93-95, 98-102
  Non-zero exit status: 1
