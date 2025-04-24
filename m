Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ACE1FDD
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532844; cv=none; b=fZ5OsZ4Xeq0cn7VDiGPxBlUBpD9c6vxVmThbkX1kY/Rv4Gfjh0G5XG+9gqFS4Xpn4MysNEnWtlxiD8Ouyoy48jOSKZF/DuP2tvRmfirMLjCognzpp2p1HTB3N8OaRWvcj5QLFjxPuVPERQcDO1L6rvQyoMO1r2OAa87PS+FaiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532844; c=relaxed/simple;
	bh=TX2i4hK2Xm7etXvAGavn9mu2cFt+PSxfZVnewLNqHLs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ghfsUGOwDbPvt7/S4bNhl33gtZgFpHddvOT6iQt3F7fVSU6uIKDvAtENHEHDTArE3nU8eN/YNb0Ia9QCyjsL1VQE4k1kVf8afCuIVZgVcVcDLeCcm8YYEb5um3I0F6FseXQlZwV8v3Cd0JMzg/wWp4oMLxpKw/3gLStRE2ahzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N30ijuby; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMN+9dQ6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N30ijuby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMN+9dQ6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6049A1140237;
	Thu, 24 Apr 2025 18:14:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 24 Apr 2025 18:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1745532840; x=1745619240; bh=rLvxTLWMvXYmiftuk1rLRQ5/UTZO80l1
	T4mjnBvXis4=; b=N30ijubynbwSaHnY4V/Ls0njn4JDgg0N7AGNgTUgrjRTO3Yo
	Tbv08CgMRVFk18W0r51wurBCxSsBzRKdHkBcFAj5Ei7cALQXh9iedSU58cCiqVS3
	fAVUWYY0W5nK97ihVKUjhwX9nwY6YW8rKGafRxS19SHZEi2mQ/83PutVJp6wyqDa
	d08bZ9SPSP38t3hq4zcoaIUoPhdWHAQmJaGToIxofJ1LPUXvk/Kprws9szBAvZQV
	5g7e8fhATFmc7f1W0gvTwon53n8QUR14kEDKyJ/UAYufIuQgYtmmKap9oW3Jo1+m
	q+4R68//IQl4maE7KwbYtVv8iz/2iqJsrbgL1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745532840; x=
	1745619240; bh=rLvxTLWMvXYmiftuk1rLRQ5/UTZO80l1T4mjnBvXis4=; b=M
	MN+9dQ6rwJVzGlVVaun+Q4U8W20pl5m0U2CnJkNEvNxsAcpj1IjaZGxEgYbHJwS6
	jaNxHZz3QAbuLecvp43vaYIqc3GvG0v8HcxpyDNXT3D4xyBidjcReMdhYzbco0Jn
	BUSh0KixgoxhgrdF/tAoT8qZG2M8ZEHNFssjH58fVvktrpYEdZ4RJVVU572IE8JM
	nxNCe9g7W/JJrPlTauqwtbv8OTxnd6ZPZ+PPS38Cgr9JeQZpPmxxX/+Mb4bIBSwl
	YM46PE//tuSPpjmg4bhqzM9OPO+oltZAHTz2cxhJSPVIajm6rwJ1/5aNETRY7sHP
	F55dVV9TC3KkrtMvUk6fA==
X-ME-Sender: <xms:qLcKaAJ2urUkglVlo3E3IMEyZS_PIbEmiUw5pMZdhGfDLJW47GnQsQ>
    <xme:qLcKaAInOLTfNy9mXhQMjoKF6hQF7Ce9Q4Nz6tzMoOSbn3s08ppmUI3Wrmu4SwV9b
    gxEFDRypZ52_IjzwA>
X-ME-Received: <xmr:qLcKaAvALNgmVkDzEXsb5gnSqAWekgPlCKVo_JXp7hT8rjR83cu25tpZH11oG38-KA-39KyM49VxPVYxDN9l73wviiLopE0tQM6l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptddtle
    ekvdejjedvfeevhfdtteeiieekieevteejteffuedvtdeljeeiteettdehnecuffhomhgr
    ihhnpegvtghlihhpshgvshhtrghtuhhsrdhiohdpthhophhitgdrtghipdhinhhsthgrlh
    hlqdguvghpvghnuggvnhgtihgvshdrshhhpdgvtghlihhpshgvrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qLcKaNYSnxjznVSKQ5QC5iFy2PxOzd3kklcI2jVobnii8Dv4lQ2f9A>
    <xmx:qLcKaHYNM5RSLr8eOjQBDvKX1BKc6UUBEr1DUKFzKwD8Dou2ohKFBA>
    <xmx:qLcKaJBbgzUH6pNqUggCDiCUjskW1Ovp8yy3UPzrP0nci1WgoE_svA>
    <xmx:qLcKaNbtjojRL-GO2Z2iSD9Y37lbrrmW1lGoBTPf8_J69bpL87A3og>
    <xmx:qLcKaEK5_IPkwNIZkHMQTgtcHhG2-RUGuy546JyVsEWFxi-fm1BT98p_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 18:13:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: repo.eclipse.org outage breaking all our linux CI jobs
Date: Thu, 24 Apr 2025 15:13:58 -0700
Message-ID: <xmqqfrhxtdg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As https://www.eclipsestatus.io/ reports there is no ETA for
recovery, and due to the failure of downloading JGit material in an
early stage of our CI jobs, our linux CI jobs are all failing, I am
very tempted to apply the following to 'maint' immediately and
propagate it all the way up to 'master', 'next', and 'seen'.

I would very very much appreciate additional thoughts and advices by
anybody more involved in JGit community and more clueful than I am
on the situation.

Anyway, what is somewhat funny is that at the end of this script,
there is an attempt to notice and report the lack of jgit (as well
as p4 and lfs) but still continuing:

	...
        if type jgit >/dev/null 2>&1
        then
                echo "$(tput setaf 6)JGit Version$(tput sgr0)"
                jgit version
        else
                echo >&2 "WARNING: JGit wasn't installed, see above for clues why"
        fi

        end_group "Install dependencies"

but because ci/lib.sh does "set -e", we fail way before we hit this
code.  I am tempted to suggest we remove that "set -e" as a long
term maintainability improvement measure, but that is a separate
topic.

 ci/install-dependencies.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git c/ci/install-dependencies.sh w/ci/install-dependencies.sh
index be9ba5e30a..4dda5db7e5 100755
--- c/ci/install-dependencies.sh
+++ w/ci/install-dependencies.sh
@@ -74,8 +74,9 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 			-C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
 		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 
-		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
-		chmod a+x "$CUSTOM_PATH/jgit"
+		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
+		chmod a+x "$CUSTOM_PATH/jgit" ||
+		echo >&2 "JGit download failed, but we do not care and keep going"
 		;;
 	esac
 	;;
