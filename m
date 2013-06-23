From: Dave Abrahams <dave@boostpro.com>
Subject: Re: fast-import bug?
Date: Sat, 22 Jun 2013 19:16:48 -0700
Message-ID: <m2txkp1shb.fsf@cube.gateway.2wire.net>
References: <m2zjuj2504.fsf@cube.gateway.2wire.net>
	<20130622102157.GE4676@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 23 07:52:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqdEH-0000MF-Gu
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 07:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab3FWFwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 01:52:31 -0400
Received: from mail-gh0-f173.google.com ([209.85.160.173]:33878 "EHLO
	mail-gh0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3FWFwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 01:52:30 -0400
Received: by mail-gh0-f173.google.com with SMTP id g16so2921630ghb.32
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 22:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=OgKovlJ2e+DCljiVHw/Fg/gOXkp1o4+kHiGDeYdqn0g=;
        b=LOA1nGKkKDyz8nhFmtB8ZOkDcS++o9rtbbKK4Gy014Jcvef+r8kvcGXYTg6bK3OfqS
         lTfiuAket7Ja9rFjb8tFuEWkwpqV3/1vlkXMEL14qYQiKy6tQEktPkSvPahvjBcLpRq1
         e92VWsZhlMRpeU2thOTwt4z1BrIZdEWpm3Lfwq0n2U54ZPUhcQLQ+xuFYzrwqCpbMSFY
         rwxyrMSgLuw5f3gAP9YuwK6R9YRkJVjTFAPRk8iZOg5LmLsyJP/j2jmFTYfmklde907q
         NWP3HLFL3lk2zUlgN+Krc6JvIBuXl3TSKxjF0vum59+erxCY3Aey+26wOM/c/npd5Cue
         sbDw==
X-Received: by 10.236.24.226 with SMTP id x62mr10584680yhx.124.1371966749451;
        Sat, 22 Jun 2013 22:52:29 -0700 (PDT)
Received: from pluto.boostpro.com (107-219-149-247.lightspeed.sntcca.sbcglobal.net. [107.219.149.247])
        by mx.google.com with ESMTPSA id q7sm21450836yhm.8.2013.06.22.22.52.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 22:52:28 -0700 (PDT)
Received: by pluto.boostpro.com (Postfix, from userid 501)
	id 5A5E025984A4; Sat, 22 Jun 2013 19:16:48 -0700 (PDT)
In-Reply-To: <20130622102157.GE4676@serenity.lan> (John Keeping's message of
	"Sat, 22 Jun 2013 11:21:58 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.2.93 (darwin)
X-Gm-Message-State: ALoCoQmRILFybjEnceSuuEQLa4yoMCEUY9fAxDhlnzf2Av4If/Vad49s95V+Ysku6wlI+kn3EpyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228720>


on Sat Jun 22 2013, John Keeping <john-AT-keeping.me.uk> wrote:

> On Fri, Jun 21, 2013 at 02:21:47AM -0700, Dave Abrahams wrote:
>> The docs for fast-import seem to imply that I can use "ls" to get the
>> SHA1 of a commit for which I have a mark:
>> 
>>        Reading from a named tree
>>            The <dataref> can be a mark reference (:<idnum>) or the full 40-byte
>
>>            SHA-1 of a Git tag, commit, or tree object, preexisting or waiting to
>>            be written. The path is relative to the top level of the tree named by
>>            <dataref>.
>> 
>>                        'ls' SP <dataref> SP <path> LF
>> 
>>        See filemodify above for a detailed description of <path>.
>> 
>>        Output uses the same format as git ls-tree <tree> -- <path>:
>> 
>>            <mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
>> 
>>        The <dataref> represents the blob, tree, or commit object at <path> and
>>                                                    ^^^^^^
>>        can be used in later cat-blob, filemodify, or ls commands.
>> 
>> but I can't get it to work.  It's not entirely clear it's supposed to
>> work.  What path would I pass?  Passing an empty path simply causes git
>> to report "missing ".
>
> Which version of Git are you using?  

,----[ git --version ]
| git version 1.8.3.1
`----

> I just tried this and get the error
> "fatal: Empty path component found in input", 

I get that too.

> which seems to be from commit 178e1de (fast-import: don't allow 'ls'
> of path with empty components, 2012-03-09), which is included in Git
> 1.7.9.5.

Yes, that's at least part of the issue.  I notice git-fast-import
rejects the root path "" for other commands, e.g. when used as the
source of a filecopy we get the same issue.  I also note that the docs
don't make it clear that quoting the path is mandatory if it might turn
out to be empty.

> It seems to be slightly more complicated than that though, because after
> allowing empty trees I get the "missing" message for the root tree.

Yeah, I've tried to patch Git to solve this but ran into that problem
and gave up.

> This seems to be because its mode is 0 and not S_IFDIR.

Aha.

> With the patch below, things are working as I expect 

Awesome; works for me, too!

> but I don't understand why the mode of the root is not set correctly
> at this point.  Perhaps someone more familiar with fast-import will
> have some insight...

Yeah... there's no bug tracker for Git, right?  So if nobody pays
attention to this thread, the problem will persist?

> -- >8 --
> diff --git a/fast-import.c b/fast-import.c
> index 23f625f..bcce651 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1626,6 +1626,15 @@ del_entry:
>  	return 1;
>  }
>
> +static void copy_tree_entry(struct tree_entry *dst, struct tree_entry *src)
> +{
> +	memcpy(dst, src, sizeof(*dst));
> +	if (src->tree && is_null_sha1(src->versions[1].sha1))
> +		dst->tree = dup_tree_content(src->tree);
> +	else
> +		dst->tree = NULL;
> +}
> +
>  static int tree_content_get(
>  	struct tree_entry *root,
>  	const char *p,
> @@ -1651,11 +1660,7 @@ static int tree_content_get(
>  		e = t->entries[i];
>  		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
>  			if (!slash1) {
> -				memcpy(leaf, e, sizeof(*leaf));
> -				if (e->tree && is_null_sha1(e->versions[1].sha1))
> -					leaf->tree = dup_tree_content(e->tree);
> -				else
> -					leaf->tree = NULL;
> +				copy_tree_entry(leaf, e);
>  				return 1;
>  			}
>  			if (!S_ISDIR(e->versions[1].mode))
> @@ -3065,7 +3070,11 @@ static void parse_ls(struct branch *b)
>  			die("Garbage after path in: %s", command_buf.buf);
>  		p = uq.buf;
>  	}
> -	tree_content_get(root, p, &leaf);
> +	if (!*p) {
> +		copy_tree_entry(&leaf, root);
> +		leaf.versions[1].mode = S_IFDIR;
> +	} else
> +		tree_content_get(root, p, &leaf);
>  	/*
>  	 * A directory in preparation would have a sha1 of zero
>  	 * until it is saved.  Save, for simplicity.

-- 
Dave Abrahams
