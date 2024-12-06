Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7946426
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484248; cv=none; b=HTmJf+IawTmY+KmdpBcMkc7G721qg+5j6Mkt2h5djCBlz1ErfglOGkgX8JUFiKEbD/tffpkClRdfvT/h61RGlSGZZCNDvCvKtB8R/lmSxJoqzf5oSJXLryLiWs+364lbvR4LqeLOijumwQIGH4yq8lICTo5oLcQx0o2hkVP3Zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484248; c=relaxed/simple;
	bh=NHxGaUl4jX/0FVrSomwMH9w1uDVWpqt0iuAPpMc4iug=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=uAoCLyf6QYXumPAbr85zZ/BWCka1NeUd9DuVHkjVROfaWJSFK4kSECnVfhoL+oxabKSKXcInMWExEhZYsB4FzI28b0dofnHjV+1Zh0bW0vhNyNAP+M85qyEsYgkY+8D+XHaiiJhM3kbhfg4lGtXApKgUO6KDAmHgK0/ktGKcT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=NJcY0hJC; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="NJcY0hJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=vOfh5fvBNTo8zn/k433yH5o16Lu4PXbuPcXotXnOhkc=;
 b=NJcY0hJCEzo7rwgSLTaLYy9ntegpPiFpQCrVPL2vHMUhYRqYv3c1+WBofA1OyKIpHBVEGmdZFnEG
   DECu6T2id5pBYSI/QIwfmN7n40kI0QNBwoSezho7ipuVAYxmAyNDV9/vvtBtfItXSK/qi1ILpRKU
   nVBYpFYqVde4esHO6cc9/IGZM1QZSlhj4/eOgN6TKpzHaETWqkfrVbWqFbN2tk3RJ5eJ4kTfsUWQ
   kFPpNJ+VROEn0ZSTuCPcSrMijcyIiP/JeHs5RobJMLgrpz/O4vQbkvAvH59sdjQHYUDV4cmqDS3M
   eQU6TSMSfvNX0h+gjGJpMAnoV4gZHkSa30MuHw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO200B4QKZZVXE0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 06 Dec 2024 11:23:59 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 06 Dec 2024 12:23:36 +0100
Message-id: <D64KVBBE5WVH.19V9S7ZY89IZS@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: Re* [PATCH] Fix `git fetch --tags` in repo with no configured
 remote
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>, <l.s.r@web.de>,
 <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>, <me@ttaylorr.com>,
 <ps@pks.im>, <jonathantanmy@google.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Josh Steadmon" <steadmon@google.com>
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
 <b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
 <xmqqcyi5zdzb.fsf@gitster.g> <xmqqcyi5xmhr.fsf@gitster.g>
In-reply-to: <xmqqcyi5xmhr.fsf@gitster.g>
Reporting-Meta:
 AAFpnKTqviHAYguBHvnSJ1YdHBL6X+JyKq38ekviXAwpp3XZRwrZ81Ng9/1RsHBO
 J5CK8Y54Liprxexsm2oOh8Ex50r+UdMtspQ5mO+sLWTSqNMkyxicmYZY1+dHNVYO
 kGi6MpH2PLoGZCZkTgLAdQNajsmIBXETSqR+repHxXFemhdLcdDgCCPiExtGxyjp
 FckNAqLHvMIxzdTKKsCvmZseteqWZGsOyz5ayfHxnb35RWAi2uWToqxsREa4v+KY
 21fFDQvfyI1gW8xLATLl4aZphAi+uO6yGqPFufMW3M9HjI+HzkUnBNefurNTdyaX
 mSN5WmXL7O+trGRrCmEpN5Qeps1l7ll6vy3hefjid9xHt4c8OPGs7tA4F2gPNfUd
 6ZXDHNDWCop09ozqqES/WXjQLgMVldUP9majM5sxZjEWDpB9Tyqpqjg8n7V81qX7
 k6LC0QrGNDeFcx8/wwHKLXBWUG6B/0r8SAcuO5HHQBNWrxioTY72FYZC


