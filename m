From: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
Subject: Re: [PATCH 3/2] attribute "coding": specify blob encoding
Date: Sat, 05 Jan 2008 01:16:49 +0900 (JST)
Message-ID: <20080105.011649.26949633.tshibata@ab.jp.nec.com>
References: <7vsl1gy2si.fsf@gitster.siamese.dyndns.org>
	<200801032128.m03LSIn2022902@mi0.bluebottle.com>
	<7vejcyo9ql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Cc: nanako3@bluebottle.com, git@vger.kernel.org, tshibata@ab.jp.nec.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 04 17:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JApnA-0005s6-5B
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 17:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbYADQwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 11:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbYADQwn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 11:52:43 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:37066 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410AbYADQwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 11:52:40 -0500
Received: from mailgate3.nec.co.jp (mailgate54C.nec.co.jp [10.7.69.197])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m04GptCC004287;
	Sat, 5 Jan 2008 01:51:55 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id m04Gptm13224; Sat, 5 Jan 2008 01:51:55 +0900 (JST)
Received: from shoin.jp.nec.com (shoin.jp.nec.com [10.26.220.3])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id m04Gptse025333;
	Sat, 5 Jan 2008 01:51:55 +0900 (JST)
Received: from localhost ([10.19.71.63] [10.19.71.63]) by mail.jp.nec.com with ESMTP; Sat, 5 Jan 2008 01:51:53 +0900
In-Reply-To: <7vejcyo9ql.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 4.2 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69582>

On Thu, 03 Jan 2008 13:54:58 -0800, gitster wrote:
> しらいしななこ  <nanako3@bluebottle.com> writes:
> 
> > Quoting Junio C Hamano <gitster@pobox.com>:
> > 
> >> This teaches "diff hunk header" function about custom character
> >> encoding per path via gitattributes(5) so that it can sensibly
> >> chomp a line without truncating a character in the middle.
> >>
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> ---
> >>
> >>  * This is not intended for serious inclusion, but was done more
> >>    as a demonstration of the concept, hence [3/2].
> >
...
> >> +static struct {
> >> +	const char *coding;
> >> +	sane_truncate_fn fn;
> >> +} builtin_truncate_fn[] = {
> >> +	{ "euc-jp", truncate_euc_jp },
> >> +	{ "utf-8", NULL },
> >> +};
> >
> >Can you also do JIS and Shift JIS?  I ask because many of my
> >old notes are in Shift JIS and I think it is the same for many
> >other people. 
> 
> I guess somebody else could (hint, hint,...).  Shift_JIS should
> be more or less straightforward to add.
> 
> With the current code structure, however, ISO-2022 (you said
> "JIS" -- Japanese often use that word to mean 7-bit ISO-2022 and
> so did you in this context) is a bit cumbersome to handle, as
> you cannot just truncate but also have to add a few escape bytes
> to go back to ASCII at the end of line.

I guess that there are many other encodings and support everything are
not reasonable.
In my experience, It seems that chopping a multi-byte character
occurs the field after "@@". I believe this field is for the name of
the appropriate function. Also, I believe most of the function names
are in ASCII. 
So, question is why we should think of this field in case of non
programming language files ? 
In case of text file using any coding, Should we need to add something
after "@@"?
How about not to add anything after "@@" when the file name was .txt
or no extension (ie. HOWTO)?
