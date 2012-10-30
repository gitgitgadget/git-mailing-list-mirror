From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push tags
Date: Tue, 30 Oct 2012 12:09:36 -0500
Message-ID: <CAEUsAPZhXpZx+d3+2XUyyYQnM5NFB691FLcasnK5k6fS9efQFQ@mail.gmail.com>
References: <508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
	<CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
	<CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
	<508E532F.2010109@alum.mit.edu>
	<20121029103837.GA14614@sigill.intra.peff.net>
	<CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
	<20121029113500.GA15597@sigill.intra.peff.net>
	<20121029172330.GC8359@camk.edu.pl>
	<20121029213508.GB20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 18:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTFK5-0002oE-2n
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759967Ab2J3RJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 13:09:40 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64045 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759908Ab2J3RJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 13:09:38 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so400087lbo.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mRyqSc/3wESllMsL7Z4ynH15N1EHFQ9X9D0cAR9Xq9Q=;
        b=HCWwECNssrPhkeQk3weRH/Ii6NQk+0dTE5ftNGc1GNa1K6826ijNWUyl2oBb4ETqqG
         gBKSE4TyY52hks8TkFd0Bg2twBvFfTC84rEnQ4j4hb7afJ6s9pFLJ65lFNtXNz+UamJi
         2qZsrLfBf0n/wWMao3fVtFHm+a29tUhL5PlJ1Ln8+n2WYg7IGD1yynV8IFwviJ9twdvo
         0FAjh7pHNLu5Q4WplgyganBkUP0jkLpkWqA/JyRlE76i3CCOD9uAfnqJJBOof7/Liajr
         7ccESdaNi/YeIqhg+OSpHm4AwkdXmoHhkAWwd4S+MtgAhVYvLPKzT4hKTIH+LSGDvpKa
         KCCQ==
Received: by 10.112.46.105 with SMTP id u9mr13441413lbm.67.1351616976309; Tue,
 30 Oct 2012 10:09:36 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Tue, 30 Oct 2012 10:09:36 -0700 (PDT)
In-Reply-To: <20121029213508.GB20513@sigill.intra.peff.net>
X-Google-Sender-Auth: E6MRMQ7eQ1zrf2Cag8Z_YErjMCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208708>

On Mon, Oct 29, 2012 at 4:35 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 06:23:30PM +0100, Kacper Kornet wrote:
>
>> > That patch just blocks non-forced updates to refs/tags/. I think a saner
>> > start would be to disallow updating non-commit objects without a force.
>> > We already do so for blobs and trees because they are not (and cannot
>> > be) fast forwards. The fact that annotated tags are checked for
>> > fast-forward seems to me to be a case of "it happens to work that way"
>> > and not anything planned. Since such a push drops the reference to the
>> > old version of the tag, it should probably require a force.
>>
>> I'm not sure. Looking at 37fde87 ("Fix send-pack for non-commitish
>> tags.") I have an impression that Junio allowed for fast-forward pushes
>> of annotated tags on purpose.
>
> Hmm. You're right, though I'm not sure I agree with the reasoning of
> that commit. I'd certainly like to get Junio's input on the subject.
>
>> > Then on top of that we can talk about what lightweight tags should do.
>> > I'm not sure. Following the regular fast-forward rules makes some sense
>> > to me, because you are never losing objects. But there may be
>> > complications with updating tags in general because of fetch's rules,
>> > and we would be better off preventing people from accidentally doing so.
>> > I think a careful review of fetch's tag rules would be in order before
>> > making any decision there.
>>
>> The problem with the current behaviour is, that one can never be 100% sure
>> that his push will not overwrite someone else tag.
>
> Yes, although you do know that you are not throwing away history if you
> do (because it must be a fast forward). Whereas if you have to use "-f"
> to update a tag, then you have turned off all safety checks. So it is an
> improvement for one case (creating a tag), but a regression for another
> (updating an existing tag). I agree that the latter is probably less
> common, but how much? If virtually nobody is doing it because git-fetch
> makes the fetching side too difficult, then the regression is probably
> not a big deal.
>
> -Peff

This is probably a bit premature given there are still open questions,
but I was curious and decided to take a stab at this.

The change is to only allow fast-forward when both the old and new are
commits and the reference is not a lightweight tag.  All other
reference updates require --force.  I think this resolves the reported
issue and takes into account feedback on this thread.  This change
only broke one test and it was an expected failure given the change in
behavior (i.e., I needed to add a "-f" to update a tag in the remote.)

I wasn't sure how to handle provided feedback to the user when there
are multiple refs not pushed for different reasons.  But I think this
adds the plumbing for handling it correctly, whateverever that this.

