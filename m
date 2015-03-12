From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/16] list-files: make :(glob) pathspec default
Date: Thu, 12 Mar 2015 14:10:59 -0700
Message-ID: <xmqqwq2l2a70.fsf@gitster.dls.corp.google.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 22:11:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWANs-0001YG-Fk
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 22:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbbCLVLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2015 17:11:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751387AbbCLVLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2015 17:11:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB931400E9;
	Thu, 12 Mar 2015 17:11:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ixd4x+W3rEAT
	Sk0wsuRm563ULns=; b=w68A5PPuQfoSIuYbluMUYTfbSkoaANLQeef7lvFqU1BG
	vBGtiEbp3+gr2BvbmBIpuET5yXHwLAsPTBQVtM4VMTNcVs5LNpwyLjOy2DNQh4Rz
	LgPWIpk5DsdHoI/ULrblOpkCPcLlgaE1UdaByjvUS6d/6pO1lqsWNNGxdGZ3E80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=igSETY
	DvSnFRuKpM+gjSXrbEaMQLsEevlX2ExtshaJvbm/tNBrRaEZrSE3m/mS38SeUblx
	GDCjW6NmU6d2mytdaH8xfNFi1CjJppXTXArVUZjHiEVG+eoA4jYw/4/iOc5ZMUL3
	Gydfhy4PQ+aLcsODZqRenUYL5IA+pYtFAuS0I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB6BF400E8;
	Thu, 12 Mar 2015 17:11:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7E93400DF;
	Thu, 12 Mar 2015 17:11:00 -0400 (EDT)
In-Reply-To: <1425896314-10941-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Mar
 2015 17:18:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48DB6750-C8FC-11E4-A9E7-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265371>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/list-files.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index ac33f13..b99f2b7 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -65,6 +65,8 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
>  {
>  	struct string_list result =3D STRING_LIST_INIT_NODUP;
> =20
> +	setenv(GIT_GLOB_PATHSPECS_ENVIRONMENT, "1", 0);
> +
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(ls_usage, ls_options);

Yikes.

I do not have enough info at this step in the series to judge if it
is sensible to force the :(glob) interpretation as default, but is
it something we would want to do commonly to flip the default per
Git subcommand?  If so, using the environment feels like a clunky
way to do that.

How about a two-patch clean-up before this step?

 (1) remove the handling of literal_global and friends that peek
     into various environment variables from prefix_pathspec(),
     which is a function that is repeatedly called for each pathspec
     element given from the command line, and move that logic to
     parse_pathspec(); pass necessary information down to
     prefix_pathspec() as parameter(s);

 (2) allow parse_pathspec() so that the caller can say "the default,
     when there is no environment variable given by the end user to
     tell us otherwise, is to :(glob)".
