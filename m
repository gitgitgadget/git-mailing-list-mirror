From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] t7505: ensure cleanup after hook blocks merge
Date: Fri, 10 Jan 2014 15:40:54 -0800
Message-ID: <xmqqppnz76d5.fsf@gitster.dls.corp.google.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<1389228344-38813-1-git-send-email-ryan@yaauie.com>
	<1389228344-38813-3-git-send-email-ryan@yaauie.com>
	<vpq61ptnwdl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Biesemeyer <ryan@yaauie.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jan 11 00:41:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1lhH-0007uQ-QH
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 00:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbaAJXlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 18:41:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaAJXk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 18:40:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B6D76257C;
	Fri, 10 Jan 2014 18:40:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V6T/mFmDFwMVe7QzSn5C//SmgT4=; b=tVWdHJ
	mquXys//pGG1gPF36qTkATCiNDznB3BVclC9zLoYR8zAqTa4XtCF6qqq7O8fFqRc
	iSdbUpBEvcapCY1v58yg1G5XLZ6AHa9cZTdirCMPTN8muqhgXsrcLDdd19mYemFn
	0a3TIf7C+fCvjiBgdYhMaH2Gs/RdjmchlE9mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AeCFgY6RNhAke0Mu/07FLOIMrotZsrWa
	fybAyELnaMXsBn9jhN7PEX57K4sKn3BJPVAROCFxF5nf9jaQELicIJNg8EH9HRPI
	rpIPW77QrbNZTK+/ZWkLdoadzoSTaPBNphxK0laYwrCagzZPssQpP2Avtm+5L5Zk
	xXZfoh9znbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE5162578;
	Fri, 10 Jan 2014 18:40:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 609B662576;
	Fri, 10 Jan 2014 18:40:57 -0500 (EST)
In-Reply-To: <vpq61ptnwdl.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	09 Jan 2014 14:00:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A74D0C86-7A50-11E3-A076-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240322>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ryan Biesemeyer <ryan@yaauie.com> writes:
>
>> +  test_when_finished "git merge --abort" &&
>> +  (
>> +		git checkout -B other HEAD@{1} &&
>
> Weird indentation (space/tab mix).

Also I do not quite see why the body has to be in a subshell.
