Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863F199EAF
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477131; cv=none; b=G6UsjEsljCXNZE7MJE0munVrPmfODTBDiDYrWzsGAw2qgFAJ42MyZz0xo8BpoB010a1XlB3tmXZA3BI66W8skt4ULy7clTKq23ZMHVwktYYZz0hxTBoB+6TAfKIOXMjf7JEyufEEohqRYAwR51J10dtoQpHvjjQBBXVnwnltEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477131; c=relaxed/simple;
	bh=K+fmIkekIDp5sPTHPaEvZLjaNbjIzcQYPEMiEKgRx2M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LiRiHa8jwOIgv00wCzbYWRUlbbCLykmRGdn2CB/7P+WLBD2lMGuRq2bN6MVuPQPCjYNDbLe7Ym31IO8Mlnmw3hYSyYQwuejcunvOSQJVSkLdYOXlw19Yp1YowX/jbdmGAhVDOc2USxYpf9sHqUP1/D69FzUKF4Cbv6/ymuaOMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd2UOsWy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd2UOsWy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so1199453f8f.1
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477128; x=1714081928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMHiehbYjFFBdrnTvLdOi6SENwk0PFkyB/EwEssssnw=;
        b=Sd2UOsWyZQhlgSLvQvDKZSNDS26TxGwOp6rSF+AaoAH9Y+Qexn8ygSBR1dJXbUWDdc
         OJpaKWhJbpJNS497xqG8cGYmdP7yNu1ZDCrs7f6PyBAcTk4l7GxAKIZXrink8xM89LEv
         j9zUkd0QFLXNDRKObofzNY9a+/zV5S29Pby/BbEQTayXATv11cL9bb0RoWi+JvR+O8Ys
         AZD3NaDE/sVrqqEy52z2pjgN2pxDpd2a/oa7pcPjUNttIgn8uahbId36yQdffnFxXlnJ
         KRCFWff9OjOosdz/hTZMIh1Z4JMaCMgN1S+oOWprmgw81mKhS1d6x+WEP1X7qKZWYYwn
         FCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477128; x=1714081928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMHiehbYjFFBdrnTvLdOi6SENwk0PFkyB/EwEssssnw=;
        b=EDwsaQYDJH6rM53SfK5EkEKAZw5SuMyBDmFBRJmhOedT5Moz0FvfHfbUsYgCDhgWJN
         dspNHGJoJdm8C/XXQTv2q2+ZAfdOk9YkMaDq09hsQRD9GJZEJhnkE3ltPvApqGfIgMly
         O74iP4YN7MU2yjRhEuTlTZKmP0IM4etTpgxoSeIFUNMYa1si4VeByXEp70zG7jXHIHzA
         MqWNeC8AXtCdMP7r4OwJ6xryQ/+xebCvtWTY3xZoB6NJzuQW+MMv7n/xHmc2K/aKSw6p
         28VRFvxxeD2kejZysI34oBDtd9sVlH3FbOs3hbAGfIjDql2KpbbjXCjjdoGeMmvvQEE3
         85Aw==
X-Gm-Message-State: AOJu0YygggAxhyg/G7m6ajDNt4LL8elVOWxW1dQXYxu86CdB8dkuy0OI
	kmYPDJSBlaolbZERt7Zyk+iNf7L3+oz2zAnwOEci5av6A547cd1yukioZQ==
X-Google-Smtp-Source: AGHT+IEqyQABN3SfqqSb6kSrjeHd1jUmPqL5S2HBtOE4AkC6gNYhxKLfXaXaL96b/+aRBhDKrZV4IQ==
X-Received: by 2002:adf:eecf:0:b0:33e:7896:a9d7 with SMTP id a15-20020adfeecf000000b0033e7896a9d7mr81826wrp.67.1713477127402;
        Thu, 18 Apr 2024 14:52:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b004161af729f4sm4055544wmb.31.2024.04.18.14.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:07 -0700 (PDT)
Message-Id: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:51:57 +0000
Subject: [PATCH v6 0/8] docs: recommend using contrib/contacts/git-contacts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

Make git-contacts more prominent in our docs.


Notable changes in v6
=====================

 * Prefix the command with "perl" to avoid the need to have it installed at
   /usr/bin/perl per the shebang line in git-contacts.
 * Drop "you must have Perl installed in your system" guidance because it's
   a bit moot now given the explicit call to "perl".


Notable changes in v5
=====================

 * Drop mention of "/usr/share/..." as an "installed" path for
   "git-contacts"; instead point users to the script as a relative path
   inside the Git codebase
 * Minor wording tweaks to commit messages


