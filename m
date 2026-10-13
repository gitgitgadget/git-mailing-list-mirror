Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB23C2BB9
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899817; cv=none; b=e5QkhhRYUgQIUmTMgc9CT2tIBWAKPsSI7leo2NZVmaL85wQSBBOULlNTn7rIRqt6tUIWWSC0mWQT1GJ6CfhpWGNtUS8a/jKxVNcEOuEkNGep30CY7E6J34UVm5nCmewlzAe87CaWfBw+Ivslt/Yx4fu7z5X524vq3SkZjF0ys/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899817; c=relaxed/simple;
	bh=mnBrm0FnBkM5RwK0Dn2UeVrRU5Mml+tcHmkJboNV3gQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JmP/RY36gIQKHu9/u94yqkEYwtnE3/h5l8E6XgXXa1PeLYaUrJ0nIZ7hpo1nEmtzAqL4wkQHuGl9TkRTzZeHgT+QUdKWTryqZ1TXE9EHqiqBAL+eBbDY91KPvRlXkTB2E+keuk9T5gNtVEOD6meU0VP7FiSBa74p29CMqK+CVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AJHPXcrN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQtBVhsH; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AJHPXcrN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQtBVhsH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 76AA813000C5
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:56:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 09:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791899814;
	 x=1791903414; bh=SfKfBV+VEmVIf9KdAS4V6WUPvJtf1uh7aYgx5XZ5U4M=; b=
	AJHPXcrNzhLtM8cWG2ZZl9LWq9oTnPzz1gsYXlIIXNoT+E9OHeTKGDYA09gqeUuy
	AiWPJ+kCR1TZp63lS/uOVq3XIMpIQxAy4DDoFoGUbR8SrOg+zBI/ctGIcH0yKLHF
	Ihwrk7jS5actv9y3FbmCGXfe4kPEAF6HhudtzfKefOVHZpbUYo5uKMKnkN7okQQH
	y2kNZnqwM+FYSWjZvlISjKPE5+85+Ya318Va/HrUAybahvIkxkA9byc0Y/ipA3Wu
	PyMTLw0LEdeeWQ0clNJOVL2JFGdOvJp3+lJtm905jpo1ORPOwmtyhIV7rLagstcb
	sUSQU5BeU5zeu3zgpEbJog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791899814; x=
	1791903414; bh=SfKfBV+VEmVIf9KdAS4V6WUPvJtf1uh7aYgx5XZ5U4M=; b=H
	QtBVhsH50R2K3XCH35vBzrQTUVf9OxUpYCmGCxoFgTdBscsDGtAbsPoBWs2sHuJX
	+ASCGtWLzV0JzqnotvItv9Qb8pDXtoJickkxrjOfmBMebelVBPbbTPIICwMM6pmv
	NaEGvIducy3csVaH2cbGghxC44J1p9WhDHWRTI7/CeGAfyrI6abFjbehGpx48BdN
	vCR4EzVMlTcsbGPVgHIDSdbCpdse/t7mU7PbzcV1HHZxuKAScwUfryiuvFTpX557
	E0wCpK4iZ3lgYQoy1/vk2nNiDTkI2zC4IINASGfNpiC3Ba8QTXk1PiONhbaFqZ2w
	WWbo1r2k7ysIqRHLWYXsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791899814; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:m4jczzgQ30li2e/Ee7J9vsVXKuBUjYbDKXKNb831gOzGG7z
	hXBPPb25+0pDJicO4/aBR7IC6YvEIBjN7oM11ppNBeBV420dZDLWWsgyJ82kU6Fp
	XLh2wW4JsfGJK70xfiapq34gu5uCo/HRqGTkFUe7ErVNUGDZZ1WxZbuRk3TIqHfW
	ynaBRkXeTvfL5gSMz6w17FMhMZKAPv+htUzX+u0d+ZclPQQaUqAZTXyo/PRCPNUO
	x/A+PjmkaGmwCrFAHOx/3gwbSrRHeNPdcYJAbhsv6llwPCWkNfzsiUOJ/TtbQq0b
	Z5a80VeVcUun3d40M75KNj4CX/E+9Miya4hu0WA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jGSh5oRTDHqW86xVSSOWeCr8F1gAaGqsEaogKL7IJ+A=:mnBrm0FnBkM5RwK0Dn2UeVrRU5Mml+tcHmkJboNV3gQ=;
X-ME-Sender: <xms:pTjOarUF_FyRNSKyG7XIHk15W_1QWp_mdHR2iXVVtsn96tpHwClqLA>
    <xme:pTjOaqnMeaDOAMtXdOUTPMnSgDDnbHe1KxShXHYGBoBFAjqPnZ1LE7nC_Tu_tskYA
    96UiRfevbi494SozlHzYcHM5kWg2gLoiYyIeb7mcp1MLqSd4tagvShN>
