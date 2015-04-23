From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 01/16] refs: convert struct ref_entry to use struct object_id
Date: Wed, 22 Apr 2015 17:52:09 -0700
Message-ID: <CAGZ79kbjBbuE=KGrW_7a7AOCGgEJgYb9fEE_MLq89ytkaBctRQ@mail.gmail.com>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
	<1429745061-295908-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 02:52:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl5NI-0000Lu-QG
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 02:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934406AbbDWAwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 20:52:12 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37678 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbbDWAwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 20:52:10 -0400
Received: by igblo3 with SMTP id lo3so11342141igb.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NhT9fBRE1qN6JKlTwa+3UfK9j98pEb8gDkSYxw1gzRQ=;
        b=I+r6BcHnWtwsT3LAhBacfnyjH/OIEZZ/kH+nImJ1ucUqh0SCXNQ19zvP3PnSSw58hD
         bCN0botaCvMkNVBZef/69yiQfdNKboy+WMBP0ytX5hSzrS0LokED7gBeET/y+xFAx9DC
         RYXOu4dVzKTrlofUE37jrwet79w5h7NzV/jQW4a9GqEcy9wrEmVW27hQk8WPQnohWPwN
         7MeIGYyxH56iqpSEhSr5YwGGIF9iCeUKejlDJeadIITuIWETuFUwfU6Qy/A7YuCi7W+1
         oysFfYOx6bRHcS5nBlOxcNGUjl1FLJ02PRrDFbz1ILUNAZ1HlVyPm1V2PQn+kDFFlRxd
         eaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NhT9fBRE1qN6JKlTwa+3UfK9j98pEb8gDkSYxw1gzRQ=;
        b=LrhOG2byERBwS9rV1MCSzLa+YymUprIjXXjKbJhpzgkesP2ZxJvaLi9K7Lo4eznTig
         PNxonelhD+eM5GOspHBSybeWJXV8szCMNBoXsWgYsg8d9+D+4dZlsi129Lo7CZU8BBld
         PN8PA+U6lLNe7n+OcTPk5YsEu4V9qrny9Jzkay8om+9CKmiYJw6fI+XJglKxxw5sIgRy
         9eNFX1Y0Ul+taC+NE+yNTV7VFcGKTEO1b++/y7uIbAWp6E//AFELWNtMm5QlVDGP3Tqn
         oVd4ZkT63HuUZje30/jXE95+dcdXcMZU0iML/juQctMKx+NusLABTMZdpkKWjvkMF7Rr
         jC0A==
X-Gm-Message-State: ALoCoQkAmQFTD5u+N9MFwtn4pTA1rjzUOK16exS2mCnkSF27SDYLmSMGdeJeDd3bdTwxZIKY9JmW
X-Received: by 10.107.170.135 with SMTP id g7mr415774ioj.2.1429750330091; Wed,
 22 Apr 2015 17:52:10 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 17:52:09 -0700 (PDT)
In-Reply-To: <1429745061-295908-2-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267672>

On Wed, Apr 22, 2015 at 4:24 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  refs.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 81a455b..522d15d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -156,7 +156,7 @@ struct ref_value {
>          * null.  If REF_ISSYMREF, then this is the name of the object
>          * referred to by the last reference in the symlink chain.
>          */
> -       unsigned char sha1[20];
> +       struct object_id oid;
>
>         /*
>          * If REF_KNOWS_PEELED, then this field holds the peeled value
> @@ -164,7 +164,7 @@ struct ref_value {
>          * be peelable.  See the documentation for peel_ref() for an
>          * exact definition of "peelable".
>          */
> -       unsigned char peeled[20];
> +       struct object_id peeled;
>  };
>
>  struct ref_cache;
> @@ -346,8 +346,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
>                 die("Reference has invalid format: '%s'", refname);
>         len = strlen(refname) + 1;
>         ref = xmalloc(sizeof(struct ref_entry) + len);
> -       hashcpy(ref->u.value.sha1, sha1);
> -       hashclr(ref->u.value.peeled);
> +       hashcpy(ref->u.value.oid.hash, sha1);
> +       oidclr(&ref->u.value.peeled);
>         memcpy(ref->name, refname, len);
>         ref->flag = flag;
>         return ref;
> @@ -621,7 +621,7 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
>                 /* This is impossible by construction */
>                 die("Reference directory conflict: %s", ref1->name);
>
> -       if (hashcmp(ref1->u.value.sha1, ref2->u.value.sha1))
> +       if (oidcmp(&ref1->u.value.oid, &ref2->u.value.oid))
>                 die("Duplicated ref, and SHA1s don't match: %s", ref1->name);

So you're switching the code for a possible future
In an earlier series/cover letter you wrote

> The goal of this series to improve type-checking in the codebase and to
> make it easier to move to a different hash function if the project
> decides to do that.  This series does not convert all of the codebase,
> but only parts.  I've dropped some of the patches from earlier (which no
> longer apply) and added others.

Which yields the question if you also want to take care of the error message
(It may not be a SHA1 any more but some $HASHFUNCTION)?

