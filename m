From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Mon, 02 May 2016 10:34:28 -0700
Message-ID: <xmqqk2jcuzx7.fsf@gitster.mtv.corp.google.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
	<xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
	<CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
	<20160427101833.GA5536@lanh>
	<xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
	<20160501002852.GA3963@lanh> <20160501060009.GA30748@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:34:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHjy-0005q5-LU
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbcEBRee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 13:34:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754436AbcEBRec convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 13:34:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAF87161E4;
	Mon,  2 May 2016 13:34:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YLXVYuopr6OX
	iqrh6s9xYpOHNTE=; b=VOmAw0Ymby/ebrso9TBnJiPPJNbgx/1QGelN9HnTwa9l
	jXPFKyW05izcLk+KR08QVEYN2a67AcoBOSEMpRjUBrVRWXAd5Fh9umU6UJhRHqbb
	7AVFKhdHM2TZBTWx8KSXXSdTfmfo6epCRARZRmMnTbm+meLXDVy4qk5MVbpLGrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fE7YXY
	7QZ7ede7iu+pn8a5PIpjY2rgMgavvESJbpzpBqxBa5FDGIqF4CxfZGFewV2Nr4gP
	0fawup3DAR6xv/QlM/Bdt849Zl/cJ89H9YrRlGanuWP7n/c4eu1dFGCyPYDmRsfo
	WD8aF4pfuBpycGHR9D+49imwK5rgMoj1cAHqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2ECE161E3;
	Mon,  2 May 2016 13:34:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4ABE8161E2;
	Mon,  2 May 2016 13:34:30 -0400 (EDT)
In-Reply-To: <20160501060009.GA30748@lanh> (Duy Nguyen's message of "Sun, 1
	May 2016 13:00:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2034D84E-108C-11E6-B1D4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293245>

Duy Nguyen <pclouds@gmail.com> writes:

> I may have rushed to judgement. wrap-for-bin.sh has always been the
> dependency for bin-wrappers/*. If we force that file to change, then
> bin-wrappers/* will be recreated when switching branches. So how abou=
t
> this?

I do not think you are "force updating wrap-for-bin" in any way in
the patch, though.  You are building it in such a way that it does
not have to get updated within the revision that contains e6e7530
(assuming that this will be queued directly on top it and merged to
everywhere e6e7530 is contained).

The new case/esac looks somewhat bad (its knowing that where test-*
lives, test-* is the only thing that is special, etc. troubles me at
the same time that case/esac is funnily formated).

Where does "@@PATH@@" come from and who rewrites it?  Is that a
misspelt "@@PROG@@"?

> -- 8< --
> Subject: [PATCH] wrap-for-bin.sh: handle t/helper/ paths internally
>
> Commit e6e7530 (test helpers: move test-* to t/helper/ subdirectory -
> 2016-04-13) moves test-* to t/helper. However because bin-wrappers/*
> only depend on wrap-for-bin.sh, when switching between a branch that =
has
> this commit and one that does not, bin-wrappers/* may not be regenera=
ted
> and point to the old/outdated test programs. Fix it by force updating
> wrap-for-bin.sh so that it will be regenerated anyway.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Makefile        |  2 +-
>  wrap-for-bin.sh | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index dd178ee..38dcdf7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2204,7 +2204,7 @@ bin-wrappers/%: wrap-for-bin.sh
>  	@mkdir -p bin-wrappers
>  	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>  	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
> -	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $<=
 > $@ && \
> +	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
>  	chmod +x $@
> =20
>  # GNU make supports exporting all variables by "export" without para=
meters.
> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> index db0ec6a..bb334ed 100644
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -18,11 +18,19 @@ GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'"${GITP=
ERLLIB:+:$GITPERLLIB}"
>  GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
>  PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
> +case "@@PATH@@" in
> +    test-*)
> +	PROG=3D"${GIT_EXEC_PATH}/t/helper/@@PROG@@"
> +	;;
> +    *)
> +	PROG=3D"${GIT_EXEC_PATH}/@@PROG@@"
> +	;;
> +esac
> =20
>  if test -n "$GIT_TEST_GDB"
>  then
>  	unset GIT_TEST_GDB
> -	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> +	exec gdb --args "$PROG" "$@"
>  else
> -	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> +	exec "$PROG" "$@"
>  fi
