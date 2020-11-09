Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A80C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1E2206ED
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="L5v3ykwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgKIXtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:49:07 -0500
Received: from mout.web.de ([212.227.15.3]:51075 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbgKIXtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604965742;
        bh=V6XzqgjoikUuFFiy10R8woeQRg2rtK79WnGHzatJH+8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L5v3ykwfP008F9OB/Luuc88HZjhHe2McFXv/o9wopjoOYWy62o8Y9yPI4D3CgOaRh
         1AsSlmED4CYmPAjm4C6oNu1k0SlxyYEXyP+F5WC9jNpgKdteohRSFPduPo96cUPX9H
         Pwco+1TcnCv9vLpElNfibttdY0b9QyeCq4SvhVSs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ljron-1k0TB63d4D-00bv5e; Tue, 10
 Nov 2020 00:49:01 +0100
Subject: Re: [PATCH] archive: support compression levels beyond 9
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <96e6e2ce-fc7b-1e73-0112-93589b28506d@web.de>
 <xmqq7dqucr9t.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9c35f3e7-e0ac-b68a-2807-ef1ef9ade54f@web.de>
Date:   Tue, 10 Nov 2020 00:48:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dqucr9t.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rhJI0WR+/PKLdd+BD7A3NXZ7m8NIZTZrlQgPJJENk9chJG8aEC6
 1caQ8HOH123Zen7fuypGRQP/W7oXHQQMShnZUYhkYLgMnWA7q9md4+xLu1q6j0OXlBzO0o+
 E0vlAm7vl+OA1PrLD3dC8NySZq6IHbsge87Ee1UgduEDPyqsj4tXE7D+gt7gNT9aeicQ/rx
 Cg2WsCVwh2oaxnTvRUhKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iLsyquZiNj8=:b3H6P43TAag8XfR/Sx/C2l
 3vYCSHJ9CrThfCAI1FJuZQhHOhV4VY35bVFRlQWa5kujuhAhv8Qo3AG27unmd+dMIJMRZF/Oa
 ahXpoBOG9LrEhkOu+m66H+X+82xlbqJz2ASqTxauXEbA51P0rhG4GXXsAFPFohC3U7byHbbDP
 OzG/Jxum2Nkqarud4+o6knJ+CWgyOhOtn3NNYila4rWv6R4DKVrvB1uv/xQO7GvmGX5H0W8uC
 jtyLrFBNSVgiXdqEW9H+qobrVK38a2XQ5Xh499w4VPIb5095RuB+m6exjBmevsXRt/YhgLk+i
 slzzDJpxQA9uutwja3ApIWjepMd7bTNv4MRwDNL0RV0dXgvKh+12c/CaEvVXL2iV/J10grEDa
 El0zUeuHs/I61KyI/nGMN3uV+Rst1u+oOp50F2S2h6vc/CSObfDW25NvjkeKNghAXRdc3SXQv
 oONsl+GRpcIQKZAlbLbpdk9KOnq9fafU1x77DR2YL/N4stNcyrasd1umlcAubK2a5V2lmxcCu
 rwNWw7SkFlvFrnswJvdkdxS7k99ElHqt9JEtGmZhPvSw7Lp42qtcc8OH64aM7LU9hr+q4c02N
 1aUbZbKCXv4GrqIxXw2NP2IIoYUl1JVTmoLCZifJp5/eZkqGfcCvPKjfuvVVSmZpoyn2TlPwl
 QM3m2Ecz8fBf9Qu06nO7qFGCgfHVj/iLOuCjsTnGr+J1YgncRBZpJUcUcOLRXIU8bZCLaai3h
 VWtcWHiVFj+k1cMWkSrU/f/hw0VfWtslfgVjgntxvy6UfcX1XKzSJB7LJ/VdOtJVblhdIV86u
 QWiBcQ0U7XbLs2GItHPxHb/FZrh0gTSPzBSLe4/K0ZgeSCkISO9a1Z12lreO3iIOn2UpPHmdX
 CDfXnPiMzaavLqAMcu5Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.11.20 um 19:35 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Compression programs like zip, gzip, bzip2 and xz allow to adjust the
>> trade-off between CPU cost and size gain with numerical options from -1
>> for fast compression and -9 for high compression ratio.  zip also
>> accepts -0 for storing files verbatim.  git archive directly support
>> these single-digit compression levels for ZIP output and passes them to
>> filters like gzip.
>>
>> Zstandard additionally supports compression level options -10 to -19, o=
r
>> up to -22 with --ultra.  This *seems* to work with git archive in most
>> cases, e.g. it will produce an archive with -19 without complaining, bu=
t
>> since it only supports single-digit compression level options this is
>> the same as -1 -9 and thus -9.
>>
>> Allow git archive to accept multi-digit compression levels to support
>> the full range supported by zstd.  Explicitly reject them for the ZIP
>> format, as otherwise deflateInit2() would just fail with a somewhat
>> cryptic "stream consistency error".
>
> The implementation looks more like "not enable them for the ZIP
> format", but the symptom observable to end-users is exactly
> "explicitly reject", so that's OK ;-)
>
> As with the usual compression levels, this is only about how
> deflator finds a better results, and the stream is understandable by
> any existing inflator, right?

Support for higher levels might have been added in later versions of
Zstandard -- https://github.com/facebook/zstd/blob/dev/CHANGELOG
mentions "Command line utility compatible with high compression levels"
for v.0.4.0.  I'm not aware of other implementations  of the algorithm
than the original one from Facebook, so I don't know how compatible
they are.  It's not a problem we can solve in Git, though.

Side note: Using Zstandard with git archive requires the config setting
tar.tar.zst.command=3Dzstd.

>> diff --git a/archive.c b/archive.c
>> index 3c1541af9e..7a888c5338 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -529,10 +529,12 @@ static int add_file_cb(const struct option *opt, =
const char *arg, int unset)
>>  	return 0;
>>  }
>>
>> -#define OPT__COMPR(s, v, h, p) \
>> -	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
>> -#define OPT__COMPR_HIDDEN(s, v, p) \
>> -	OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN)
>> +static int number_callback(const struct option *opt, const char *arg, =
int unset)
>> +{
>> +	BUG_ON_OPT_NEG(unset);
>> +	*(int *)opt->value =3D strtol(arg, NULL, 10);
>> +	return 0;
>> +}
>>
>>  static int parse_archive_args(int argc, const char **argv,
>>  		const struct archiver **ar, struct archiver_args *args,
>> @@ -561,16 +563,8 @@ static int parse_archive_args(int argc, const char=
 **argv,
>>  		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
>>  			N_("read .gitattributes in working directory")),
>>  		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
>> -		OPT__COMPR('0', &compression_level, N_("store only"), 0),
>> -		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
>> -		OPT__COMPR_HIDDEN('2', &compression_level, 2),
>> -		OPT__COMPR_HIDDEN('3', &compression_level, 3),
>> -		OPT__COMPR_HIDDEN('4', &compression_level, 4),
>> -		OPT__COMPR_HIDDEN('5', &compression_level, 5),
>> -		OPT__COMPR_HIDDEN('6', &compression_level, 6),
>> -		OPT__COMPR_HIDDEN('7', &compression_level, 7),
>> -		OPT__COMPR_HIDDEN('8', &compression_level, 8),
>> -		OPT__COMPR('9', &compression_level, N_("compress better"), 9),
>> +		OPT_NUMBER_CALLBACK(&compression_level,
>> +			N_("set compression level"), number_callback),
>
> Doubly nice.  Adds a feature while removing lines.
>
> Do we miss the description given in "git archive -h" though?
>
>     usage: git archive [<options>] <tree-ish> [<path>...]
>        or: git archive --list
>        ...
>         -v, --verbose         report archived files on stderr
>         -0                    store only
>         -1                    compress faster
>         -9                    compress better
>

Perhaps; I just couldn't cram it all into a single line.  Showing an
acceptable range would be nice and terse, but that depends on the
compressor.

Hmm, adding an option for passing arbitrary options to the filter and
removing the feature flag ARCHIVER_WANT_COMPRESSION_LEVELS from
archive-tar.c would be cleaner overall.  The latter would be a
regression, though.

Ren=C3=A9
