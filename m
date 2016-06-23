Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C372018A
	for <e@80x24.org>; Thu, 23 Jun 2016 17:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbcFWRKm (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 13:10:42 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51690 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415AbcFWRKk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 13:10:40 -0400
X-AuditID: 12074411-2b3ff700000008f0-26-576c18053315
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0C.76.02288.5081C675; Thu, 23 Jun 2016 13:10:30 -0400 (EDT)
Received: from [192.168.69.130] (p508EAB27.dip0.t-ipconnect.de [80.142.171.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5NHARLo003075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 23 Jun 2016 13:10:28 -0400
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <20160616174620.1011-1-sbeller@google.com>
 <20160617153637.GA9314@sigill.intra.peff.net>
 <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <576C1803.5050905@alum.mit.edu>
Date:	Thu, 23 Jun 2016 19:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqMsmkRNuMGGKokXXlW4mi92L+5kt
	frT0MFts3tzO4sDisXPWXXaPBZtKPZ717mH0+LxJLoAlitsmKbGkLDgzPU/fLoE7Y+7dD6wF
	n7QrenZfYGtg3C3XxcjJISFgIrFzxQ1GEFtIYCujxPP3SV2MXED2eSaJrU//MIMkhAUiJK4c
	fQRWJCLgKPHi2UJ2iKK1jBK/Z25hBUkwC8RLfH/9FKyITUBXYlFPMxOIzSugLbHu4HJ2EJtF
	QFVi4uajbCC2qECIxPl1W1khagQlTs58wgJicwoESrzet4gNYqa6xJ95l5ghbHmJ7W/nME9g
	5J+FpGUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJXMEd
	jDNOyh1iFOBgVOLhfSGeEy7EmlhWXJl7iFGSg0lJlNdIDCjEl5SfUpmRWJwRX1Sak1p8iFGC
	g1lJhNdaBCjHm5JYWZValA+TkuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLg9QcZKliU
	mp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KyfhiYFSCpHiA9naAtPMWFyTmAkUhWk8x
	WnIc2X9vLRPHnV0PgOS8SbuOMQmx5OXnpUqJ81qDNAiANGSU5sGtg6WvV4ziQN8L8x4GqeIB
	pj64qa+AFjIBLbzbnw2ysCQRISXVwFiffND2p8QTtcqb26d8nfhZ7p1WW821RQKpz16KVaeU
	arzmvOj2xJaZ+Rn7gb2HJu5f6n3i9mQmnyuxqpPmTY68+dE1vuPjl8nu6yy2/+TuP7bXm/f0
	okQfh+3Xv09Jin3+zTh1WSlT9iqpGS9c35qJbAg7XXym4FO14NkkT/9XPKI/bc3XXr2ixFKc
	kWioxVxUnAgAGxRakDoDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/17/2016 06:09 PM, Stefan Beller wrote:
> I think before spending more time on discussing and implementing new
> (hopefully better) heuristics, I'd want to step back and try to be a bit more
> systematic, i.e. I'll want to collect lots of test cases in different languages
> and use cases. A mini test suite, maybe?

Stefan,

I've also been playing around with diff heuristics and also trying to
find some good test data. Have you put together some test cases yet?

In case you are interested, the current iteration of my heuristic
considers six things to determine a "score" for breaking a diff above a
particular line:

* `blank` -- is the line blank?
* `indent` -- the indentation of the line (if it is not blank)
* `pre_blank` -- is the preceding line blank?
* `pre_indent` -- the indentation of the closest preceding non-blank
  line
* `post_blank` -- is the following line blank?
* `post_indent` -- the indentation of the closest following non-blank
  line

The meat of the scoring algorithm is below. I compute the score for the
beginning and the end of the insert/delete block for each candidate
shift of an insertion/deletion hunk, then choose the one that has the
lowest score.

There are some adjustable "bonus" values below. The values shown give
quite good results for C, shell, Python, XML, Ruby, CSS, YAML, and HTML
in the couple of projects that I've tried it on. But I haven't done
enough systematic testing over a large enough corpus to know whether the
parameters could be improved or whether there are types of code that it
performs really terribly on.

Right now my program doesn't output diffs in the usual format, but
rather as a diff notated with various information. So it's not in a form
that other people could use so easily. Here's an example:

> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>                   *
>                   * Default behaviour is to initialize the notes tree from the tree object
>                   * specified by the given (or default) notes ref.
>                   */
>                  #define NOTES_INIT_EMPTY 1
>     |     -4     
>     |     -6 +   /*
>     ||    28 +  + * By default, the notes tree is only readable, and the notes ref can be
>     ||       +  + * any treeish. The notes tree can however be made writable with this flag,
>     ||       +  + * in which case only strict ref names can be used.
>     ||       +  + */
>     ||       +  +#define NOTES_INIT_WRITABLE 2
>      |       +  +
>      |          +/*
>                   * Initialize the given notes_tree with the notes tree structure at the given
>                   * ref. If given ref is NULL, the value of the $GIT_NOTES_REF environment
>                   * variable is used, and if that is missing, the default notes ref is used
>                   * ("refs/notes/commits").
>                   *
>                   * If you need to re-initialize a notes_tree structure (e.g. when switching from
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The two columns of vertical bars show the highest and lowest range of
lines that this insertion block can be shifted to. The numbers show the
score for breaking the diff above that line. The first column of +/- is
where this version of the heuristic would place the diff, and the second
column is where the master version of Git would place it.

My program can also search for and output "slideable" insertion/deletion
blocks, so it can be used to find diffs that are theoretically capable
of being optimized, even if they don't happen to be handled differently
by two different algorithms.

Let me know if you want to collaborate on this somehow.

Michael

Scoring heuristic:

>     # A place to accumulate bonus factors (positive makes this
>     # index more favored):
>     bonus = 0
> 
>     # Bonuses based on the location of blank lines:
>     if pre_blank and not blank:
>         bonus += 3
>     elif blank and not pre_blank:
>         bonus += 2
>     elif blank and pre_blank:
>         bonus += 1
> 
>     # Now fill in missing indent values:
>     if pre_indent is None:
>         pre_indent = 0
> 
>     if post_indent is None:
>         post_indent = 0
> 
>     if blank:
>         indent = post_indent
> 
>     if indent > pre_indent:
>         # The line is indented more than its predecessor. It is
>         # preferable to keep these lines together, so we score it
>         # based on the larger indent:
>         score = indent
>         bonus -= 4
> 
>     elif indent < pre_indent:
>         # The line is indented less than its predecessor. It could
>         # be that this line is the start of a new block (e.g., of
>         # an "else" block, or of a block without a block
>         # terminator) or it could be the end of the previous
>         # block.
>         if indent < post_indent:
>             # The following line is indented more. So it is likely
>             # that this line is the start of a block. It's a
>             # pretty good place to split, so score it based on the
>             # smaller indent:
>             score = indent
>             bonus += 2
>         else:
>             # This was probably the end of a block. We score based
>             # on the line's own indent:
>             score = indent
> 
>     else:
>         # The line has the same indentation level as its
>         # predecessor. We score it based on its own indent:
>         score = indent
> 
>     return 10 * score - bonus

