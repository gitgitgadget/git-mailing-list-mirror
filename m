From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 14:11:02 -0700
Message-ID: <xmqqtwi5mxeh.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
	<CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
	<CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
	<20160510230111.Horde.JpLRouwWbSCYp7yuvqhy5SS@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 10 23:11:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Evw-0005Ms-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbcEJVLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 17:11:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752791AbcEJVLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 17:11:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 400641B0F5;
	Tue, 10 May 2016 17:11:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FT9ksx/Zkpe7
	pkEhgwWZY5sYw/k=; b=I7c40vcZSI8yWDBnH/WFX0RvQPy4nrsVYm4z5YGocA5C
	3C+iSmvsvpLi6Mv4WNTfDMvxC/m4M2EzJNrhwWB7A9q2lyRragDqeGmU9CmUfNTF
	TxbowP6l/M6L603GzDYyh+9UANxp4xoXg7ekHJlW7R+9Ru2ug2ThLMN44h2X0Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YC0cDK
	WjQtUGPeuKjdF5WpvUUQOF01Ew3rqjLokKlTReVsAWQThkDxJHCZdRLwEglWFp7s
	ciSPMVmKjPvpw4MXRUcmpMB6sa6z68er8XtHCdpgqNhL7GE46WFdnZRk32vzuWEM
	DJnALVhip9/NZCSwaC9n5Fu6AyWb/hFddAoJA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 384041B0F4;
	Tue, 10 May 2016 17:11:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B40FC1B0F3;
	Tue, 10 May 2016 17:11:04 -0400 (EDT)
In-Reply-To: <20160510230111.Horde.JpLRouwWbSCYp7yuvqhy5SS@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 10 May 2016 23:01:11
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4D623DC-16F3-11E6-9D43-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294194>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I wonder if is it really necessary to specify the path to the .git
> directory via $GIT_DIR.  Would 'git --git-dir=3D/over/there' be just =
as
> good?

Then you are testing two different things that may go through
different codepaths.

Adding yet another test to check "git --git-dir=3D" in addition is
fine, but that is not a replacement.  We do want to make sure that
"GIT_DIR=3Dthere git" form keeps giving us the expected outcome.
