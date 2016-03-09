From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disown ssh+git and git+ssh
Date: Wed, 09 Mar 2016 13:56:39 -0800
Message-ID: <xmqqbn6ngvs8.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
	<1455546546-65710-1-git-send-email-cmn@dwim.me>
	<CAPig+cQ6JC65QkH=8nJ9Qwghr6cwv0BsB5TRDeg=gZmDpcdcHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:56:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adm64-00042f-IO
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 22:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbcCIV4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 16:56:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753394AbcCIV4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 16:56:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 556ED4C1F8;
	Wed,  9 Mar 2016 16:56:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nP28qWxbsonu
	hi/7z3TrRypFp+M=; b=xtaUSlcUlavxSBiSgWOy1ptwNZbuI+D/X24BB/iOBQFQ
	wAwqm7IbDCiA2p9fLR/NgUQO4JZyBjHfjsc1dDv1R1xvLZlA/KHT8r23swksVqFE
	pbl1FxAYl3jIs19wIGm1b8ulZQvkiZ3cb2+OqZ8wEU1ysUa0GUGeXynlZbvfJsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ced3Bu
	R0fuCGI4BpFVE8prU9lVXtBj9umDrTwx8fU3JQ9B8jmIKh2a47KQICII6Gdqrj6D
	6I0Z8LK9yhWfjyJrE7iVpE8nFZPg7SJZQnuGtsrTT4pEq/I74Sd+UFrKL8IwYrlZ
	+vFvRx1ATZNyilKplhBpwicFntgfuu/nqc2BA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D13E4C1F7;
	Wed,  9 Mar 2016 16:56:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C14394C1F6;
	Wed,  9 Mar 2016 16:56:40 -0500 (EST)
In-Reply-To: <CAPig+cQ6JC65QkH=8nJ9Qwghr6cwv0BsB5TRDeg=gZmDpcdcHg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 15 Feb 2016 13:16:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE0095DC-E641-11E5-9083-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288577>

Eric Sunshine <sunshine@sunshineco.com> writes:

> It might be helpful to cite some reference to support the claim that
> they are "silly" since it's not necessarily obvious to readers who di=
d
> not following the discussion.
> ...
>>                 || starts_with(url, "ssh://")
>> +               /*
>> +                * These ways to spell the ssh transport remain supp=
orted for
>> +                * compat but are undocumented and their use is disc=
ouraged
>> +                */
>>                 || starts_with(url, "git+ssh://")
>>                 || starts_with(url, "ssh+git://")) {
>
> A little "comment" bikeshedding: Aside from undesirably interrupting
> the code flow, these large comment blocks draw far too much attention
> from the reader than these deprecated spellings of "ssh" deserve, thu=
s
> making them seem overly important.

I've been waiting for an update for it but got tired of it.
Instead of discarding the topic, let's amend it like so:

-- >8 --
=46rom: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
Date: Mon, 15 Feb 2016 15:29:06 +0100
Subject: [PATCH] Disown ssh+git and git+ssh

Some people argue that these were silly from the beginning (see
http://thread.gmane.org/gmane.comp.version-control.git/285590/focus=3D2=
85601
for example), but we have to support them for compatibility.

That doesn't mean we have to show them in the documentation.  These
were already left out of the main list, but a reference in the main
manpage was left, so remove that.

Also add a note to discourage their use if anybody goes looking for the=
m
in the source code.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 2 +-
 connect.c             | 4 ++--
 transport.c           | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d987ad2..2f90635 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1122,7 +1122,7 @@ of clones and fetches.
 	    connection (or proxy, if configured)
=20
 	  - `ssh`: git over ssh (including `host:path` syntax,
-	    `git+ssh://`, etc).
+	    `ssh://`, etc).
=20
 	  - `rsync`: git over rsync
=20
diff --git a/connect.c b/connect.c
index fd7ffe1..3babb81 100644
--- a/connect.c
+++ b/connect.c
@@ -267,9 +267,9 @@ static enum protocol get_protocol(const char *name)
 		return PROTO_SSH;
 	if (!strcmp(name, "git"))
 		return PROTO_GIT;
-	if (!strcmp(name, "git+ssh"))
+	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
 		return PROTO_SSH;
-	if (!strcmp(name, "ssh+git"))
+	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
 		return PROTO_SSH;
 	if (!strcmp(name, "file"))
 		return PROTO_FILE;
diff --git a/transport.c b/transport.c
index 67f3666..908e08b 100644
--- a/transport.c
+++ b/transport.c
@@ -1001,8 +1001,9 @@ struct transport *transport_get(struct remote *re=
mote, const char *url)
 		|| starts_with(url, "file://")
 		|| starts_with(url, "git://")
 		|| starts_with(url, "ssh://")
-		|| starts_with(url, "git+ssh://")
-		|| starts_with(url, "ssh+git://")) {
+		|| starts_with(url, "git+ssh://") /* deprecated - do not use */
+		|| starts_with(url, "ssh+git://") /* deprecated - do not use */
+		) {
 		/*
 		 * These are builtin smart transports; "allowed" transports
 		 * will be checked individually in git_connect.
--=20
2.8.0-rc1-142-g215006a
