Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B74C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E7724670
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 20:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RCmZ1eTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfLEU2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:28:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59006 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLEU2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 15:28:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B93999459;
        Thu,  5 Dec 2019 15:28:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bb6G0jc+DM4G
        OWGMuWlLZ7RkgnY=; b=RCmZ1eTlIFvKoVK59KuNY+2r4Ncm5UBvpqwem87YLRdf
        6VZPVey0HHFN4WX84PI/1etSVLNUS3Ov1bSyXzAvGV3tkS5vyxXfbIB5lWuidqWU
        kkg8Wwqu5+gKlC+MCL5TOVT9OrpnpXiIRltGCIF2X28JRl5cmdlPYsp7N7fGz2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AG3/eB
        lM8l5qiX4CkUtETjyU5hxI/f9NmsP/Xxjxh4VUr17bDTstLPSe5HIKK38z7I73wf
        l9AJwXM+aPij6WdMR67bb9+ov9gKZaBbhxvERis6B5zIrtysLSWKtlP7VVOG+2Rk
        ZWsg9+gFywH0kVbNnZGCefWwYXQlk3WuinwWA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1539B99458;
        Thu,  5 Dec 2019 15:28:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 575E699457;
        Thu,  5 Dec 2019 15:28:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5Yqg6Jek5LiA?= =?utf-8?B?5Y2a?= <kato-k@ksysllc.co.jp>
Subject: Re: [PATCH] gitk branch name encoding utf-8 probrem
References: <TY2PR01MB24271C32E2FD9FD8C27CA8C2CA5D0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
        <20191204222921.GB195537@google.com>
        <TY2PR01MB2427631CC07116A662AF3D38CA5C0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
Date:   Thu, 05 Dec 2019 12:28:06 -0800
In-Reply-To: <TY2PR01MB2427631CC07116A662AF3D38CA5C0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
        (=?utf-8?B?IuWKoOiXpOS4gOWNmiIncw==?= message of "Thu, 5 Dec 2019 15:02:15
 +0000")
Message-ID: <xmqqimmuzfe1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C06A51B0-179D-11EA-A644-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E5=8A=A0=E8=97=A4=E4=B8=80=E5=8D=9A <kato-k@ksysllc.co.jp> writes:

> fix branch name encoding error on gitk.
>
> git checkout -b '=E6=BC=A2=E5=AD=97'
> gitk show branch name broken like this '=E8=B2=8D=EF=BD=A2=E8=9F=84'
> fix this problem.

Paul (the gitk maintainer), the patch text itself does look
reasonable.

    After "git checkout -b '=E6=BC=A2=E5=AD=97'" to create a branch with =
UTF-8
    character in it, "gitk" shows the branch name incorrectly, as it
    forgets to turns the bytes read from the "git show-ref" command
    into Unicode characters.

is how I would phrase the log message.

Thanks.

>
> Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>
> ---
>  gitk | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/gitk b/gitk
> index abe4805..3f61a5b 100755
> --- a/gitk
> +++ b/gitk
> @@ -1780,11 +1780,15 @@ proc readrefs {} {
>      global otherrefids idotherrefs mainhead mainheadid
>      global selecthead selectheadid
>      global hideremotes
> +    global tclencoding
> =20
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs} =
{
>  	unset -nocomplain $v
>      }
>      set refd [open [list | git show-ref -d] r]
> +    if {$tclencoding !=3D {}} {
> +	fconfigure $refd -encoding $tclencoding
> +    }
>      while {[gets $refd line] >=3D 0} {
>  	if {[string index $line 40] ne " "} continue
>  	set id [string range $line 0 39]
> --
>
> See this pull request
> https://github.com/kkato233/gitk/pull/4
>
> -----Original Message-----
> From: Jonathan Nieder <jrnieder@gmail.com>=20
> Sent: Thursday, December 5, 2019 7:29 AM
> To: =E5=8A=A0=E8=97=A4=E4=B8=80=E5=8D=9A <kato-k@ksysllc.co.jp>
> Cc: git@vger.kernel.org; Paul Mackerras <paulus@ozlabs.org>
> Subject: Re: [PATCH] gitk branch name encoding utf-8 probrem
>
> (cc-ing Paul, gitk expert)
> Hi!
>
> =E5=8A=A0=E8=97=A4=E4=B8=80=E5=8D=9A wrote:
>
>> Here is a patch to gitk branch name utf-8 probrem.
>
> Thanks for reporting it.  Can you provide a short summary here of
> the problem that we can use for a self-contained description in the
> commit log?  See
> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html=
#describe-changes
> for more on this subject.
>
> May we also have your sign-off?  See
> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html=
#sign-off
> for what this means.
>
> Thanks and hope that helps,
> Jonathan
>
>> See issue
>> https://github.com/kkato233/gitk/issues/1
>> and fix it=20
>> https://github.com/kkato233/gitk/pull/2
>>=20
>>=20
>> ---
>>=20
>> diff --git a/gitk b/gitk
>> index abe4805..3f61a5b 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -1780,11 +1780,15 @@ proc readrefs {} {
>>      global otherrefids idotherrefs mainhead mainheadid
>>      global selecthead selectheadid
>>      global hideremotes
>> +    global tclencoding
>>=20
>>      foreach v {tagids idtags headids idheads otherrefids idotherrefs}=
 {
>>         unset -nocomplain $v
>>      }
>>      set refd [open [list | git show-ref -d] r]
>> +    if {$tclencoding !=3D {}} {
>> +       fconfigure $refd -encoding $tclencoding
>> +    }
>>      while {[gets $refd line] >=3D 0} {
>>         if {[string index $line 40] ne " "} continue
>>         set id [string range $line 0 39]