X-ME-Received: <xmr:pTjOasYHcmkhh7IPSBf8vEBQ-gaZHJZwr1Apx1fKjKMZnS5YY52qk1qOszhB55NtdutEWUsLUJJ5NxnEMj9LRLFhqg>
X-ME-Proxy-Cause: dmFkZTGTYcu5Hsdwml6bd52pIwBe5ppbzpewCi+5ZQVzAbR5yYMXmwvZHv8WQC54+0b7LN
    x0mTDErb8ue91G9fsy0tN5qOJdCYHl/E6e8/PeumB3Z6c9Jj7oPr7VD9LFM1W1t7djtjvw
    33DFN+vD3mV4qlMWYs8/QQh2prnh8T9liHIioL552KqD2/JHUxOpuVZXxWtKQeDshQomUb
    MY/dqi0JGC1n6yyBqBr5C//JiMEdUaYh4pDgMXmJbf/TFjUYBM3wRAC1QderWLcWvFHRMI
    jvn52Xd2Od+ALxXZ6NBeR964yOrew/pf23xzmU5vVn0IKWrOOMcerB4EIGVGh3MOYliFTU
    ODK2iDXOsFkdSQuNPUrkvlcp0/f3Ey7cL820pP0jFOm3dH68IzkbEApTaYg5Tzz/ZnXPiA
    SDvuP9aJ0cVCXximo+xQJudkbd6EHzS4yG8BvZjAI4dhli/F7Hz4p2/fBI8BfPtR7smRIf
    H10Zmf4nTrPf4G5FVMqX+twWN2qoUtfSKMl6OlwkeVGFtqhFjo7V6es5bQUUiJnyaRUImg
    2hvBzEsjG+wdf27NxBwAvP8gdFO/pZH5YLtVum8UyX2JV4sG1NLnQdtt+ju5LEQpBKm992
    C8sF4JyGMW6XaBq646q+JtwfrAZpgstz9v1i2jcMVhR2he0nnFEMOSEmJWHw
X-ME-Proxy: <xmx:pTjOalNBMRDlO9isJalJzRgCSyaT64u_jf-TzoMrKEz_qOU-JffmIw>
    <xmx:pTjOahaYbgVnQ7391zwupnuk0sG6-CYVxQhiXYX3ErMtRYAkGPBCRA>
    <xmx:pTjOaj3TmEOT0EBMF7x20KIhzOR6-RWnPeV0B9aB02GOHI8xY28-Pg>
    <xmx:pTjOanfSAUBNOePuYpru2WKD7_GugJ7Vjh8v2U7qkAZsJYThwb_98g>
    <xmx:pTjOak8oRQI0W6IRYWKLZA7QSXmUG38SadB11SDPvhu8nBRD0azoVKZl>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 09:56:53 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 09:56:53 -0400
Message-Id: <DM3RGXVFVT35.1EPI4MJB0RDBB@fastmail.com>
Cc: <git@vger.kernel.org>, <jltobler@gmail.com>
Subject: Re: [PATCH v4 1/1] repo: add filtering options to "repo structure"
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261010150539.930614-4-markchucarroll@fastmail.com>
 <as4a7t-NEQi-4Yqp@pks.im>
In-Reply-To: <as4a7t-NEQi-4Yqp@pks.im>

On Tue Oct 13, 2026 at 7:50 AM EDT, Patrick Steinhardt wrote:
> On Sat, Oct 10, 2026 at 11:05:41AM -0400, Mark C. Chu-Carroll wrote:
> [snip]
>> This implementation makes an awkward trade-off involving
>> "setup_revisions". In order to accept standard the standard
>> revs parameters, it uses `setup_revisions`, which does a ref
>> walk and populates the pending objects list that will be used
>> by "repo structure". But this ref walk doesn't count refs in the
>> way that "repo structure" requires, and because "setup_revisions"
>> doesn't support a custom callback for its ref-walk, that's not
>> changeable.
>
> It's a tradeoff indeed, but I think it's a sensible one. I see these as
> counting two different things, refs and objects, and the revisions only
> filter objects.

I guess my wording wasn't clear. The tradeoff here isn't that
the revision filters don't affect refs - it's that when we use
setup_revisions, we end up doing the ref-walk twice.=20

>> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
>> index ed7d80c690..67be7efd23 100644
>> --- a/Documentation/git-repo.adoc
>> +++ b/Documentation/git-repo.adoc
>> @@ -66,6 +66,12 @@ supported:
>>  * Total disk size of reachable objects by type
>>  * Largest reachable objects in the repository by type
>>  +
>> +The set of objects counted can be filtered by specifying a collection
>> +of revisions to select which objects will be counted. These parameters
>> +follow the same syntax as the parameters to similar commands like
>> +`git log`. If no includes are specified, then the include set is all
>> +reachable objects.
>
> Nit: I think it would make sense to define "reachable" in this case, as
> there are a bunch of data structures that could in theory make an object
> reachable. How about this instead:
>
>   Defaults to all objects reachable from a reference.

Sounds good to me.

>
>> @@ -141,6 +147,28 @@ using the `nul` format:
>>  git repo info --format=3Dnul layout.bare layout.shallow
>>  ------------
>> =20
>> +* Generates information about storage usage in the repository:
>> ++
>> +------------
>> +git repo structure
>> +------------
>> ++
>> +
>> +* Generates information about storage usage in the repository omitting
>> +the branch "foo":
>> ++
>> +------------
>> +git repo structure ^foo
>> +------------
>
> Wait, wouldn't this result in the empty set of objects because there are
> no positive revisions?

