From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 04 May 2016 00:28:21 -0700
Message-ID: <xmqqbn4mjn8q.fsf@gitster.mtv.corp.google.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:28:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrET-0001im-RC
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbcEDH2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 03:28:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751256AbcEDH2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 03:28:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5BA411559;
	Wed,  4 May 2016 03:28:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uyp4Wn3A73chQVExVWQ3OnU8oes=; b=Pjf+g/
	4yBctV6zld6OYct1lCHwnWdhESOynkDtdsvfyAfX3dNucTcNOG+UejhYWBsjiG9Y
	o/ADvkkgUolmTfvm59woGuiCkJHsDanxlklXGAuiGXVdwPXd+yZs1k9XMwv7/lTb
	XIhhZPgcLhfiXlb96cG57oibc/7Aevy7TM+2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzX9hmKMtpKpIxYBJKvKPjXj63skD1p5
	+si0jMX7k1BDNu3ScnBvDvgrYMBAuKraBCGsC2ASNtf0yDBjXaxWMkGxm1/gr4RB
	07S7F/feTQq+PMkN9gb8COaf9nRI8zzIRD3YOTrSSh8psCQJqhkT3LgsApxB2l6O
	08bxRYDYkZM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACB8611553;
	Wed,  4 May 2016 03:28:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0979B11550;
	Wed,  4 May 2016 03:28:23 -0400 (EDT)
In-Reply-To: <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 4 May 2016 02:07:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C87DAC90-11C9-11E6-A1EC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293504>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +enum sub_commands {
>
> How about calling this 'enum subcommand' (no underscore, non-plural)?
>
>> +       NEXT_ALL = 1
>> +};
>> +
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>> -       int next_all = 0;
>> +       int sub_command = 0;
>
> s/sub_command/subcommand/

Non-plural is a good suggestion, but remember that you are using
OPT_CMDMODE to parse out that thing.  There is already a name for
that concept: "command name".  Why not name these after that phrase,
just like merge-base, replace, and tag already do?
