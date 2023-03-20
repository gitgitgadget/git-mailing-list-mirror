Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF1C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCTMfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTMfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964878687
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B3B55C017E;
        Mon, 20 Mar 2023 08:35:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 20 Mar 2023 08:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315719; x=1679402119; bh=yD
        LBMfHC6frvMsMVvvEUU10R9KWKb6+rUVtK/ZYYfLs=; b=GQEVaSc2O1ghePZ/5W
        /TSP6/guJdvMOVbExK3VgHXveSh3TiYl8o4Q5fDvL36Uo1VFp+pK0xTuIj9Kr6b+
        hxG4e7+MrMTHq+MWLfFOu0YMM/eClW0ueVbW4IpfCzU8rys/L3Ay4pyPT2m4r7Xn
        hzuxfFRFRZwK/ZaKAlDgYflbzNZgEe423Fx5XMEFmyEfHX4YPo1Up/TFVTdkwiC3
        WZr2Y/2hfUemVcj4Yh16vRB7G5kFJ8IDSE80sGhgq371SsczxzdfUr8IRDzQSLDG
        yOdSxvGOgEzIKsZU0obwAZBnr4sl/2OtdgFJevgE+hr0C7un2/pOwbPJaUzDtG+Y
        ZBfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315719; x=1679402119; bh=yDLBMfHC6frvM
        sMVvvEUU10R9KWKb6+rUVtK/ZYYfLs=; b=MOGGdcWP2Gq5r42I9AwVfWf7YG7iV
        w6boWfi7igK0ph8DYQWVaU5X9UhyEuVQ4Xdd8mtwB9UFIzmWuEWbMAseewKWh4dN
        AixNf5qkuKSqcoxFDjJdtpexyOm1OTMIBO4FTz/wK6CY5WnUAhjDeA675b5zAjB5
        2L8B9YWtp+03dY1Sizt+xALW6mAhhEh8TZfPiWHGwaEu7tel52WMiEuYirAPrG6N
        o7hS9NQqt06gbFItMnMrP2Yr4jJhU/XfuJrBYrxvnn9RxaYMMmzrgJzDKFWzun46
        yAMihKlLPOUvw0cFKKPd7y7zBKHZFFegYUT2Y/NAy2AsFLTX6mvY2v5zQ==
X-ME-Sender: <xms:B1MYZHId8QvAyoQAoF52zSTOpyQOR_iPpD4RHjxEpt4zbLu_zyuW0A>
    <xme:B1MYZLIRLP825SKiISDyioas_HQlbTxt4AvPlwnYIKWUZMBO2FCcoipQOHkxJZg9i
    GB8cvVYRI4gIb36mA>
X-ME-Received: <xmr:B1MYZPvMIeG0fstPpvlQKWi8Czb6GufBINYSeBMEsd4ZfX_U7JwBrztlSr9j1VUcGr3G5I20VtXRVqlO-CWMwAVtvx1OeN-hDJg70o0jlm8-lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:B1MYZAY11R-nZ9USgjt5zgXlqFpjsu9E6fmzDGAsjpfm12YHTNSaBg>
    <xmx:B1MYZOa7Nm31SqibLIQyq1QczukhujlgPHfq3kaQaiBfpGITS6hyEA>
    <xmx:B1MYZEBBDdp4bVWsCzR7vonEPUpw_Lo64fzSqikngZNRMkFEeDgsCg>
    <xmx:B1MYZBybnwWGsJqUipJVmygg9WQrLcW1OyCxjHrjGocJTDKxPmbyAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:18 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1f1deea8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:34:45 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 0/6] fetch: refactor code that prints reference updates
Message-ID: <cover.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsmeTTGIjeBFVU2b"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XsmeTTGIjeBFVU2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This is the second version of my patch series to refactor the code that
prints reference updates during git-fetch(1). Its aim is it to make the
code more self-contained so that it can be easily amended for a new
machine-parseable format.

Changes compared to v1:

    - I've dropped the first patch to rename the preexisting `display`
      buffer variable. Instead, I'm now just picking the longer
      `display_state` variable name for the newly introduced structure
      in order to avoid naming conflicts.

    - I've touched up the commit messages of patches 4-6 to hopefully
      clarify their intent a little bit better.

    - I've dropped patch 7/8 that unified the logic to calculate the
      summary width. Even though it fixes a bug in one case, Jonathan
      correctly pointed out that it's weird in the case where there are
      only reference deletions without any reference updates. I may have
      another go in a separate patch series after the dust has settled.

Thanks for the feedback so far!

Patrick

Patrick Steinhardt (6):
  fetch: move reference width calculation into `display_state`
  fetch: move output format into `display_state`
  fetch: pass the full local reference name to `format_display`
  fetch: centralize handling of per-reference format
  fetch: centralize logic to print remote URL
  fetch: centralize printing of reference updates

 builtin/fetch.c | 267 +++++++++++++++++++++++++-----------------------
 1 file changed, 138 insertions(+), 129 deletions(-)