It needs some work, but thought I'd throw it out for feedback to see
if it's at least in the right direction.

Chris

--- 8< ---
diff --git a/builtin/push.c b/builtin/push.c
index db9ba30..fabcea0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -220,6 +220,10 @@ static const char message_advice_checkout_pull_push[] =
 	   "(e.g. 'git pull') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");

+static const char message_advice_ref_already_exists[] =
+	N_("Updates were rejected because a matching reference already exists in\n"
+	   "the remote.  Use git push -f if you really want to make this update.");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
@@ -241,6 +245,11 @@ static void advise_checkout_pull_push(void)
 	advise(_(message_advice_checkout_pull_push));
 }

+static void advise_ref_already_exists(void)
+{
+	advise(_(message_advice_ref_already_exists));
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -277,6 +286,9 @@ static int push_with_options(struct transport
*transport, int flags)
 		else
 			advise_checkout_pull_push();
 		break;
+	case ALREADY_EXISTS:
+		advise_ref_already_exists();
+		break;
 	}

 	return 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7d05064..f159ec3 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -202,6 +202,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "non-fast forward";
 			break;

+		case REF_STATUS_REJECT_ALREADY_EXISTS:
+			res = "error";
+			msg = "already exists";
+			break;
+
 		case REF_STATUS_REJECT_NODELETE:
 		case REF_STATUS_REMOTE_REJECT:
 			res = "error";