Yes. One of these days, I'm going to learn to type. That's supposed to
be "git repo structure --all ^foo".=20


>> diff --git a/builtin/repo.c b/builtin/repo.c
>> index 84e012f83f..081940a85c 100644
>> --- a/builtin/repo.c
>> +++ b/builtin/repo.c
>> @@ -766,10 +767,12 @@ static int count_references(const struct reference=
 *ref, void *cb_data)
>>  	}
>> =20
>>  	/*
>> -	 * While iterating through references for counting, also add OIDs in
>> +	 * While iterating through references for counting, if we didn't alrea=
dy
>> +	 * populate the pending list in setup_revisions, also add OIDs in
>>  	 * preparation for the path walk.
>>  	 */
>> -	add_pending_oid(data->revs, NULL, ref->oid, 0);
>> +	if (data->add_to_pending)
>> +		add_pending_oid(data->revs, NULL, ref->oid, 0);
>> =20
>>  	ref_count =3D get_total_reference_count(stats);
>>  	display_progress(data->progress, ref_count);
>
> Right. An alternative would be to simply never call `add_pending_oid()`
> here and always let the revision walk handle this by defaulting to
> "--all". That'd have the downside of walking references twice, but the
> upside of making each of the steps completely self-contained.
>
> I think ultimately it doesn't matter too much which of these two
> approaches we pick. I'd have picked defaulting to "--all" myself, but I
> won't insist on it.

I went back and forth on this a fair bit. Both approaches work,
and both have their downsides. In the end, I felt like munging argv
to add the "--all" was uglier than this. (Plus, when you do the default
"--all", the command will always fail on an empty repos, because the
"all" logic tries to call "refs_head_ref", but there are no head refs in
a newly initialized empty repo.)=20

>>  	if (show_progress < 0)
>>  		show_progress =3D isatty(2);
>> =20
>> -	structure_count_references(&stats.refs, &revs, repo, show_progress);
>> +	repo_init_revisions(repo, &revs, prefix);
>> +	if (argc > 1) {
>> +		argc =3D setup_revisions(argc, argv, &revs, NULL);
>> +		included_revision_args =3D true;
>> +	}
>> +	if (argc > 1)
>> +		usage(_("too many arguments"));
>
> Tiny nit: this reads a bit odd because we have the same condition twice,
> and the second evaluation really only needs to happen in case we have
> called `setup_revisions()`. So I'd have moved the second check right
> after the call to that function.

Will do.

>
>> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
>> index 02cc2b594a..e35b46a277 100755
>> --- a/t/t1901-repo-structure.sh
>> +++ b/t/t1901-repo-structure.sh
>> @@ -21,58 +21,6 @@ object_type_disk_usage() {
>>  	fi
>>  }
>> =20
>> -test_expect_success 'empty repository' '
>> ...
>> -	)
>> -'
>
> Huh, why did you drop this test?

When I was floundering about whether to use "--all" default, I found that t=
he
command will fail on an empty repos. Even without the "--all" default, it s=
eems
strange that some version of "git repo structure" will succeed, and others =
will
fail with a confusing error ("'HEAD': unknown revision or path not in the
working tree."). It seemed to me that when you consider that running this
command in an empty repo is pointless, I thought it made sense to drop that=
.
I'm happy to either add a line to the documentation, or to reinstate the te=
st.


>> @@ -144,6 +92,165 @@ test_expect_success SHA1 'repository with reference=
s and objects' '
>> ...
>> +		git repo structure --format=3Dlines  >actual 2>actual-err &&
>
> There's two spaces here between `--format=3Dlines  >actual`.

Good catch, I have no idea how anyone can see that.

>
>> +		test_line_count =3D 0 actual-err &&
>
> `test_must_be_empty actual-err`. The same applies to some lines further
> down.
>
>> +		test_grep "objects.commits.inflated.size=3D231976" actual &&
>> +		test_grep "objects.commits.count=3D1046" actual &&
>> +		test_grep "objects.blobs.count=3D1006" actual &&
>> +		test_grep "objects.trees.count=3D1006" actual &&
>> +		test_grep "objects.trees.disk_size=3D284547" actual &&
>> +		test_grep "objects.blobs.disk_size=3D21022" actual &&
>> +		test_grep "objects.tags.disk_size=3D126" actual &&
>
> I think this would be a bit easier to parse if you instead:
>
>     cat >expect <<-\EOF &&
>     objects.commits.inflated.size=3D231976
>     objects.commits.count=3D1046
>     objects.blobs.count=3D1006
>     objects.trees.count=3D1006
>     objects.trees.disk_size=3D284547
>     objects.blobs.disk_size=3D21022
>     objects.tags.disk_size=3D126
>     EOF
>     test_grep "^objects" actual >actual.objects &&
>     test_cmp expect actual.objects
>
> It's also more efficient because we don't have to invoke grep 8 times.
> But we'd also have to add the inflated size (which I've omitted out of
> laziness).

Good idea, will do.






--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

