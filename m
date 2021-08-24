Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC8C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E22B6127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhHXKhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:37:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60633 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236136AbhHXKhm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:37:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 82A215C013C;
        Tue, 24 Aug 2021 06:36:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Aug 2021 06:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PTHnL50Nj5mhpOy7vO9NJt0G2BX
        +B3ats08MaQZaN6U=; b=RiT3F4D0QjMeuzbkjMTRbHE/63EP+J0Gv8NwObs6OYN
        IbXddHmRQuoK3mb5DmovLEVCscVuUj4G8kVPlMjQyvTyPqsxTpgDJ5wzRCjbYb5Q
        GairI6HiFVmKQkdjZjsTxWJGMAz+D9hZ8g4Jm+NLRzS0p+fqxlSjV/jB3f4E+tR/
        tAf9jsEGbviQqr5pEcbirDjbLrdjMwTZ/QVIpRLJJutCce/V/QZY2vEtBb/I9rZ+
        ukIEL5bEKkb9XbYN4IBtb+vm9l2HEHQjtp3r16LBUFSRkUDo+UDAEuBYJ6AtV6v+
        Hb4qhwiPrpdRxm13juSW5vQ+eVcnU1OaWC/l3FCL1tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PTHnL5
        0Nj5mhpOy7vO9NJt0G2BX+B3ats08MaQZaN6U=; b=b/aoiV4rPIwnKc6itbGPhb
        8TtIwl5M2eMShjb3xtS0o/l2YxFG5nHy4WC5dDA3uUlWrK5pIOBZg+2+hzJc5SwJ
        t0XGMIyFPyYs+AKMP7svjR0xipnh3C4RY8B1H2M63GOmC6DZDE/B9puiFSo/E4jZ
        7rPtkQumBGv3gyFRSR1+NAOMuAO6BZDGS3gz6hb05xpoQ7RKrjndxGQ1WkO4vl3K
        RPITkHfMjqmy5a8/dsg6j3E1U0980iNn3LRAGGI4imEqy3FyCJ662H/7Vw2HrnGy
        EvMT1zHi9sQRkc1mwC1vRQBmhS3aEtlmNPBxeR7QoAxYOeX1PNMRCBj4ogg41vpg
        ==
X-ME-Sender: <xms:ycskYR9rqNItt4Gw1kAJoYcwLAtIOZxmMrknFjzYX-nrHY5aYcAUBg>
    <xme:ycskYVuSfewDcZ2F8asFvDGjRTmLW38Aw6bpOkZ8e3QtScoP6R3tiiKwaXz3AiXRZ
    0VVc9w8om1J5fjs-w>
X-ME-Received: <xmr:ycskYfBqOVCfkJbTTIosrFJEBZHvbAGUkSPZkVjuI7DhLlIbgZeBHJkLP9UAuqwdPe8bb3ZPLy2xg6nrmnZ5pJOkAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ycskYVeUqbgz4RFNeF8aJOT3TwCltYEge-uTa_0Is5sT8dKKA1styA>
    <xmx:ycskYWMX8mmNzpPriw2mxSY1keU6b60sNidqMUNwYm5Klct3MYHKbg>
    <xmx:ycskYXmDQYeDR8YpzUh1hPiOF7EZVSWh7m2sSDfPujqHxPg1OOeM9w>
    <xmx:ysskYTrnYr6MVx9d3ot8gDQmqJgZa_uVnKXhMATFaZi_hUc_LTKSpg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:36:56 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 12c9d77b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:36:52 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:36:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 0/7] Speed up mirror-fetches with many refs
Message-ID: <cover.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJu+1W5zLeVzOrp3"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xJu+1W5zLeVzOrp3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series to speed up mirror-fetches
with many refs. This topic applies on top of Junio's 9d5700f60b (Merge
branch 'ps/connectivity-optim' into jch, 2021-08-23).

