Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923237FF62
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216994; cv=pass; b=LhAbph2MHAaV2aX3Hzwr1R7wIMoEvwULSIj5QcPnkUBS1UwGmun7mb2ulOLgOCHYMZs4JQuoHXWlzISjXzyWnhet3KmHRE5kWXUjVciHtvFiDqNUerKJ0n2K3MIstFaHMabFNHPiQ8T7WfMPViXMXDlSt7Mxoin6B4C9al/USxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216994; c=relaxed/simple;
	bh=OErOwhgrZ5il4BJ8Mr3V/v62RWwMDT6V4WTT2WeMolY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seGDzCMGkjdIIZZZk+vSyqQ5PV9sVLqBbappvhVg9poNzmU+9B6/ZEyfyHmqb0BKQfT3o3wsQ6+yte3d2302rIXR7iLMgPJ5TFKaFPvlfGYeKz+bHLquXDX3JEGo57Z7m6bFRA7tqm5fdoabr3L7qne8Jo6+inYDLszbuitVdm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZKci/UD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T+quaON3; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZKci/UD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T+quaON3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0PUS065433
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+fSkb3VfzDhlV4eNkhvjw7F7INcZT8wpgFOW0AG2ZiM=; b=RZKci/UDdKxcei7s
	jb5R3p46xVWAjc1HmsqPf6/WWIao9Go9NFPZdpZCt5gRpWeNiF88REgA8K84cwbh
	ETtzrkRNoxesqWal3j5g665KQK53Mvg4jBXzhSEN4WYiZmzzGhIDUNK1bAIgbPi1
	e/V0EQxPkm2KNixF7q0WlIhJ2zACdiQZMkJF4s6fvFLOFWpEiXABj+EwELzlyO6w
	dcvtYL+Sbjs/eyfP1Mo058Ib7wopnvDTohlltQcvgxudzqQnKy4pKnok1WH7cd+q
	wivMa8Dt81yyttb7hhk2Gjl7t273HQXdrkKowQVLYgw0cPfDaAyKkTCUzC3OtkpT
	vpILtg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cka2xhcjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:29:51 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6445cf02fcbso3064939d50.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 10:29:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772216991; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9lduUXzjFR9dw/gH1nh2Uj3aYZOp5ahrbQnzguvbPlG+alqWr/eA5ksAmp6ZpTP8s
         gaV8X82gT4kabowAC7YplIbEqDOiQGBulWmzAJ5YwajjghUd0XZbzHSorsPHN4fnkUbw
         YhSnuemud94ENY1lmUv6GVh3hDLHyztXM9Ovaa6dB+U72uhE2HyN6VFjLLeVceTFkrhj
         TlKD15TiEf7qOWDVvNXmMJKy+ltHiNjcGVfEvjdbwRD++JONreYqmR+bC6yJqUkTmmJC
         ZHp3f34+VMB61nCTshVGbZlZot+SPbRGg7uUJIT7xqF1r9j0PxxNBiU/V+TKJFO7gDz0
         hgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+fSkb3VfzDhlV4eNkhvjw7F7INcZT8wpgFOW0AG2ZiM=;
        fh=DW7/E6WjsU7x309xCHuRB1/ZdJJbGvw5PKToTZNYdGo=;
        b=h8LRcp5oyfpxYt8Zu6Pn6AjBkchXF0mKUiU6TPe8iZVAX9D2vpoX1F9NJCLco8+vBR
         fOYx1Ywy8W2iiC6vXAnf/qQvb2TG9+aiJoJMlDjChnGqeTx1n0+DmRn15QnYi3z+Sfyg
         L80TDY1MGsZuecD8DG6lwjEc1VZHrGkYYwijOQ0n98Ze8KQM1ij41fcz3VXrlDQb5eo3
         Uqj5XaWZajVbXqIEiGl8rJc2uqXpMrXdY78pOSmxa//FFgcRi75elyjOlv/fKAMRYmO0
         7af+dSHeCfilTl9zyp6XCFEkkkJlLyxErJ9xSGtRv+oH6jxVGWSitBbQLOTNuEwHBkyv
         6uww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772216991; x=1772821791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fSkb3VfzDhlV4eNkhvjw7F7INcZT8wpgFOW0AG2ZiM=;
        b=T+quaON3KmgvMJROSCdTormkI0oKmrrc6uDkZDI1k+WVS/GruPQdolzVL0LWCKkoq3
         d/k1ilMQ//SpFCfTxeN30PMX6hkl90v2UnSlRhbtcIH9fkhgSlb8QbI8FCyHM7oEkWSE
         mGOsm6BDT4k4gqzg/1eb4BEwNCT6jz1fIRSrHKCWhwgpH7V0OulGr3d2FgWMhkmH9swl
         aWhQA0SLeszZgpX9Q/tBksLl7lkdEMeSax4/NAkVF0MdiqN4daRjMznYGdjjn5YITLo0
         zVLDIrOTjkI5NQdeY/YFgLTYUYMN9MIuGlIhRwtuM5FmZOdEaXwldUkXgEwQrD1+vni9
         DLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216991; x=1772821791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+fSkb3VfzDhlV4eNkhvjw7F7INcZT8wpgFOW0AG2ZiM=;
        b=bhyp1EjTwEqSzcYnc31YeKEeQNtwfRHTF/EFFAXBr3WiSL+7c9PJGPiQBAtoS02dkq
         3ZErQevkornW+JAKL/OUsfQ/rlrxq2DxrfrZ0mOJJdRnFAUvOzDL8DeNuUPug3O1GYF1
         w+LcBroLWdwnhVCw9jFiR8CZGig+Pf9HgF17S3eBDucE3uhEYQ9ainpAmm+kEiOc6EiS
         eaEbIhe5DuT/kkKdAgeq2s8mJRE7glupnGKdQuJ/c3+QCbRdjULqt3B6clQfvj13KB/b
         K7vmzbeviw7pHHZgi12ZOqawx+5X3FYwjoAWTbQ97ZWexmVh1qA24/FA+4x5rRVzqGpd
         FK1A==
