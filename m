From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Fri, 11 Sep 2015 23:42:56 +0530
Message-ID: <CAOLa=ZTZiFzLogP=OXi_cS3Dn4775bU5LqBUWLu8Sf5ocs6T=g@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3m6nrf9.fsf@scolette.imag.fr> <CAOLa=ZQppSg0-kc5nCfRYfHMoD5ehTTOigKz48G01vn1Mn=FTw@mail.gmail.com>
 <CAPig+cTmnOz899k_xySb1Q-SeFctOrs6fnJJN=qc731nXmXwkw@mail.gmail.com> <xmqqwpvwzvaa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 20:13:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaSpV-00072A-0Q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 20:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbbIKSNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 14:13:30 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36814 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbIKSN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 14:13:26 -0400
Received: by obqa2 with SMTP id a2so67034278obq.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zjkNItS2SniX/Hny6t5XRELG9XGyHl1uHoTAvabHi50=;
        b=a60KLwqTfXfLRp1L9dpK3K+AnwRbbMXAVPa2AW07PA5VPy4ad23y3lthIyCl1l0khS
         OAm6Y4+6t8R33jWpz873lhrRcW9DeRsTu9iWhuHO//qxVIMrKGluVzsWQNRW5C+xavdH
         1tpun65PWWDYnNJmNN6BDqbgzuewbTAai/V6SPsd3oVKSOnWJ4UL1H3cCilNgtjs3mD+
         JlncAG51hVHlmThy+JSZNDHOKJIyK7/ZDZJvsE4tcVj0m6IULtpV2AXrfJFqKAdmkWA6
         xpxLh5Qk5qYcfHVZQXogTluqUBI7PDCHkOsEXYP0XBXzUMvO6BwbU1lIkQjJLEbIwdQS
         J8Tg==
X-Received: by 10.182.153.161 with SMTP id vh1mr112150obb.34.1441995205682;
 Fri, 11 Sep 2015 11:13:25 -0700 (PDT)
Received: by 10.182.59.15 with HTTP; Fri, 11 Sep 2015 11:12:56 -0700 (PDT)
In-Reply-To: <xmqqwpvwzvaa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277688>

On Fri, Sep 11, 2015 at 11:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Hmm, but what actually changed in the re-sent patches? Without a link
> to the discussion leading up to the re-send of changed-only patches,
> and without an interdiff, the re-send is opaque and less accessible to
> the reviewer; which is at odds with Matthieu's suggestion which was
> intended to make review easier and more streamlined.
>

Should have put an interdiff, my bad!

> In addition to a link to the previous round and an interdiff, it would
> be helpful to reviewers for you to annotate each patch (in the
> commentary are below the "---" line after your sign-off) with a
> description of the changes in that patch since the previous round in
> order to focus the reviewer's attention (where it needs to be) on the
> latest changes.

WIll follow this next time :)

On Fri, Sep 11, 2015 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> In addition to a link to the previous round and an interdiff, it would
>> be helpful to reviewers for you to annotate each patch (in the
>> commentary are below the "---" line after your sign-off) with a
>> description of the changes in that patch since the previous round in
>> order to focus the reviewer's attention (where it needs to be) on the
>> latest changes.
>
> I may have got confused by seeing the same v17 (if they were marked
> as v18 or v17bis, it would have been easier to make sure I didn't
> miss anything), but here is the difference between what I had last
> night and what I queued.  The removal of !body[1] and flipping the
> order of to_free/format are not seen because I already had a local
> fix-up SQUASH??? commits queued in the yesterday's batch.
>
>
> $ git diff --stat -p kn/for-each-tag@{4.hours} kn/for-each-tag
>  ref-filter.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 226e94d..fd839ac 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -47,9 +47,6 @@ static struct {
>         { "subject" },
>         { "body" },
>         { "contents" },
> -       { "contents:subject" },
> -       { "contents:body" },
> -       { "contents:signature" },
>         { "upstream" },
>         { "push" },
>         { "symref" },
> @@ -58,7 +55,6 @@ static struct {
>         { "color" },
>         { "align" },
>         { "end" },
> -       { "contents:lines" },
>  };
>
>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
> @@ -899,6 +895,7 @@ static void populate_value(struct ref_array_item *ref)
>                         align->position = ALIGN_LEFT;
>
>                         while (*s) {
> +                               /*  Strip trailing comma */
>                                 if (s[1])
>                                         strbuf_setlen(s[0], s[0]->len - 1);
>                                 if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))

The complete interdiff:

diff --git a/builtin/tag.c b/builtin/tag.c
index 081fe84..f2f6e2d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -43,9 +43,9 @@ static int list_tags(struct ref_filter *filter,
struct ref_sorting *sorting, con

     if (!format) {
         if (filter->lines) {
-            format = xstrfmt("%s %%(contents:lines=%d)",
-                     "%(align:15)%%(refname:short)%%(end)", filter->lines);
-            to_free = format;
+            to_free = xstrfmt("%s %%(contents:lines=%d)",
+                      "%(align:15)%(refname:short)%(end)", filter->lines);
+            format = to_free;
         } else
             format = "%(refname:short)";
     }
diff --git a/ref-filter.c b/ref-filter.c
index 59716db..fd839ac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -47,9 +47,6 @@ static struct {
     { "subject" },
     { "body" },
     { "contents" },
-    { "contents:subject" },
-    { "contents:body" },
-    { "contents:signature" },
     { "upstream" },
     { "push" },
     { "symref" },
@@ -58,7 +55,6 @@ static struct {
     { "color" },
     { "align" },
     { "end" },
-    { "contents:lines" },
 };

 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -268,7 +264,7 @@ static int match_atom_name(const char *name, const
char *atom_name, const char *

     if (!skip_prefix(name, atom_name, &body))
         return 0; /* doesn't even begin with "atom_name" */
-    if (!body[0] || !body[1]) {
+    if (!body[0]) {
         *val = NULL; /* %(atom_name) and no customization */
         return 1;
     }
@@ -899,6 +895,7 @@ static void populate_value(struct ref_array_item *ref)
             align->position = ALIGN_LEFT;

             while (*s) {
+                /*  Strip trailing comma */
                 if (s[1])
                     strbuf_setlen(s[0], s[0]->len - 1);
                 if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))


-- 
Regards,
Karthik Nayak
