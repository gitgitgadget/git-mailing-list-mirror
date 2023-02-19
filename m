Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB8C05027
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 10:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBSKpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 05:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSKpN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 05:45:13 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638611153
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676803479; i=l.s.r@web.de;
        bh=MrWUBbRZsc2OLLc/lqk4RUw1ph5laQjQN31VUyDZPwI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=c9IOXOOaasDIJ2yjSOO1pbbFV8XPRW/Yjroy/ZeqEishA8tZ1fW4LS8RXRvCISAVl
         7RvWs2+GOisUtqSYezN5yn+le2eh+rZU0kNQxAMDskgfUUAZHzMvbNgU2hBMyTvVnq
         X1lxycGqFInmcwV2b/xaM/j1V1M5jL+m239xFgwsDjpD+A352pfcjbBdM+nL9+Xmj1
         iDo77zbV+EfTVkn11lEuUIgjQh50N9MmLOR2VRhiXaduj4YrYNlcO0AGMPHUjt8Tpt
         HMABv1kX2BPs4r3NTOTSrL5wK+0Qv0YAdfiVhAY6pDAsIAUwRE60P7l9Fm7ceG/3aD
         niwn3mU1Ib+xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M608n-1pRkJ347bf-007f1J; Sun, 19
 Feb 2023 11:44:39 +0100
Message-ID: <57b6643a-b9ff-3ea4-d60d-1a434d9ea75e@web.de>
Date:   Sun, 19 Feb 2023 11:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] archive: add --mtime
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>
References: <Y+6G9n6cWRT9EKyl@google.com>
 <91a73f5d-ca3e-6cb0-4ba3-38d703074ee6@web.de> <xmqqilfykhsf.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqilfykhsf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mp7D399jSXTzC3Kv/BHx2oBvz9+qTyK3x8xT2TrrGgFlO6R3noL
 gd0qqLHn4n69Qj6sF8WCKr10j1coskY5mJoT2ePAigLoSwtDaObOpmsiZcGMMAaCit9/BOJ
 f91tGhdYqVbn7vn3gSwzVAbIq0VSCa4lT5kZNHhD0/ghpOlbYDSMJAGHcRSxQ4bXcqITT4U
 AuKIJvkU9I1WUcKgH4uYg==
UI-OutboundReport: notjunk:1;M01:P0:O3DqhxcqKS4=;zQIUnSM5CKKFaEis1YjnGnIe2Jw
 dLu244dB8TaZ907YUi7Gp3nEfmu48rnUUWUrewehAVle6FF9oTKnZqMqsr309c9pm0Wz1Lkhs
 b26/xT7ED9PVblmcEYJkekwACx8QU+Lq4qjoI05qvwNyv56fTHPccdnDkDukQ8SErvt514UEf
 KbsvcE1AVEl1dydZwj3OcuVxxu1327ByfczRlulW6aMr7LxXMBJlGWwwFUxZjXKaMXTmCpLTu
 0KUndxPZvKkSFsENMegoWpAA/iIFNAdAXCop67V/QhGRHRrTyC8jd0ztPJ7QzhRzlUbi9JHKe
 kLeI+cDpJ0zhbO+JD/FQYxVOcddAd++XGvD7gYhH4D03Qgo7Z1TGdicua66fqzZR0MA5A2hIk
 oiHosTv1OSjCanDGhgdnsntgvscShSOftvAMbArTk5eOKbg7MYYKlkBe586OaJ5WkhTczocHu
 iOpXP/XPGyI3kuL6FaIlqJiJl0yY9Iluja/p0kagtaxqCrAV2Cv41yd4PNSZArmBsoNv33+03
 clDiTH9ImzzEYkpymSkMYLN+FYJvAyGjstfBb04XNnlw0eb9baVuuQc1ert7v9PCg06vmgsZY
 mARB7Gr7xr+rzCWyiHu8SLlWvhnhZ9ulkBAyYq2wFY27fvcYXxVuiV67wyAKZ4j0rj7z9sMa2
 YDAkP9Oqln0phOTXfkB6j9LQq5elod4dbXZJCgsrsI45t2R30Q5OdqTMfmgKLhrpdiHuAxfV+
 P0hraHmsT6zpfPZ/Zzo32IxEIHhfGfv+IQlmTQ8gRh16yIoDJ4eOMES7NySArVlNIS0nYiCBJ
 vP576bx/kiPPMfg281VbEyleh8G05EH9ZeWNc99gJiXp4DeB8dBOVMSW1HC7g+xN5LNIRF1ig
 I6KB+rkGvrk4ghWCxauA20vrCxT/3nfHEUBboLF2vwmKto3oxcANUYESYc3+ADjcjCcN7ETwu
 e1SMug==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.02.23 um 18:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> +--mtime=3D<time>::
>> +	Set modification time of archive entries.  Without this option
>> +	the committer time is used if `<tree-ish>` is a commit or tag,
>> +	and the current time if it is a tree.
>> +
>>  <extra>::
>>  	This can be any options that the archiver backend understands.
>>  	See next section.
>> diff --git a/archive.c b/archive.c
>> index 81ff76fce9..122860b39d 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -472,6 +472,8 @@ static void parse_treeish_arg(const char **argv,
>>  		commit_oid =3D NULL;
>>  		archive_time =3D time(NULL);
>>  	}
>> +	if (ar_args->mtime_option)
>> +		archive_time =3D approxidate(ar_args->mtime_option);
>
> This is the solution with least damage, letting the existing code to
> set archive_time and then discard the result and overwrite with the
> command line option.

I actually like Peff's solution more, because it's short and solves the
specific problem of non-deterministic timestamps for tree archives.  The
downside of spreading ancient timestamps seems only cosmetic to me.  It
would be ideal if there was a way to specify a NULL timestamp or none at
all.  The --mtime option on the other hand mimics GNU tar, so it is more
familiar and proven, though.

> I wonder if we want to use approxidate_careful() to deal with bogus
> input?  The code is perfectly serviceable without it (users who feed
> bogus input deserve what they get), but some folks might prefer to
> be "nicer" than necessary ;-)

It isn't all that careful, but you're right that we should do what we
can.  Like this on top?  The message string is borrowed from commit's
handling of --date.

=2D--
 archive.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 122860b39d..871d80ee79 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -438,6 +438,15 @@ static void parse_pathspec_arg(const char **pathspec,
 	}
 }

+static timestamp_t approxidate_or_die(const char *date_str)
+{
+	int errors =3D 0;
+	timestamp_t date =3D approxidate_careful(date_str, &errors);
+	if (errors)
+		die(_("invalid date format: %s"), date_str);
+	return date;
+}
+
 static void parse_treeish_arg(const char **argv,
 		struct archiver_args *ar_args, const char *prefix,
 		int remote)
@@ -473,7 +482,7 @@ static void parse_treeish_arg(const char **argv,
 		archive_time =3D time(NULL);
 	}
 	if (ar_args->mtime_option)
-		archive_time =3D approxidate(ar_args->mtime_option);
+		archive_time =3D approxidate_or_die(ar_args->mtime_option);

 	tree =3D parse_tree_indirect(&oid);
 	if (!tree)
=2D-
2.39.2