X-Gm-Message-State: AOJu0YwKWmloNhj2rW0rDt7d291FNa5Eb6D50Ho22wBNmj3G0AB3Ogg0
	4dmeYfmazLTGNbxU/LQMDr8A1J4QpZsgxvpEWJaxu+poIrtd3Ks2tmk9OWrUGvD/jLSz3PZ++N9
	6rweP/Sm+LFtVuxMiZHJncib5Nhcwg8+WrfAxwSkeeKmprIeR3XsvJDLPLFjxJ/K7oQxBUfrGkp
	haiKZKlU/eC+gqXY7OMIDfMmYTZCNtsA==
X-Gm-Gg: ATEYQzzDNmCQgwavljum+gREv3cjCYo7XhRxtYz96NUvMNx7erDsyJs4CzYHA4hhbA8
	p+vP6aOkndB6pBPLPQvE/Xi7SQdyj6JH6vPMsT9WhrprjFMxcdme+HfgupWQdL2wFHOHdxmzxVC
	OZymellbF9KEDzJ7PraDL9RfenW4VcOu8YtLiKmlxOa12kkRhScxSbtSUCwbZ0e5GNWu0btpUPI
	Ua/aXKa
X-Received: by 2002:a53:d805:0:b0:64a:d6b4:94a3 with SMTP id 956f58d0204a3-64cc22e1a84mr2550650d50.49.1772216991246;
        Fri, 27 Feb 2026 10:29:51 -0800 (PST)
X-Received: by 2002:a53:d805:0:b0:64a:d6b4:94a3 with SMTP id
 956f58d0204a3-64cc22e1a84mr2550636d50.49.1772216990760; Fri, 27 Feb 2026
 10:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
 <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com> <xmqq5x8to53y.fsf@gitster.g>
In-Reply-To: <xmqq5x8to53y.fsf@gitster.g>
From: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 11:29:40 -0700
X-Gm-Features: AaiRm52nHGPTk5jJlmiRGrYIZUzcKRVRy8C45AeHcdEmjChp1jrIW-4DoGAqFmk
Message-ID: <CAFcKa=9PLNDQcvM1bFq=8_nbP-Ha1qDVHSSwde=apiXTcAC+DQ@mail.gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BOC+bVQG c=1 sm=1 tr=0 ts=69a1e29f cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=ybZZDoGAAAAA:8 a=EUspDBNiAAAA:8
 a=P7nEAia34Obg3XOBtKEA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-GUID: iHHk2vEhct7ZJemZBWy8XdFUdsXWcaS_
X-Proofpoint-ORIG-GUID: iHHk2vEhct7ZJemZBWy8XdFUdsXWcaS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2MyBTYWx0ZWRfX6QVdc1UCDGbK
 n5Kg40q54z3FIWEtVJSWyqG0qPCN+HibqHA2AoI2LOs1YJ4/EV8h1XXtXDJChyiV3COM9TdJt1x
 vr+hk6caJZ+Ef70vqaugAXQC7HLH1rsF7/wC7Kg43PuKHdHJgN565/bXZ1QLAFW6EdU7RD8mGMp
 pkJKci7BiLQQa/lquxETYbMjMMJlgn7XRsX0KObs2Mao3uOmOVb3xitbZEQw2lx5Q2hUES+FUR2
 FpLu3F/MJ2TYZe+jMzlm71Jfzj4PQ/djw8ecq48qWRzsSwA48TEbG0Ks1lraTPNGjLbDi7Withe
 CHYt2LnFsntImqYVZujZdsyBrgz4nVSiIJQc+AdBxMFSPtc40rQlDlOm1Nj8g6uZTIWn8+rfrnh
 FdWXMBEuMwq3ZljnS9Xmrauei9GEd3xGgapmFfygvbvK+6seMWYCqfZ8z02qutAQmIt6DYr3hef
 6/BQuvjjFtmyuFm9gmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270163

