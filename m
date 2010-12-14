From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Export three functions from diff.c
Date: Tue, 14 Dec 2010 15:08:43 -0800
Message-ID: <7v39q0rlz8.fsf@alter.siamese.dyndns.org>
References: <cover.1292291624.git.trast@student.ethz.ch>
 <4973127c3f9251b92c4836b19d818a340741102a.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdzQ-00020u-Oz
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0LNXI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:08:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab0LNXIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:08:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C2B82D5D;
	Tue, 14 Dec 2010 18:09:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iw1m8p3ghr3rhmV/62pG3n6hbHg=; b=N8KyrA
	8Cz0vb+K+NlJFi95wSRf12WT+8j3+YUqNg9skKmT22GjheJIjqqPaiSRq6+oa56F
	VTkNS67dPxE/C4WxojQZ9PGgyllwJEK42hLxubYIgXQWG2hLNOCYRmSgB6OKZbKy
	8szgyrr5EhFc+kEVB/GrFIUEDw4+qL2U9+muM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GpLXjZaal6N3MxOwGBMaGLbzHJgkjNTk
	xwT3EsS1xvnZu4xI6PsjaF/Za9v9Jia4HDO4q2oaFdeh+5AvI11T/Ge7RlQnawtJ
	khBnE2QYFgbQHazEp5B3NsjcLlBvjezWKZnHlXeUF5kLTiDBnNDhpA4YF57Or9P1
	qfXP0pliIiI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16DCB2D59;
	Tue, 14 Dec 2010 18:09:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A29812D55; Tue, 14 Dec 2010
 18:09:12 -0500 (EST)
In-Reply-To: <4973127c3f9251b92c4836b19d818a340741102a.1292291624.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 14 Dec 2010 03\:03\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CB503B4-07D7-11E0-8921-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163717>

Thomas Rast <trast@student.ethz.ch> writes:

> From: Bo Yang <struggleyb.nku@gmail.com>
>
> Use fill_metainfo to fill the line level diff meta data,
> emit_line to print out a line and quote_two to quote
> paths.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  diff.c |    6 +++---
>  diff.h |   17 +++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 6991ed4..a0ea9e5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -151,7 +151,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  	return git_color_default_config(var, value, cb);
>  }
>  
> -static char *quote_two(const char *one, const char *two)
> +char *quote_two(const char *one, const char *two)
>  {
>  	int need_one = quote_c_style(one, NULL, NULL, 1);
>  	int need_two = quote_c_style(two, NULL, NULL, 1);

This is not specific to "diff" anymore (it is a utility to cquote a path
that happens to be stored as two separate components); wouldn't quote.c
be a better home for it?

> -static void emit_line(struct diff_options *o, const char *set, const char *reset,
> +void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
>  	emit_line_0(o, set, reset, line[0], line+1, len-1);

Within the context of "diff", it is clear that a function called
emit_line() will be used to emit a single line of patch output, and within
that context, it is understandable that it takes coloring related arguments
as we do emit diff output in color.

But does it still make sense to give it such a generic sounding name when
exported outside of its original context?  Call it either emit-diff-line
(if "diff-ness" is more important, and the new callers will use the
function to emit diff output) or emit-colored-line (if the new caller
produces output not necessarily related to diff, but is merely borrowing
the coloring infrastructure from this implementation), perhaps?

> @@ -2583,7 +2583,7 @@ static int similarity_index(struct diff_filepair *p)
>  	return p->score * 100 / MAX_SCORE;
>  }
>  
> -static void fill_metainfo(struct strbuf *msg,
> +void fill_metainfo(struct strbuf *msg,
>  			  const char *name,
>  			  const char *other,
>  			  struct diff_filespec *one,

Likewise.  Within the context of "diff", it is clear what kind of metainfo
we mean (that's the one between "diff --git" and the first "@@ ... @@").
Other APIs with different kind of "metainfo" may later want to introduce a
totally different function that fills their metainfo, and calling this
"fill_metainfo" forces them to use some different name, and cause
confusion to readers.  Perhaps fill-diff-metainfo?
