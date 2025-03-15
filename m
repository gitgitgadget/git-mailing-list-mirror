Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79D2EB1D
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007003; cv=none; b=ACoU1ztFJHYeF5VBr29rbfqoFY/4Us1oAEHt5k4PIW7MqISZJN9cWXUD0cO5EMCaci28JEoRpK3SRhMcFqHaKBGtNwymgno437P+7+Ayb55GSl0zn/TRyeqiwhOf03r5rO6J4qa5sAtlc4wr98jxtNI11uCVekHMbDtlBnjV9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007003; c=relaxed/simple;
	bh=C7N/7Ep2z135/T81IdzzPxbS9hppsV3QU1710HrzbHw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q0iRmJ3YVoogXZ7QJ1lfa8kKeARzPmkwOqk8434mXmnHviCCjrHjTVakH2Cexgg/m+dYWdWAAnkOYoCplCbaPtbNrbfMheNys2j0TCFcoJmHTUAtr4B8KUfwnow3p8FjfD1BCGiEkAOeCznzevuNxmboSihA4nVyilcvcQT9QTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ig55ckMi; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ig55ckMi"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHYBtGMqwvxWAtHYCteQBm; Sat, 15 Mar 2025 02:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006821; bh=cdrXfiXioY/k3f2g4Z+1JY76gspSvv3ITSBjVjd6N2E=;
	h=Date:To:Cc:From:Subject;
	b=ig55ckMi3ibkeoBGE9Uoyea2+Os+yXwexqsh/c/BbncI+dlG4WqJ5NvpvJPyxMs1S
	 zU9mzelAtj4mtPdRDeOm5RTj0Bvi6SfANCHkUn3xvAPhY9eskXRaU233ObxA9ragXL
	 V8sTUh5DdUQrQifxMXzCWtMlwB5tx3JH3vADhCrq+ruez/mrjNdvTR49pmcHZWjZmH
	 wK3Wkz8fKtqnONoAZENTpKV0/uM2Ys8+4nDlODpBsd6GHoR2vTUDsdw73iT4KcZMwK
	 9W7exoHklf49bpbRX7Xx4NeKqSY6kHQLylVRdA49jAKlwvYKnKMEooFT+RHWHhnpMq
	 YUdFFQ6m1e0Sw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea25
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=6qvqOJHbk8VEAzwtmn4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <5d0112ae-98b5-46f2-91ad-35ed11358c3e@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:46:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 03/12] meson.build: only set build variables for non-default
 values
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMnjGdm/KRrOik3/vBy/auKeE422hOLXaafi3zKJuyUM6cQy2+npi9L8dR+8WFMSN4xToxSAl8WcyphKreVUXizzhSCZKWQ6pkgDhI5zzku9SmGfJ/Qt
 FsDVgIxBh2T6UJDQIAfgK32wtuTFJ64JsDqNj0zIl3Puu+OiCkm3+nvm6TN056EYxxcaXRT7XxqjVF977l4DmP74PPqqi24Tlj0=


Some preprocessor -Defines have defaults sets in the source code when
they have not been provided to the C compiler. In this case, there is
no need to pass them on the command-line, unless the build requires a
non-standard value.

The build variables for DEFAULT_EDITOR, DEFAULT_HELP_FORMAT along with
DEFAULT_PAGER have appropriate defaults ('vi', 'man' and 'less') set in
the code. Add the preprocessor -Defines to the 'libgit_c_args' only if
the values set with the corresponding 'options' are different to these
standard values.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 88a29fd043..24a4c2e3c2 100644
--- a/meson.build
+++ b/meson.build
@@ -693,10 +693,7 @@ endif
 # These variables are used for building libgit.a.
 libgit_c_args = [
   '-DBINDIR="' + get_option('bindir') + '"',
-  '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"',
   '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
-  '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
-  '-DDEFAULT_PAGER="' + get_option('default_pager') + '"',
   '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
   '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
@@ -708,6 +705,16 @@ libgit_c_args = [
   '-DPAGER_ENV="' + get_option('pager_environment') + '"',
   '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
 ]
+if get_option('default_editor') != 'vi'
+  libgit_c_args += '-DDEFAULT_EDITOR="' + get_option('default_editor') + '"'
+endif
+if get_option('default_pager') != 'less'
+  libgit_c_args += '-DDEFAULT_PAGER="' + get_option('default_pager') + '"'
+endif
+if get_option('default_help_format') != 'man'
+  libgit_c_args += '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"'
+endif
+
 libgit_include_directories = [ '.' ]
 libgit_dependencies = [ ]
 
-- 
2.49.0
