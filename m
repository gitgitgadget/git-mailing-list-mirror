From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git remote add: allow re-adding remotes with the same URL
Date: Tue, 23 Dec 2014 10:51:15 -0800
Message-ID: <xmqq8uhy2o9o.fsf@gitster.dls.corp.google.com>
References: <20141216021900.50095.24877@random.io>
	<cover.1419267895.git.johannes.schindelin@gmx.de>
	<9c0c693efe68b1c0b080c14104bb6c5f7bf74097.1419267895.git.johannes.schindelin@gmx.de>
	<xmqq1tnrbmn1.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231425220.21312@s15462909.onlinehome-server.info>
	<CAPc5daXcXs+Sw8jr65dmLnpf6LQ6Lr34y80bxSf2AhhFyXa_mQ@mail.gmail.com>
	<alpine.DEB.1.00.1412231923560.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: anapsix@random.io, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:51:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3UYE-00020U-IL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbaLWSvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:51:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756507AbaLWSvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:51:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F31A291D2;
	Tue, 23 Dec 2014 13:51:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B1lTQbYK+tLe5vQdFsQP/Jwvu1s=; b=UhsEq1
	rnXLvw/D8b/T5VjGcZ1q6aCWVG5JNiBq7tLFBVBJ+FLceDLvtkSdKAaDWqMcMQFr
	lHu4BT9mfxXcUG7aGbmrAHKfkEuNt2HtmrvtIXP/ajGT7ViM1WKPbWfhoFPu2AVa
	rZ+8HU2fNnDrRwdoiycLBRkAzY/BLXH2JxcW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gz6WcJe7C/Olds8FZPZoLFREtVFPljD5
	2R5vjJ4opxsxGdIavvx94nS4fyBd4pqJeFdDI+pWG5GV+vog60SH3CowzkE33lfk
	mgrf/Rzla5DvaRPvWwzpVV6WdKHNL8e0fNRDqU3efEY7FDQrY5l2gztzzC3KJ5t7
	lOJtAFyJfVo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66AEA291D0;
	Tue, 23 Dec 2014 13:51:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC6C3291CE;
	Tue, 23 Dec 2014 13:51:16 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231923560.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 19:26:55 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD0F78D0-8AD4-11E4-AA49-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261762>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > I hope v2 addresses your concerns.
>> 
>> Unfortunately I am still confused.
>> 
>> The way the overlong line is folded in the new version of the patch
>> makes it easier to read, but I didn't find a reason why checking the
>> number of fetch_refspec does not go against that goal there.
>
> Since you pointed out rightfully that the main goal is *not* to allow
> multiple `git remote add` to succeed when they try to add the same remote
> with the same URL, I changed the commit message to point out that the goal
> was to handle adding remotes via `git remote add <nick> <url>` when
> url.<url>.insteadOf = <nick> already exists, with the same <nick> and
> <url>.
>
> Since I have no interest in opening the can of worms to allow re-adding
> remotes, I did not touch that part at all, I hope you do not mind.

Oh, don't get me wrong.  I do not have any interest in allowing
re-adding remotes, either, so we are on the same page.

I was just saying that it was unclear what ensures that the change
in the codepath only affects the remote setting that conflicts with
"insteadOf" without randomly (read: sometimes it allows, sometimes
it forbids) allowing re-adding remotes.
