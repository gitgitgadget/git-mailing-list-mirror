Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880DB1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 20:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdBAU4H (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 15:56:07 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32895 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdBAU4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 15:56:06 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so35189881pgd.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hbqyWDIblAy+PHULO4tpfWXGAVVQLNMfxwi7r7qWx78=;
        b=hNWIUbck4960M/2PJa1wCB6G0SmNICpeIiXiLaKPE8hzEzp4CHy0bzz67VW1TOvk4C
         RxZdFmsJP2AT+jgY+nIkDloXwYRbKSJ6Ws+FcGw590RgfR/EZRgu2GGhWAb7kS3KklOV
         quC34jYZSh8Yr2SzZHLDdK86kmKtBeF1GnfHIciwWUIN2DK4o7KW07NHaCcLwcL6wPbV
         JhT81XKAVSP01SUr3p8AQ7xG+SNS+AUvMexw+4FAowk900lATMZpD1nOfZaIP4U66dvh
         feDw6ueaPBIXAWdisOdxLev+E7rYJ7bPV963OpoLResix1blx6xjWDlKy6giMTZyj5LI
         ovHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hbqyWDIblAy+PHULO4tpfWXGAVVQLNMfxwi7r7qWx78=;
        b=CY4U+Do6qpQnuoC1txiFbIctw9BEMP3uwW/v8fN1be2qLPbtwBz8rWwzi5XCkt1k3A
         incX6jOFOkH2bQDSjhUsFst8foukRmtfSiOynOhG26C83uU98LJfiEPrAHJgPXwkpIj1
         uBuMgi6SmTtGRwth1l1xbHYcO4wHcCE6jpQuyfeU7iA+L6EIOL7esK+YMKXuB7nhH44p
         TXTVSwxtHAQxykbo237QMJ07BcchphxXtIMhjK+qAX1qxhuuRwQhDGRb5J4LuuubZQUC
         tkaJIWOGlZfOnW0t+tewBiY1iWOcyrBRU7OiLD/ANiaVjY99vLJfpQ1RBnq0WLaXwSyH
         XMeA==
X-Gm-Message-State: AIkVDXJ0hyYkTJ1nhHElNe75/j0WSOQLvFZP/bcxXFPypFU7YILHb5b/vIwZqHFhyeFm3Q==
X-Received: by 10.98.90.196 with SMTP id o187mr6015432pfb.30.1485982565583;
        Wed, 01 Feb 2017 12:56:05 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id j7sm51924724pfe.84.2017.02.01.12.56.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 12:56:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: make "CONFLICT (rename/delete)" message show both paths
References: <1485636764.2482.2.camel@mattmccutchen.net>
        <xmqqvaswrv5q.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Feb 2017 12:56:03 -0800
In-Reply-To: <xmqqvaswrv5q.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 30 Jan 2017 15:21:37 -0800")
Message-ID: <xmqqh94dockc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matt McCutchen <matt@mattmccutchen.net> writes:
> ...
>> Please check that my refactoring is indeed correct!  All the existing tests pass
>> for me, but the existing test coverage of these conflict messages looks poor.
>
> This unfortunately is doing a bit too many things at once from that
> point of view.  I need to reserve a solid quiet 20-minutes without
> distraction to check it, which I am hoping to do tonight.

Let me make sure if I understood your changes correctly:

 * conflict_rename_delete() knew which one is renamed and which one
   is deleted (even though the deleted one was called "other"), but
   because in the original code handle_change_delete() wants to
   always see tree A first and then tree B in its parameter list,
   the original code swapped a/b before calling it.  In the original
   code, handle_change_delete() needed to figure out which one is
   the deleted one by looking at a_oid or b_oid.

 * In the updated code, the knowledge of which branch survives and
   which branch is deleted is passed from the caller to
   handle_change_delete(), which no longer needs to figure out by
   looking at a_oid/b_oid.  The updated API only passes the oid for
   surviving branch (as deleted one would have been 0{40} anyway).

 * In the updated code, handle_change_delete() is told the names of
   both branches (the one that survives and the other that was
   deleted).  It no longer has to switch between o->branch[12]
   depending on the NULLness of a_oid/b_oid; it knows both names and
   which one is which.

 * handle_modify_delete() also calls handle_change_delete().  Unlike
   conflict_rename_delete(), it is not told by its caller which
   branch keeps the path and which branch deletes the path, and
   instead relies on handle_change_delete() to figure it out.
   Because of the above change to the API, now it needs to sort it
   out before calling handle_change_delete().

It all makes sense to me.  

The single call to update_file() that appears near the end of
handle_change_delete() in the updated code corresponds to calls to
the same function in 3 among 4 codepaths in the function in the
original code.  It is a bit tricky to reason about, though.

In the original code, update_file() was omitted when we didn't have
to come up with a unique alternate filename and the one that is left
is a_oid (i.e. our side).  The way to tell if we did not come up
with a unique alternate filename used to be to see the "renamed"
variable but now it is the NULL-ness of "alt_path".  And the way to
tell if the side that is left is ours, we check to see o->branch1
is the change_branch, not delete_branch.

So the condition to guard the call to update_file() also looks
correct to me.

Thanks.

>> -	char *renamed = NULL;
>> +	char *alt_path = NULL;
>> +	const char *update_path = path;
>>  	int ret = 0;
>> +
>>  	if (dir_in_way(path, !o->call_depth, 0)) {
>> -		renamed = unique_path(o, path, a_oid ? o->branch1 : o->branch2);
>> +		update_path = alt_path = unique_path(o, path, change_branch);
>>  	}
>>  
>>  	if (o->call_depth) {
>> @@ -1081,43 +1085,43 @@ static int handle_change_delete(struct merge_options *o,
>>  		 */
>>  		ret = remove_file_from_cache(path);
>>  		if (!ret)
>> -			ret = update_file(o, 0, o_oid, o_mode,
>> -					  renamed ? renamed : path);
>> -	} else if (!a_oid) {
>> -		if (!renamed) {
>> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> -			       "and %s in %s. Version %s of %s left in tree."),
>> -			       change, path, o->branch1, change_past,
>> -			       o->branch2, o->branch2, path);
>> -			ret = update_file(o, 0, b_oid, b_mode, path);
>> -		} else {
>> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> -			       "and %s in %s. Version %s of %s left in tree at %s."),
>> -			       change, path, o->branch1, change_past,
>> -			       o->branch2, o->branch2, path, renamed);
>> -			ret = update_file(o, 0, b_oid, b_mode, renamed);
>> -		}
>> +			ret = update_file(o, 0, o_oid, o_mode, update_path);
>>  	} else {
>> -		if (!renamed) {
>> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> -			       "and %s in %s. Version %s of %s left in tree."),
>> -			       change, path, o->branch2, change_past,
>> -			       o->branch1, o->branch1, path);
>> +		if (!alt_path) {
>> +			if (!old_path) {
>> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> +				       "and %s in %s. Version %s of %s left in tree."),
>> +				       change, path, delete_branch, change_past,
>> +				       change_branch, change_branch, path);
>> +			} else {
>> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> +				       "and %s to %s in %s. Version %s of %s left in tree."),
>> +				       change, old_path, delete_branch, change_past, path,
>> +				       change_branch, change_branch, path);
>> +			}
>>  		} else {
>> -			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> -			       "and %s in %s. Version %s of %s left in tree at %s."),
>> -			       change, path, o->branch2, change_past,
>> -			       o->branch1, o->branch1, path, renamed);
>> -			ret = update_file(o, 0, a_oid, a_mode, renamed);
>> +			if (!old_path) {
>> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> +				       "and %s in %s. Version %s of %s left in tree at %s."),
>> +				       change, path, delete_branch, change_past,
>> +				       change_branch, change_branch, path, alt_path);
>> +			} else {
>> +				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
>> +				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
>> +				       change, old_path, delete_branch, change_past, path,
>> +				       change_branch, change_branch, path, alt_path);
>> +			}
>>  		}
>>  		/*
>> -		 * No need to call update_file() on path when !renamed, since
>> -		 * that would needlessly touch path.  We could call
>> -		 * update_file_flags() with update_cache=0 and update_wd=0,
>> -		 * but that's a no-op.
>> +		 * No need to call update_file() on path when change_branch ==
>> +		 * o->branch1 && !alt_path, since that would needlessly touch
>> +		 * path.  We could call update_file_flags() with update_cache=0
>> +		 * and update_wd=0, but that's a no-op.
>>  		 */
>> +		if (change_branch != o->branch1 || alt_path)
>> +			ret = update_file(o, 0, changed_oid, changed_mode, update_path);
>>  	}
>> -	free(renamed);
>> +	free(alt_path);
>>  
>>  	return ret;
>>  }
>> @@ -1125,28 +1129,17 @@ static int handle_change_delete(struct merge_options *o,
>>  static int conflict_rename_delete(struct merge_options *o,
>>  				   struct diff_filepair *pair,
>>  				   const char *rename_branch,
>> -				   const char *other_branch)
>> +				   const char *delete_branch)
>>  {
>>  	const struct diff_filespec *orig = pair->one;
>>  	const struct diff_filespec *dest = pair->two;
>> -	const struct object_id *a_oid = NULL;
>> -	const struct object_id *b_oid = NULL;
>> -	int a_mode = 0;
>> -	int b_mode = 0;
>> -
>> -	if (rename_branch == o->branch1) {
>> -		a_oid = &dest->oid;
>> -		a_mode = dest->mode;
>> -	} else {
>> -		b_oid = &dest->oid;
>> -		b_mode = dest->mode;
>> -	}
>>  
>>  	if (handle_change_delete(o,
>>  				 o->call_depth ? orig->path : dest->path,
>> +				 o->call_depth ? NULL : orig->path,
>>  				 &orig->oid, orig->mode,
>> -				 a_oid, a_mode,
>> -				 b_oid, b_mode,
>> +				 &dest->oid, dest->mode,
>> +				 rename_branch, delete_branch,
>>  				 _("rename"), _("renamed")))
>>  		return -1;
>>  
>> @@ -1665,11 +1658,27 @@ static int handle_modify_delete(struct merge_options *o,
>>  				 struct object_id *a_oid, int a_mode,
>>  				 struct object_id *b_oid, int b_mode)
>>  {
>> +	const char *modify_branch, *delete_branch;
>> +	struct object_id *changed_oid;
>> +	int changed_mode;
>> +
>> +	if (a_oid) {
>> +		modify_branch = o->branch1;
>> +		delete_branch = o->branch2;
>> +		changed_oid = a_oid;
>> +		changed_mode = a_mode;
>> +	} else {
>> +		modify_branch = o->branch2;
>> +		delete_branch = o->branch1;
>> +		changed_oid = b_oid;
>> +		changed_mode = b_mode;
>> +	}
>> +
>>  	return handle_change_delete(o,
>> -				    path,
>> +				    path, NULL,
>>  				    o_oid, o_mode,
>> -				    a_oid, a_mode,
>> -				    b_oid, b_mode,
>> +				    changed_oid, changed_mode,
>> +				    modify_branch, delete_branch,
>>  				    _("modify"), _("modified"));
>>  }
>>  
>> diff --git a/t/t6045-merge-rename-delete.sh b/t/t6045-merge-rename-delete.sh
>> new file mode 100755
>> index 0000000..8f33244
>> --- /dev/null
>> +++ b/t/t6045-merge-rename-delete.sh
>> @@ -0,0 +1,23 @@
>> +#!/bin/sh
>> +
>> +test_description='Merge-recursive rename/delete conflict message'
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'rename/delete' '
>> +echo foo >A &&
>> +git add A &&
>> +git commit -m "initial" &&
>> +
>> +git checkout -b rename &&
>> +git mv A B &&
>> +git commit -m "rename" &&
>> +
>> +git checkout master &&
>> +git rm A &&
>> +git commit -m "delete" &&
>> +
>> +test_must_fail git merge --strategy=recursive rename >output &&
>> +test_i18ngrep "CONFLICT (rename/delete): A deleted in HEAD and renamed to B in rename. Version rename of B left in tree." output
>> +'
>> +
>> +test_done