Notable changes in v4
=====================

 * Avoid using "should" for guidance around using "git-contacts"
 * Clarify where to find the "git-contacts" script (because it's not a
   default builtin command)


Notable changes in v3
=====================

 * Refer to GitGitGadget via a link to MyFirstContribution (instead of
   sending readers to GGG's homepage directly)
 * Soften the advice for using git-contacts


Notable changes in v2
=====================

 * Improve existing mention of git-contacts in SubmittingPatches (instead of
   adding a separate, entirely new paragraph)
 * Add example usage of integrating git-contacts with git-send-email with
   the latter's --cc-cmd flag.
 * Various smaller fixes to SubmittingPatches

Linus Arver (8):
  MyFirstContribution: mention contrib/contacts/git-contacts
  SubmittingPatches: clarify 'git-contacts' location
  SubmittingPatches: mention GitGitGadget
  SubmittingPatches: quote commands
  SubmittingPatches: discuss reviewers first
  SubmittingPatches: dedupe discussion of security patches
  SubmittingPatches: add heading for format-patch and send-email
  SubmittingPatches: demonstrate using git-contacts with git-send-email

 Documentation/MyFirstContribution.txt |  9 ++++
 Documentation/SubmittingPatches       | 72 ++++++++++++++++-----------
 2 files changed, 51 insertions(+), 30 deletions(-)


base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1704

Range-diff vs v5:

 1:  d2c9551ee0e ! 1:  4ced981b82e MyFirstContribution: mention contrib/contacts/git-contacts
     @@ Documentation/MyFirstContribution.txt: $ git send-email --to=target@example.com
       
      +:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
      +not part of the core `git` binary and must be called directly. Clone the Git +
     -+codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     -+in your system).]
     ++codebase and run `perl contrib/contacts/git-contacts`.]
      +
      +NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
      +list potential reviewers. In addition, you can do `git send-email
     -+--cc-cmd='contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
     ++--cc-cmd='perl contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
      +automatically pass this list of emails to `send-email`.
      +
       NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 2:  92d72a8a25a ! 2:  f26f0695f40 SubmittingPatches: clarify 'git-contacts' location
     @@ Documentation/SubmittingPatches: security relevant should not be submitted to th
       
      +:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
      +not part of the core `git` binary and must be called directly. Clone the Git +
     -+codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     -+in your system).]
     ++codebase and run `perl contrib/contacts/git-contacts`.]
      +
       Send your patch with "To:" set to the mailing list, with "cc:" listing
      -people who are involved in the area you are touching (the `git
 3:  7c4cc5a91f0 = 3:  c201b313644 SubmittingPatches: mention GitGitGadget
 4:  621912a64fb = 4:  0a79615cf2f SubmittingPatches: quote commands
 5:  8f44343c482 ! 5:  aac5dea0bfa SubmittingPatches: discuss reviewers first
     @@ Documentation/SubmittingPatches: letter.
      +
      +:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
      +not part of the core `git` binary and must be called directly. Clone the Git +
     -+codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     -+in your system).]
     ++codebase and run `perl contrib/contacts/git-contacts`.]
      +
      +Send your patch with "To:" set to the mailing list, with "cc:" listing
      +people who are involved in the area you are touching (the `git-contacts`
     @@ Documentation/SubmittingPatches: patch, format it as "multipart/signed", not a t
      -
      -:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
      -not part of the core `git` binary and must be called directly. Clone the Git +
     --codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
     --in your system).]
     +-codebase and run `perl contrib/contacts/git-contacts`.]
      -
      -Send your patch with "To:" set to the mailing list, with "cc:" listing
      -people who are involved in the area you are touching (the `git-contacts`
 6:  fd8ad38cab0 = 6:  333775d4129 SubmittingPatches: dedupe discussion of security patches
 7:  b23c73459cc = 7:  ef031e30047 SubmittingPatches: add heading for format-patch and send-email
 8:  911d4f2a0e5 ! 8:  f346da95ee2 SubmittingPatches: demonstrate using git-contacts with git-send-email
     @@ Documentation/SubmittingPatches: trial merges of your topic to `next` and `seen`
      +this:
      +
      +....
     -+	git send-email --cc-cmd='contrib/contacts/git-contacts' feature/*.patch
     ++	git send-email --cc-cmd='perl contrib/contacts/git-contacts' feature/*.patch
      +....
      +
       :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]

-- 
gitgitgadget
