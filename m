From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-config support for diff.relative setting
Date: Sat, 20 Dec 2014 18:58:56 -0800
Message-ID: <xmqq61d5d7yn.fsf@gitster.dls.corp.google.com>
References: <54954054.7080201@shysecurity.com>
	<CFEBFB254713492C988FED7E11475227@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <kelson@shysecurity.com>, "Git Mailing List" <git@vger.kernel.org>,
	"Duy Nguyen" <pclouds@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 03:59:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2Wjg-0002jt-RL
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 03:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbaLUC7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 21:59:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812AbaLUC7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2014 21:59:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC8F5297D3;
	Sat, 20 Dec 2014 21:58:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IwT3/J4RDEiaD7TIlO2WHofbEg=; b=ZORi9h
	qiBP39eRlnWvmG1FC4XyXO0EceQQNVKiJdCw+AtvW4gt5HvBtTYo+VyD1dEzTFBU
	y+0Boms9to0at4oX4hNVW21EVmERaw6+wa5rslLArC5hF0yz4o2awgOd8tuoYviM
	fpR9F7mej9xSpkxhcWPg0S/YQ9pcOH4cj/908=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xvXE2YN+Rhy5nV1vk93QoW8nJun/Pne7
	Ztnh8tbohfIf+gtoSK8kOhNoguPNQhdT5rVHJPy2PXzNhDF6eroq/BgJbbcHe8FL
	LbxQnAd84PqFwbsio0Sl+fjPjDHag6nq8MzP6vj1MrAZX1uMR4fMbGHwLMbWkCa/
	k3341FuKvDg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2A57297D2;
	Sat, 20 Dec 2014 21:58:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AFDE297D1;
	Sat, 20 Dec 2014 21:58:58 -0500 (EST)
In-Reply-To: <CFEBFB254713492C988FED7E11475227@PhilipOakley> (Philip Oakley's
	message of "Sat, 20 Dec 2014 14:32:46 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EF05FE4-88BD-11E4-B19E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261611>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: <kelson@shysecurity.com>
>> By default, git-diff shows changes and pathnames relative to the
>> repository root. Setting the diff.relative config option to "true"
>> shows pathnames relative to the current directory and excludes
>> changes outside this directory (identical to "git diff --relative").
> Shouldn't this `(identical to "git diff --relative")` also be included
> in the documentation change? It would truly clarify the intenbt for
> the reader.

A configuration that sticks a non-default behaviour without a way to
revert to the default is a no-no.

There should be a way to run non-relative diff in a repository that
has the configuration set, perhaps by overriding with some command
line option (e.g. "--no-relative").