Changes compared to v1:

    - Patch 1/7: I've applied Stolee's proposal to only
      opportunistically load objects via the commit-graph in case the
      reference is not in refs/tags/ such that we don't regress repos
      with many annotated tags.

    - Patch 3/7: The return parameter of the iterator is now const to
      allow further optimizations by the compiler, as suggested by
      Ren=C3=A9. I've also re-benchmarked this, and one can now see a very
      slight performance improvement of ~1%.

    - Patch 4/7: Added my missing DCO, as pointed out by Junio.

    - Patch 5, 6, 7: I've redone these to make it clearer that the
      refactoring I'm doing doesn't cause us to miss any object
      connectivity checks. Most importantly, I've merged `fetch_refs()`
      and `consume_refs()` into `fetch_and_consume_refs()` in 6/7, which
      makes the optimization where we elide the second connectivity
      check in 7/7 trivial.

Thanks for your feedback!

Patrick

Patrick Steinhardt (7):
  fetch: speed up lookup of want refs via commit-graph
  fetch: avoid unpacking headers in object existence check
  connected: refactor iterator to return next object ID directly
  fetch-pack: optimize loading of refs via commit graph
  fetch: refactor fetch refs to be more extendable
  fetch: merge fetching and consuming refs
  fetch: avoid second connectivity check if we already have all objects

 builtin/clone.c        |  8 ++---
 builtin/fetch.c        | 74 +++++++++++++++++++++++-------------------
 builtin/receive-pack.c | 17 ++++------
 connected.c            | 15 +++++----
 connected.h            |  2 +-
 fetch-pack.c           | 14 +++++---
 6 files changed, 68 insertions(+), 62 deletions(-)

Range-diff against v1:
1:  6872979c45 ! 1:  4a819a6830 fetch: speed up lookup of want refs via com=
mit-graph
    @@ Commit message
         referenced objects.
    =20
         Speed this up by opportunistcally trying to resolve object IDs via=
 the
    -    commit graph: more likely than not, they're going to be a commit a=
nyway,
    -    and this lets us avoid having to unpack object headers completely =
in
    -    case the object is a commit that is part of the commit-graph. This
    -    significantly speeds up mirror-fetches in a real-world repository =
with
    +    commit graph. We only do so for any refs which are not in "refs/ta=
gs":
    +    more likely than not, these are going to be a commit anyway, and t=
his
    +    lets us avoid having to unpack object headers completely in case t=
he
    +    object is a commit that is part of the commit-graph. This signific=
antly
    +    speeds up mirror-fetches in a real-world repository with
         2.3M refs:
    =20
             Benchmark #1: HEAD~: git-fetch
    -          Time (mean =C2=B1 =CF=83):     56.942 s =C2=B1  0.449 s    [=
User: 53.360 s, System: 5.356 s]
    -          Range (min =E2=80=A6 max):   56.372 s =E2=80=A6 57.533 s    =
5 runs
    +          Time (mean =C2=B1 =CF=83):     56.482 s =C2=B1  0.384 s    [=
User: 53.340 s, System: 5.365 s]
    +          Range (min =E2=80=A6 max):   56.050 s =E2=80=A6 57.045 s    =
5 runs
    =20
             Benchmark #2: HEAD: git-fetch
    -          Time (mean =C2=B1 =CF=83):     33.657 s =C2=B1  0.167 s    [=
User: 30.302 s, System: 5.181 s]
    -          Range (min =E2=80=A6 max):   33.454 s =E2=80=A6 33.844 s    =
5 runs
    +          Time (mean =C2=B1 =CF=83):     33.727 s =C2=B1  0.170 s    [=
User: 30.252 s, System: 5.194 s]
    +          Range (min =E2=80=A6 max):   33.452 s =E2=80=A6 33.871 s    =
