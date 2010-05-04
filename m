From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] blame: add a range option to -L
Date: Tue, 04 May 2010 10:31:11 -0700
Message-ID: <7vd3xbmv4w.fsf@alter.siamese.dyndns.org>
References: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
X-From: git-owner@vger.kernel.org Tue May 04 19:31:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Lxy-0000KW-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 19:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604Ab0EDRbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 13:31:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab0EDRbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 13:31:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB71B0559;
	Tue,  4 May 2010 13:31:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DYWY4OawYEWq16q+YJE+aS0s3k4=; b=Mnr1jM
	1bl6Keiz88DwusqxT0ZPZCLxW/FAEpzbkgbm6Obla4k+CwbTo75PtUhPZ+WCQ02Z
	KUZ57gXCbzF4dQYkq5quT1CCW+bqhmPhSZ6UZzcTmpeUf6hyJth2p/8iowdFSfcm
	ch7DfDP7M3AaJX2ho9Vbb2WPF/i9710qLWJps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tj/uuumT2mKStkF9Ejo6/CkTKdx8xzjj
	fOfsFZTMj/juhVHqMavYf2ZSx/okMZUzX0pV8rPalXXNKdJ/Gx4FgROSBI0PZaEV
	I+3j/EQGzdpDgOP1saDo9DG+Q0azSG0mDco1/i/hi3yoYyguV/veLZHVX4pChy9R
	A9131POQt6w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B19B0558;
	Tue,  4 May 2010 13:31:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2D20B0557; Tue,  4 May
 2010 13:31:12 -0400 (EDT)
In-Reply-To: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu> (Bill
 Pemberton's message of "Mon\,  3 May 2010 14\:06\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D76DE41E-57A2-11DF-9AB1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146332>

Bill Pemberton <wfp5p@virginia.edu> writes:

> In addition to <start>,<end> you can now use <center>%<radius>
> to specify how many lines around <center> that you want to see.
> For example: -L 20%5 would show lines 15 through 25
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---

Please retitle, as (1) -L has always been about "range", and (2) what you
are adding now is a "radius" option ;-)

> +-L <center>%<radius>::
> +	This works like <start>,<end> with the annotated range
> +	centered on <center> and showing <radius> lines around it.

I am not sure how "like <start>,<end>" in this sentence helps the readers.
If you bring up the similarity, shouldn't you at least be saying that it
is an shorthand to give "<radius> lines before <center>" as <start>, and
"<radius> lines after <center>" as <end>, or somesuch?

> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index a27f439..73f6b83 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -110,6 +110,14 @@ line 40):
>  	git blame -L 40,60 foo
>  	git blame -L 40,+21 foo
>  
> +A range of lines around a particular line can be shown by using '%'
> +instead of ','.  If you wanted to see line 20 along with the 5
> +lines around it:
> +
> +       git blame -L 20%5 foo
> +
> +
> +

Why this many blank lines around the example?

I see this at the beginning of parse_loc() in builtin/blame.c:

	/* Allow "-L <something>,+20" to mean starting at <something>
	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
	 * <something>.
	 */

which means that it is not "-L <start>,<end>" to begin with.  I wonder if
it makes the interface more consistent to rewrite the above comment like
this:

	/*
	 * Allow "-L <something>,+20" to mean starting at <something>
	 * for 20 lines; "-L <something>,-5" for 5 lines ending at
	 * <something>; and "-L <something>,+-5" for 5 lines around
         * <something>.
	 */

and the match the code.
