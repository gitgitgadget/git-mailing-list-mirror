Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B16C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCFSFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCFSFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:05:46 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090895D75F
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678125884; i=l.s.r@web.de;
        bh=R67fYwDGSmflDiUwb6xJ+rISlxZJeHjfKNySZpZLc/I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qH//omQw7XGcr9b1tV+a9cAxyrAwSZqsZ7UJBujBmdHWVXGBFXVMa50Os6N/Ubm35
         pp9w5EW+eX0H5ut5BLoTRdB7IuT3B0zs8gD/MIp6iBxwmnMoh7z/mEZ2y6jjh+jDMe
         BzIO54BRxDfblin9ZMC5auw0TchYi9ZCSVmAByhlqv2NXx1MHg23mZScRxL4LWage6
         geGN+AtXJXYZs3winrshGl/vzrh/XdHQiQTJeFqsE39bE3/AH3zbbwQkMcZKblFQYF
         mAEpmc9VJo+7YX2I4ivwDCZ9S8NggAW3EvrK90MmdpEJNzn3AybIHEa6x+B4bG4sDP
         eNrZoNLWkUs5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRW6L-1puVQg0WzF-00NQ6i; Mon, 06
 Mar 2023 18:51:19 +0100
Message-ID: <a86f05cb-407e-f5c6-ed15-a1fbf1be0584@web.de>
Date:   Mon, 6 Mar 2023 18:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqy1o9byye.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqy1o9byye.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aGaSXi7BddQXPSSmZYuU8oPKpmRrwGRpEqFf5NcP6IwE0nuVPd6
 LgtTAKS+1Z7ustMSfL/kqPcB2KqkP1ndde3xDB1XaP+Q/r/j/kwRJy5mADyHHSR9LYCQ1is
 ezbI/ZsURUGL8fZhd3hnCCJXGmjcn+xRPmeOoS0Lg7NOglUeuyEWgtm8JddIdiNyq5709hq
 a8UxytXtsWvnAzgHExxUQ==
UI-OutboundReport: notjunk:1;M01:P0:VvyfUxo5D+Y=;gy/7MXBKn9SzdQNR+8IjFCFfWiw
 Z05viwh2+L7ewi8QlrePMcsMYrnEuuuB5RAHxNa9gKJqJWgvV9ZXBDiUuIuox+u1416skmR7S
 9DJ/Naun6LczMmU4VEBcyo3mfmQPc1nZaI2Yg5/UlfMo/PH1+T6/gADGk1o6HawDs4e6Uh7q+
 kH0+/C/4pG1ERaNXTyvpqu6c4ncjX+Z/6jx+DsQqUfoDRm2RNJA5zxkmrFq1+HXDdwKGFfeIS
 O7SAhaxW8rebd61hfArQdCopmp3g5GBc8XubZrVLS2UvbnhcfCbi3HIxhCXIODwaG4FvH5Fr/
 r1LOZszI1CfacKNvVfxNtRfYiDytMu3W7aJkAkd8+Es6CAb1t/CY2INqyyApmWqTQJqnIoXjB
 8s+ocl2bgSj5HdqW/29ngCaO5wZBpZWoZw6M09V3nFGMTD+usmbASvKEaVTvpUbqAjt7aNm2K
 NvQC0ztDZFOwGuG7NnEXw2OBY6NK2ADupSxu59U/eajhiiSMgc3WqCw93A6ZVcJAd/r31IbYH
 y1vqKfzQnfBxiq8KgjVtgRbsiZfrrtW2xTyZskB88xdgc/FSOv628JteW43AzjOBRDJk97SDP
 HEsVVaaRVa2fPJPHGpK5nfYn/HBrj21nfo0M0NJJ1nDRx6dQedS2lLaLji6GwQ88nejw7cxV8
 UwDVQZMWvnGgZhjJ1TglQUBNk4J3eydYTFIZOZi8MniR4pYAjKEHEtuE3chzulli9mv1d31Py
 CBrLX4RQUwb3tRKINwIGBLeZC/mMXaXxWHdpAMoUX7jExbd1Qp4ssGG3an7w1Gu+x6u2PcXxW
 DQHVple6eQevWMJhkfjpd9VJLL146PzqJfQIEmy8YT2bvrAuCD9kn24hPJmavcPmXAeUF8HyB
 MfS9VFi9RsrCZYH7XCWrVN+ZF8v59mbQjshGcU+RM9PKFlwvFHpo2tBSIgTPEMfQFRgIaerA9
 vtNhfBRoRhV28CJzuUHmHjYoDIk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.23 um 17:56 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>    $ git archive --strip-components=3D1 HEAD sha1dc | tar tf -
>>    .gitattributes
>>    LICENSE.txt
>>    sha1.c
>>    sha1.h
>>    ubc_check.c
>>    ubc_check.h
>
> What should happen to paths that match the given pathspec that do
> not have enough number of components?  E.g. "cache.h" when the
> command is "git archive --strip-components=3D1 HEAD \*.h"?  Should it
> be documented?

Entries whose full path is stripped away don't make it into the archive.
That behavior is copied from bsdtar along with the option name and most
of its description in git-archive.txt.

Alternatively we could warn or die.  The latter would be a bit awkward
because we'd either have to check all paths first or risk reporting them
after writing at least some headers.

No strong preference, but following the precedence set by bsdtar makes
the most sense to me.

>> The new option does not affect the paths of entries added by --add-file
>> and --add-virtual-file because they are handcrafted to their desired
>> values already.  Similarly, the value of --prefix is not subject to
>> component stripping.
>
> Very sensible.
>
>> diff --git a/archive.c b/archive.c
>> index 9aeaf2bd87..8308d4d9c4 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -166,6 +166,18 @@ static int write_archive_entry(const struct object=
_id *oid, const char *base,
>>  		args->convert =3D check_attr_export_subst(check);
>>  	}
>
> We probably could save attribute lookup overhead by moving the new
> logic a bit higher in the function?
>
> No, that would invalidate the path_without_prefix variable by using
> strbuf_remove() on &path, and will break the attribute look-up.  The
> variable is used only once before this point and never used later,
> but as an independent future-proofing, we may want to remove the
> variable or narrow the scope.  It's totally out of scope of the
> patch, though.

Would you have noticed that attribute lookup breakage without the
presence of that variable? :)

The sad thing is that we concatenate base and filename here and
then attr.c::collect_some_attrs() goes and splits them again.  It
also uses the concatenated path, but perhaps that can be avoided?

>> +	if (args->strip_components > 0) {
>> +		size_t orig_baselen =3D baselen;
>> +		for (int i =3D 0; i < args->strip_components; i++) {
>> +			const char *slash =3D memchr(base, '/', baselen);
>> +			if (!slash)
>> +				return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;
>> +			baselen -=3D slash - base + 1;
>> +			base =3D slash + 1;
>> +		}
>> +		strbuf_remove(&path, args->baselen, orig_baselen - baselen);
>> +	}
>
> Nice to see that the core logic of the new feature is surprisingly
> small.
>
>>  	if (args->verbose)
>>  		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>
> By having the verbose output after the path stripping, we won't show
> the leading components we stripped, making it similar to what we
> would see when we piped the resulting archive to "| tar tf -".  I
> guess this makes sense than showing the original path.

Right, printing the path as it appears in the archive makes sense.
bsdtar does the same..

Ren=C3=A9
