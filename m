From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow to specify the editor used for git rebase -i by
 config/environment var
Date: Mon, 17 Oct 2011 14:36:27 -0700
Message-ID: <7v1uubl2qs.fsf@alter.siamese.dyndns.org>
References: <57346812.Rh0UlzroDp@soybean>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Oct 17 23:36:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFurL-0005rf-1O
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 23:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab1JQVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 17:36:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab1JQVg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 17:36:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC1F455DA;
	Mon, 17 Oct 2011 17:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ykC1OVZxmsmSyiN53JvN5mQx3g=; b=MP+uHs
	UgKpJG0dy7iwYdnAKQTMbsWgO06adH+wCy5Aw8UQAfglPgS68Wc0zSK7mFjoQ1DO
	LSJF5OkQfJIK/o3wHtfzPFCHnO5/hVQPQage4QiIN/LJYacz57fm7Kg8bfLjN5+G
	m9DDGvhMxC8GgavgVVCYIs4k4cWy1QIpLm2kU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vYclVGVPDwPMgJKiX09R1qPV/a/mBmLe
	jO+oVajzhOzbFITlQEY+soh0BkkQ3m2IBBp+LzM24VH9MdXY36z0QPS9cfynnNFX
	EQ/p3rVUlEfoLfr/Em9hWrKB7G8ePgAlOVlLC6fOAjPQPwycx2gJsRTemeWawIPm
	8xQdgMGCNaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D37E055D9;
	Mon, 17 Oct 2011 17:36:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67E7155D8; Mon, 17 Oct 2011
 17:36:28 -0400 (EDT)
In-Reply-To: <57346812.Rh0UlzroDp@soybean> (Peter Oberndorfer's message of
 "Mon, 17 Oct 2011 22:26:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 125EB58C-F908-11E0-BBCA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183826>

Peter Oberndorfer <kumbayo84@arcor.de> writes:

> The search order for choosing the sequence editor is:
> $GIT_SEQUENCE_EDITOR
> git config sequence.editor
> git var GIT_EDITOR (default editor for commit messages)
>
> With this change is it possible to have a separate
> (possibly graphical) editor that helps the user
> during a interactive rebase.
>
> Using $GIT_EDITOR or core.editor config var for this is not possible
> since they is also used to start the commit message editor for reword action.

Thanks. I'll reword the proposed commit log message before queuing,
because it won't make _any_ sense to talk about the search order before
telling what these things that are searched would do, or why they are
useful things to have.

    "rebase -i": support special-purpose editor to edit insn sheet

    The insn sheet used by "rebase -i" is designed to be easily editable by
    any text editor, but an editor that is specifically meant for it (but
    is otherwise unsuitable for editing regular text files) could be useful
    by allowing drag & drop reordering in a GUI environment, for example.

    The GIT_SEQUENCE_EDITOR environment variable and/or the sequence.editor
    configuration variable can be used to specify such an editor, while
    allowing the usual editor to be used to edit commit log messages. As
    usual, the environment variable takes precedence over the configuration
    variable.

    It is envisioned that other "sequencer" based tools will use the same
    mechanism.

    Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