On Fri Dec 06, 2024 at 09:08, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stepping back a bit, do we even need to learn where HEAD points at
>> in the remote, when we are not doing the "opportunistically set
>> $REMOTE/HEAD"?  Your example is "in repo with no configured remote",
>> which by definition means that we do not use any refs/remotes/*/ ref
>> hierarchy to keep track of the remote-tracking branches for the
>> remote we are fetching from.  There is no place we record what we
>> learn by running ls-remote HEAD against them, so should we even push
>> "HEAD" to the ls-remote prefixes in such a case?

Yes, it probably doesn't make any sense to do that.

>>
>> While this change may hide the breakage you saw in your set-up, we
>> may be now asking to ls-remote HEAD even in cases we do not need to.
>>
>>> Fix this by adding HEAD to the ref_prefixes list prior to handling the
>>> `--tags` flag, and removing the now obsolete check whether ref_prefixes
>>> is empty or not.
>>
>> And if we unconditionally add HEAD even when we do not need to,
>> especially with the loss of the ref-prefixes condition that was
>> there in order to implement "learn refs/tags/* hierarchy only when
>> we are doing the default fetch", wouldn't it mean we may learn
>> refs/tags/* even when we do not have to?
>
> In other words, what I think the "fix" should look like is more like
> the attached.  It seems to pass your test, as well as existing tests
> Bence added and other tests about "git fetch".
>
> One thing I am not happy about is the abstraction violation that is
> needed to make the uses_remote_tracking() helper aware of the "use
> the rs, the refspec given from the command line, or if it is empty,
> use the configured 'fetch' refspec from the remote" rule, which is
> primarily used by get_ref_map() that is much later called, but the
> layering violation started when we started limiting the ls-remote
> request with narrowing common prefixes, and it would take a larger
> surgery to fix, I would think.
>
> ---- >8 ----
> Subject: [PATCH] fetch: do not ask for HEAD unnecessarily
>
> In 3f763ddf28 (fetch: set remote/HEAD if it does not exist,
> 2024-11-22), git-fetch learned to opportunistically set $REMOTE/HEAD
> when fetching by always asking for remote HEAD, in the hope that it
> will help setting refs/remotes/<name>/HEAD if missing.
>
> But it is not needed to always ask for remote HEAD.  When we are
> fetching from a remote, for which we have remote-tracking branches,
> we do need to know about HEAD.  But if we are doing one-shot fetch,
> e.g.,
>
>   $ git fetch --tags https://github.com/git/git
>
> we do not even know what sub-hierarchy of refs/remotes/<remote>/
> we need to adjust the remote HEAD for.  There is no need to ask for
> HEAD in such a case.
>
> Incidentally, because the unconditional request to list "HEAD"
> affected the number of ref-prefixes requested in the ls-remote
> request, this affected how the requests for tags are added to the
> same ls-remote request, breaking "git fetch --tags $URL" performed
> against a URL that is not configured as a remote.
>
> Reported-by: Josh Steadmon <steadmon@google.com>
> [jc: tests are also borrowed from Josh's patch]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Even though I borrowed some part of the commit log message from
>    Josh's version, it not clear to me how "*after* deciding" led to
>    whatever the observed breakage (which was not described in the
>    log message), in the following part.
>
>       Specifically, we now unconditionally add HEAD to the
>       ref_prefixes list, but we did this *after* deciding whether we
>       also need to explicitly request tags.
>
>    Bence's change asks "HEAD" after "if we are fetching something,
>    then also ask about refs/tags/" logic thought we are not fetching
>    anything (i.e. ref_prefixes.nr =3D=3D 0 at that point).  But before
>    Bence's series, the same refs/tags/ logic saw that (ref_prefix.nr
>    =3D=3D 0), didn't it?  So that does not sound like a sufficient
>    explanation on how the series regressed.

I did a bit of poking around on what is happening. For one I can confirm, t=
hat
both before and after the set_head series
`transport_ls_refs_options.ref_prefixes.nr` is 0. So the difference must be
happening somewhere after that, and is not a side effect of calling set_hea=
d
either, but I didn't manage to pin it down further.

I also checked what happens in set_head, just to be on the safe side: `head=
s`
is empty so we reach the if where we check `heads.nr` which is 0. So at lea=
st
no strange refs are created :)



> ---
>  builtin/fetch.c  | 20 +++++++++++++++++++-
>  t/t5510-fetch.sh | 17 +++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a64de4485f..3eb6f3acc9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1643,6 +1643,21 @@ static int set_head(const struct ref *remote_refs)
>  	return result;
>  }
> =20
> +static int uses_remote_tracking(struct transport *transport, struct refs=
pec *rs)
> +{
> +	if (!remote_is_configured(transport->remote, 0))
> +		return 0;
> +
> +	if (!rs->nr)
> +		rs =3D &transport->remote->fetch;
> +
> +	for (int i =3D 0; i < rs->nr; i++)
> +		if (rs->items[i].dst)
> +			return 1;
> +
> +	return 0;
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs,
>  		    const struct fetch_config *config)
> @@ -1712,7 +1727,10 @@ static int do_fetch(struct transport *transport,
>  				    "refs/tags/");
>  	}
> =20
> -	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +	if (uses_remote_tracking(transport, rs)) {
> +		must_list_refs =3D 1;
> +		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +	}
> =20
>  	if (must_list_refs) {
>  		trace2_region_enter("fetch", "remote_refs", the_repository);
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 87698341f5..d7602333ff 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -189,6 +189,23 @@ test_expect_success 'fetch --prune --tags with refsp=
ec prunes based on refspec'
>  	git rev-parse sometag
>  '
> =20
> +test_expect_success 'fetch --tags gets tags even without a configured re=
mote' '
> +	REMOTE=3D"$(pwd)/test_tag_1" &&
> +	git init test_tag_1 &&
> +	(
> +		cd test_tag_1 &&
> +		test_commit foo
> +	) &&
> +	git init test_tag_2 &&
> +	(
> +		cd test_tag_2 &&
> +		git fetch --tags "file://$REMOTE" &&
> +		echo "foo" >expect &&
> +		git tag >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success REFFILES 'fetch --prune fails to delete branches' '
>  	cd "$D" &&
>  	git clone . prune-fail &&


