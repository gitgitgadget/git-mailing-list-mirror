From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 00:53:43 -0700
Message-ID: <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
References: <4D871972.7080008@elegosoft.com>
 <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, szeder@ira.uka.de, spearce@spearce.org,
	bebarino@gmail.com, ted@tedpavlic.com, tlikonen@iki.fi,
	trast@student.ethz.ch
To: Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 08:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1wQ0-0003FS-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 08:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab1CVHyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 03:54:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab1CVHyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 03:54:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A48BA291B;
	Tue, 22 Mar 2011 03:55:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VqWWg5u2XVReq/y/vbVOxGFUqQA=; b=o/JJei
	atZAl44JmkM2m8DLmf+oaCM/INZZrdKDmQFfa36+Mc5TXzlmz+tUUSYZXWBUS9G0
	bcTsjXe0qzV0hNEoZTnKhKA6etbauSDLIks1Dby+SRuwWJkIIZFFc4/trG+5FnAH
	zB/YBGerWzqVY8VKC2KXSkoHgw/czMmbxYL0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nj6hehh9N3SFhqpmSZMW+Lmt8/YqpszO
	1xAHwIZw0yRZ24Y5mFFtCxjjnvFvAe2kt602fI8UuuEMWzr9gMFGhqLPCg71QxA3
	cv0dlG5c67Xy09ZE8DwfapJFn2NYTKW2dspgoqlGpCx0/xfYalldQCgaXE/jzav4
	kzuvFUzzts0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE60B2919;
	Tue, 22 Mar 2011 03:55:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 270C62915; Tue, 22 Mar 2011
 03:55:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1103212302000.1561@bonsai2> (Johannes
 Schindelin's message of "Mon, 21 Mar 2011 23:07:15 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5D3FAEA-5459-11E0-9E6C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169705>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > diff --git a/contrib/completion/git-completion.bash
>> > b/contrib/completion/git-completion.bash
>> > index 893b771..f9a74d3 100755
>> > --- a/contrib/completion/git-completion.bash
>> > +++ b/contrib/completion/git-completion.bash
>> > @@ -1506,7 +1506,7 @@ _git_help ()
>> >  		;;
>> >  	esac
>> >  	__git_compute_all_commands
>> > -	__gitcomp "$__git_all_commands
>> > +	__gitcomp "$__git_all_commands $(__git_aliases)
>> >  		attributes cli core-tutorial cvs-migration
>> >  		diffcore gitk glossary hooks ignore modules
>> >  		repository-layout tutorial tutorial-2
>> 
>> This patch may not be _wrong_ per-se, but it it useful in practice?
>> 
>> I dunno.
>> 
>> Don't people usually use aliases so that they do not have to type long
>> command names that would need completion?
>
> Yes. And if you use a lot of aliases, or a lot of machines with evolving 
> aliases, the easiest way to inspect the alias is "git help <alias>". Not 
> seeing it completed is an unexpected behavior.

I've queued the patch and I already said that this is not wrong, but I
think your argument cuts it both ways.

I have "co" aliased to "checkout", but with this change "git help co<TAB>"
now will interfere with my expectation that it would complete to commit,
config and the like, but exclude an alias that I myself defined and know
how to spell but forgot what its exact definition was, in order to avoid
cluttering the choices offered.

This is a constructive tangent but if we are going to run $(__git_aliases)
every time we run _git_help, perhaps it would want a hack similar to the
way the value for $__git_all_commands is generated just once?