5 runs
    =20
             Summary
               'HEAD: git-fetch' ran
    -            1.69 =C2=B1 0.02 times faster than 'HEAD~: git-fetch'
    +            1.67 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    +@@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    + 			      int connectivity_checked, struct ref *ref_map)
    + {
    + 	struct fetch_head fetch_head;
    +-	struct commit *commit;
    + 	int url_len, i, rc =3D 0;
    + 	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
    + 	struct ref_transaction *transaction =3D NULL;
    +@@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
    + 	     want_status <=3D FETCH_HEAD_IGNORE;
    + 	     want_status++) {
    + 		for (rm =3D ref_map; rm; rm =3D rm->next) {
    ++			struct commit *commit =3D NULL;
    + 			struct ref *ref =3D NULL;
    +=20
    + 			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW) {
     @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
      				continue;
      			}
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, =
const char *
     -								1);
     -			if (!commit)
     -				rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
    -+			commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
    ++			/*
    ++			 * References in "refs/tags/" are often going to point
    ++			 * to annotated tags, which are not part of the
    ++			 * commit-graph. We thus only try to look up refs in
    ++			 * the graph which are not in that namespace to not
    ++			 * regress performance in repositories with many
    ++			 * annotated tags.
    ++			 */
    ++			if (!starts_with(rm->name, "refs/tags/"))
    ++				commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
     +			if (!commit) {
     +				commit =3D lookup_commit_reference_gently(the_repository,
     +									&rm->old_oid,
2:  d3dac607f2 =3D 2:  81ebadabe8 fetch: avoid unpacking headers in object =
existence check
3:  3bdad7bc8b ! 3:  98e981ced9 connected: refactor iterator to return next=
 object ID directly
    @@ Commit message
         The object ID iterator used by the connectivity checks returns the=
 next
         object ID via an out-parameter and then uses a return code to indi=
cate
         whether an item was found. This is a bit roundabout: instead of a
    -    separate error code, we can just retrun the next object ID directl=
y and
    +    separate error code, we can just return the next object ID directl=
y and
         use `NULL` pointers as indicator that the iterator got no items le=
ft.
         Furthermore, this avoids a copy of the object ID.
    =20
         Refactor the iterator and all its implementations to return object=
 IDs
    -    directly. While I was honestly hoping for a small speedup given th=
at we
    -    can now avoid a copy, both versions perform the same. Still, the e=
nd
    -    result is easier to understand and thus it makes sense to keep this
    -    refactoring regardless.
    +    directly. This brings a tiny performance improvement when doing a =
mirror-fetch of a repository with about 2.3M refs:
    +
    +        Benchmark #1: 328dc58b49919c43897240f2eabfa30be2ce32a4~: git-f=
etch
    +          Time (mean =C2=B1 =CF=83):     30.110 s =C2=B1  0.148 s    [=
User: 27.161 s, System: 5.075 s]
    +          Range (min =E2=80=A6 max):   29.934 s =E2=80=A6 30.406 s    =
10 runs
    +
    +        Benchmark #2: 328dc58b49919c43897240f2eabfa30be2ce32a4: git-fe=
tch
    +          Time (mean =C2=B1 =CF=83):     29.899 s =C2=B1  0.109 s    [=
User: 26.916 s, System: 5.104 s]
    +          Range (min =E2=80=A6 max):   29.696 s =E2=80=A6 29.996 s    =
10 runs
    +
    +        Summary
    +          '328dc58b49919c43897240f2eabfa30be2ce32a4: git-fetch' ran
    +            1.01 =C2=B1 0.01 times faster than '328dc58b49919c43897240=
f2eabfa30be2ce32a4~: git-fetch'
    +
    +    While this 1% speedup could be labelled as statistically insignifi=
cant,
    +    the speedup is consistent on my machine. Furthermore, this is an e=
nd to
    +    end test, so it is expected that the improvement in the connectivi=
ty
    +    check itself is more significant.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ builtin/clone.c: static void write_followtags(const struct ref *refs=
, const char
      }
     =20
     -static int iterate_ref_map(void *cb_data, struct object_id *oid)
    -+static struct object_id *iterate_ref_map(void *cb_data)
    ++static const struct object_id *iterate_ref_map(void *cb_data)
      {
      	struct ref **rm =3D cb_data;
      	struct ref *ref =3D *rm;
    @@ builtin/fetch.c: static int update_local_ref(struct ref *ref,
      }
     =20
     -static int iterate_ref_map(void *cb_data, struct object_id *oid)
    -+static struct object_id *iterate_ref_map(void *cb_data)
    ++static const struct object_id *iterate_ref_map(void *cb_data)
      {
      	struct ref **rm =3D cb_data;
      	struct ref *ref =3D *rm;
    @@ builtin/receive-pack.c: static void refuse_unconfigured_deny_delete_=
current(void
      }
     =20
     -static int command_singleton_iterator(void *cb_data, struct object_id=
 *oid);
    -+static struct object_id *command_singleton_iterator(void *cb_data);
    ++static const struct object_id *command_singleton_iterator(void *cb_da=
ta);
      static int update_shallow_ref(struct command *cmd, struct shallow_inf=
o *si)
      {
      	struct shallow_lock shallow_lock =3D SHALLOW_LOCK_INIT;
    @@ builtin/receive-pack.c: static void check_aliased_updates(struct com=
mand *comman
      }
     =20
     -static int command_singleton_iterator(void *cb_data, struct object_id=
 *oid)
    -+static struct object_id *command_singleton_iterator(void *cb_data)
    ++static const struct object_id *command_singleton_iterator(void *cb_da=
ta)
      {
      	struct command **cmd_list =3D cb_data;
      	struct command *cmd =3D *cmd_list;
    @@ builtin/receive-pack.c: struct iterate_data {
      };
     =20
     -static int iterate_receive_command_list(void *cb_data, struct object_=
id *oid)
    -+static struct object_id *iterate_receive_command_list(void *cb_data)
    ++static const struct object_id *iterate_receive_command_list(void *cb_=
data)
      {
      	struct iterate_data *data =3D cb_data;
      	struct command **cmd_list =3D &data->cmds;
    @@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
      	FILE *rev_list_in;
      	struct check_connected_options defaults =3D CHECK_CONNECTED_INIT;
     -	struct object_id oid;
    -+	struct object_id *oid;
    ++	const struct object_id *oid;
      	int err =3D 0;
      	struct packed_git *new_pack =3D NULL;
      	struct transport *transport;
    @@ connected.h: struct transport;
       * to signal EOF, otherwise return 0.
       */
     -typedef int (*oid_iterate_fn)(void *, struct object_id *oid);
    -+typedef struct object_id *(*oid_iterate_fn)(void *);
    ++typedef const struct object_id *(*oid_iterate_fn)(void *);
     =20
      /*
       * Named-arguments struct for check_connected. All arguments are
    @@ fetch-pack.c: static void update_shallow(struct fetch_pack_args *arg=
s,
      }
     =20
     -static int iterate_ref_map(void *cb_data, struct object_id *oid)
    -+static struct object_id *iterate_ref_map(void *cb_data)
    ++static const struct object_id *iterate_ref_map(void *cb_data)
      {
      	struct ref **rm =3D cb_data;
      	struct ref *ref =3D *rm;
4:  67917af7ce ! 4:  6311203f08 fetch-pack: optimize loading of refs via co=
mmit graph
    @@ Commit message
         In case this fails, we fall back to the old code which peels the
         objects to a commit.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## fetch-pack.c ##
     @@ fetch-pack.c: static struct commit *deref_without_lazy_fetch(const =
struct object_id *oid,
      {
5:  7653f8eabc ! 5:  56a9158ac3 fetch: refactor fetch refs to be more exten=
dable
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *re=
f_map)
      static int fetch_refs(struct transport *transport, struct ref *ref_ma=
p)
      {
     -	int ret =3D check_exist_and_connected(ref_map);
    --	if (ret) {
    --		trace2_region_enter("fetch", "fetch_refs", the_repository);
    --		ret =3D transport_fetch_refs(transport, ref_map);
    --		trace2_region_leave("fetch", "fetch_refs", the_repository);
    --	}
     +	int ret;
     +
     +	/*
    @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *re=
f_map)
     +	 * refs.
     +	 */
     +	ret =3D check_exist_and_connected(ref_map);
    - 	if (!ret)
    + 	if (ret) {
    + 		trace2_region_enter("fetch", "fetch_refs", the_repository);
    + 		ret =3D transport_fetch_refs(transport, ref_map);
    + 		trace2_region_leave("fetch", "fetch_refs", the_repository);
    ++		if (ret) {
    ++			transport_unlock_pack(transport);
    ++			return ret;
    ++		}
    + 	}
    +-	if (!ret)
     -		/*
     -		 * Keep the new pack's ".keep" file around to allow the caller
     -		 * time to update refs to reference the new objects.
     -		 */
    - 		return 0;
    +-		return 0;
     -	transport_unlock_pack(transport);
     -	return ret;
     +
    -+	trace2_region_enter("fetch", "fetch_refs", the_repository);
    -+	ret =3D transport_fetch_refs(transport, ref_map);
    -+	trace2_region_leave("fetch", "fetch_refs", the_repository);
    -+	if (ret) {
    -+		transport_unlock_pack(transport);
    -+		return ret;
    -+	}
    -+
     +	/*
     +	 * Keep the new pack's ".keep" file around to allow the caller
     +	 * time to update refs to reference the new objects.
6:  646ac90e62 < -:  ---------- fetch: avoid second connectivity check if w=
e already have all objects
-:  ---------- > 6:  31d9f72edf fetch: merge fetching and consuming refs
-:  ---------- > 7:  84e39c847f fetch: avoid second connectivity check if w=
e already have all objects
--=20
2.33.0


--xJu+1W5zLeVzOrp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky8IACgkQVbJhu7ck
PpSvThAAgooA4grOUprrSX0FW1Tcl6z+1chXgxbCGX29WzG1lHiAKJ0eyS110bCi
TxuQjZmVZyXCyoKSlZMqw174SWQFkOGhlCBv6bT2QZXnWMKgG59qxlvQcG1ktp4Z
mN5MfBxxGpnIted0uC5OOvyyun9mwHLtKCkmVZl6TFpbwxIDZAnjoqOgymREn6oK
Bp9Avu0cZBGNiX+Hcut61Hj8C0gAElTTtZuiJjQt2Yad9PT1hhNk3i4o+5/bgCSu
FI56Kz9tS+OH4YoYkf8MnfLWOTaKsr6aNSWT7YAlQh7mAVbz4PYPVe8L0lTh1mrs
dxmB4zoJhf9F0p3bEbUKT4Qs+fTRRnPVpRBoLxAEj4RtfCYCKxnmiG7givDBMRmZ
NN6vH0M9kmSMuwt+lJX9LMEEK13NthFzcBwRKNMCkXfg3RrE/pePfuaEbhu48wz9
41OgnjqqdlvtGQnZBVyScvBvNSoYfDrYzzdXPOiB9JiPAuPoWHm6+zHI7Zb58h4t
Ls62kp1//BDRp9I97zf5BkEQ11soZVQvDrJYE6xkhEeNHxutwxjs47Le5jo9xIkh
N1CZ1+ZSMncXGAu9Hiab+pFJhYt5rAiaq5PeUZn2VupkRn5iqjzt+D0n/FV9vYSx
yiwtwtanrXUPvrsSKdCx7M4OcOgJf28Qz0kUDhwmOrGvs6amKJA=
=iTAN
-----END PGP SIGNATURE-----

--xJu+1W5zLeVzOrp3--
