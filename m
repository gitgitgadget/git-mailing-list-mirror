From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 23:09:13 +0100
Message-ID: <20160118220913.GI7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
 <20160118195159.GD1009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:08:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHym-0001zW-Fv
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 23:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbcARWIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 17:08:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34465 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbcARWIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 17:08:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so19264602wmb.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9+Hl1u+z6VFBJEALbGC4AKZXZjkt90psjr4fGVJeBRg=;
        b=OSYVKNatLyJpG+xQ5ve49v9RfZIJ1applXwGTYDx6RYMsOthYHbpT9nm8alZu82MC3
         rCHBLf2bsUIqneKcIcDKO9hwpB0hYLKHVapiEDSE11NY72owSYfeD+06HtEWWT9GAZ9y
         r51db7RE/Wxlz6ZnKKPDjoRoRluaaqOmaTEhy8hIW8z5TnlBe85Qppyq9vxbwTmEam6f
         dT7TLfTNwzjx+OWKE95/ZkyF3xX2s/rGs08dpfhGqxYN80BndmF51U0RHCeD+AuOWGHy
         Ko1o0Xo+Rm/6LS0W61VCiAFeXwxHQI5dZ1NpNocGWWYMU4Dg5c0OgP3ev+IT3PBuojCN
         H/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9+Hl1u+z6VFBJEALbGC4AKZXZjkt90psjr4fGVJeBRg=;
        b=SVUiqPG7SMEPWaqpWjkQc16uGFZ2oRJGKMTEjGkmz+DlUkBCaw6DhzV9Z86U7Jm45w
         aHzqF5Byh+j881ISH+ajKBclGUny4W7mEGa9VrXh5hmFIAlW1TLmnNfhRlw3XX9/9mfI
         f0RRozgUgEKzB68gNNItI9qlKZ4lc/4g6fJeLrU/J7j27O0F+UsG7OP2Guv/L6pNyJss
         g3D6S3cv1+QgHBXSJlxkSCORPX6yaxa58XcAfqgQw5oT+nj1bddbMgFgioXAsfZG8Ukc
         0t5EPfYIq9B59dvI3ANn3U8RfaVEEvoieaszG6WlUppmPXLtfEHxyhWDe+Q3LP/Q312I
         Jwzg==
X-Gm-Message-State: AG10YOQOCE9ZuPCOHYFmguYmkgBka5VtGkZM4sM5vDxpxMniCtt0KIr2NsjD4SBphgutlQ==
X-Received: by 10.28.173.208 with SMTP id w199mr14451374wme.45.1453154927119;
        Mon, 18 Jan 2016 14:08:47 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id m128sm17522439wma.24.2016.01.18.14.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 14:08:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160118195159.GD1009@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284330>

On 01/18, Jeff King wrote:
> On Mon, Jan 18, 2016 at 05:57:18PM +0100, Thomas Gummerer wrote:
>
> > While there, replace a literal tab in the format string with \t to make
> > it more obvious to the reader.
>
> Heh, I didn't notice in the first review that you actually inherited
> that from the original. Definitely worth doing, IMHO.
>
> > @@ -101,7 +104,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
> >  			continue;
> >  		if (!tail_match(pattern, ref->name))
> >  			continue;
> > -		printf("%s	%s\n", oid_to_hex(&ref->old_oid), ref->name);
> > +		if (symrefs && ref->symref)
> > +			printf("ref: %s\t%s\n", ref->symref, ref->name);
> > +		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
> >  		status = 0; /* we found something */
>
> Yeah, this looks like the right logic to me.
>
> > +test_expect_success 'ls-remote --symrefs' '
> > +	cat >expect <<-EOF &&
>
> Please use "<<-\EOF" here (and in the test below) to prevent
> interpolation. It's not wrong in your case, but it's easier for a reader
> (or somebody who later modifies the test) to not have to wonder what you
> were expecting to be expanded. So as a general style, we quote our
> here-doc markers.

Will do, thanks!

> > +	ref: refs/heads/master	HEAD
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
> > +	EOF
> > +	git ls-remote --symrefs >actual &&
> > +	test_cmp expect actual
> > +'
>
> This test covers "symrefs, along with everything". And this one:
>
> > +test_expect_success 'ls-remote with filtered symrefs' '
> > +	cat >expect <<-EOF &&
> > +	ref: refs/heads/master	HEAD
> > +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
> > +	EOF
> > +	git ls-remote --symrefs . HEAD >actual &&
> > +	test_cmp expect actual
> > +'
>
> covers symrefs plus a refname filter. It would be nice to also test that
> "git ls-remote --symrefs --heads" shows "refs/heads/foo" as a symref.
> But that cannot work with the current code, because upload-pack only
> tells us about the symref HEAD, and not any others.
>
> This may change in the future, though. I'm not sure if it's worth
> squashing in the expect_failure test below. The "negative" one below
> that does tell us something, though it is somewhat redundant (it does
> catch the "always show symrefs" logic from your original version, but
> it seems unlikely that would pop up as a regression).
>
> ---
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 3edbc9e..92fc7e9 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -176,7 +176,7 @@ test_expect_success 'ls-remote --symrefs' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success 'ls-remote with filtered symrefs' '
> +test_expect_success 'ls-remote with filtered symrefs (refname)' '
>  	cat >expect <<-EOF &&
>  	ref: refs/heads/master	HEAD
>  	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
> @@ -185,4 +185,27 @@ test_expect_success 'ls-remote with filtered symrefs' '
>  	test_cmp expect actual
>  '
>
> +test_expect_failure 'ls-remote with filtered symrefs (--heads)' '
> +	git symbolic-ref refs/heads/foo refs/tags/mark &&
> +	cat >expect <<-\EOF &&
> +	ref: refs/heads/bar	refs/tags/mark
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> +	EOF
> +	git ls-remote --symrefs --heads . >actual &&
> +	test_cmp expect actual
> +'

I'm a bit confused by this.  Shouldn't the "ref: refs/heads/bar
refs/tags/mark" line only show up when we use --tags, not --heads?
Also should refs/heads/bar be refs/heads/foo?

> +
> +test_expect_success 'ls-remote --symrefs omits filtered-out matches' '
> +	cat >expect <<-\EOF &&
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
> +	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> +	EOF
> +	git ls-remote --symrefs --heads . >actual &&
> +	test_cmp expect actual &&
> +	git ls-remote --symrefs . "refs/heads/*" >actual &&
> +	test_cmp expect actual
> +'
> +
> +
>  test_done
>

--
Thomas
