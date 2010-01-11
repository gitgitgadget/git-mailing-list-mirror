From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 11 Jan 2010 08:22:04 -0800
Message-ID: <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:22:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN28-0006Y3-SV
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab0AKQWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 11:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786Ab0AKQWU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:22:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab0AKQWU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 11:22:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6728F753;
	Mon, 11 Jan 2010 11:22:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6eM1+k3FEk3D
	Sbogb71BHg8Tk0U=; b=C8nJumZNpK43jYyoORYF4fO5FMe/eHExHIYDCbmxFepk
	JOCLt3HI6hKJszHUUqu0YE0gSYaSDnZXfuVzgO89Mg2qcKr0QQQHcJ237JfVXCMu
	09nGqHZGmmeUdFB1pDuyfHi7AMpnWlQ1w4vV+lkSSOJIc2IThxb0k4n72LaXsU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FrOo7W
	rIRlRLOIKa7FHe78xf4OrpYK5RivqQ+W6q46ais7eZl8127CiKHC7aPDrjpQmJuN
	xSvkpLalAuXN4QojM8r9jH58E6qlZ5LyS3Oq842lUznqBQNSD/R/tL3e4ro8XAxd
	qigiHlDDLpiEsEbQaZOhlzweWMHd3PfuOM3Lw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D40638F750;
	Mon, 11 Jan 2010 11:22:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C704A8F74C; Mon, 11 Jan
 2010 11:22:05 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 11 Jan 2010 07\:59\:18 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 78EF0F9A-FECD-11DE-8130-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136638>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The bad news is that you broke multi-line greps:
>
> 	git grep --no-ext-grep -2 qwerty.*as
>
> results in:
>
> 	drivers/char/keyboard.c-unsigned char kbd_sysrq_xlate[KEY_MAX + 1] =3D
> 	drivers/char/keyboard.c-        "\000\0331234567890-=3D\177\t"      =
              /* 0x00 - 0x0f */
> 	drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"              =
            /* 0x10 - 0x1f */

Meh.  I checked pre-context codepath before sending the patch and was v=
ery
satisfied that Ren=C3=A9 did the right thing in 49de321 (grep: handle p=
re
context lines on demand, 2009-07-02), but somehow forgot about the post
context codepath.

An ObviouslyRightThing fix is this two-liner.  We shouldn't lookahead i=
f
we want to do something more than just skipping when we see an unmatch =
for
the line we are currently looking at.

 grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/grep.c b/grep.c
index 940e200..ac0ce0b 100644
--- a/grep.c
+++ b/grep.c
@@ -719,6 +719,8 @@ static int grep_buffer_1(struct grep_opt *opt, cons=
t char *name,
 		int hit;
=20
 		if (try_lookahead
+		    && !(last_hit
+			 && lno <=3D last_hit + opt->post_context)
 		    && look_ahead(opt, &left, &lno, &bol))
 			break;
 		eol =3D end_of_line(bol, &left);
