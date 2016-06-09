From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] fixup! d5ad6c13
Date: Wed, 08 Jun 2016 17:10:37 -0700
Message-ID: <xmqqporrjk76.fsf@gitster.mtv.corp.google.com>
References: <20160608225818.726-1-gitster@pobox.com>
	<20160608225818.726-4-gitster@pobox.com>
	<CAGZ79kYjaWJ8=3rizFE+EZXS3P1LjX8bGD-6LwfmjG83cjgVJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnYb-0007fL-7r
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 02:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933758AbcFIAKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 20:10:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933755AbcFIAKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 20:10:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7132F22847;
	Wed,  8 Jun 2016 20:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bqAGXt5rrOso5HSOw3OBGw2PnYg=; b=IeVoqA
	4NrLqahbcd/sFqQJYRpK215FAyF2a81PV3kIXrxUNSVjL7v6W8SaL93KQhwKFxWS
	PjnBHbWSL22vd4HHFwqNyiuW5IjiMLUNCdHeHlQ0DW2zxslqS1t0uED+KBPr4SI0
	46zqo42zwCVoeLvvkWgwoUCGpwjNATkXzAV00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XOCnkl33CZ4s93SJbsRmhT4g5CVEJH0E
	Nbuq2ScfhGsKVhGbd6y19GGYAJDuCB4cQZ6zSSUPpL+xMwjqcIRrXeXsP3U62IPQ
	LKQ64h0hP4LaKLrj7J9KG5IR43Mg9uCAY6BCe7Yqj7xt7C+9dpqKJE46/KFAq3gs
	dVPX3T5cC/Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6610222846;
	Wed,  8 Jun 2016 20:10:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBF2922844;
	Wed,  8 Jun 2016 20:10:38 -0400 (EDT)
In-Reply-To: <CAGZ79kYjaWJ8=3rizFE+EZXS3P1LjX8bGD-6LwfmjG83cjgVJQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 8 Jun 2016 17:00:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98AD065E-2DD6-11E6-9746-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296864>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Jun 8, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> As the topic is in 'next' already, I'll leave this floating near the
>> tip for now, until we can rewind the topic after the next release.
>
> I don't quite understand the motivation behind this commit.
>
>     We return the last element to allow succeeding operations
>     access to the bottom of the stack without needing to walk it?
>     This makes the follow up operations faster, because we expect the stack
>     to be larger than 5 elements.
>
> ?

Think how you call _append() that returns void and then set the
value to the last appended item.  YOu'd need to do something
unwieldy like

	git_attr_check_append(check, attr);
	check->check[check->check_nr-1].value = value
