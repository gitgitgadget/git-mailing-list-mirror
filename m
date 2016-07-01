Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859CB20FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 11:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcGALIy (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 07:08:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:61828 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbcGALIx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 07:08:53 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lzsf1-1bNBLJ3dh5-0151nT; Fri, 01 Jul 2016 13:08:46
 +0200
Date:	Fri, 1 Jul 2016 13:08:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 7/9] merge-recursive: handle return values indicating
 errors
In-Reply-To: <xmqqbn2j3dt0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011246400.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <4f2817208cf2f7d4e839ddb6818bf652b0aa633c.1467199553.git.johannes.schindelin@gmx.de> <xmqqbn2j3dt0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1PD0URcPrzmcnJE9RIGeil3/KP/U/VLcyUa/DQ8QM/M38WoRfh5
 DAXNHS/F3sU9J06DkfSfgHCYADwfcg9d/IybdpQWlcne8D4eD3rZj5zfVd5WmY3Fb+80EGk
 IYwJ4pGrR7uzUnvuno5c1XvXthbZT3N12Y8vclptlRepKXNWQ+AmRaBFXPvZPLoJgBieCWt
 0mArw6SI4xamXCw+MSYSw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:b2UPk0o5k9E=:fuEENl15550EBXC+zZvwyi
 W0zbq5SBhyhC9ka4jDHN5/+Wjr8gt1noebQl7XjzJT6ahfA+wJpPMp5rgkFHHa7w+c6lKqphP
 Ecj9i+dYGnnQZ8Xnx53ljVE8r+yA3bstv2FA8D/2Mh+v7wcS3i22KMjIvBqpss3eLS3nMFEbe
 k593OUVAtqrzCuCNCyZQ20dh0yoq/qUI8R+t5Ci63BSYSzFQeSe5Epeki1VK7ncc+dMvtrwDF
 /g6l/FW2+OddB7x2VVgOwCEd1XWW3C6udryfAiQJjMGzIMcp7rk5n6FZCCpgok6bqJX367cZ2
 a0tL5T8r58SOqDVTOtAc4IU5qkiTMDIeCZHpJl1FgUFHzYpaLEvh3Uy6abnMv4DEqBBeaBmBG
 OtYWsDaXzhivNlbueXq0kxN+ly8Uxo73mCI/41c9xy+bV2D+gdC0QlcTyeTCgMwNLv6K2OC7U
 BVDC6FFmrOo7Pipi60RjrRvNtbVkNLwBAFu7sNNCyPvP9KiZJIFpKfjJYAHcm9u9nH6hQwNI+
 pT3WT6N9GW2HWLsYP/0hMUemJ3w2gLfd02agblGg2h9KA2S/Dm8C9baYWOfEJ+hje9hOmbCTB
 sa9/tZACBgGPrEhNkzcYeWLtUdpo9HPxGN7LoCo/6biAaionOj0CPsE2/mwglMv2hsZj//UwS
 BKwg8WY0Sj34ZOFmFfB+G0QmsZcF83H8nciqFmbsZ+xBnNmlzXKRPB50RORfSH9HCb9UVwFD/
 ZvnwtqRO30Xjnqjeedz2JevICRhaURvqy8X/baP0fQACPOV8Be4vaSPqVJr4F5lsWWGiZ4070
 KBqwHDs
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 6ab7dfc..bb075e3 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -266,8 +266,10 @@ struct tree *write_tree_from_memory(struct merge_options *o)
> >  		active_cache_tree = cache_tree();
> >  
> >  	if (!cache_tree_fully_valid(active_cache_tree) &&
> > -	    cache_tree_update(&the_index, 0) < 0)
> > -		die(_("error building trees"));
> > +	    cache_tree_update(&the_index, 0) < 0) {
> > +		error(_("error building trees"));
> > +		return NULL;
> > +	}
> 
> This actually is a BUG(), isn't it?  We have already verified that
> the cache is merged, so cache_tree_update() ought to be able to come
> up with the whole-tree hash.

