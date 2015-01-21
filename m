From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH v2] Makefile: collect some Makefile variables instead of
 directly assignment
Date: Wed, 21 Jan 2015 15:33:43 +0600
Message-ID: <CANCZXo6DaSB4eiqQ6XrDpYMYeES50t1pi8CJwdzPZ2DOQpRjig@mail.gmail.com>
References: <1421830161-27623-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqzj9cwkq4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrfc-0001nM-U9
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbbAUJdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:33:49 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:54885 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbbAUJdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:33:44 -0500
Received: by mail-oi0-f48.google.com with SMTP id v63so407156oia.7
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ohBEfof7gb4n6Sp/N74krBr/tgjNadRLUha9DcnpFco=;
        b=F5rNmf38BMeOMk24DAOca80Ou9RRszAzw7/C35Y0QEQZMQAqxpFsduoB/Nqpw5k8Ur
         BMLGwg9zgMXUtt8REVx4A7I3Ese5r1usqGuqKPQ4I6T8Vh7NUGpcJ6G2tEzWJHSjH7Fm
         infjiumn+oSX7EXCuhJqPUx5NIfORPQRRAkR0UvwouRgQewZEAgoVM0EyIi81AkEzPvC
         NWy2BblY47SIzHbi+aZ6ggl/WGr5hJrkAmjT5ru+XNHXSQ97SkZnoTquMfEeoMaawEGz
         Z7TqgRRP9JqZ3JbdA2vGQrPPpbGZmaogXNPLVV9feVuhePzFEifLWmImVhNhhWtmRS1B
         C60g==
X-Received: by 10.60.52.132 with SMTP id t4mr24213504oeo.11.1421832823892;
 Wed, 21 Jan 2015 01:33:43 -0800 (PST)
Received: by 10.182.26.116 with HTTP; Wed, 21 Jan 2015 01:33:43 -0800 (PST)
In-Reply-To: <xmqqzj9cwkq4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262727>

Hello Junio,

2015-01-21 15:23 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> Some of Makefile variables as TEST_PROGRAMS_NEED_X and BUILTIN_OBJS filled
>> directly by hand, let's collect it with the standard functions of 'make' util.
>
> I am not sure if we want to do this.
>
> $(wildcard) is a double-edged sword.  It will grab any file that
> matches on the filesystem, not just the ones we want to include in
> the Git source set.  I often have a file called test-something and
> I'd prefer not to see such a random thing included in the build,
> only because the filename matches some pattern.

Yes, grabbing files by test-*.c is unreliable in this case. But what
about builtin/*.c?
Is there any plans that builtin will contain something another than
builtin object files?

>
> While "we consider anything with a name that match the pattern we
> say matter (e.g. test-*.c or builtin/*.c) as part of the source set"
> is sometimes handy (it allows us to be lazy), it risks surprising
> unsuspecting users.
>
> So I dunno.
