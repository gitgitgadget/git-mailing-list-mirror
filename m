From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Bug: pull --rebase with =?utf-8?Q?=C3=A9?= in name
Date: Tue, 6 Mar 2012 09:36:31 +0100
Message-ID: <87399mazxs.fsf@thomas.inf.ethz.ch>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
	<20120305102657.GB29061@sigill.intra.peff.net>
	<87399nqqog.fsf@thomas.inf.ethz.ch>
	<F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
	<20120305115815.GA4550@sigill.intra.peff.net>
	<0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
	<87ipijkxlm.fsf@thomas.inf.ethz.ch>
	<20120305132913.GA15004@sigill.intra.peff.net>
	<7v8vjf2c8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Haber <rene@habr.de>,
	<git@vger.kernel.org>, Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4pss-0005p6-U3
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758707Ab2CFIge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 03:36:34 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:4186 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758704Ab2CFIgd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 03:36:33 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 09:36:34 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 09:36:31 +0100
In-Reply-To: <7v8vjf2c8o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 05 Mar 2012 09:23:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192313>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> It would be nice if the --pretty format placeholders had a "shell-qu=
ote"
>> modifier, and we could just do:
>>
>>   git show --format=3D'GIT_AUTHOR_NAME=3D%(an:shell)'
>>
>> or something similar. for-each-ref knows about shell-quoting, but we
>> can't use it here, because we are looking at arbitrary commits, not =
just
>> ones pointed to by refs.
>
> You guys seem to have been having a lot of fun overnight. Perhaps I
> should live on European time?

IIUC Peff just got up at an unreasonably early time to have fun with us
Europeans?

> I think there were talks about cross pollinating and eventually
> unifying the placeholder languages of pretty and for-each-ref, and
> if we were to do so, I agree that --pretty definitely should learn
> to do --sq. But I do not think we want to teach everything :shell;
> following the style of %w(), something more generic that would apply
> to any payload would be preferred, perhaps giving an end result like
> this:
>
> 	git show -s --format=3D'
> 		GIT_AUTHOR_NAME=3D%(sq-begin)%an%(sq-end)
>                 GIT_AUTHOR_EMAIL=3D%(sq-begin)%ae%(sq-end)
>         '

How about something along the lines of %Q(%an) instead?  Though at leas=
t
implementation-wise, it should be possible to make %'%an%' work, too,
which would be rather cute.

> In any case, my reading of the conclusion you guys have already
> reached in this thread is that the issue is not even a bug in Git,
> but is a broken build/installation of sed by a third-party.  I am
> inclined to suggest any change to get_author_ident_from_commit
> helper backburnered before we teach --sq to --pretty machinery.

Ok.

This is the second "victim" of this broken install of sed, however.  I
wonder where Ren=C3=A9 and Will got it from?  Perhaps this is "the" com=
mon
way of getting GNU sed on OS X, and thus more widespread than we might
think.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
