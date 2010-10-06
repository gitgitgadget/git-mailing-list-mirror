From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] worktree: provide better prefix to go back to original
 cwd
Date: Wed, 06 Oct 2010 08:47:45 -0700
Message-ID: <4CAC9A21.7030401@gmail.com>
References: <1286373578-2484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 17:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3WDo-0004AH-Pp
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 17:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab0JFPrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 11:47:52 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51067 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab0JFPrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 11:47:51 -0400
Received: by pvg2 with SMTP id 2so1959991pvg.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gW1vP7TVM/HCFq6TCCh9paVHF1qlYRxthnVjJhmU5r0=;
        b=Rg9UEAJVJyHErpN3pJXRv53z2lXDv22+C9TKFw8iFevskalJEcgOjMcanDkHRtZdFV
         0/LC0abdxHqZ5IJWkTTOVpU/r6/GxlcqQ3cPe5SsmhghAOhaRScaD/MdRDmZnki1ZgM9
         j2vdB/LACuiCwdmKC0Ga5KNFkDn+DEN3QCHLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dvOnZD3y5p9jFjkFZqEVTxul0qqPCbUfSW7w1RXFDk+dr1eX6KgguhiVzIfB4pjZcE
         vM4P5v4LzJFaTbdmPAGqt6wWmfr8Y7MwwjDpbl9fj9jOvKnGKcj4Hpuxpc/2pJzkb7GQ
         0VbdH1naQJQDH0/SL0zVWRgUPu+HOotP6NW+w=
Received: by 10.114.93.19 with SMTP id q19mr15717320wab.15.1286380070891;
        Wed, 06 Oct 2010 08:47:50 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d2sm1619878wam.2.2010.10.06.08.47.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 08:47:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <1286373578-2484-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158293>

On 06/10/10 06:59, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside worktr=
ee,
> prefix (the one passed to every builtin commands) will be set to NULL=
,
> which means "user stays at worktree topdir".
>=20
> As a consequence, command line arguments are supposed to be relative
> to worktree topdir, not current working directory. Not very intuitive=
=2E
> Moreover, output from such situation is (again) relative to worktree
> topdir. Users are expected to understand that.
>=20
> This patch allows builtin commands access to original cwd even if it'=
s
> outside worktree, via cwd_to_worktree and worktree_to_cwd fields. As
> the name implies, if you stay at original cwd, "cd $(cwd_to_worktree)=
"
> would take you to worktree topdir and vice versa.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  startup_info->cwd_to_worktree would be as same as opt.submodule_pref=
ix
>  in your 2/3 patch.

Thanks. I must admit I was struggling a little with implementing this
part. I'll be sending out a re-roll of my series shortly and I'll
include your patch if Junio doesn't pick it up on its own. I was also
planning on re-basing my patches on top of next or pu so more people ca=
n
actually compile it.
