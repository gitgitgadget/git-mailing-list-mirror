From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 18:20:29 -0700
Message-ID: <7vzk77f602.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino> <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino> <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
 <20120710210901.GI8439@burratino> <7vehojgqgk.fsf@alter.siamese.dyndns.org>
 <20120710234717.GA21467@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 03:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SolbZ-0007Sf-NB
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 03:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab2GKBUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 21:20:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab2GKBUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 21:20:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65D3E9109;
	Tue, 10 Jul 2012 21:20:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CG7Vz3kQExEwrfGb7GJThtVNjv4=; b=KkVzX4
	uUDChK9TopNRbmEkXV8p35SlwdjdC3InWC790CZ5DV7EZ3b8tI9Sbx/PjsFwVLgQ
	lkq0TVdbGsw+R109PNtOSmhHDKgvw7sgWP+ttXnsGKc24EJJWOui3i/OxIikeZwZ
	Zeo3MJDl59O2V8jbEhLrXeBjkszYQbF4mtwgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sR4egFbQ9WRiOX5Q79JTdqWZaM3VPKTM
	H6Ml2R1ceBtngl5UznwxcBgL8ldEkb9wG8qPgDsu0He7b/vmv34NsQ+ygZuGVc9h
	tuoTQ1mujEj4bHyzB/4mzDhWBBSb5IwOG8VYnmeG8dSt1Q02MVEFeIfqZ3istcqn
	CxZCry/km9M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EA939108;
	Tue, 10 Jul 2012 21:20:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D38C09107; Tue, 10 Jul 2012
 21:20:30 -0400 (EDT)
In-Reply-To: <20120710234717.GA21467@burratino> (Jonathan Nieder's message of
 "Tue, 10 Jul 2012 18:47:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AFBD986-CAF6-11E1-9E96-BDA02E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201287>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The truth is that neither one of us is right.  Both conventions
> could work, and which one is more intuitive will vary from person
> to person.

It is not just person-to-person, I think.

In short, you are saying that, assuming that missing <start> and
<branch> are given a sane default values (namely "HEAD"), the
syntax:

	git branch <branch> [<start>]
	git branch --set-upstream-jrn [<branch>] <upstream>

is easier to understand, while I think

	git branch <branch> [<start>]
        git branch --set-upstream-to=<upstream> [<branch>]

so that omitted things can come uniformly at the end (of course,
unless the --option=argument in the middle is omitted, that is)
makes things more consistent.

I do not think it is productive to keep agreeing that we disagree
and continuing to talk between ourselves without waiting for others
to catch up, so I'll stop here.
