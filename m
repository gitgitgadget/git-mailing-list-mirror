From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Sat, 16 Mar 2013 21:47:29 -0700
Message-ID: <7vobeityxq.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com>
 <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
 <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
 <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
 <514343BA.3030405@web.de> <7vvc8svc2r.fsf@alter.siamese.dyndns.org>
 <51435D49.6040005@web.de> <7v4ngcv35l.fsf@alter.siamese.dyndns.org>
 <51438F33.3080607@web.de> <7vzjy4tjd5.fsf@alter.siamese.dyndns.org>
 <51441D8E.7090303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 17 05:48:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH5Vo-0003ff-KY
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 05:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802Ab3CQErd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 00:47:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab3CQErc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 00:47:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1B0480D2;
	Sun, 17 Mar 2013 00:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ehRHk1l/cvsk
	YEEwd3tAtzx1Z8I=; b=afjk18ofrSv16ftbgQJhV0MRVX/s8uQuf7TvaIkrhE7C
	i2DD6E4EcRLxE2vbA3qET5NBGMzmfJrekkYLgetEoC7FEOnI3Ebd+buO9Xbrm+BE
	KKdhST8ylNhPn+GEkmZfOQGd2HJuEXT36/E1Igmhq+XKvPGrxRiB81+5dHdlvqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rVP28Z
	lrsm6sH40SSxB8qG5UMsHYPlZVwxEoE4jwnYnCY/en8ao4RvwR8wZlbnLx+Z6C1F
	orO4DtPL0ZuDP+Ojzk+x8wvJtRNpfpfEL80EKdxQNK4iCYvKGTzVAUu/+Xra3p4v
	t7AWXPUn3sRk1nmJ1QsdRUspzXLxZu3o8zqaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4A2B80D1;
	Sun, 17 Mar 2013 00:47:31 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EBC680D0; Sun, 17 Mar 2013
 00:47:31 -0400 (EDT)
In-Reply-To: <51441D8E.7090303@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sat, 16 Mar 2013 08:21:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6E45D6C-8EBD-11E2-A1AC-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218326>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Or we can be more explicit and say
>>=20
>> # It took 2.58 seconds to search for untracked files.  'status -uno'
>> # may speed it up, but you have to be careful not to forget to add
>> # new files yourself (see 'git help status').
>>=20
> Thanks, that looks good for me

OK, then I'll squash this in to the version queued to 'pu', but we
should start thinking about merging these multi-line messages into
one multi-line strings that is split by the output layer to help the
localization folks, using something like strbuf_commented_addf() and
strbuf_add_commented_lines().

diff --git a/wt-status.c b/wt-status.c
index 6e75468..53c2222 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,10 +1027,14 @@ void wt_status_print(struct wt_status *s)
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("It took %.2f seconds to enumerate untracked files."),
+				 _("It took %.2f seconds to enumerate untracked files."
+				   "  'status -uno'"),
 				 s->untracked_in_ms / 1000.0);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				 _("Consider the -u option for a possible speed-up?"));
+				 _("may speed it up, but you have to be careful not"
+				   " to forget to add"));
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				 _("new files yourself (see 'git help status')."));
 		}
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%=
s"),
