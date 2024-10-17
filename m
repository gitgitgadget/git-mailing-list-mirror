Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4E143895
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198027; cv=none; b=cxa6G1hrm6gWKeAFb34XsWCfgOcCSsp/6HQ3Eu+1lOrfqkLTtxYrMZSp/sRCv+F/r70+uOQRf6M5x1SzkpmRie/ATQL2r50NnH2uKjCZeSxb9y+5Dg+wtkmYIUn33dSYVlJUvygYTMrGqQQaJqY9zHpDE8sr4DL93pWqD/BRoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198027; c=relaxed/simple;
	bh=UoQGA0yQp0fmfyjaXcEG+yT6uUCOJE2KuxjGKNFe0Kc=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From; b=eU4otAS9H33P4Gfce5Rdk4VFib5EDgYc+foO3QjPb62SiWHvcbcLVyXWech6JZCq3v+I3KmqbAtBgyxAlDeKIhOMx3u3nxJPdbuSKwYwAqxYDl5jws8CqIMcnQY/KnWOpQXmu21tYvlbxNe2d0eIDArWy21/OMD5gcrHdj20/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=mHIx8OoK; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="mHIx8OoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=oqGHjEf8hIDhUoTaiyXJ1v5/7CPmaUHE3Sd0t9kfyCQ=;
 b=mHIx8OoKvC6GLdDiRsoVkoODdbgittsn98msDPAdEhj6Z0CaI7YgYNutp6JcK/klwAP749I+1aUn
   t6Ts2RT4/r0+qY+njOzuodsPl0W2HMucD0J+NfhSGFfoXSe2Yk6LWSCqOod+XFeaIPudjAtcOApr
   GmPiV7ZiRo+pcr3ZPMwPt5AWO4JybRGU+93Z5qi+i+IM/eccc3/bJ7tSLJZziKA3u7plCBaO28Lz
   U5prlfh903mC6Ci/NJJBbKltWrJnVz+aVGg+RcHpv52EFfpUQDvH2df3yJqzcJIaY27cxELWS+UX
   5zULDpQxW68pzHCPVvKJQy1bPiYesNMpenkYIA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLI002JSPQ6UD20@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 17 Oct 2024 20:46:54 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 17 Oct 2024 22:45:58 +0200
Message-id: <D4YDINQ682QL.N0FD2J9C1O22@ferdinandy.com>
Subject: CI behaving differently from local tests
Cc: "Taylor Blau" <me@ttaylorr.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Reporting-Meta:
 AAH/DTXKLQGnvjdtWLRf3yWhDMsYN9QIRUhd41bV/O48qhCpiauV+MvpLfL85ASu
 DMuObgu9yvIwYJm1HCbAVNBD1RF2TkRYJPU9D3eLQsut3chk3MpExfhIVaF2bveY
 27fK7mD4o4tQLJ5A4yWaIi2jlN0IWWHogACohUVUYTxPGuGCN7vSYufPrNnUUDjc
 1Ok632hA8OX0xaY3DAS/ckEdmWK+oO8ODnLMMBwvK9m9QiB+Ei3yXydkspVWRi/a
 PTdVgrNR3yt/NCThWyVs5lMn+xbPb9nmzNyukd1n8j5pQLtFEe8qpIDjYbc604d3
 ns7bZCda4aaLkxUiEvaxdCnMyZmwfPbsAnH4T0yEPBLWHGC76uHhF4IfbruzW8E4
 VMPsUjNr/g7UL4ijrppII8ccB5m4h9DpWuTJ9zyw4UyVaqXNCNJRshIkR6Ypx6et
 Nvx78DWV8fbtL4+E8AXMvTukmRYs+xgrFTYy6+R2FZ/KmYeZSmotrBeo

Hi,

I'm looking at why the set-head series (cf.:
https://lore.kernel.org/git/20241014225431.1394565-1-bence@ferdinandy.com/)
breaks the CI. The problem stems from the local test repositories being set=
 up
differently from that of the CI.

I ran both the CI and a local test on current master with the following pat=
ch
applied on top, i.e. I print all remote refs and intentionally break the te=
st
so that the result is easy to get from the CI:

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f..d625a3a8b6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -724,8 +724,11 @@ test_expect_success 'update' '
 		cd one &&
 		git remote add drosophila ../two &&
 		git remote add apis ../mirror &&
+		git ls-remote drosophila &&
+		git ls-remote apis &&
 		git remote update &&
 		git branch -r >output &&
+		echo "force error" >output &&
 		test_cmp expect output
 	)
 '

The CI gives the following output:
https://github.com/ferdinandyb/git/actions/runs/11392309625/job/31698105287


    + git ls-remote drosophila
    9d34b142e42f6b3dbab46dd4b9bc515e0ab16101       HEAD
    9d34b142e42f6b3dbab46dd4b9bc515e0ab16101       refs/heads/another
    9d34b142e42f6b3dbab46dd4b9bc515e0ab16101       refs/heads/main
    2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f       refs/heads/side
    + git ls-remote apis
    6329a3ca5268a0b28a1dc29b602e8b72a0bc1b37       HEAD
    6329a3ca5268a0b28a1dc29b602e8b72a0bc1b37       refs/heads/main
    2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f       refs/heads/side


While from ./t5505-remote.sh -v I get:

    9d34b142e42f6b3dbab46dd4b9bc515e0ab16101        HEAD
    9d34b142e42f6b3dbab46dd4b9bc515e0ab16101        refs/heads/another
    9d34b142e42f6b3dbab46dd4b9bc515e0ab16101        refs/heads/main
    2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f        refs/heads/side
    6329a3ca5268a0b28a1dc29b602e8b72a0bc1b37        refs/heads/main
    2ce9c504874e3f0ce77f83c0bb0b1024c7a6387f        refs/heads/side

Since `git remote update` here is essentially running `git fetch --multiple=
 --all`,
with the set-head series applied we're attempting to set HEAD for both
remotes. Obviously, this fails locally and succeeds in the CI, which is
actually the patch series behaving as intended, but obviously a drift betwe=
en
the local and the CI testing environments.

I'm probably too tired right now, but I don't see how or what could make th=
e
mirror repo be different depending on having it locally or in the CI ... At
least I know it's definitely not my patch series :) Does anyone have an ide=
a
what to try and look into?

I guess ideally the fix for this would be added to the beginning of the ser=
ies
so we can continue with both local and CI tests working. (Although it could=
 be
marked as a know breakage as well, not so elegant).

Thanks,
Bence


--=20
bence.ferdinandy.com

