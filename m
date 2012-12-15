From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FW: Git log --graph doesn't output color when redirected
Date: Sat, 15 Dec 2012 10:30:12 -0800
Message-ID: <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Srb\, Michal" <michal.srb11@imperial.ac.uk>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjwVQ-0002Lv-VE
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab2LOSaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:30:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab2LOSaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:30:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A86DAD6A;
	Sat, 15 Dec 2012 13:30:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DZcOxta3oQNTeZn90Kq90QnSVQw=; b=CpsJhN
	w+mPn5pxzcqkrXHMVFvx0JEi0AwoxMb6LZ8XvLJGALwlpuAKDaw7x/LWznc+cnum
	aGTn4vlwIoeU80hLe5hRe9jwnCKXOQ+d46R5jwllaBfLYLr754dM1WrtlGYzTYly
	jQFbagWYBwk6ykNGC/wGhTNKrZALM+6mC/L5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j/XzYnfapicbGnj30d/BcbE4DYaWB+Ll
	P9r+ZUG4naX55rO5OSzzkiNBfvXV89eomAe8db1SXO8ZWrmo7fDdQkCH3dDjAa2T
	JCSYmrjaC+g5vL8Rej7EVmbWICJj8MfdL8VbuBIYWtNtkHg/fdJN1VMzP0HNx751
	DdZGZizqajo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 469FBAD69;
	Sat, 15 Dec 2012 13:30:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BF78AD67; Sat, 15 Dec 2012
 13:30:14 -0500 (EST)
In-Reply-To: <20121215101659.GB21577@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 15 Dec 2012 05:16:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77D5814E-46E5-11E2-A77B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211554>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 15, 2012 at 10:23:10AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> On Thu, Dec 13, 2012 at 8:13 PM, Jeff King <peff@peff.net> wrote:
>> > If you are using --format="%C(red)" or similar placeholders,
>> > they are the odd duck by not respecting the auto-color mode.
>> 
>> But they should, shouldn't they? Just asking. I may do it to when I
>> revive nd/pretty-placeholder-with-color-option.
>
> If I were designing --format today, I would certainly say so. The only
> thing holding me back would be backwards compatibility. We could get
> around that by introducing a new placeholder like %c(color) that behaves
> like %C(color), except respects the --color flag.

I think the %c(color) thing is a good way to go if we want to pursue
this.

Another possibility without wasting one more special letter would be
to allow %C(auto,red), perhaps like this (untested):

 pretty.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git i/pretty.c w/pretty.c
index dba6828..77cf826 100644
--- i/pretty.c
+++ w/pretty.c
@@ -960,12 +960,19 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	switch (placeholder[0]) {
 	case 'C':
 		if (placeholder[1] == '(') {
-			const char *end = strchr(placeholder + 2, ')');
+			const char *begin = placeholder + 2;
+			const char *end = strchr(begin, ')');
 			char color[COLOR_MAXLEN];
+
 			if (!end)
 				return 0;
-			color_parse_mem(placeholder + 2,
-					end - (placeholder + 2),
+			if (!memcmp(begin, "auto,", 5)) {
+				if (!want_color(GIT_COLOR_AUTO))
+					return 0;
+				begin += 5;
+			}
+			color_parse_mem(begin,
+					end - begin,
 					"--pretty format", color);
 			strbuf_addstr(sb, color);
 			return end - placeholder + 1;
