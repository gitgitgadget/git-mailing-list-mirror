From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 12:13:33 -0800
Message-ID: <xmqqzjbouv0y.fsf@gitster.dls.corp.google.com>
References: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
	<20141118194129.GI6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alan Stern <stern@rowland.harvard.edu>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqp9g-0003qD-CB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbaKRUNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:13:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754214AbaKRUNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:13:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E0C1E980;
	Tue, 18 Nov 2014 15:13:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BUCCLjh3bbbzluaW/s5LYQHeayY=; b=DIGuVg
	b3DNrfRoYHi2AQLemOMsp+XchXv08XnsKCSFLIhVsznbvG28LY5iGkW1F1ym8b1x
	N40G6r1ojiBcgLqtGEc1n3DDNl7g9/vPzvJ2ZzEEWIA442hf9mm5awNHWOCncmjq
	Ipv1wYoSHKxKEvkMajqBemPf4iMyVq0eVb6ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBhLfYWubiiOiIqqcNJz9b8xL0In/+d6
	WFFXayfyF4gEq6pemq6QrF/pl+OorfSi3sI7Mqa8R/q0ctaMLQvv21v07I/Ye4Wz
	lgN0V8ufRARxU0na7c49Ba3UYrrCTCq7LICP8/P1mQM/zFYWe3K8AYp+vUpROonl
	8E6tAI9u1po=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD5C51E97E;
	Tue, 18 Nov 2014 15:13:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59EB11E97D;
	Tue, 18 Nov 2014 15:13:36 -0500 (EST)
In-Reply-To: <20141118194129.GI6527@google.com> (Jonathan Nieder's message of
	"Tue, 18 Nov 2014 11:41:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60C0DCB6-6F5F-11E4-916A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> --ancestry-path is my current favorite tool for walking-forward needs.

Curious.  I often want to answer this question:

    Commit 982ac87 was reported to be faulty.  What topic was it on
    and at which point was it merged to 'master'?

     - What is the 'bottom' of the topic, that is, the commit
       reachable from the faulty commit that was already on 'master'
       when the faulty commit was written the first time?

     - What is the 'top' of the topic, that is, were there more
       commits made on top to build on the faulty commit on the
       topic before the whole thing was merged to 'master'?

     - Were there follow-up fixes and enhancements on the topic
       after the topic was merged to 'master' (this is harder)?

And my experiments with --ancestry-path has been less than ideal.