On Thu, Jan 22, 2026 at 11:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index d537ab087a..b180a24091 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -112,6 +112,43 @@ static int get_default_remote_submodule(const char=
 *module_path, char **default_
> >       return 0;
> >  }
> >
> > +static int module_get_default_remote(int argc, const char **argv, cons=
t char *prefix,
> > +                                  struct repository *repo UNUSED)
> > +{
> > +     const char *path;
> > +     char *resolved_path =3D NULL;
> > +     char *default_remote =3D NULL;
> > +     int code;
> > +     struct option options[] =3D {
> > +             OPT_END()
> > +     };
> > +     const char *const usage[] =3D {
> > +             N_("git submodule--helper get-default-remote <path>"),
> > +             NULL
> > +     };
> > +
> > +     argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> > +     if (argc !=3D 1)
> > +             usage_with_options(usage, options);
>
> Hmph, I am not sure what is going on.  What are we getting out of
> parse_options() here?  Would it be the same to see if we got
> anything remaining on the command line by checking argc and call
> usage_with_options() without calling parse_options(), or am I
> missing something?

I had found a few other places following this same pattern (for example:
gc.c maintenance_stop() and notes.c list()) and I thought it was because
parse_options() handles common options like '-h' and has standardized
messages for errors like unknown options.

> > +     code =3D get_default_remote_submodule(path, &default_remote);
> > +     if (code) {
> > +             free(resolved_path);
> > +             return code;
> > +     }
> > +
> > +     printf("%s\n", default_remote);
>
> Do we know that the value of default_remote has no funny bytes in
> it, like newline?  In the end the name has to become part of
> refs/remotes/<name>/HEAD that has to be a valid refname, so not
> giving any facility to quote funny bytes and allowing the caller of
> this helper to assume a LF terminated single line should be fine, so
> I am guessing that the answer is yes, but I offhand do not know how
> we know that we do not have to worry about such a situation in the
> code path that begins with get_default_remote_submodule().

I don't think we know that, or at least I can't find proof of it. All I
can find is that remote.c issues a warning for remote names starting
with '/'. That seems to miss cases tested in t0602-reffiles-fsck.sh.
However, I'm not sure if this helper should be responsible for
validating the remote name as that seems like something remote.c should
be doing when parsing configs.

> Hmph, these overly long lines are eyesore.  I wonder if we can do
> something about them?

I'll send a fixed version.

> I also wonder if we want to make sure we are getting from the remote
> that is given the custom name in a more direct way (instead of "we
> see that our fetch succeeds, and because there is no other remote,
> it must have gotten what is needed from the renamed one"), or is it
> too much paranoia?

I can capture the fetch command output and compare it to some expected
output where we have the remote paths, but that still doesn't show the
remote name. But it looks like I can inspect the GIT_TRACE output and
compare the `git submodule--helper get-default-remote` and subsequent
`git fetch` commands to expected output. I've added both methods to this
new test and the existing test it was modeled on so that it's obvious
there's a difference between them.

>
> > +test_expect_success 'fetch new submodule commit on-demand in FETCH_HEA=
D from custom remote' '
> > +     # depends on the previous test for setup
> > +
> > +     C=3D$(git -C submodule commit-tree -m "another change outside ref=
s/heads for custom remote" HEAD^{tree}) &&
> > +     git -C submodule update-ref refs/changes/custom4 $C &&
> > +     git update-index --cacheinfo 160000 $C submodule &&
> > +     test_tick &&
> > +
> > +     D=3D$(git -C sub1 commit-tree -m "another change outside refs/hea=
ds for custom remote" HEAD^{tree}) &&
> > +     git -C sub1 update-ref refs/changes/custom5 $D &&
> > +     git update-index --cacheinfo 160000 $D sub1 &&
> > +
> > +     git commit -m "updated submodules outside of refs/heads" &&
> > +     E=3D$(git rev-parse HEAD) &&
> > +     git update-ref refs/changes/custom6 $E &&
> > +     (
> > +             cd downstream &&
> > +             git fetch --recurse-submodules origin refs/changes/custom=
6 &&
> > +             git -C submodule cat-file -t $C &&
> > +             git -C sub1 cat-file -t $D &&
> > +             git checkout --recurse-submodules FETCH_HEAD
> > +     )
> > +'
>
> Are we testing anything new in this test, compared to the previous
> one?  Both update the submodule sub1 by adding a new ref under
> refs/changes/ hierachy and have "git fetch --recurse-submodules"
> follow the changes.

I think the only difference is not creating a new superproject ref under
refs/heads/ when we fetch. I mirrored it after the test above 'fetch new
submodule commit on-demand in FETCH_HEAD', but for the intent of testing
this remote name feature, I don't think we need both. I don't mind
dropping it if you think it's unnecessary.