Range-diff against v1:
1:  692206f7ff < -:  ---------- fetch: rename `display` buffer to avoid nam=
e conflict
2:  aa792b12a4 ! 1:  ce2c4b61ae fetch: move reference width calculation int=
o `display_state`
    @@ builtin/fetch.c: static void adjust_refcol_width(const struct ref *r=
ef)
      }
     =20
     -static void prepare_format_display(struct ref *ref_map)
    -+static void display_state_init(struct display_state *display, struct =
ref *ref_map)
    ++static void display_state_init(struct display_state *display_state, s=
truct ref *ref_map)
      {
      	struct ref *rm;
      	const char *format =3D "full";
     =20
    -+	memset(display, 0, sizeof(*display));
    ++	memset(display_state, 0, sizeof(*display_state));
     +
      	if (verbosity < 0)
      		return;
    @@ builtin/fetch.c: static void prepare_format_display(struct ref *ref_=
map)
      		die(_("invalid value for '%s': '%s'"),
      		    "fetch.output", format);
     =20
    -+	display->refcol_width =3D 10;
    ++	display_state->refcol_width =3D 10;
      	for (rm =3D ref_map; rm; rm =3D rm->next) {
     +		int width;
     +
    @@ builtin/fetch.c: static void prepare_format_display(struct ref *ref_=
map)
     +		 * appear on the left hand side of '->' and shrink the column
     +		 * back.
     +		 */
    -+		if (display->refcol_width < width)
    -+			display->refcol_width =3D width;
    ++		if (display_state->refcol_width < width)
    ++			display_state->refcol_width =3D width;
      	}
      }
     =20
    --static void print_remote_to_local(struct strbuf *display_buffer,
    -+static void print_remote_to_local(struct display_state *display,
    +-static void print_remote_to_local(struct strbuf *display,
    ++static void print_remote_to_local(struct display_state *display_state,
     +				  struct strbuf *display_buffer,
      				  const char *remote, const char *local)
      {
    --	strbuf_addf(display_buffer, "%-*s -> %s", refcol_width, remote, loca=
l);
    -+	strbuf_addf(display_buffer, "%-*s -> %s", display->refcol_width, rem=
ote, local);
    +-	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
    ++	strbuf_addf(display_buffer, "%-*s -> %s", display_state->refcol_widt=
h, remote, local);
      }
     =20
      static int find_and_replace(struct strbuf *haystack,
    @@ builtin/fetch.c: static int find_and_replace(struct strbuf *haystack,
      	return 1;
      }
     =20
    --static void print_compact(struct strbuf *display_buffer,
    -+static void print_compact(struct display_state *display, struct strbu=
f *display_buffer,
    +-static void print_compact(struct strbuf *display,
    ++static void print_compact(struct display_state *display_state, struct=
 strbuf *display_buffer,
      			  const char *remote, const char *local)
      {
      	struct strbuf r =3D STRBUF_INIT;
      	struct strbuf l =3D STRBUF_INIT;
     =20
      	if (!strcmp(remote, local)) {
    --		strbuf_addf(display_buffer, "%-*s -> *", refcol_width, remote);
    -+		strbuf_addf(display_buffer, "%-*s -> *", display->refcol_width, rem=
ote);
    +-		strbuf_addf(display, "%-*s -> *", refcol_width, remote);
    ++		strbuf_addf(display_buffer, "%-*s -> *", display_state->refcol_widt=
h, remote);
      		return;
      	}
     =20
    -@@ builtin/fetch.c: static void print_compact(struct strbuf *display_b=
uffer,
    +@@ builtin/fetch.c: static void print_compact(struct strbuf *display,
     =20
      	if (!find_and_replace(&r, local, "*"))
      		find_and_replace(&l, remote, "*");
    --	print_remote_to_local(display_buffer, r.buf, l.buf);
    -+	print_remote_to_local(display, display_buffer, r.buf, l.buf);
    +-	print_remote_to_local(display, r.buf, l.buf);
    ++	print_remote_to_local(display_state, display_buffer, r.buf, l.buf);
     =20
      	strbuf_release(&r);
      	strbuf_release(&l);
      }
     =20
    --static void format_display(struct strbuf *display_buffer, char code,
    -+static void format_display(struct display_state *display,
    +-static void format_display(struct strbuf *display, char code,
    ++static void format_display(struct display_state *display_state,
     +			   struct strbuf *display_buffer, char code,
      			   const char *summary, const char *error,
      			   const char *remote, const char *local,
      			   int summary_width)
    -@@ builtin/fetch.c: static void format_display(struct strbuf *display_=
buffer, char code,
    +@@ builtin/fetch.c: static void format_display(struct strbuf *display,=
 char code,
     =20
    - 	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
    + 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
    +=20
    +-	strbuf_addf(display, "%c %-*s ", code, width, summary);
    ++	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
      	if (!compact_format)
    --		print_remote_to_local(display_buffer, remote, local);
    -+		print_remote_to_local(display, display_buffer, remote, local);
    +-		print_remote_to_local(display, remote, local);
    ++		print_remote_to_local(display_state, display_buffer, remote, local);
      	else
    --		print_compact(display_buffer, remote, local);
    -+		print_compact(display, display_buffer, remote, local);
    +-		print_compact(display, remote, local);
    ++		print_compact(display_state, display_buffer, remote, local);
      	if (error)
    - 		strbuf_addf(display_buffer, "  (%s)", error);
    +-		strbuf_addf(display, "  (%s)", error);
    ++		strbuf_addf(display_buffer, "  (%s)", error);
      }
     =20
      static int update_local_ref(struct ref *ref,
      			    struct ref_transaction *transaction,
    -+			    struct display_state *display,
    ++			    struct display_state *display_state,
      			    const char *remote, const struct ref *remote_ref,
    - 			    struct strbuf *display_buffer, int summary_width)
    + 			    struct strbuf *display, int summary_width)
      {
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     =20
      	if (oideq(&ref->old_oid, &ref->new_oid)) {
      		if (verbosity > 0)
    --			format_display(display_buffer, '=3D', _("[up to date]"), NULL,
    -+			format_display(display, display_buffer, '=3D', _("[up to date]"), =
NULL,
    +-			format_display(display, '=3D', _("[up to date]"), NULL,
    ++			format_display(display_state, display, '=3D', _("[up to date]"), N=
ULL,
      				       remote, pretty_ref, summary_width);
      		return 0;
      	}
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		 * If this is the head, and it's not okay to update
      		 * the head, and the old value of the head isn't empty...
      		 */
    --		format_display(display_buffer, '!', _("[rejected]"),
    -+		format_display(display, display_buffer, '!', _("[rejected]"),
    +-		format_display(display, '!', _("[rejected]"),
    ++		format_display(display_state, display, '!', _("[rejected]"),
      			       _("can't fetch into checked-out branch"),
      			       remote, pretty_ref, summary_width);
      		return 1;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		if (force || ref->force) {
      			int r;
      			r =3D s_update_ref("updating tag", ref, transaction, 0);
    --			format_display(display_buffer, r ? '!' : 't', _("[tag update]"),
    -+			format_display(display, display_buffer, r ? '!' : 't', _("[tag upd=
ate]"),
    +-			format_display(display, r ? '!' : 't', _("[tag update]"),
    ++			format_display(display_state, display, r ? '!' : 't', _("[tag upda=
te]"),
      				       r ? _("unable to update local ref") : NULL,
      				       remote, pretty_ref, summary_width);
      			return r;
      		} else {
    --			format_display(display_buffer, '!', _("[rejected]"), _("would clob=
ber existing tag"),
    -+			format_display(display, display_buffer, '!', _("[rejected]"),
    +-			format_display(display, '!', _("[rejected]"), _("would clobber exi=
sting tag"),
    ++			format_display(display_state, display, '!', _("[rejected]"),
     +				       _("would clobber existing tag"),
      				       remote, pretty_ref, summary_width);
      			return 1;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		}
     =20
      		r =3D s_update_ref(msg, ref, transaction, 0);
    --		format_display(display_buffer, r ? '!' : '*', what,
    -+		format_display(display, display_buffer, r ? '!' : '*', what,
    +-		format_display(display, r ? '!' : '*', what,
    ++		format_display(display_state, display, r ? '!' : '*', what,
      			       r ? _("unable to update local ref") : NULL,
      			       remote, pretty_ref, summary_width);
      		return r;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		strbuf_addstr(&quickref, "..");
      		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
      		r =3D s_update_ref("fast-forward", ref, transaction, 1);
    --		format_display(display_buffer, r ? '!' : ' ', quickref.buf,
    -+		format_display(display, display_buffer, r ? '!' : ' ', quickref.buf,
    +-		format_display(display, r ? '!' : ' ', quickref.buf,
    ++		format_display(display_state, display, r ? '!' : ' ', quickref.buf,
      			       r ? _("unable to update local ref") : NULL,
      			       remote, pretty_ref, summary_width);
      		strbuf_release(&quickref);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		strbuf_addstr(&quickref, "...");
      		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
      		r =3D s_update_ref("forced-update", ref, transaction, 1);
    --		format_display(display_buffer, r ? '!' : '+', quickref.buf,
    -+		format_display(display, display_buffer, r ? '!' : '+', quickref.buf,
    +-		format_display(display, r ? '!' : '+', quickref.buf,
    ++		format_display(display_state, display, r ? '!' : '+', quickref.buf,
      			       r ? _("unable to update local ref") : _("forced update"),
      			       remote, pretty_ref, summary_width);
      		strbuf_release(&quickref);
      		return r;
      	} else {
    --		format_display(display_buffer, '!', _("[rejected]"), _("non-fast-fo=
rward"),
    -+		format_display(display, display_buffer, '!', _("[rejected]"), _("no=
n-fast-forward"),
    +-		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
    ++		format_display(display_state, display, '!', _("[rejected]"), _("non=
-fast-forward"),
      			       remote, pretty_ref, summary_width);
      		return 1;
      	}
    @@ builtin/fetch.c: N_("it took %.2f seconds to check forced updates; y=
ou can use\n
         "to avoid this check\n");
     =20
     -static int store_updated_refs(const char *raw_url, const char *remote=
_name,
    -+static int store_updated_refs(struct display_state *display,
    ++static int store_updated_refs(struct display_state *display_state,
     +			      const char *raw_url, const char *remote_name,
      			      int connectivity_checked,
      			      struct ref_transaction *transaction, struct ref *ref_map,
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
      			strbuf_reset(&note);
      			if (ref) {
     -				rc |=3D update_local_ref(ref, transaction, what,
    -+				rc |=3D update_local_ref(ref, transaction, display, what,
    ++				rc |=3D update_local_ref(ref, transaction, display_state, what,
      						       rm, &note, summary_width);
      				free(ref);
      			} else if (write_fetch_head || dry_run) {
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
      				 * is set).
      				 */
     -				format_display(&note, '*',
    -+				format_display(display, &note, '*',
    ++				format_display(display_state, &note, '*',
      					       *kind ? kind : "branch", NULL,
      					       *what ? what : "HEAD",
      					       "FETCH_HEAD", summary_width);
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *re=
f_map)
      }
     =20
     -static int fetch_and_consume_refs(struct transport *transport,
    -+static int fetch_and_consume_refs(struct display_state *display,
    ++static int fetch_and_consume_refs(struct display_state *display_state,
     +				  struct transport *transport,
      				  struct ref_transaction *transaction,
      				  struct ref *ref_map,
    @@ builtin/fetch.c: static int fetch_and_consume_refs(struct transport =
*transport,
     =20
      	trace2_region_enter("fetch", "consume_refs", the_repository);
     -	ret =3D store_updated_refs(transport->url, transport->remote->name,
    -+	ret =3D store_updated_refs(display, transport->url, transport->remot=
e->name,
    ++	ret =3D store_updated_refs(display_state, transport->url, transport-=
>remote->name,
      				 connectivity_checked, transaction, ref_map,
      				 fetch_head);
      	trace2_region_leave("fetch", "consume_refs", the_repository);
    @@ builtin/fetch.c: static int fetch_and_consume_refs(struct transport =
*transport,
      }
     =20
     -static int prune_refs(struct refspec *rs,
    -+static int prune_refs(struct display_state *display,
    ++static int prune_refs(struct display_state *display_state,
     +		      struct refspec *rs,
      		      struct ref_transaction *transaction,
      		      struct ref *ref_map,
    @@ builtin/fetch.c: static int prune_refs(struct refspec *rs,
      				shown_url =3D 1;
      			}
     -			format_display(&sb, '-', _("[deleted]"), NULL,
    -+			format_display(display, &sb, '-', _("[deleted]"), NULL,
    ++			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
      				       _("(none)"), prettify_refname(ref->name),
      				       summary_width);
      			fprintf(stderr, " %s\n",sb.buf);
    @@ builtin/fetch.c: static struct transport *prepare_transport(struct r=
emote *remot
      }
     =20
     -static int backfill_tags(struct transport *transport,
    -+static int backfill_tags(struct display_state *display,
    ++static int backfill_tags(struct display_state *display_state,
     +			 struct transport *transport,
      			 struct ref_transaction *transaction,
      			 struct ref *ref_map,
    @@ builtin/fetch.c: static int backfill_tags(struct transport *transpor=
t,
      	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
      	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
     -	retcode =3D fetch_and_consume_refs(transport, transaction, ref_map, =
fetch_head);
    -+	retcode =3D fetch_and_consume_refs(display, transport, transaction, =
ref_map, fetch_head);
    ++	retcode =3D fetch_and_consume_refs(display_state, transport, transac=
tion, ref_map, fetch_head);
     =20
      	if (gsecondary) {
      		transport_disconnect(gsecondary);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      {
      	struct ref_transaction *transaction =3D NULL;
      	struct ref *ref_map =3D NULL;
    -+	struct display_state display;
    ++	struct display_state display_state;
      	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
      	int retcode =3D 0;
      	const struct ref *remote_refs;
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	if (retcode)
      		goto cleanup;
     =20
    -+	display_state_init(&display, ref_map);
    ++	display_state_init(&display_state, ref_map);
     +
      	if (atomic_fetch) {
      		transaction =3D ref_transaction_begin(&err);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		 */
      		if (rs->nr) {
     -			retcode =3D prune_refs(rs, transaction, ref_map, transport->url);
    -+			retcode =3D prune_refs(&display, rs, transaction, ref_map, transpo=
rt->url);
    ++			retcode =3D prune_refs(&display_state, rs, transaction, ref_map, t=
ransport->url);
      		} else {
     -			retcode =3D prune_refs(&transport->remote->fetch,
    -+			retcode =3D prune_refs(&display, &transport->remote->fetch,
    ++			retcode =3D prune_refs(&display_state, &transport->remote->fetch,
      					     transaction, ref_map,
      					     transport->url);
      		}
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	}
     =20
     -	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_h=
ead)) {
    -+	if (fetch_and_consume_refs(&display, transport, transaction, ref_map=
, &fetch_head)) {
    ++	if (fetch_and_consume_refs(&display_state, transport, transaction, r=
ef_map, &fetch_head)) {
      		retcode =3D 1;
      		goto cleanup;
      	}
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      			 * the transaction and don't commit anything.
      			 */
     -			if (backfill_tags(transport, transaction, tags_ref_map,
    -+			if (backfill_tags(&display, transport, transaction, tags_ref_map,
    ++			if (backfill_tags(&display_state, transport, transaction, tags_ref=
_map,
      					  &fetch_head))
      				retcode =3D 1;
      		}
3:  a4fd935c40 ! 2:  34eedb882c fetch: move output format into `display_sta=
te`
    @@ builtin/fetch.c: static int s_update_ref(const char *action,
      {
      	int max, rlen, llen, len;
     =20
    -@@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display, struct ref *ref_ma
    +@@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display_state, struct ref *
     =20
      	git_config_get_string_tmp("fetch.output", &format);
      	if (!strcasecmp(format, "full"))
     -		compact_format =3D 0;
    -+		display->compact_format =3D 0;
    ++		display_state->compact_format =3D 0;
      	else if (!strcasecmp(format, "compact"))
     -		compact_format =3D 1;
    -+		display->compact_format =3D 1;
    ++		display_state->compact_format =3D 1;
      	else
      		die(_("invalid value for '%s': '%s'"),
      		    "fetch.output", format);
    -@@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display, struct ref *ref_ma
    +@@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display_state, struct ref *
      		    !strcmp(rm->name, "HEAD"))
      			continue;
     =20
     -		width =3D refcol_width(rm);
    -+		width =3D refcol_width(rm, display->compact_format);
    ++		width =3D refcol_width(rm, display_state->compact_format);
     =20
      		/*
      		 * Not precise calculation for compact mode because '*' can
    -@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay,
    +@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay_state,
      	width =3D (summary_width + strlen(summary) - gettext_width(summary));
     =20
      	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
     -	if (!compact_format)
    -+	if (!display->compact_format)
    - 		print_remote_to_local(display, display_buffer, remote, local);
    ++	if (!display_state->compact_format)
    + 		print_remote_to_local(display_state, display_buffer, remote, local);
      	else
    - 		print_compact(display, display_buffer, remote, local);
    + 		print_compact(display_state, display_buffer, remote, local);
4:  0998173b57 ! 3:  ec355b8b8d fetch: pass the full local reference name t=
o `format_display`
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay,
    +@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay_state,
     =20
      	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
    - 	if (!display->compact_format)
    --		print_remote_to_local(display, display_buffer, remote, local);
    -+		print_remote_to_local(display, display_buffer, remote, prettify_ref=
name(local));
    + 	if (!display_state->compact_format)
    +-		print_remote_to_local(display_state, display_buffer, remote, local);
    ++		print_remote_to_local(display_state, display_buffer, remote, pretti=
fy_refname(local));
      	else
    --		print_compact(display, display_buffer, remote, local);
    -+		print_compact(display, display_buffer, remote, prettify_refname(loc=
al));
    +-		print_compact(display_state, display_buffer, remote, local);
    ++		print_compact(display_state, display_buffer, remote, prettify_refna=
me(local));
      	if (error)
      		strbuf_addf(display_buffer, "  (%s)", error);
      }
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
    - 			    struct strbuf *display_buffer, int summary_width)
    + 			    struct strbuf *display, int summary_width)
      {
      	struct commit *current =3D NULL, *updated;
     -	const char *pretty_ref =3D prettify_refname(ref->name);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      	if (oideq(&ref->old_oid, &ref->new_oid)) {
      		if (verbosity > 0)
    - 			format_display(display, display_buffer, '=3D', _("[up to date]"), =
NULL,
    + 			format_display(display_state, display, '=3D', _("[up to date]"), N=
ULL,
     -				       remote, pretty_ref, summary_width);
     +				       remote, ref->name, summary_width);
      		return 0;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     =20
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		 */
    - 		format_display(display, display_buffer, '!', _("[rejected]"),
    + 		format_display(display_state, display, '!', _("[rejected]"),
      			       _("can't fetch into checked-out branch"),
     -			       remote, pretty_ref, summary_width);
     +			       remote, ref->name, summary_width);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     =20
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      			r =3D s_update_ref("updating tag", ref, transaction, 0);
    - 			format_display(display, display_buffer, r ? '!' : 't', _("[tag upd=
ate]"),
    + 			format_display(display_state, display, r ? '!' : 't', _("[tag upda=
te]"),
      				       r ? _("unable to update local ref") : NULL,
     -				       remote, pretty_ref, summary_width);
     +				       remote, ref->name, summary_width);
      			return r;
      		} else {
    - 			format_display(display, display_buffer, '!', _("[rejected]"),
    + 			format_display(display_state, display, '!', _("[rejected]"),
      				       _("would clobber existing tag"),
     -				       remote, pretty_ref, summary_width);
     +				       remote, ref->name, summary_width);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      	}
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		r =3D s_update_ref(msg, ref, transaction, 0);
    - 		format_display(display, display_buffer, r ? '!' : '*', what,
    + 		format_display(display_state, display, r ? '!' : '*', what,
      			       r ? _("unable to update local ref") : NULL,
     -			       remote, pretty_ref, summary_width);
     +			       remote, ref->name, summary_width);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
     =20
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		r =3D s_update_ref("fast-forward", ref, transaction, 1);
    - 		format_display(display, display_buffer, r ? '!' : ' ', quickref.buf,
    + 		format_display(display_state, display, r ? '!' : ' ', quickref.buf,
      			       r ? _("unable to update local ref") : NULL,
     -			       remote, pretty_ref, summary_width);
     +			       remote, ref->name, summary_width);
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      	} else if (force || ref->force) {
     @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      		r =3D s_update_ref("forced-update", ref, transaction, 1);
    - 		format_display(display, display_buffer, r ? '!' : '+', quickref.buf,
    + 		format_display(display_state, display, r ? '!' : '+', quickref.buf,
      			       r ? _("unable to update local ref") : _("forced update"),
     -			       remote, pretty_ref, summary_width);
     +			       remote, ref->name, summary_width);
      		strbuf_release(&quickref);
      		return r;
      	} else {
    - 		format_display(display, display_buffer, '!', _("[rejected]"), _("no=
n-fast-forward"),
    + 		format_display(display_state, display, '!', _("[rejected]"), _("non=
-fast-forward"),
     -			       remote, pretty_ref, summary_width);
     +			       remote, ref->name, summary_width);
      		return 1;
      	}
      }
    -@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y,
    +@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y_state,
      				shown_url =3D 1;
      			}
    - 			format_display(display, &sb, '-', _("[deleted]"), NULL,
    + 			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
     -				       _("(none)"), prettify_refname(ref->name),
     +				       _("(none)"), ref->name,
      				       summary_width);
5:  d45ec31eea ! 4:  e4c1ed4ad5 fetch: deduplicate handling of per-referenc=
e format
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    fetch: deduplicate handling of per-reference format
    +    fetch: centralize handling of per-reference format
    =20
    -    Both callsites that call `format_display()` and then print the res=
ult to
    -    standard error use the same formatting directive " %s\n" to print =
the
    -    reference to disk, thus duplicating a small part of the logic.
    +    The function `format_display()` is used to print a single reference
    +    update to a buffer which will then ultimately be printed by the ca=
ller.
    +    This architecture causes us to duplicate some logic across the dif=
ferent
    +    callsites of this function. This makes it hard to follow the code =
as
    +    some parts of the logic are located in one place, while other part=
s of
    +    the logic are located in a different place. Furthermore, by having=
 the
    +    logic scattered around it becomes quite hard to implement a new ou=
tput
    +    format for the reference updates.
    =20
    -    Refactor the code to handle this in `format_display()` itself. This
    -    paves the way for handling the printing logic in that function
    -    completely.
    +    We can make the logic a whole lot easier to understand by making t=
he
    +    `format_display()` function self-contained so that it handles form=
atting
    +    and printing of the references. This will eventually allow us to e=
asily
    +    implement a completely different output format, but also opens the=
 door
    +    to conditionally print to either stdout or stderr depending on the
    +    output format.
    +
    +    As a first step towards that goal we move the formatting directive=
 used
    +    by both callers to print a single reference update into this funct=
ion.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay,
    +@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay_state,
     =20
      	width =3D (summary_width + strlen(summary) - gettext_width(summary));
     =20
     -	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
     +	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
    - 	if (!display->compact_format)
    - 		print_remote_to_local(display, display_buffer, remote, prettify_ref=
name(local));
    + 	if (!display_state->compact_format)
    + 		print_remote_to_local(display_state, display_buffer, remote, pretti=
fy_refname(local));
      	else
    - 		print_compact(display, display_buffer, remote, prettify_refname(loc=
al));
    + 		print_compact(display_state, display_buffer, remote, prettify_refna=
me(local));
      	if (error)
      		strbuf_addf(display_buffer, "  (%s)", error);
     +	strbuf_addch(display_buffer, '\n');
      }
     =20
      static int update_local_ref(struct ref *ref,
    -@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display,
    +@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display_state,
      							url_len, url);
      					shown_url =3D 1;
      				}
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state =
*display,
      			}
      		}
      	}
    -@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y,
    - 			format_display(display, &sb, '-', _("[deleted]"), NULL,
    +@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y_state,
    + 			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
      				       _("(none)"), ref->name,
      				       summary_width);
     -			fprintf(stderr, " %s\n",sb.buf);
6:  2ea3a4e308 ! 5:  98b799af71 fetch: deduplicate logic to print remote URL
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    fetch: deduplicate logic to print remote URL
    +    fetch: centralize logic to print remote URL
    =20
         When fetching from a remote, we not only print the actual referenc=
es
         that have changed, but will also print the URL from which we have
    @@ Commit message
         can convert the global variable into a member of `display_state`. =
And
         second, we can deduplicate the logic to compute the anonymized URL.
    =20
    +    This also works as expected when fetching from multiple remotes, f=
or
    +    example via a group of remotes, as we do this by forking a standal=
one
    +    git-fetch(1) process per remote that is to be fetched.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    @@ builtin/fetch.c: static int refcol_width(const struct ref *ref, int =
compact_form
      	return rlen;
      }
     =20
    --static void display_state_init(struct display_state *display, struct =
ref *ref_map)
    -+static void display_state_init(struct display_state *display, struct =
ref *ref_map,
    +-static void display_state_init(struct display_state *display_state, s=
truct ref *ref_map)
    ++static void display_state_init(struct display_state *display_state, s=
truct ref *ref_map,
     +			       const char *raw_url)
      {
      	struct ref *rm;
      	const char *format =3D "full";
     +	int i;
     =20
    - 	memset(display, 0, sizeof(*display));
    + 	memset(display_state, 0, sizeof(*display_state));
     =20
     +	if (raw_url)
    -+		display->url =3D transport_anonymize_url(raw_url);
    ++		display_state->url =3D transport_anonymize_url(raw_url);
     +	else
    -+		display->url =3D xstrdup("foreign");
    ++		display_state->url =3D xstrdup("foreign");
     +
    -+	display->url_len =3D strlen(display->url);
    -+	for (i =3D display->url_len - 1; display->url[i] =3D=3D '/' && 0 <=
=3D i; i--)
    ++	display_state->url_len =3D strlen(display_state->url);
    ++	for (i =3D display_state->url_len - 1; display_state->url[i] =3D=3D =
'/' && 0 <=3D i; i--)
     +		;
    -+	display->url_len =3D i + 1;
    -+	if (4 < i && !strncmp(".git", display->url + i - 3, 4))
    -+		display->url_len =3D i - 3;
    ++	display_state->url_len =3D i + 1;
    ++	if (4 < i && !strncmp(".git", display_state->url + i - 3, 4))
    ++		display_state->url_len =3D i - 3;
     +
      	if (verbosity < 0)
      		return;
     =20
    -@@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display, struct ref *ref_ma
    +@@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display_state, struct ref *
      	}
      }
     =20
    -+static void display_state_release(struct display_state *display)
    ++static void display_state_release(struct display_state *display_state)
     +{
    -+	free(display->url);
    ++	free(display_state->url);
     +}
     +
    - static void print_remote_to_local(struct display_state *display,
    + static void print_remote_to_local(struct display_state *display_state,
      				  struct strbuf *display_buffer,
      				  const char *remote, const char *local)
    -@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay,
    +@@ builtin/fetch.c: static void format_display(struct display_state *d=
isplay_state,
      	if (verbosity < 0)
      		return;
     =20
    -+	if (!display->shown_url) {
    -+		strbuf_addf(display_buffer, _("From %.*s\n"), display->url_len, dis=
play->url);
    -+		display->shown_url =3D 1;
    ++	if (!display_state->shown_url) {
    ++		strbuf_addf(display_buffer, _("From %.*s\n"),
    ++			    display_state->url_len, display_state->url);
    ++		display_state->shown_url =3D 1;
     +	}
     +
      	width =3D (summary_width + strlen(summary) - gettext_width(summary));
    @@ builtin/fetch.c: static void format_display(struct display_state *di=
splay,
     @@ builtin/fetch.c: N_("it took %.2f seconds to check forced updates; =
you can use\n"
         "to avoid this check\n");
     =20
    - static int store_updated_refs(struct display_state *display,
    + static int store_updated_refs(struct display_state *display_state,
     -			      const char *raw_url, const char *remote_name,
     +			      const char *remote_name,
      			      int connectivity_checked,
    @@ builtin/fetch.c: N_("it took %.2f seconds to check forced updates; y=
ou can use\n
      		rm =3D ref_map;
      		if (check_connected(iterate_ref_map, &rm, &opt)) {
     -			rc =3D error(_("%s did not send all necessary objects\n"), url);
    -+			rc =3D error(_("%s did not send all necessary objects\n"), display=
->url);
    ++			rc =3D error(_("%s did not send all necessary objects\n"),
    ++				   display_state->url);
      			goto abort;
      		}
      	}
    -@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display,
    +@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display_state,
      				what =3D rm->name;
      			}
     =20
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state =
*display,
      			strbuf_reset(&note);
      			if (*what) {
      				if (*kind)
    -@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display,
    +@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display_state,
     =20
      			append_fetch_head(fetch_head, &rm->old_oid,
      					  rm->fetch_head_status,
     -					  note.buf, url, url_len);
    -+					  note.buf, display->url, display->url_len);
    ++					  note.buf, display_state->url,
    ++					  display_state->url_len);
     =20
      			strbuf_reset(&note);
      			if (ref) {
    -@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display,
    +@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display_state,
      					       *what ? what : "HEAD",
      					       "FETCH_HEAD", summary_width);
      			}
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state =
*display,
      		}
      	}
     =20
    -@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display,
    +@@ builtin/fetch.c: static int store_updated_refs(struct display_state=
 *display_state,
     =20
       abort:
      	strbuf_release(&note);
    @@ builtin/fetch.c: static int store_updated_refs(struct display_state =
*display,
      	return rc;
      }
     =20
    -@@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_s=
tate *display,
    +@@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_s=
tate *display_state,
      	}
     =20
      	trace2_region_enter("fetch", "consume_refs", the_repository);
    --	ret =3D store_updated_refs(display, transport->url, transport->remot=
e->name,
    -+	ret =3D store_updated_refs(display, transport->remote->name,
    +-	ret =3D store_updated_refs(display_state, transport->url, transport-=
>remote->name,
    ++	ret =3D store_updated_refs(display_state, transport->remote->name,
      				 connectivity_checked, transaction, ref_map,
      				 fetch_head);
      	trace2_region_leave("fetch", "consume_refs", the_repository);
    -@@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_s=
tate *display,
    - static int prune_refs(struct display_state *display,
    +@@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_s=
tate *display_state,
    + static int prune_refs(struct display_state *display_state,
      		      struct refspec *rs,
      		      struct ref_transaction *transaction,
     -		      struct ref *ref_map,
    @@ builtin/fetch.c: static int fetch_and_consume_refs(struct display_st=
ate *display
      	if (!dry_run) {
      		if (transaction) {
      			for (ref =3D stale_refs; ref; ref =3D ref->next) {
    -@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y,
    +@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y_state,
     =20
      		for (ref =3D stale_refs; ref; ref =3D ref->next) {
      			struct strbuf sb =3D STRBUF_INIT;
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display,
     -				fprintf(stderr, _("From %.*s\n"), url_len, url);
     -				shown_url =3D 1;
     -			}
    - 			format_display(display, &sb, '-', _("[deleted]"), NULL,
    + 			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
      				       _("(none)"), ref->name,
      				       summary_width);
    -@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y,
    +@@ builtin/fetch.c: static int prune_refs(struct display_state *displa=
y_state,
     =20
      cleanup:
      	strbuf_release(&err);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      {
      	struct ref_transaction *transaction =3D NULL;
      	struct ref *ref_map =3D NULL;
    --	struct display_state display;
    -+	struct display_state display =3D { 0 };
    +-	struct display_state display_state;
    ++	struct display_state display_state =3D { 0 };
      	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
      	int retcode =3D 0;
      	const struct ref *remote_refs;
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      	if (retcode)
      		goto cleanup;
     =20
    --	display_state_init(&display, ref_map);
    -+	display_state_init(&display, ref_map, transport->url);
    +-	display_state_init(&display_state, ref_map);
    ++	display_state_init(&display_state, ref_map, transport->url);
     =20
      	if (atomic_fetch) {
      		transaction =3D ref_transaction_begin(&err);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		 * don't care whether --tags was specified.
      		 */
      		if (rs->nr) {
    --			retcode =3D prune_refs(&display, rs, transaction, ref_map, transpo=
rt->url);
    -+			retcode =3D prune_refs(&display, rs, transaction, ref_map);
    +-			retcode =3D prune_refs(&display_state, rs, transaction, ref_map, t=
ransport->url);
    ++			retcode =3D prune_refs(&display_state, rs, transaction, ref_map);
      		} else {
    - 			retcode =3D prune_refs(&display, &transport->remote->fetch,
    + 			retcode =3D prune_refs(&display_state, &transport->remote->fetch,
     -					     transaction, ref_map,
     -					     transport->url);
     +					     transaction, ref_map);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		error("%s", err.buf);
      	}
     =20
    -+	display_state_release(&display);
    ++	display_state_release(&display_state);
      	close_fetch_head(&fetch_head);
      	strbuf_release(&err);
      	free_refs(ref_map);
7:  f67f9640a8 < -:  ---------- fetch: fix inconsistent summary width for p=
runed and updated refs
8:  9667301711 < -:  ---------- fetch: centralize printing of reference upd=
ates
-:  ---------- > 6:  fe7e2e85eb fetch: centralize printing of reference upd=
ates
--=20
2.40.0


--XsmeTTGIjeBFVU2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUwMACgkQVbJhu7ck
PpRloBAAq4mzvaJwa52kt4IlK/eaSCzbc6xxyEEIXnbDDnHZrU9qjMSUwoyMWdQ6
URC2PDEQd/FDOjaXG/HoasW/CYM/R4feZXdRyC7gdVW418PB/jPJbLElv/CgsuA/
4biYGLSCMwnuA4D7NlUtD0M8Qam5j49ep8fDxuR151dw0kac8HDxaBZGfK+ztQr/
HuB1nEGzH2P1/2Uk3Ao9gQ2lnaYgQsClwWdKaIVlNzZQum1cASSwPEgEuWeDlKa4
Th7kjZGasO9btDNA/itFeb3wXbxcYuBS5UiV3RJR4vFGCN+yvCnZly48wgC2FMw+
FekWAZsCsg7XTdJkDK/mxddOU4ldokoFO+q3ezCRq6TVKaaCEE0+4YIXk1wZJHUF
P0aMMyTEfV36PZ9fka6SdkNxX8KAg3wkFur2Pt1IdnzYLTk0MQQQx+DE04lOiliA
s0atdHhqn9eTH2Tam3jCjgCk+WxqJ+fJi53R/TU0cyIJ7UFTuUfY2HYdMs9bvVSr
50lX3uDWSeLiWh5HdwxmTURUVBOPuaQ+3IL3qMyQ3C1NXN9yo6UUFGXxdmUY4fzd
g744xCXLPrpmanGKmANncvHnt24xGjZD3d5v2oPB0uB2H/JmfY2WtrAMpU84s4ME
2HVjkRurZwA2vSEnWZo6Fltj84k7FCzLuZAFLlbkS+3P1cQdQpU=
=K0Qn
-----END PGP SIGNATURE-----

--XsmeTTGIjeBFVU2b--
