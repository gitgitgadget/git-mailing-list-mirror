From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Apr 2013, #10; Mon, 29)
Date: Sat, 4 May 2013 10:40:16 +0200
Message-ID: <87y5bvyw7j.fsf@hexa.v.cablecom.net>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 04 10:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYY16-0003qH-B5
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 10:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab3EDIkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 04:40:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10790 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685Ab3EDIkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 04:40:21 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 4 May
 2013 10:40:14 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 4 May
 2013 10:40:17 +0200
In-Reply-To: <7vppxdgife.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 29 Apr 2013 14:01:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223362>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/config-ignore-inaccessible (2013-04-15) 1 commit
>  - config: allow inaccessible configuration under $HOME
>
>  When $HOME is misconfigured to point at an unreadable directory, we
>  used to complain and die. This loosens the check.
>
>  I do not think we agreed that this is a good idea, though.

As a data point: yesterday on IRC, two users complained that they each
had this problem.

  http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3022
  http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3111

So for one thing, "ha ha we told you so" is not an extremely
satisfactory answer, especially since we only "told them so" with the
recent doc update.  Wouldn't a stern warning or even an early error be
better?  It could be tempered by checking that HOME agrees with what
getpwnam says should be the HOME of the existing user, and checking that
it is not readable, before warning; more experienced users like the
scenario you mention in

  http://thread.gmane.org/gmane.comp.version-control.git/220661/focus=220921

would make sure that at least one of those conditions is not true.

But for another, they both claim that it fails even with HOME unset(!)
and even with a completely empty environment.  I cannot reproduce this,
but there might be another issue lurking?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
