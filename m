From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 11/32] rev-list: support --narrow-tree
Date: Tue, 24 Aug 2010 21:59:58 -0600
Message-ID: <AANLkTi=KBThiZ_FBUh0RfzLtP=YAtUPcx5PJW1q5OCd4@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo79i-0005Ku-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab0HYEAB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 00:00:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52343 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab0HYD77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 23:59:59 -0400
Received: by fxm13 with SMTP id 13so74399fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vmk02bxdKAiYqEaK4cWkK3lQiIgTQJDQhXta8hbrBvY=;
        b=HY5aPmxJQjYZXqjJ+Q7BtbH9cvH001o29aPRd7xXlfyNO+gEDiJKZ6IDY0k9SfQuIy
         2OZf1zMF+OenO/yHihwcVKbFv8EGF2UR4jOl83zyOr9g2PuCoEXMsBdaKZjTDNjqpZzo
         CyI537HS5zq0MC5Pa8NqgDkfoqpBtkKPjEtBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d2CDW0yXnBCi3y1/shQ72jTHV0BpJU6/Y4DySgiHkxU9tO/wsPjxmUbuSgytsnndp1
         tX3kwre71F3geCnS+eusjtB92d4FZ/xIte3Zs+B4gBVbzY2cZwaEw5SmId7VE6qx/7/W
         5fFyIFHJumDLoaEVag1/Rx3jkHA8ergXj3Bcw=
Received: by 10.223.126.19 with SMTP id a19mr6811502fas.88.1282708798414; Tue,
 24 Aug 2010 20:59:58 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 20:59:58 -0700 (PDT)
In-Reply-To: <1282688422-7738-12-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154410>

Hi,

2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> These options allow plumbing to access narrow tree traverse modes.
> As a consequence, tests can now be written to test these modes.
>
<snip>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!prefixcmp(arg, "--narrow-tree=3D")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->narrow_prefix =3D arg + 14;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->narrow_tree =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }

Seems somewhat non-gittish.  Why not 'git rev-list --objects HEAD --
<subtree_path>' rather than 'git rev-list --objects
--narrow-tree=3D<subtree_path> HEAD'?  (Was it due to the current bug i=
n
rev-list when specifying both --objects and paths?  If so, that's
addressed in the patch series I just sent.)


> +cat <<EOF >merge.expected
> +0da28f8308e336bd4b2c26b61c7fc44e41a30e49
> +7475cb8a389b36ce238b9ee6cbfdfa26a1b67e35
> +af9c31c0e217154296d93d66b9a5a41892c7b321
> +ba7a30916c792624a8372cb26da50f5594098222
> +74a398027f0b59183db54ca8c67dc30b5aeed0ff t2

Is this right?  Do you expect to see a t2 entry when filtering for t1/t=
12?

> +3b52e9990a52d9ea46b25199b5810566324759f4
> +fa0bba1767985729582729a12a5459cd041d6cf6 t1
> +d81015b2a1c40fc6cbc5bf5a8b16949018c3aede t1/t12
> +52bd8e43afb01d0c9747f1fedf2fc94684ee4cc4 t1/t12/f120
> +aa0602ee56ea4cb5e5bfff8713bb8a9a6ab4303e
> +d77d258d806b2aa7cdb5a301e6a54f023d9bdcfe t1
> +ab246f7eb05e94f695d2a0e30093d94fde7b837e t1/t12
> +04156ae83e615fa5b6019170928bc131539f9996 t1/t12/f120
> +72e05e456b9ff4c01ccf6178ce60d9b52b41aae4
> +4fc1656b01ce8b21987c55a2870b8c9a431ec772 t1
> +EOF
> +
> +test_expect_success 'rev-list --narrow-tree=3Dt1/t12 with merges' '
> + =C2=A0 =C2=A0 =C2=A0 git rev-list --objects --narrow-tree=3Dt1/t12 =
$MERGE >result &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp merge.expected result