I am not so sure. What if the disk is full?

> > @@ -548,19 +550,17 @@ static int update_stages(const char *path, const struct diff_filespec *o,
> >  	 */
> >  	int clear = 1;
> >  	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
> > +	int ret = 0;
> > +
> >  	if (clear)
> > -		if (remove_file_from_cache(path))
> > -			return -1;
> > -	if (o)
> > -		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
> > -			return -1;
> > -	if (a)
> > -		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
> > -			return -1;
> > -	if (b)
> > -		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
> > -			return -1;
> > -	return 0;
> > +		ret = remove_file_from_cache(path);
> > +	if (!ret && o)
> > +		ret = add_cacheinfo(o->mode, o->sha1, path, 1, 0, options);
> > +	if (!ret && a)
> > +		ret = add_cacheinfo(a->mode, a->sha1, path, 2, 0, options);
> > +	if (!ret && b)
> > +		ret = add_cacheinfo(b->mode, b->sha1, path, 3, 0, options);
> > +	return ret;
> >  }
> 
> Aren't the preimage and the postimage doing the same thing?  The
> only two differences I spot are (1) it is clear in the original that
> the returned value is -1 in the error case, even if the error
> convention of remove_file_from_cache() and add_cacheinfo() were "0
> is good, others are bad"; and (2) the control flow is easier to
> follow in the original.

Ah crap. This is a late left-over from the time when I thought I had to
introduce a "really fatal error" condition, i.e. return -128. I thought
that there might be errors that need to be handled differently, and
therefore it was essential that the return value -128 would not be
converted into a -1.

Will revert this hunk.