That said I'll focus on the type checking part in this review
and not annotate the SHA1s I find any more. ;)
>
>         warning("Duplicated ref: %s", ref1->name);
> @@ -669,7 +669,7 @@ static int ref_resolves_to_object(struct ref_entry *entry)
>  {
>         if (entry->flag & REF_ISBROKEN)
>                 return 0;
> -       if (!has_sha1_file(entry->u.value.sha1)) {
> +       if (!has_sha1_file(entry->u.value.oid.hash)) {
>                 error("%s does not point to a valid object!", entry->name);
>                 return 0;
>         }
> @@ -717,7 +717,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
>         /* Store the old value, in case this is a recursive call: */
>         old_current_ref = current_ref;
>         current_ref = entry;
> -       retval = data->fn(entry->name + data->trim, entry->u.value.sha1,
> +       retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
>                           entry->flag, data->cb_data);
>         current_ref = old_current_ref;
>         return retval;
> @@ -1193,7 +1193,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>                     line.len == PEELED_LINE_LENGTH &&
>                     line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
>                     !get_sha1_hex(line.buf + 1, sha1)) {
> -                       hashcpy(last->u.value.peeled, sha1);
> +                       hashcpy(last->u.value.peeled.hash, sha1);
>                         /*
>                          * Regardless of what the file header said,
>                          * we definitely know the value of *this*
> @@ -1374,7 +1374,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
>         if (ref == NULL)
>                 return -1;
>
> -       hashcpy(sha1, ref->u.value.sha1);
> +       hashcpy(sha1, ref->u.value.oid.hash);
>         return 0;
>  }
>
> @@ -1461,7 +1461,7 @@ static int resolve_missing_loose_ref(const char *refname,
>          */
>         entry = get_packed_ref(refname);
>         if (entry) {
> -               hashcpy(sha1, entry->u.value.sha1);
> +               hashcpy(sha1, entry->u.value.oid.hash);
>                 if (flags)
>                         *flags |= REF_ISPACKED;
>                 return 0;
> @@ -1771,9 +1771,9 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
>         if (entry->flag & REF_KNOWS_PEELED) {
>                 if (repeel) {
>                         entry->flag &= ~REF_KNOWS_PEELED;
> -                       hashclr(entry->u.value.peeled);
> +                       oidclr(&entry->u.value.peeled);
>                 } else {
> -                       return is_null_sha1(entry->u.value.peeled) ?
> +                       return is_null_oid(&entry->u.value.peeled) ?
>                                 PEEL_NON_TAG : PEEL_PEELED;
>                 }
>         }
> @@ -1782,7 +1782,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
>         if (entry->flag & REF_ISSYMREF)
>                 return PEEL_IS_SYMREF;
>
> -       status = peel_object(entry->u.value.sha1, entry->u.value.peeled);
> +       status = peel_object(entry->u.value.oid.hash, entry->u.value.peeled.hash);
>         if (status == PEEL_PEELED || status == PEEL_NON_TAG)
>                 entry->flag |= REF_KNOWS_PEELED;
>         return status;
> @@ -1797,7 +1797,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
>                             || !strcmp(current_ref->name, refname))) {
>                 if (peel_entry(current_ref, 0))
>                         return -1;
> -               hashcpy(sha1, current_ref->u.value.peeled);
> +               hashcpy(sha1, current_ref->u.value.peeled.hash);
>                 return 0;
>         }
>
> @@ -1817,7 +1817,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
>                 if (r) {
>                         if (peel_entry(r, 0))
>                                 return -1;
> -                       hashcpy(sha1, r->u.value.peeled);
> +                       hashcpy(sha1, r->u.value.peeled.hash);
>                         return 0;
>                 }
>         }
> @@ -2422,9 +2422,9 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>         if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
>                 error("internal error: %s is not a valid packed reference!",
>                       entry->name);
> -       write_packed_entry(cb_data, entry->name, entry->u.value.sha1,
> +       write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
>                            peel_status == PEEL_PEELED ?
> -                          entry->u.value.peeled : NULL);
> +                          entry->u.value.peeled.hash : NULL);
>         return 0;
>  }
>
> @@ -2531,24 +2531,24 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
>         peel_status = peel_entry(entry, 1);
>         if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
>                 die("internal error peeling reference %s (%s)",
> -                   entry->name, sha1_to_hex(entry->u.value.sha1));
> +                   entry->name, oid_to_hex(&entry->u.value.oid));
>         packed_entry = find_ref(cb->packed_refs, entry->name);
>         if (packed_entry) {
>                 /* Overwrite existing packed entry with info from loose entry */
>                 packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
> -               hashcpy(packed_entry->u.value.sha1, entry->u.value.sha1);
> +               oidcpy(&packed_entry->u.value.oid, &entry->u.value.oid);
>         } else {
> -               packed_entry = create_ref_entry(entry->name, entry->u.value.sha1,
> +               packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
>                                                 REF_ISPACKED | REF_KNOWS_PEELED, 0);
>                 add_ref(cb->packed_refs, packed_entry);
>         }
> -       hashcpy(packed_entry->u.value.peeled, entry->u.value.peeled);
> +       oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
>
>         /* Schedule the loose reference for pruning if requested. */
>         if ((cb->flags & PACK_REFS_PRUNE)) {
>                 int namelen = strlen(entry->name) + 1;
>                 struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
> -               hashcpy(n->sha1, entry->u.value.sha1);
> +               hashcpy(n->sha1, entry->u.value.oid.hash);
>                 strcpy(n->name, entry->name);
>                 n->next = cb->ref_to_prune;
>                 cb->ref_to_prune = n;
> --
> 2.3.5

The patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
