From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 5/8] sequencer: run post-rewrite hook
Date: Tue, 4 Jun 2013 11:03:33 +0200
Message-ID: <877giaxn6i.fsf@linux-k42r.v.cablecom.net>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-6-git-send-email-felipe.contreras@gmail.com>
	<7vhahfdnu6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 11:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujn9a-0001cc-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 11:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab3FDJDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 05:03:38 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:15268 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab3FDJDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 05:03:37 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 4 Jun
 2013 11:03:32 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 4 Jun 2013 11:03:33 +0200
In-Reply-To: <7vhahfdnu6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 3 Jun 2013 11:57:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226332>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +static void run_rewrite_hook(void)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	struct child_process proc;
>> +	const char *argv[3];
>> +	int code, i;
>> +
>> +	argv[0] = find_hook("post-rewrite");
>> +	if (!argv[0])
>> +		return;
>> +
>> +	argv[1] = "rebase";
>> +	argv[2] = NULL;
>
> When the end-user action is "git cherry-pick A..B", shouldn't
> the rewrite hook be called with "cherry-pick" not "rebase" as its
> first argument?

The whole function was copied from builtin/commit.c except for that
string.  So it should be refactored anyway, with the "cherry-pick" being
an argument.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