@@ -288,6 +293,7 @@ int send_pack(struct send_pack_args *args,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/cache.h b/cache.h
index a58df84..2d160a9 100644
--- a/cache.h
+++ b/cache.h
@@ -1002,11 +1002,14 @@ struct ref {
 	unsigned int force:1,
 		merge:1,
 		nonfastforward:1,
+		forwardable:1,
+		update:1,
 		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
 		REF_STATUS_REJECT_NONFASTFORWARD,
+		REF_STATUS_REJECT_ALREADY_EXISTS,
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
diff --git a/remote.c b/remote.c
index 04fd9ea..0d94888 100644
--- a/remote.c
+++ b/remote.c
@@ -1309,22 +1309,42 @@ void set_ref_status_for_push(struct ref
*remote_refs, int send_mirror,
 		 *     to overwrite it; you would not know what you are losing
 		 *     otherwise.
 		 *
-		 * (3) if both new and old are commit-ish, and new is a
-		 *     descendant of old, it is OK.
+		 * (3) if both new and old are commits, the reference is not
+		 *     a tag, and new is a descendant of old, it is OK.
 		 *
 		 * (4) regardless of all of the above, removing :B is
 		 *     always allowed.
 		 */

-		ref->nonfastforward =
+		ref->update =
 			!ref->deletion &&
-			!is_null_sha1(ref->old_sha1) &&
+			!is_null_sha1(ref->old_sha1);
+
+		ref->nonfastforward =
+			ref->update &&
 			(!has_sha1_file(ref->old_sha1)
 			  || !ref_newer(ref->new_sha1, ref->old_sha1));

-		if (ref->nonfastforward && !ref->force && !force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
-			continue;
+		if (prefixcmp(ref->name, "refs/tags/")) {
+			struct object *old = parse_object(ref->old_sha1);
+			struct object *new = parse_object(ref->new_sha1);
+			ref->forwardable = (old && new &&
+			  old->type == OBJ_COMMIT && new->type == OBJ_COMMIT);
+		} else
+			ref->forwardable = 0;
+
+		if (!ref->force && !force_update) {
+			if (ref->forwardable) {
+				if (ref->nonfastforward) {
+					ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+					continue;
+				}
+			} else {
+				if (ref->update) {
+					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
+					continue;
+				}
+			}
 		}
 	}
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b5417cc..cff559f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -368,7 +368,7 @@ test_expect_success 'push with colon-less refspec (2)' '
 		git branch -D frotz
 	fi &&
 	git tag -f frotz &&
-	git push testrepo frotz &&
+	git push -f testrepo frotz &&
 	check_push_result $the_commit tags/frotz &&
 	check_push_result $the_first_commit heads/frotz

@@ -929,6 +929,34 @@ test_expect_success 'push into aliased refs
(inconsistent)' '
 	)
 '

+test_expect_success 'push tag requires --force to update remote tag' '
+	mk_test heads/master &&
+	mk_child child1 &&
+	mk_child child2 &&
+	(
+		cd child1 &&
+		git tag lw_tag &&
+		git tag -a -m "message 1" ann_tag &&
+		git push ../child2 lw_tag &&
+		git push ../child2 ann_tag &&
+		>file1 &&
+		git add file1 &&
+		git commit -m "file1" &&
+		git tag -f lw_tag &&
+		git tag -f -a -m "message 2" ann_tag &&
+		! git push ../child2 lw_tag &&
+		! git push ../child2 ann_tag &&
+		git push --force ../child2 lw_tag &&
+		git push --force ../child2 ann_tag &&
+		git tag -f lw_tag HEAD~ &&
+		git tag -f -a -m "message 3" ann_tag &&
+		! git push ../child2 lw_tag &&
+		! git push ../child2 ann_tag &&
+		git push --force ../child2 lw_tag &&
+		git push --force ../child2 ann_tag
+	)
+'
+
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..ef9a6f8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -643,6 +643,11 @@ static void push_update_ref_status(struct strbuf *buf,
 			free(msg);
 			msg = NULL;
 		}
+		else if (!strcmp(msg, "already exists")) {
+			status = REF_STATUS_REJECT_ALREADY_EXISTS;
+			free(msg);
+			msg = NULL;
+		}
 	}

 	if (*ref)
@@ -702,6 +707,7 @@ static int push_refs_with_push(struct transport *transport,
 		/* Check for statuses set by set_ref_status_for_push() */
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
 		default:
diff --git a/transport.c b/transport.c
index 9932f40..d218884 100644
--- a/transport.c
+++ b/transport.c
@@ -659,7 +659,7 @@ static void print_ok_ref_status(struct ref *ref,
int porcelain)
 		const char *msg;

 		strcpy(quickref, status_abbrev(ref->old_sha1));
-		if (ref->nonfastforward) {
+		if (ref->nonfastforward || (!ref->forwardable && ref->update)) {
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
@@ -695,6 +695,10 @@ static int print_one_push_status(struct ref *ref,
const char *dest, int count, i
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "non-fast-forward", porcelain);
 		break;
+	case REF_STATUS_REJECT_ALREADY_EXISTS:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+						 "already exists", porcelain);
+		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
 						 ref->deletion ? NULL : ref->peer_ref,
@@ -714,7 +718,7 @@ static int print_one_push_status(struct ref *ref,
const char *dest, int count, i
 }

 void transport_print_push_status(const char *dest, struct ref *refs,
-				  int verbose, int porcelain, int *nonfastforward)
+				  int verbose, int porcelain, int *willnotupdate)
 {
 	struct ref *ref;
 	int n = 0;
@@ -733,18 +737,21 @@ void transport_print_push_status(const char
*dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);

-	*nonfastforward = 0;
+	*willnotupdate = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD &&
-		    *nonfastforward != NON_FF_HEAD) {
+		    *willnotupdate != NON_FF_HEAD) {
 			if (!strcmp(head, ref->name))
-				*nonfastforward = NON_FF_HEAD;
+				*willnotupdate = NON_FF_HEAD;
 			else
-				*nonfastforward = NON_FF_OTHER;
+				*willnotupdate = NON_FF_OTHER;
+		} else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS &&
+		    *willnotupdate == 0) {
+				*willnotupdate = ALREADY_EXISTS;
 		}
 	}
 }
@@ -1031,9 +1038,9 @@ static void die_with_unpushed_submodules(struct
string_list *needs_pushing)

 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
-		   int *nonfastforward)
+		   int *willnotupdate)
 {
-	*nonfastforward = 0;
+	*willnotupdate = 0;
 	transport_verify_remote_names(refspec_nr, refspec);

 	if (transport->push) {
@@ -1099,7 +1106,7 @@ int transport_push(struct transport *transport,
 		if (!quiet || err)
 			transport_print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
-					nonfastforward);
+					willnotupdate);

 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
diff --git a/transport.h b/transport.h
index 3b21c4a..326271e 100644
--- a/transport.h
+++ b/transport.h
@@ -142,6 +142,7 @@ void transport_set_verbosity(struct transport
*transport, int verbosity,

 #define NON_FF_HEAD 1
 #define NON_FF_OTHER 2
+#define ALREADY_EXISTS 3
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   int * nonfastforward);
@@ -170,7 +171,7 @@ void transport_update_tracking_ref(struct remote
*remote, struct ref *ref, int v
 int transport_refs_pushed(struct ref *ref);

 void transport_print_push_status(const char *dest, struct ref *refs,
-		  int verbose, int porcelain, int *nonfastforward);
+		  int verbose, int porcelain, int *willnotupdate);

 typedef void alternate_ref_fn(const struct ref *, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
-- 
1.8.0
