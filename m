From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 10:07:18 -0800
Message-ID: <xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
	<CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
	<b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
	<20150122220140.GB6695@peff.net>
	<315bf23981813799d16fdd9b533444f3@www.dscho.org>
	<20150123122317.GA12517@peff.net>
	<6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
	<20150123133033.GA27692@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEido-0000SB-VB
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbbAWSH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:07:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753430AbbAWSH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:07:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F8AF31262;
	Fri, 23 Jan 2015 13:07:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=POFtQ/B2eKa/ron496gv8GdlJm8=; b=AaXWg+
	bQgKlZbc8l/dz2FHHgas4bGW9ejf0MXI0ly7fotL7YbJMOt3ByH5DbLaEe0TnLPE
	PemXb8I2TJ0IXAiQn5/NGV7TALX2hTmJDxdSQ8/npGs0lWXy3SSYVpB8KqP4aj6f
	yyz2bUFubb6v52KXENga7j5dp81NusmmbkBsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbvwcHsbof6L1ghD9C2U0SyOWqSnw9w6
	OKYYfJT66ZSk6+5hMpvu3b88LxlBn7N1/LODmgTQZo0i3SBjCXNylLC1wiSszNKj
	ejY/PGEpspSl4AvlD6T8frlCZfoPmGRhPxO7Msevil2ayTb/4iMzKtf7XP9X8Svk
	h2HoazWgKkM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52AC73125C;
	Fri, 23 Jan 2015 13:07:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE3CB31259;
	Fri, 23 Jan 2015 13:07:19 -0500 (EST)
In-Reply-To: <20150123133033.GA27692@peff.net> (Jeff King's message of "Fri,
	23 Jan 2015 08:30:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC050E3C-A32A-11E4-9775-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262940>

Jeff King <peff@peff.net> writes:

>> diff --git a/fsck.c b/fsck.c
>> index 15cb8bd..8f8c82f 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -107,7 +107,7 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
>>  {
>>  	int severity;
>>  
>> -	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
>> +	if (options->msg_severity && ((unsigned int) msg_id) < FSCK_MSG_MAX)
>>  		severity = options->msg_severity[msg_id];
>>  	else {
>>  		severity = msg_id_info[msg_id].severity;
>> -- snap --
>> 
>> What do you think? Michael, does this cause more Clang warnings,
>> or would it resolve the issue?
>
> Hmm, yeah, that does not seem unreasonable, and is more localized.

Or we could force enum to be signed by defining FSCK_MSG_UNUSED to
be -1 at the very beginning of enum definition, without changing
anything else.  Then "msg_id < 0" would become a very valid
protection against programming mistakes, no?
