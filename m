From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 1/3] mergetools/p4merge: swap LOCAL and REMOTE
Date: Tue, 12 Mar 2013 19:05:19 -0700
Message-ID: <CAJDDKr7NJsmB3R_kYtZeocSZAz-kfP9k6GssZ+AM-qfPCTzrdg@mail.gmail.com>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
	<1363137142-18606-1-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Wed Mar 13 03:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFb4h-00021P-51
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 03:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586Ab3CMCFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 22:05:21 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:40858 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564Ab3CMCFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 22:05:21 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so388082wib.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 19:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5xLmeOpYDVb4jo0fNKDyy5OYEXexzKpvwgPCXxkzY1Q=;
        b=PMmT1PmJfwDBkYmZdynqNNCRx68+FZN6ZceGG7Vds9emhBoBxnigzSS0i6KrQhvva+
         NWB3wzdVzn13C/QjC10uFTnjNWh7nYNprPkVhuHskR1OcPDTyLmA+zlvCh7sNzHsk2zU
         7F5XOLu+adKg5fB50fkzhaunPOyzOzMYv+hyUV6ZZaeD0CKXFEOYzrInY9eYnJ27XT72
         WXPQBkgxfLOf0+9gFBniubU8s73z+OaZewxsVOSoYeE6k9jaywqAF4sRyi9BGOD3uo/5
         uIJppQayNUW+Xi6KfJzPScDHGcnepWM/BjbmGX2uk5nz45VHE6SblFy4F5v85MLf/diq
         YrHA==
X-Received: by 10.180.87.129 with SMTP id ay1mr23629396wib.1.1363140319883;
 Tue, 12 Mar 2013 19:05:19 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Tue, 12 Mar 2013 19:05:19 -0700 (PDT)
In-Reply-To: <1363137142-18606-1-git-send-email-kevin@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218025>

On Tue, Mar 12, 2013 at 6:12 PM, Kevin Bracey <kevin@bracey.fi> wrote:
> Reverse LOCAL and REMOTE when invoking P4Merge as a mergetool, so that
> the incoming branch is now in the left-hand, blue triangle pane, and the
> current branch is in the right-hand, green circle pane.
>
> This change makes use of P4Merge consistent with its built-in help, its
> reference documentation, and Perforce itself. But most importantly, it
> makes merge results clearer. P4Merge is not totally symmetrical between
> left and right; despite changing a few text labels from "theirs/ours" to
> "left/right" when invoked manually, it still retains its original
> Perforce "theirs/ours" viewpoint.
>
> Most obviously, in the result pane P4Merge shows changes that are common
> to both branches in green. This is on the basis of the current branch
> being green, as it is when invoked from Perforce; it means that lines in
> the result are blue if and only if they are being changed by the merge,
> making the resulting diff clearer.
>
> Note that P4Merge now shows "ours" on the right for both diff and merge,
> unlike other diff/mergetools, which always have REMOTE on the right.
> But observe that REMOTE is the working tree (ie "ours") for a diff,
> while it's another branch (ie "theirs") for a merge.
>
> Ours and theirs are reversed for a rebase - see "git help rebase".
> However, this does produce the desired "show the results of this commit"
> effect in P4Merge - changes that remain in the rebased commit (in your
> branch, but not in the new base) appear in blue; changes that do not
> appear in the rebased commit (from the new base, or common to both) are
> in green. If Perforce had rebase, they'd probably not swap ours/theirs,
> but make P4Merge show common changes in blue, picking out our changes in
> green. We can't do that, so this is next best.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---

This seems sensible to apply.  The commit message is a bit long,
but I think it's justified since this is exactly the kind of thing
I would tend to forget after enough time has passed.

Ditto on the create_virtual_base patch.  Your latest patch
addressed Junio's note about making it take 2 args.

FWIW, please feel free to add:

Reviewed-by: David Aguilar <davvid@gmail.com>

Thanks.

>  mergetools/p4merge | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergetools/p4merge b/mergetools/p4merge
> index 8a36916..46b3a5a 100644
> --- a/mergetools/p4merge
> +++ b/mergetools/p4merge
> @@ -22,7 +22,7 @@ diff_cmd () {
>  merge_cmd () {
>         touch "$BACKUP"
>         $base_present || >"$BASE"
> -       "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
> +       "$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
>         check_unchanged
>  }
>
> --
> 1.8.2.rc3.7.g1100d09.dirty
>



-- 
David
