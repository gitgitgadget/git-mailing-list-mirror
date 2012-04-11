From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Wed, 11 Apr 2012 11:50:29 -0700
Message-ID: <7vy5q2je6i.fsf@alter.siamese.dyndns.org>
References: <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
 <20120410203944.GA12139@hmsreliant.think-freely.org>
 <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
 <20120411004419.GA19616@neilslaptop.think-freely.org>
 <7v62d6mcsa.fsf@alter.siamese.dyndns.org>
 <20120411182927.GA24833@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:50:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2cn-0004RO-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886Ab2DKSud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:50:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221Ab2DKSuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:50:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D3963F0;
	Wed, 11 Apr 2012 14:50:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0DrQHSJwwKm0TgtklX27RDbEUWA=; b=EfrE9M
	p2+aEECDiBdK+jNai57olSbxAYEtpFyi/hsHwFcUB8Te0rv/yjlglVHyTUTBtcW6
	ZwfHYOHrVVl2owbRTscGIVO8Y2elH7dYGeeJQ67UE2hFPbrJJFWiEk29mYGQ1bnp
	RqYplJcHlsk2f0X/hSnTD5D8gb4Mcjjx2XStc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EsCVIdhEh5jhRRDgYOx3z8dw5w6CHjmW
	M2O2WMf8lRai77AImDVcU1uu5e3VeAM7S320p/md1gwN90o0ftjeDlq/R9d9jAkH
	ylXN2fRTUja4b9AylaF+3uNQRJrK957G1NHuXWJUYQ73GelYgTIa4oknC1d6PljW
	7LYodoL4UAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8C0963EE;
	Wed, 11 Apr 2012 14:50:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24F0B63EC; Wed, 11 Apr 2012
 14:50:31 -0400 (EDT)
In-Reply-To: <20120411182927.GA24833@hmsreliant.think-freely.org> (Neil
 Horman's message of "Wed, 11 Apr 2012 14:29:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 367D0010-8407-11E1-A59D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195235>

Neil Horman <nhorman@tuxdriver.com> writes:

>> But that cannot be correct, without --continue [*1*], i.e.
>> 
>> 	$ git cherry-pick --allow-empty --continue
>> 
>> no?  I didn't check, but if the command without --continue in the above
>> sequence does not error out, I think it is a bug.
>> 
> No, it errors out.  I'm sorry to have confused you.  The only point that I was
> trying to make here is that, when running git cherry-pick, its seems awkward to
> a user to get advice indicating that git commit --allow-empty should be run.

I was only saying that "git cherry-pick --allow-empty" is a *bad*
suggestion because it does *not* work and errors out, and you seem to
agree with me on that point.  I also said I am OK if the suggestion for
this case were to run "git cherry-pick --continue".

But you sound like you are disagreeing with me; I am not sure where you
found what I said not agreeable.  So I am not sure what to say at this
point.
