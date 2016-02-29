From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 22:28:37 +0100
Message-ID: <56D4B805.7090702@kdbg.org>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
 <56D4AE8A.2050403@kdbg.org> <xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
 <xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:28:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVMy-0005g5-IY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbcB2V2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:28:41 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:7684 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbcB2V2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:28:40 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qDZTK5Lw7z5tlM;
	Mon, 29 Feb 2016 22:28:37 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 64C5752C2;
	Mon, 29 Feb 2016 22:28:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287905>

Am 29.02.2016 um 22:19 schrieb Junio C Hamano:
> Stefan Beller <sbeller@google.com> writes:
>
>> Maybe we want to remove the struct child_process from the
>> function signature of the callbacks and callbacks need to rely on
>> the data provided solely thru the pointer as passed around for
>> callback purposes, which the user is free to use for any kind
>> of data.
>
> I think that is the most sensible.

I also think that is the better approach. Dumping out the argv array is 
not the best end-user experience. It is just a debugging aid, and for 
that we have (or should extend if necessary) GIT_TRACE infrastructure. 
Moreover, a command that failed should have printed error messages, and 
it is not necessary to follow it up with another "A child process exited 
with code N" message.

-- Hannes
