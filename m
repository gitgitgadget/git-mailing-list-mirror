From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 01:56:19 -0700
Message-ID: <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <20090823171819.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 10:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf8sd-0005j5-Iy
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 10:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbZHWI4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 04:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbZHWI4a
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 04:56:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbZHWI43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 04:56:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70FC71503F;
	Sun, 23 Aug 2009 04:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FIM5mGIxu1u/J77juyE10iN7QUo=; b=c904A5vXcd4SHVvPHHT9iBo
	vMTN736ItOwXN0jv908RU2uZiSLMONXf5EM431b91je15UYtmRrl5V8cTxF9Kc59
	5WoFiKJQNKcCy9Rbv2r/DpwW0QOk81TIL6cGW7kmBtl1K3FhfZD8CK/X9oxbiqSA
	UQVgcr03nqSWNqV2/pKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=U+iKtspe0uCWV3aTMi4aiRIQW0P7kTxV/0IIpltrRzRaD+2bO
	DHy4zQ5cPCaLlvIT1hKZtk/lU//D/Z8BWrQzt9ekvZrO4YBEnmjkTAWFxpkWdk0c
	uZpC8E4HcwvkxeW5rcDcA4d/CoWVGZOTD49TmcGIYwomKPeuDIr5qfKSy0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 319CA1503D;
	Sun, 23 Aug 2009 04:56:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 250B01503C; Sun, 23 Aug
 2009 04:56:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D708418E-8FC2-11DE-A295-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126850>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> How about doing it like this patch instead?  This counterproposal replaces
>> your 3 patches starting from [3/6].
>>
>> -- >8 --
>> Subject: xutils: Fix xdl_recmatch() on incomplete lines
>>
>> Thell Fowler noticed that various "ignore whitespace" options to
>> git diff does not work well with whitespace glitches on an incomplete
>> line.
>
> I think this should be "options to git diff don't work".

Soory, I kant speel; thanks.

> (1) Why do you post patches to the list, instead of committing them
> yourself?

So that others can catch silly mistakes of mine, like the one you just
caught.

I play three separate roles here, two of which I should send patches out
while playing them.

 * Just like everybody else, I find itches to scratch from time to time,
   and I build my own topic branches locally for the changes to scratch
   them, just like other contributors.

   They are indeed committed and often immediately merged to 'pu', but I
   send out format-patch output for them, because I firmly believe that
   the development _process_, not just the end result, should be in the
   open.  Everybody's patch should go through the list, get reviewed and
   improved by help from others.  So should mine.

 * I read others' patches, review, comment, and suggest improvements and
   make counterproposals, just like others on the list.

   The "how about" patches when I am playing this role are often not meant
   as the final shape of the patch but to show the direction to improve
   upon.  They are output from "git diff", not format-patch nor even "git
   diff --cached"---I do not commit, nor even add them to the index---and
   after I send out e-mails, I typically reset them away to work on
   something else, because they are usually not my itch.

 * I accept patches that were reviewed favorably on the list by running
   "git am" on them.

> (2) How do I apply a patch like this one to try to my tree? Am I
> expected to edit the mail message to remove everything before the shears
> mark before running the git-am command?

That is how I have been doing it.  My workflow is:

 (1) First read patches in my primary mailbox, while copying promising
     ones to a separate mailbox;

 (2) And then go through the separate mailbox as a separate pass, while
     fixing obvious typos and minor coding style violations still inside
     mailbox; and finally

 (3) Run "git am" on the (possibly edited) patch to apply.

Because I'll be editing the messages (both log and code) _anyway_,
removing everything before the scissors mark is not much of a trouble.

Having said that, I could use something like this.

-- >8 -- cut here -- >8 -- 
Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark

This teaches mailinfo the scissors -- >8 -- mark; the command ignores
everything before it in the message body.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mailinfo.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b0b5d8f..461c47e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -712,6 +712,34 @@ static inline int patchbreak(const struct strbuf *line)
 	return 0;
 }
 
+static int scissors(const struct strbuf *line)
+{
+	size_t i, len = line->len;
+	int scissors_dashes_seen = 0;
+	const char *buf = line->buf;
+
+	for (i = 0; i < len; i++) {
+		if (isspace(buf[i]))
+			continue;
+		if (buf[i] == '-') {
+			scissors_dashes_seen |= 02;
+			continue;
+		}
+		if (i + 1 < len && !memcmp(buf + i, ">8", 2)) {
+			scissors_dashes_seen |= 01;
+			i++;
+			continue;
+		}
+		if (i + 7 < len && !memcmp(buf + i, "cut here", 8)) {
+			i += 7;
+			continue;
+		}
+		/* everything else --- not scissors */
+		break;
+	}
+	return scissors_dashes_seen == 03;
+}
+
 static int handle_commit_msg(struct strbuf *line)
 {
 	static int still_looking = 1;
@@ -723,10 +751,17 @@ static int handle_commit_msg(struct strbuf *line)
 		strbuf_ltrim(line);
 		if (!line->len)
 			return 0;
-		if ((still_looking = check_header(line, s_hdr_data, 0)) != 0)
+		still_looking = check_header(line, s_hdr_data, 0);
+		if (still_looking)
 			return 0;
 	}
 
+	if (scissors(line)) {
+		fseek(cmitmsg, 0L, SEEK_SET);
+		still_looking = 1;
+		return 0;
+	}
+
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
-- 
1.6.4.1
