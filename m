From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON
 prerequisite
Date: Sun, 20 Feb 2011 15:55:33 -0600
Message-ID: <20110220215533.GB32142@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-4-git-send-email-avarab@gmail.com>
 <20110220021031.GB17305@elie>
 <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 22:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrHFn-0002TY-HV
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 22:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab1BTVzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 16:55:39 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54005 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab1BTVzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 16:55:38 -0500
Received: by iwn8 with SMTP id 8so1283192iwn.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+fX0Q8SX7P4f1VZ0Zu0oL6rIhn2htLK7wdUtHM6oOak=;
        b=h+XYn3LaGDCo1tahwQULMLhxcVII4wvzaSRLCMjArWcTIAhu9aXAohGZSOSYjGwU0h
         38PCPpcIjXF7R378qAkKUclmjBDDBTI2GF5heX6IHxqx8uiZ/EOw65NX9qgfaqNMceft
         6B5dhtbxcGcwqLZwzSSNrUrxxD5vKCaThbRrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r5vytVFuRkGNfjtsB6OW63WxlyTUmZeQjSP5xdL2f58PVmjFkFPjvn16Gk2eLJhhxA
         p/hLw57pAwJ3CFa93lAlhDZRp8N+N+tpAeoHGk+e1yH7tCZgOIbsQsc49XV8RnmOsapU
         2819MEwsY0bCDnv6AmpNROQgyR2E6o+970epI=
Received: by 10.231.129.68 with SMTP id n4mr605746ibs.67.1298238937608;
        Sun, 20 Feb 2011 13:55:37 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id i16sm4460167ibl.6.2011.02.20.13.55.35
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 13:55:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167429>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It's explicitly about tests that can't deal with poison, not
> non-English. See this comment in patch  28/72:
>
>     gettextize: git-commit "enter the commit message" message
>
>     Gettextize the "# Please enter the commit message for your change=
s."
>     message. Several tests in t7500-commit.sh and t7502-commit.sh ass=
ume
>     that this message starts with a newline. Change the tests to to s=
kip
>     under GETTEXT_POISON=3DYesPlease.

Shouldn't the functional part (the starting newline, opening # marks)
be untranslatable then, to avoid making a trap for translators?  Such
a fix could happen at any time, and until then, we could skip those
tests in the non-English case.

Since that codepath requires human intervention anyway (which is
generally slow), I can't imagine doing that would hurt runtime
performance enough to matter.

But I do get your point --- perhaps in some other circumstance we have
to rely on some intelligence by the translator for correct behavior.
So maybe it means something along the lines of

	test_set_prereq SANE_TRANSLATION

?
