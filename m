From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] versionsort: support reorder prerelease suffixes
Date: Tue, 10 Mar 2015 00:52:27 -0700
Message-ID: <xmqqvbi91e84.fsf@gitster.dls.corp.google.com>
References: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
	<1424947441-19134-1-git-send-email-pclouds@gmail.com>
	<xmqqvbinhw7l.fsf@gitster.dls.corp.google.com>
	<xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
	<CACsJy8Bpta0rw1rjN8ROcUykPK508bvH_bvAJzLQQa6L6OmH7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVExu-0005R0-U4
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 08:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbbCJHwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 03:52:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751545AbbCJHwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 03:52:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 791F231F5D;
	Tue, 10 Mar 2015 03:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OjambEr+N/xqtW3yt2ES7+ojhGc=; b=Owpahx
	pjHA/CnhXJ6kwJUJsiDoXckTZZvm/Y3cFYm9/F2hcJhaoxVGk06Mby5XYqzr8/dI
	lZ7yO2wjHXHNFNR05s7fkuwb7nBQxibS33OA9ecw5JPgMLXHd9XL8/bpU9JLyDCw
	wK9y02vCRQdjEK9E2vJFHa/4eKzc0aJ3fNaQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gVtn7iw0Qd0iO1DIIqXVSsisjWGAOXWI
	AgtCldmXGjq+h49XenwpxaDjHlmvqhBcy7xZjqTeOqUIgQBPhhpCHcv6wFCbXsBT
	3cax1auBBniAfJtLfFLSK1uzUXObdDpKytxGnfWBPYyXlQnvo3RSIdW6cIYAZWw8
	TSe3hr6esrI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DA3D31F5C;
	Tue, 10 Mar 2015 03:52:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C46F831F5B;
	Tue, 10 Mar 2015 03:52:28 -0400 (EDT)
In-Reply-To: <CACsJy8Bpta0rw1rjN8ROcUykPK508bvH_bvAJzLQQa6L6OmH7w@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 9 Mar 2015 08:01:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 664A11FA-C6FA-11E4-9058-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265217>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 5, 2015 at 8:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> +versionsort.prereleaseSuffix::
>>>> +    When version sort is used in linkgit:git-tag[1], prerelease
>>>> +    tags (e.g. "1.0-rc1") may appear after the main release
>>>> +    "1.0". By specifying the suffix "-rc" in this variable,
>>>> +    "1.0-rc1" will appear before "1.0". One variable assignment
>>>> +    per suffix.
> ...
> How about..
>
> ".. "1.0-rc1" will appear before "1.0".  This key can be specified
> multiple times, one for each suffix. The order of suffixes in the
> config file determines the sorting order (e.g. if "-pre" appears
> before "-rc" in the config file then 1.0-preXX is sorted before
> 1.0-rcXX). The sorting order between different suffixes is undefined
> if they are in multiple config files"

OK. Later we might resurrect that "How would we spell 'reset this
variable' in our configuration file? Is that even a good idea in
the first place?" topic and at that time the last sentence may have
to change to make it more useful, but because we are not there yet,
the above would be a reasonable description.
