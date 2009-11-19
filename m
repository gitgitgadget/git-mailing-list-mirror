From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using `git tag -l` to get non-matching tags
Date: Thu, 19 Nov 2009 10:18:15 -0800
Message-ID: <7v1vjubcpk.fsf@alter.siamese.dyndns.org>
References: <c115fd3c0911190949x2f32d1cbw26f3260f12d43a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 19:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBBac-0005dR-Jf
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 19:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbZKSSSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 13:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbZKSSSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 13:18:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbZKSSSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 13:18:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EED1D7F183;
	Thu, 19 Nov 2009 13:18:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=MNPErwQUukakNg0GgoRkyoZDLrE=; b=n2FBNe
	VnOi/ZSBAzVkFBiCH0ZL852tGrmQ6NHmRCQYTrL/lkLtcqWl6HJiunESVb5RorB/
	J6pVF209sGK5zHlkFY9zsfV6RpHx4p+9ZujlxZjgEHjxxt5R+0Cc6R0Ju/plsK+a
	l/Dx4McsrMQ8xmBI8r9+buOeBlyq4rAWSdHtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0BG7eGeozUxZb3vj9KxCj9FVCHkdkvb
	O16ZAft6X4EmfDUiZbHqOHQvo4fR4hibUniqa2n/EOkKjKR+KEBe2Vk5HI+oiJG5
	TAlT5CJjlnZB4vaFUMSUgHedyJ1+pCKPmP5jF7T+DbuoOVs89jV/iFIQuGs1F9Ha
	PIrbbzuWkPQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD12C7F17E;
	Thu, 19 Nov 2009 13:18:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F21B7F172; Thu, 19 Nov
 2009 13:18:17 -0500 (EST)
In-Reply-To: <c115fd3c0911190949x2f32d1cbw26f3260f12d43a6e@mail.gmail.com>
 (Tim Visher's message of "Thu\, 19 Nov 2009 12\:49\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA46447A-D537-11DE-8B17-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133242>

Tim Visher <tim.visher@gmail.com> writes:

> I'm trying to use `git tag -l` to get non-matching tags.  I can't find
> anywhere in the documentation describing what is allowed in the tag
> pattern.

As a general guideline, refs are matched using glob not regexp and given
to fnmatch(3).

Who are you in your first sentence?

If you are an end user typing from the terminal trying to list tags
excluding some, the answer would be "piping to 'grep -v'".

If you are writing a tool that uses git, the tool uses a part of tag
namespace for its own use, and the tool is trying to enumerate end-user
tags by excluding the ones it uses for its own use, then the answer would
be "do not use 'git tag' in Porcelain---use 'git for-each-ref' and filter
its output yourself".