> > @@ -736,7 +736,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
> >  	return error(msg, path, _(": perhaps a D/F conflict?"));
> >  }
> >  
> > -static void update_file_flags(struct merge_options *o,
> > +static int update_file_flags(struct merge_options *o,
> >  			      const unsigned char *sha,
> >  			      unsigned mode,
> >  			      const char *path,
> > @@ -777,8 +777,7 @@ static void update_file_flags(struct merge_options *o,
> >  
> >  		if (make_room_for_path(o, path) < 0) {
> >  			update_wd = 0;
> > -			free(buf);
> > -			goto update_index;
> > +			goto free_buf;
> >  		}
> >  		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
> >  			int fd;
> > @@ -801,20 +800,22 @@ static void update_file_flags(struct merge_options *o,
> >  		} else
> >  			die(_("do not know what to do with %06o %s '%s'"),
> >  			    mode, sha1_to_hex(sha), path);
> > +free_buf:
> >  		free(buf);
> 
> I somehow find the above change harder to follow than the original.

Yeah, you noticed when commenting on the next patch why I did it. I added
a comment to the commit message.

> >  	}
> >   update_index:
> >  	if (update_cache)
> >  		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
> > +	return 0;
> >  }
> >  
> 
> This one is in line with the stated goal of the patch.
> 
> > @@ -1028,21 +1030,23 @@ static void handle_change_delete(struct merge_options *o,
> >  		 * correct; since there is no true "middle point" between
> >  		 * them, simply reuse the base version for virtual merge base.
> >  		 */
> > -		remove_file_from_cache(path);
> > -		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
> > +		ret = remove_file_from_cache(path);
> > +		if (!ret)
> > +			ret = update_file(o, 0, o_sha, o_mode,
> > +					  renamed ? renamed : path);
> 
> As you noted in the log message, this does change the behaviour.  If
> remove returns non-zero for whatever reason, we still did update()
> in the original, but we no longer do.  Does this have negative
> effect to the overall codeflow?

Please note that remove_file_from_index() does not, in fact, anything but
0 for the moment. So the practical use of testing the return value is nil
with Git's current source code.

It is more about future-proofing than anything else.

As to this incantation specifically, if we ever fail in
remove_file_from_cache(), I would expect the code to fail fast. That is
how I implemented it in this patch.

> > @@ -1087,21 +1094,22 @@ static void conflict_rename_delete(struct merge_options *o,
> >  		b_mode = dest->mode;
> >  	}
> >  
> > -	handle_change_delete(o,
> > +	ret = handle_change_delete(o,
> >  			     o->call_depth ? orig->path : dest->path,
> >  			     orig->sha1, orig->mode,
> >  			     a_sha, a_mode,
> >  			     b_sha, b_mode,
> >  			     _("rename"), _("renamed"));
> > -
> > -	if (o->call_depth) {
> > -		remove_file_from_cache(dest->path);
> > -	} else {
> > -		update_stages(dest->path, NULL,
> > +	if (ret < 0)
> > +		return ret;
> > +	if (o->call_depth)
> > +		ret = remove_file_from_cache(dest->path);
> > +	else
> > +		ret = update_stages(dest->path, NULL,
> >  			      rename_branch == o->branch1 ? dest : NULL,
> >  			      rename_branch == o->branch1 ? NULL : dest);
> > -	}
> 
> Similarly, if handle_change_delete() returns non-zero, we no longer
> call remove() or update().  Is that a good behaviour change?

Please note that handle_change_delete() did not return any value before
this patch series. In those cases that now return -1, it previously
die()d.

My patch ensures that the latter functions are not called in the error
case. Just like before.

> > -static void handle_file(struct merge_options *o,
> > +static int handle_file(struct merge_options *o,
> >  			struct diff_filespec *rename,
> >  			int stage,
> >  			struct rename_conflict_info *ci)
> 
> Likewise.

Ditto.

> > -static void conflict_rename_rename_1to2(struct merge_options *o,
> > +static int conflict_rename_rename_1to2(struct merge_options *o,
> >  					struct rename_conflict_info *ci)
> >  {
> > ...
> > -		if (merge_file_one(o, one->path,
> > +		if ((ret = merge_file_one(o, one->path,
> >  				 one->sha1, one->mode,
> >  				 a->sha1, a->mode,
> >  				 b->sha1, b->mode,
> > -				 ci->branch1, ci->branch2, &mfi) < 0)
> > -			return;
> > +				 ci->branch1, ci->branch2, &mfi)))
> > +			return ret;
> 
> This does not change behaviour.
> 
> > @@ -1194,7 +1208,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
> >  		 * pathname and then either rename the add-source file to that
> >  		 * unique path, or use that unique path instead of src here.
> >  		 */
> > -		update_file(o, 0, mfi.sha, mfi.mode, one->path);
> > +		if ((ret = update_file(o, 0, mfi.sha, mfi.mode, one->path)))
> > +			return ret;
> 
> But this does.

As stated above: it does not. In case of an error in update_file() (which
is now reported via a return value, in contrast to the previous behavior),
just like before, we skip the rest of the function.

The difference is that we now clean up our resources and return an error
instead of die()ing.

> > @@ -1205,22 +1220,31 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
> >  		 * resolving the conflict at that path in its favor.
> >  		 */
> >  		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
> > -		if (add)
> > -			update_file(o, 0, add->sha1, add->mode, a->path);
> > +		if (add) {
> > +			if ((ret = update_file(o, 0, add->sha1, add->mode,
> > +					a->path)))
> > +				return ret;
> > +		}
> 
> So does this.

Same as above (i.e. same behavior as previously).

> >  		else
> >  			remove_file_from_cache(a->path);
> >  		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
> > -		if (add)
> > -			update_file(o, 0, add->sha1, add->mode, b->path);
> > +		if (add) {
> > +			if ((ret = update_file(o, 0, add->sha1, add->mode,
> > +					b->path)))
> > +				return ret;
> > +		}
> 
> And this.

Yep. Same behavior.

> >  	} else {
> > -		handle_file(o, a, 2, ci);
> > -		handle_file(o, b, 3, ci);
> > +		if ((ret = handle_file(o, a, 2, ci)) ||
> > +		    (ret = handle_file(o, b, 3, ci)))
> > +			return ret;
> 
> And this.

Yep. Same behavior.

Ciao,
Dscho
